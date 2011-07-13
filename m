From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 14 Jul 2011 08:20:28 +0900
Subject: [PATCH 4/4] dt: i2c-omap: Convert i2c driver to use device tree
In-Reply-To: <1310592975-25773-5-git-send-email-manjugk@ti.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-5-git-send-email-manjugk@ti.com>
Message-ID: <CACxGe6vG9BKUDvthOKFtx3u=Vq0EfBaZakxVqx8AYfRe_ruNdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
>
> The i2c-omap driver is converted for supporting both
> dt and non dt builds and driver is modified to use dt
> data partially.
>
> Tested on OMAP3 beagle board.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
> ?drivers/i2c/busses/i2c-omap.c | ? 48 ++++++++++++++++++++++++++++++++++++++++-
> ?1 files changed, 47 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index ae1545b..6d11a13 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -38,9 +38,13 @@
> ?#include <linux/clk.h>
> ?#include <linux/io.h>
> ?#include <linux/of_i2c.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> ?#include <linux/slab.h>
> ?#include <linux/i2c-omap.h>
> ?#include <linux/pm_runtime.h>
> +#include <plat/i2c.h>
>
> ?/* I2C controller revisions */
> ?#define OMAP_I2C_REV_2 ? ? ? ? ? ? ? ? 0x20
> @@ -972,6 +976,10 @@ static const struct i2c_algorithm omap_i2c_algo = {
> ? ? ? ?.functionality ?= omap_i2c_func,
> ?};
>
> +#if defined(CONFIG_OF)
> +static const struct of_device_id omap_i2c_of_match[];
> +#endif
> +
> ?static int __devinit
> ?omap_i2c_probe(struct platform_device *pdev)
> ?{
> @@ -979,10 +987,17 @@ omap_i2c_probe(struct platform_device *pdev)
> ? ? ? ?struct i2c_adapter ? ? ?*adap;
> ? ? ? ?struct resource ? ? ? ? *mem, *irq, *ioarea;
> ? ? ? ?struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
> +#if defined(CONFIG_OF)
> + ? ? ? const struct of_device_id *match;
> +#endif
> ? ? ? ?irq_handler_t isr;
> ? ? ? ?int r;
> ? ? ? ?u32 speed = 0;
>
> +#if defined(CONFIG_OF)
> + ? ? ? match = of_match_device(omap_i2c_of_match, &pdev->dev);
> +#endif

of_match_device() is an empty inline when CONFIG_OF is not defined.
You can drop the #if defined() protection around this statement.

> +
> ? ? ? ?/* NOTE: driver uses the static register mapping */
> ? ? ? ?mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> ? ? ? ?if (!mem) {
> @@ -1011,11 +1026,25 @@ omap_i2c_probe(struct platform_device *pdev)
> ? ? ? ?if (pdata != NULL) {
> ? ? ? ? ? ? ? ?speed = pdata->clkrate;
> ? ? ? ? ? ? ? ?dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
> +#if defined(CONFIG_OF)
> + ? ? ? } else if (pdev->dev.of_node) {
> + ? ? ? ? ? ? ? u32 prop;
> + ? ? ? ? ? ? ? if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &prop))
> + ? ? ? ? ? ? ? ? ? ? ? speed = prop/100;
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? speed = 100;

If you move the 'speed = 100' statement above the if(pdata != NULL)
test, then this whole block can become simpler for both the pdata and
DT situations.

> +#else
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?speed = 100; ? ?/* Default speed */
> - ? ? ? ? ? ? ? dev->set_mpu_wkup_lat = NULL;
> +#endif
> ? ? ? ?}
>
> +#if defined(CONFIG_OF)
> + ? ? ? /* TODO: remove this after DT depencies with hwmod are resolved */
> + ? ? ? if (match)
> + ? ? ? ? ? ? ? return 0;
> +#endif
> ? ? ? ?dev->speed = speed;
> ? ? ? ?dev->idle = 1;
> ? ? ? ?dev->dev = &pdev->dev;
> @@ -1096,7 +1125,9 @@ omap_i2c_probe(struct platform_device *pdev)
> ? ? ? ?strlcpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
> ? ? ? ?adap->algo = &omap_i2c_algo;
> ? ? ? ?adap->dev.parent = &pdev->dev;
> +#if defined(CONFIG_OF)
> ? ? ? ?adap->dev.of_node = pdev->dev.of_node;
> +#endif

The #if defined() can be safely removed here.

>
> ? ? ? ?/* i2c device drivers may be active on return from add_adapter() */
> ? ? ? ?adap->nr = pdev->id;
> @@ -1106,7 +1137,9 @@ omap_i2c_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ?goto err_free_irq;
> ? ? ? ?}
>
> +#if defined(CONFIG_OF)
> ? ? ? ?of_i2c_register_devices(adap);
> +#endif

Ditto here. of_i2c_register_devices() is an empty inline when !CONFIG_OF

>
> ? ? ? ?return 0;
>
> @@ -1162,6 +1195,16 @@ static int omap_i2c_resume(struct device *dev)
> ? ? ? ?return 0;
> ?}
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

You can move this whole block up to where omap_i2c_of_match is forward
declared, which will make the patch smaller.

> +
> ?static struct dev_pm_ops omap_i2c_pm_ops = {
> ? ? ? ?.suspend = omap_i2c_suspend,
> ? ? ? ?.resume = omap_i2c_resume,
> @@ -1178,6 +1221,9 @@ static struct platform_driver omap_i2c_driver = {
> ? ? ? ? ? ? ? ?.name ? = "omap_i2c",
> ? ? ? ? ? ? ? ?.owner ?= THIS_MODULE,
> ? ? ? ? ? ? ? ?.pm ? ? = OMAP_I2C_PM_OPS,
> +#if defined(CONFIG_OF)
> + ? ? ? ? ? ? ? .of_match_table = omap_i2c_of_match,
> +#endif

Drop the #if defined() protection.

g.
