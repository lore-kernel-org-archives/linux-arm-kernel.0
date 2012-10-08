From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 15:13:33 -0700
Subject: [PATCH] ARM: OMAP: move old debug-devices.c and debug-leds.c
 to be OMAP2+ only for now
In-Reply-To: <alpine.DEB.2.00.1210080145080.5736@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210080145080.5736@utopia.booyaka.com>
Message-ID: <20121008221333.GZ13011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121007 18:48]:
> 
> Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
> debug_card_init() function") results in the following new sparse[1]
> warning:
> 
> arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?
> 
> Normally this could be fixed by including the appropriate header file
> in plat-omap/debug-devices.c, but the header file now exists only in
> mach-omap2/, so this would require a "sideways include" and is thus
> impractical.  It turns out that only code in mach-omap2/ currently
> uses the debug-devices.c and debug-leds.c files, so move them there.
> In the long term, these devices should be created by DT, and the code
> should be moved into drivers/ somewhere.

Hmm are you sure that omap1 is not using debug-leds.c?
At least the initcall seems like it should run on omap1
if enabled.

The sideways include here is OK, it does not get exposed to
the drivers, it seems that plat-omap is still the right location
for at least debug-leds.c code.

> rename from arch/arm/plat-omap/debug-leds.c
> rename to arch/arm/mach-omap2/debug-leds.c
> index ea29bbe..c12350b 100644
> --- a/arch/arm/plat-omap/debug-leds.c
> +++ b/arch/arm/mach-omap2/debug-leds.c
> @@ -146,11 +146,8 @@ static struct platform_driver led_driver = {
>  
>  static int __init fpga_init(void)
>  {
> -	if (machine_is_omap_h4()
> -			|| machine_is_omap_h3()
> -			|| machine_is_omap_h2()
> -			|| machine_is_omap_perseus2()
> -			)
> +	if (machine_is_omap_h4() || machine_is_omap_h3() ||
> +	    machine_is_omap_h2() || machine_is_omap_perseus2())
>  		return platform_driver_register(&led_driver);
>  	return 0;
>  }

This looks like it should work fine for the boards using
the debug leds on omap1 too.

Regards,

Tony
