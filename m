From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 1 Aug 2011 23:04:49 +0100
Subject: [PATCH] DT: OMAP: Convert I2C driver to use device tree
In-Reply-To: <1312235294-4397-1-git-send-email-manjugk@ti.com>
References: <1312235294-4397-1-git-send-email-manjugk@ti.com>
Message-ID: <CACxGe6ugCVJJb32uie=Kh7sKrKREH8h0euuZVUrGeLab4zSgVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 1, 2011 at 10:48 PM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
> The i2c-omap driver is modified to support both DT and non DT builds
> and driver is updated to use dt data partially.
>
> Tested on OMAP3 beagle board for dt and non dt builds.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
> ?drivers/i2c/busses/i2c-omap.c | ? 33 ++++++++++++++++++++++++++++++---
> ?1 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 1a766cf..cf82f89 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -37,6 +37,8 @@
> ?#include <linux/platform_device.h>
> ?#include <linux/clk.h>
> ?#include <linux/io.h>
> +#include <linux/of_i2c.h>
> +#include <linux/of_device.h>
> ?#include <linux/slab.h>
> ?#include <linux/i2c-omap.h>
> ?#include <linux/pm_runtime.h>
> @@ -971,6 +973,16 @@ static const struct i2c_algorithm omap_i2c_algo = {
> ? ? ? ?.functionality ?= omap_i2c_func,
> ?};
>
> +#if defined(CONFIG_OF)
> +static const struct of_device_id omap_i2c_of_match[] = {
> + ? ? ? {.compatible = "ti,omap3-i2c", },
> + ? ? ? {},
> +}
> +MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
> +#else
> +#define omap_i2c_of_match NULL
> +#endif
> +
> ?static int __devinit
> ?omap_i2c_probe(struct platform_device *pdev)
> ?{
> @@ -978,10 +990,13 @@ omap_i2c_probe(struct platform_device *pdev)
> ? ? ? ?struct i2c_adapter ? ? ?*adap;
> ? ? ? ?struct resource ? ? ? ? *mem, *irq, *ioarea;
> ? ? ? ?struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
> + ? ? ? const struct of_device_id *match;
> ? ? ? ?irq_handler_t isr;
> ? ? ? ?int r;
> ? ? ? ?u32 speed = 0;
>
> + ? ? ? match = of_match_device(omap_i2c_of_match, &pdev->dev);
> +
> ? ? ? ?/* NOTE: driver uses the static register mapping */
> ? ? ? ?mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> ? ? ? ?if (!mem) {
> @@ -1007,14 +1022,23 @@ omap_i2c_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ?goto err_release_region;
> ? ? ? ?}
>
> + ? ? ? speed = 100; ? ?/* Default speed */
> ? ? ? ?if (pdata != NULL) {
> ? ? ? ? ? ? ? ?speed = pdata->clkrate;
> ? ? ? ? ? ? ? ?dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
> - ? ? ? } else {
> - ? ? ? ? ? ? ? speed = 100; ? ?/* Default speed */
> - ? ? ? ? ? ? ? dev->set_mpu_wkup_lat = NULL;
> +#if defined(CONFIG_OF)
> + ? ? ? } else if (pdev->dev.of_node) {
> + ? ? ? ? ? ? ? u32 prop;
> + ? ? ? ? ? ? ? if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &prop))
> + ? ? ? ? ? ? ? ? ? ? ? speed = prop/100;
> +#endif
> ? ? ? ?}
>
> + ? ? ? /* TODO: remove this after DT depencies with hwmod are resolved */
> + ? ? ? if (match)
> + ? ? ? ? ? ? ? return 0;
> +

Drop this hunk for the patch you're submitting to mainline.  It's okay
to have it in while you're testing, but the code that is actually
merged shouldn't have it.  We'll have a workaround for the hwmod issue
sorted out this week.  After doing this you can add:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ? ? ? ?dev->speed = speed;
> ? ? ? ?dev->idle = 1;
> ? ? ? ?dev->dev = &pdev->dev;
> @@ -1095,6 +1119,7 @@ omap_i2c_probe(struct platform_device *pdev)
> ? ? ? ?strlcpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
> ? ? ? ?adap->algo = &omap_i2c_algo;
> ? ? ? ?adap->dev.parent = &pdev->dev;
> + ? ? ? adap->dev.of_node = pdev->dev.of_node;
>
> ? ? ? ?/* i2c device drivers may be active on return from add_adapter() */
> ? ? ? ?adap->nr = pdev->id;
> @@ -1103,6 +1128,7 @@ omap_i2c_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ?dev_err(dev->dev, "failure adding adapter\n");
> ? ? ? ? ? ? ? ?goto err_free_irq;
> ? ? ? ?}
> + ? ? ? of_i2c_register_devices(adap);
>
> ? ? ? ?return 0;
>
> @@ -1174,6 +1200,7 @@ static struct platform_driver omap_i2c_driver = {
> ? ? ? ? ? ? ? ?.name ? = "omap_i2c",
> ? ? ? ? ? ? ? ?.owner ?= THIS_MODULE,
> ? ? ? ? ? ? ? ?.pm ? ? = OMAP_I2C_PM_OPS,
> + ? ? ? ? ? ? ? .of_match_table = omap_i2c_of_match,
> ? ? ? ?},
> ?};
>
> --
> 1.7.1
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
