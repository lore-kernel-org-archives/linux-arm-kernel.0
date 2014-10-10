From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Oct 2014 10:00:17 -0700
Subject: [PATCH 1/2] ARM: OMAP3+: TWL: add support for mapping platform
 data via pdata-quirks
In-Reply-To: <1412948442-19896-2-git-send-email-t-kristo@ti.com>
References: <1412948442-19896-1-git-send-email-t-kristo@ti.com>
 <1412948442-19896-2-git-send-email-t-kristo@ti.com>
Message-ID: <20141010170017.GH10014@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [141010 06:41]:
> Device tree based boot does not currently support DVFS voltage scaling,
> as the VC/VP mapping is broken. This patch adds support to provide
> platform data in the device tree boot case also, basically to pass the
> function pointers to the vc/vp core for voltage changes.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/pdata-quirks.c |    8 ++--
>  arch/arm/mach-omap2/twl-common.c   |   88 ++++++++++++++++++++++++++++++++----
>  arch/arm/mach-omap2/twl-common.h   |    2 +
>  3 files changed, 84 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index 90c88d4..03e4a86 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -311,10 +311,10 @@ void omap_auxdata_legacy_init(struct device *dev)
>  	if (dev->platform_data)
>  		return;
>  
> -	if (strcmp("twl4030-gpio", dev_name(dev)))
> -		return;
> -
> -	dev->platform_data = &twl_gpio_auxdata;
> +	if (!strcmp("twl4030-gpio", dev_name(dev)))
> +		dev->platform_data = &twl_gpio_auxdata;
> +	else
> +		dev->platform_data = omap_twl_match_regulator(dev);
>  }

I think now you're passing also dev->platform_data for all the
other devices as this gets called for any devices added.

So you probale should use something like this instead:

	if (!strcmp("twl4030-gpio", dev_name(dev)))
		dev->platform_data = &twl_gpio_auxdata;

	if (!strcmp("twl4030-whatever-you-need", dev_name(dev)))
		dev->platform_data = &twl_gpio_auxdata;

Regards,

Tony
