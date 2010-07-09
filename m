From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 10 Jul 2010 01:55:26 +0200
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100709124050.GF22845@n2100.arm.linux.org.uk>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
	<20100709124050.GF22845@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/9 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> How about we have the core primecell code request the bus clock on
> driver probe, enable it, and then call the drivers probe method. ?On
> driver remove, the bus clock is disabled and put after the drivers
> remove method has been called. ?We provide two new function calls,
> amba_bus_clk_enable() and amba_bus_clk_disable() which primecell
> drivers can use to control the bus clock to the peripheral - these
> can be just macros to clk_enable and clk_disable respectively.

This looks mostly good to me (comments below) but will have as
a side effect that all clock frameworks on all platforms using PrimeCells
will need to be initialized *before* the PrimeCell devices are added.

In U8500 we solved this by moving the clock initialization to the IRQ
initialization from the .init_irq field in the machine struct, this
change would need that (or something similar) to be done uniformly.

(I can fix it for U300 and other platforms I can test.)

> So something like the patch below (untested):
>
> ?drivers/amba/bus.c ? ? ? | ? 35 +++++++++++++++++++++++++++++++----
> ?include/linux/amba/bus.h | ? 10 ++++++++++
> ?2 files changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index f60b2b6..1b9f5f8 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -130,17 +130,44 @@ static int amba_probe(struct device *dev)
> ?{
> ? ? ? ?struct amba_device *pcdev = to_amba_device(dev);
> ? ? ? ?struct amba_driver *pcdrv = to_amba_driver(dev->driver);
> - ? ? ? struct amba_id *id;
> + ? ? ? struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
> + ? ? ? struct clk *clk;
> + ? ? ? int ret;
> +
> + ? ? ? do {
> + ? ? ? ? ? ? ? pcdev->busck = clk = clk_get(dev, "busck");
> + ? ? ? ? ? ? ? if (IS_ERR(clk) && PTR_ERR(clk) != -ENOENT) {
> + ? ? ? ? ? ? ? ? ? ? ? ret = PTR_ERR(clk);
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? if (!IS_ERR(clk)) {
> + ? ? ? ? ? ? ? ? ? ? ? ret = clk_enable(clk);
> + ? ? ? ? ? ? ? ? ? ? ? if (ret)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
>
> - ? ? ? id = amba_lookup(pcdrv->id_table, pcdev);
> + ? ? ? ? ? ? ? ret = pcdrv->probe(pcdev, id);
> + ? ? ? ? ? ? ? if (ret == 0)
> + ? ? ? ? ? ? ? ? ? ? ? break;

So this means you always turn on the block clock at
probe, and then leave it on if the probe was successful.

>
> - ? ? ? return pcdrv->probe(pcdev, id);
> + ? ? ? ? ? ? ? clk_disable(clk);
> + ? ? ? } while (0);
> +
> + ? ? ? return ret;
> ?}
>
> ?static int amba_remove(struct device *dev)
> ?{
> + ? ? ? struct amba_device *pcdev = to_amba_device(dev);
> ? ? ? ?struct amba_driver *drv = to_amba_driver(dev->driver);
> - ? ? ? return drv->remove(to_amba_device(dev));
> + ? ? ? int ret = drv->remove(pcdev);
> +
> + ? ? ? if (!IS_ERR(pcdev->busck)) {
> + ? ? ? ? ? ? ? clk_disable(pcdev->busck);

And here it is disabled.

For drivers that need to conserve power, also the block
clock has to be gated when the device is not in use,
sometimes since that affects some hardware that keep
track of the usecount of the clock tree for a larger region of
silicon, so the power savings can be drastic.

It would be good if drivers could opt-out of leaving the
clock on after probe, some more property perhaps,
like "gateme" or so, then the driver will be responsible
to clk_enable() the clock when it's needed.

This would make it possible to convert the PrimeCell
drivers over to this behaviour later.

Another option would be to always gate them all off,
and then sprinkle clk_enable(adev->bus_clk) into every
PrimeCell driver probe() and clk_disable(adev->bus_clk) into
every PrimeCell driver remove(). This makes things more
explicit.

> + ? ? ? ? ? ? ? clk_put(pcdev->busck);
> + ? ? ? }
> + ? ? ? return ret;
> ?}

> ?static void amba_shutdown(struct device *dev)
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index 8b10386..f880c58 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -15,13 +15,17 @@
> ?#define ASMARM_AMBA_H
>
> ?#include <linux/device.h>
> +#include <linux/err.h>
> ?#include <linux/resource.h>
>
> ?#define AMBA_NR_IRQS ? 2
>
> +struct clk;
> +
> ?struct amba_device {
> ? ? ? ?struct device ? ? ? ? ? dev;
> ? ? ? ?struct resource ? ? ? ? res;
> + ? ? ? struct clk ? ? ? ? ? ? ?*busck;

Here you could add:
bool gateme

> ? ? ? ?u64 ? ? ? ? ? ? ? ? ? ? dma_mask;
> ? ? ? ?unsigned int ? ? ? ? ? ?periphid;
> ? ? ? ?unsigned int ? ? ? ? ? ?irq[AMBA_NR_IRQS];
> @@ -59,6 +63,12 @@ struct amba_device *amba_find_device(const char *, struct device *, unsigned int
> ?int amba_request_regions(struct amba_device *, const char *);
> ?void amba_release_regions(struct amba_device *);
>
> +#define amba_bus_clk_enable(d) \
> + ? ? ? (IS_ERR((d)->busck) ? 0 : clk_enable((d)->busck))
> +
> +#define amba_bus_clk_disable(d) ? ? ? ?\
> + ? ? ? do { if (!IS_ERR((d)->busck)) clk_disable((d)->busck); } while (0)
> +
> ?#define amba_config(d) (((d)->periphid >> 24) & 0xff)
> ?#define amba_rev(d) ? ?(((d)->periphid >> 20) & 0x0f)
> ?#define amba_manf(d) ? (((d)->periphid >> 12) & 0xff)
>

Yours,
Linus Walleij
