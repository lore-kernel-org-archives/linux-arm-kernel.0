From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Oct 2014 10:55:36 +0200
Subject: [PATCH v2 5/5] simplefb: add clock handling code
In-Reply-To: <1412337125-14388-6-git-send-email-hdegoede@redhat.com>
References: <1412337125-14388-1-git-send-email-hdegoede@redhat.com>
 <1412337125-14388-6-git-send-email-hdegoede@redhat.com>
Message-ID: <20141006085536.GD4090@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 03, 2014 at 01:52:05PM +0200, Hans de Goede wrote:
> From: Luc Verhaegen <libv@skynet.be>
> 
> This claims and enables clocks listed in the simple framebuffer dt node.
> This is needed so that the display engine, in case the required clocks
> are known by the kernel code and are described in the dt, will remain
> properly enabled.
> 
> Signed-off-by: Luc Verhaegen <libv@skynet.be>
> [hdegoede at redhat.com: drop dev_err on kzalloc failure]
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/video/fbdev/simplefb.c | 100 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index b7d5c08..f329cc1 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_data/simplefb.h>
>  #include <linux/platform_device.h>
> +#include <linux/clk-provider.h>
>  
>  static struct fb_fix_screeninfo simplefb_fix = {
>  	.id		= "simple",
> @@ -165,8 +166,98 @@ static int simplefb_parse_pd(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +/*
> + * Clock handling code.
> + *
> + * Here we handle the clocks property of our "simple-framebuffer" dt node.
> + * This is necessary so that we can make sure that any clocks needed by
> + * the display engine that the bootloader set up for us (and for which it
> + * provided a simplefb dt node), stay up, for the life of the simplefb
> + * driver.
> + *
> + * When the driver unloads, we cleanly disable, and then release the clocks.
> + */
> +struct simplefb_clock {
> +	struct list_head list;
> +	struct clk *clock;
> +};
> +
> +/*
> + * We only complain about errors here, no action is taken as the most likely
> + * error can only happen due to a mismatch between the bootloader which set
> + * up simplefb, and the clock definitions in the device tree. Chances are
> + * that there are no adverse effects, and if there are, a clean teardown of
> + * the fb probe will not help us much either. So just complain and carry on,
> + * and hope that the user actually gets a working fb at the end of things.
> + */
> +static void
> +simplefb_clocks_init(struct platform_device *pdev, struct list_head *list)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	int clock_count, i;
> +
> +	INIT_LIST_HEAD(list);
> +
> +	if (dev_get_platdata(&pdev->dev) || !np)
> +		return;
> +
> +	clock_count = of_clk_get_parent_count(np);

This looks like it does what you expect, but its name and the fact
that it's in the clk-provider.h file makes me wonder if you're not
using the wrong side of the abstraction.

> +	for (i = 0; i < clock_count; i++) {
> +		struct simplefb_clock *entry;
> +		struct clk *clock = of_clk_get(np, i);

devm_clk_get?

> +		int ret;
> +
> +		if (IS_ERR(clock)) {
> +			dev_err(&pdev->dev, "%s: clock %d not found: %ld\n",
> +			       __func__, i, PTR_ERR(clock));
> +			continue;
> +		}
> +
> +		ret = clk_prepare_enable(clock);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"%s: failed to enable clock %d: %d\n",
> +			       __func__, i, ret);
> +			clk_put(clock);
> +			continue;
> +		}
> +
> +		entry = kzalloc(sizeof(struct simplefb_clock), GFP_KERNEL);
> +		if (!entry) {
> +			clk_disable_unprepare(clock);
> +			clk_put(clock);
> +			continue;
> +		}
> +
> +		entry->clock = clock;
> +		/*
> +		 * add to the front of the list, so we disable clocks in the
> +		 * correct order.
> +		 */
> +		list_add(&entry->list, list);

I really don't think this whole list dance is necessary, especially
after reading this comment. 

It doesn't make any sense to release the clock in a particular order,
when you don't even know in what order the bootloader actually set
them (and you haven't set any requirement on the order in the binding
either). For all you know, this could be a purely random order,
without any meaning, and it would be fine, so let's just not worry
about that.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/62bf3dcb/attachment.sig>
