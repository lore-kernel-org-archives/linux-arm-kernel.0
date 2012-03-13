From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 13 Mar 2012 12:15:34 -0500
Subject: [PATCH v4 04/11] ep93xx: Use ioremap for backlight driver
In-Reply-To: <1331592502-9083-5-git-send-email-rmallon@gmail.com>
References: <1331592502-9083-5-git-send-email-rmallon@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020695AB9819@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 12, 2012 3:48 PM, Ryan Mallon wrote:
> The ep93xx backlight driver uses a single register within the
> framebuffer's register space. Currently the backlight driver uses a
> static IO mapping for the register since the memory cannot be
> requested by both drivers.
>
> Convert the static mapping to use ioremap so that we can remove the
> dependency on mach/hardware.h. To do so, we need remove the
> request_mem_region from both the backlight and framebuffer drivers,
> since whichever driver is loaded second will fail with -EBUSY
> otherwise.
>
> A proper fix is still required, and a FIXME comment has been added to
> both drivers.
>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> ---
>  arch/arm/mach-ep93xx/core.c         |   10 ++++++++++
>  drivers/video/backlight/ep93xx_bl.c |   25 ++++++++++++++-----------
>  drivers/video/ep93xx-fb.c           |   15 +++++++++------
>  3 files changed, 33 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index b5c1dae..c73e299 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -682,9 +682,19 @@ static struct platform_device ep93xx_fb_device = {
>  	.resource		= ep93xx_fb_resource,
>  };
>  
> +/* The backlight use a single register in the framebuffer's register space */
> +#define EP93XX_RASTER_REG_BRIGHTNESS 0x20
> +
> +static struct resource ep93xx_bl_resources[] = {
> +	DEFINE_RES_MEM(EP93XX_RASTER_PHYS_BASE +
> +		       EP93XX_RASTER_REG_BRIGHTNESS, 0x04),
> +};
> +
>  static struct platform_device ep93xx_bl_device = {
>  	.name		= "ep93xx-bl",
>  	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(ep93xx_bl_resources),
> +	.resource	= ep93xx_bl_resources,
>  };
>  
>  /**
> diff --git a/drivers/video/backlight/ep93xx_bl.c b/drivers/video/backlight/ep93xx_bl.c
> index b62b8b9..08214e1 100644
> --- a/drivers/video/backlight/ep93xx_bl.c
> +++ b/drivers/video/backlight/ep93xx_bl.c
> @@ -17,11 +17,6 @@
>  #include <linux/fb.h>
>  #include <linux/backlight.h>
>  
> -#include <mach/hardware.h>
> -
> -#define EP93XX_RASTER_REG(x)		(EP93XX_RASTER_BASE + (x))
> -#define EP93XX_RASTER_BRIGHTNESS	EP93XX_RASTER_REG(0x20)
> -
>  #define EP93XX_MAX_COUNT		255
>  #define EP93XX_MAX_BRIGHT		255
>  #define EP93XX_DEF_BRIGHT		128
> @@ -35,7 +30,7 @@ static int ep93xxbl_set(struct backlight_device *bl, int brightness)
>  {
>  	struct ep93xxbl *ep93xxbl = bl_get_data(bl);
>  
> -	__raw_writel((brightness << 8) | EP93XX_MAX_COUNT, ep93xxbl->mmio);
> +	writel((brightness << 8) | EP93XX_MAX_COUNT, ep93xxbl->mmio);
>  
>  	ep93xxbl->brightness = brightness;
>  
> @@ -70,21 +65,29 @@ static int __init ep93xxbl_probe(struct platform_device *dev)
>  	struct ep93xxbl *ep93xxbl;
>  	struct backlight_device *bl;
>  	struct backlight_properties props;
> +	struct resource *res;
>  
>  	ep93xxbl = devm_kzalloc(&dev->dev, sizeof(*ep93xxbl), GFP_KERNEL);
>  	if (!ep93xxbl)
>  		return -ENOMEM;
>  
> +	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENXIO;
> +
>  	/*
> -	 * This register is located in the range already ioremap'ed by
> -	 * the framebuffer driver.  A MFD driver seems a bit of overkill
> -	 * to handle this so use the static I/O mapping; this address
> -	 * is already virtual.
> +	 * FIXME - We don't do a request_mem_region here because we are
> +	 * sharing the register space with the framebuffer driver (see
> +	 * drivers/video/ep93xx-fb.c) and doing so will cause the second
> +	 * loaded driver to return -EBUSY.
>  	 *
>  	 * NOTE: No locking is required; the framebuffer does not touch
>  	 * this register.
>  	 */
> -	ep93xxbl->mmio = EP93XX_RASTER_BRIGHTNESS;
> +	ep93xxbl->mmio = devm_ioremap(&dev->dev, res->start,
> +				      resource_size(res));
> +	if (!ep93xxbl->mmio)
> +		return -ENXIO;
>  
>  	memset(&props, 0, sizeof(struct backlight_properties));
>  	props.type = BACKLIGHT_RAW;
> diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
> index 2e830ec..5301275 100644
> --- a/drivers/video/ep93xx-fb.c
> +++ b/drivers/video/ep93xx-fb.c
> @@ -519,12 +519,15 @@ static int __devinit ep93xxfb_probe(struct platform_device *pdev)
>  		goto failed;
>  	}
>  
> -	res = request_mem_region(res->start, resource_size(res), pdev->name);
> -	if (!res) {
> -		err = -EBUSY;
> -		goto failed;
> -	}
> -

Oops... Just took another look at this...

You removed the request_mem_region but left the release_mem_region in the
error path and in ep93xxfb_remove.

Regards,
Hartley

> +	/*
> +	 * FIXME - We don't do a request_mem_region here because we are
> +	 * sharing the register space with the backlight driver (see
> +	 * drivers/video/backlight/ep93xx_bl.c) and doing so will cause
> +	 * the second loaded driver to return -EBUSY.
> +	 *
> +	 * NOTE: No locking is required; the backlight does not touch
> +	 * any of the framebuffer registers.
> +	 */
>  	fbi->res = res;
>  	fbi->mmio_base = ioremap(res->start, resource_size(res));
>  	if (!fbi->mmio_base) {
