From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 9 Nov 2010 05:43:16 +0900
Subject: [PATCH 6/6 v3] ARM: Add support for the display controllers in
	VT8500 and WM8505
In-Reply-To: <20101108141407.GA25739@alchark-u3s.lan>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<1289147348-31969-6-git-send-email-alchark@gmail.com>
	<20101108041721.GA11605@linux-sh.org>
	<20101108141407.GA25739@alchark-u3s.lan>
Message-ID: <20101108204315.GA12050@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 08, 2010 at 05:14:07PM +0300, Alexey Charkov wrote:
> This incorporates fixes to the issues that Paul has identified.
> MMIO register pointer in wmt_ge_rops was just made static, as I
> could not find any immediately obvious way to pass drvdata around
> (the whole functionality of this driver is in exported functions
> that are called from a display driver context, which does not know
> about the rop engine specific data structures).
> 
Looking better.. just a few minor things left.

> diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
> new file mode 100644
> index 0000000..640d8a3
> --- /dev/null
> +++ b/drivers/video/vt8500lcdfb.c
> +#include <asm/irq.h>
> +
linux/irq.h is preferred here.

> diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
> new file mode 100644
> index 0000000..560c926
> --- /dev/null
> +++ b/drivers/video/wm8505fb.c
> +#include <asm/irq.h>
> +
Likewise.

> +static int wm8505fb_pan_display(struct fb_var_screeninfo *var,
> +				struct fb_info *info)
> +{
> +	struct wm8505fb_info *fbi = container_of(info,
> +						  struct wm8505fb_info,
> +						  fb);
> +
Sice you are open-coding this container_of() all over the place you may
simply want to make a wrapper for this. ie,

#define to_wm8505fb_info(info)	container_of(info, struct wm8505fb_info, fb)

and then just doing struct wm855fb_info *fbi = to_wm8505fb_info(info);

This wiwll also save you from having that ugly multi-line split in the
container_of() and keep you well within 80 characters.

> +static int __devinit wm8505fb_probe(struct platform_device *pdev)
> +{
...

> +	ret = register_framebuffer(&fbi->fb);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Failed to register framebuffer device: %d\n", ret);
> +		goto failed_free_cmap;
> +	}
> +
> +	ret = device_create_file(&pdev->dev, &dev_attr_contrast);
> +	if (ret < 0) {
> +		printk(KERN_WARNING "fb%d: failed to register attributes (%d)\n",
> +			fbi->fb.node, ret);
> +	}
> +
...
> +}
> +
> +static int __devexit wm8505fb_remove(struct platform_device *pdev)
> +{
> +	struct wm8505fb_info *fbi = platform_get_drvdata(pdev);
> +	struct resource *res;
> +
> +	if (!fbi)
> +		return 0;
> +
I would kill this test as well. If this ever triggers, something horribly
wrong has happened and you likely have bigger things to worry about.

> +	unregister_framebuffer(&fbi->fb);
> +
You're missing a device_remove_file().

> +static struct platform_driver wm8505fb_driver = {
> +	.probe		= wm8505fb_probe,
> +	.remove		= wm8505fb_remove,

As your remove function is flagged devexit, this ought to be wrapped with
__devexit_p(). This will save you a bit of space as the kernel will
discard the remove function outright if you're not using this as a module
or with hotplug. The same applies to your other remove functions too.

> diff --git a/drivers/video/wmt_ge_rops.c b/drivers/video/wmt_ge_rops.c
> new file mode 100644
> index 0000000..b201a60
> --- /dev/null
> +++ b/drivers/video/wmt_ge_rops.c
> +EXPORT_SYMBOL(wmt_ge_fillrect);
> +EXPORT_SYMBOL(wmt_ge_copyarea);
> +EXPORT_SYMBOL(wmt_ge_sync);
> +
...

Is there a particular reason why you are favouring EXPORT_SYMBOL? In
general we prefer that new infrastructure patches and the like stick with
EXPORT_SYMBOL_GPL, as this discourages use by non-GPLed modules going
forward.

> +static int __devinit wmt_ge_rops_probe(struct platform_device *pdev)
> +{
...
> +	regbase = ioremap(res->start, resource_size(res));
> +	if (regbase == NULL) {
> +		dev_err(&pdev->dev, "failed to map I/O memory\n");
> +		ret = -EBUSY;
> +		goto error;
> +	}
> +
You might also want to do something like:

	/* Only one ROP engine is presently supported. */
	if (unlikely(regbase)) {
		WARN_ON(1);
		return -EBUSY;
	}

	regbase = ioremap(...);
	...

> +	writel(1, regbase + GE_ENABLE_OFF);
> +	printk(KERN_INFO "Enabled support for WMT GE raster acceleration\n");
> +
> +	return 0;
> +
> +error:
> +	return ret;
> +}
> +
> +static int __devexit wmt_ge_rops_remove(struct platform_device *pdev)
> +{
> +	iounmap(regbase);
> +	return 0;
> +}
> +
You're missing a:

	writel(0, regbase + GE_ENABLE_OFF);

here?

> +MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com");
> +MODULE_DESCRIPTION("Accelerators for raster operations using "
> +		   "WonderMedia Graphics Engine");
> +MODULE_LICENSE("GPL");

Your other drivers appear to be lacking AUTHOR and DESCRIPTION
definitions.
