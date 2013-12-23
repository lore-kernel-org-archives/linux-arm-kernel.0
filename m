From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 23 Dec 2013 09:53:45 +0200
Subject: OMAP display subsystem - does it work?
In-Reply-To: <20131220165456.GD27438@atomide.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com>
 <20131219175644.GE32243@n2100.arm.linux.org.uk>
 <20131219182252.GP27438@atomide.com>
 <20131220112700.GF32243@n2100.arm.linux.org.uk>
 <20131220114837.GH32243@n2100.arm.linux.org.uk> <52B44982.4020501@ti.com>
 <20131220160432.GZ27438@atomide.com> <20131220165456.GD27438@atomide.com>
Message-ID: <52B7EC09.8080206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-20 18:55, Tony Lindgren wrote:

>> I bet that's it though. If the display is probed before twl4030 GPIO
>> is initialized, the GPIO numbers will be 0. I'm using omap2plus_defconfig
>> which has DSS built as modules.
> 
> Yeah this seems to do the trick for me for the built-in DSS on LDP.
> 
> Tony
> 
> 8< -----------------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 20 Dec 2013 08:53:27 -0800
> Subject: [PATCH] ARM: OMAP2+: Fix LCD panel backlight regression for LDP legacy booting
> 
> Looks like the LCD panel on LDP has been broken quite a while, and
> recently got fixed. However, there's still an issue where the panel
> backlight does not come on if the LCD drivers are built into the
> kernel.
> 
> Fix the issue by registering the DPI LCD panel only after the twl4030
> GPIO has probed.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -248,7 +248,7 @@ static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
>  	/* Backlight enable GPIO */
>  	ldp_lcd_pdata.backlight_gpio = gpio + 15;
>  
> -	return 0;
> +	return platform_device_register(&ldp_lcd_device);

If the panel device registration fails, does the whole TWL probe fail?
If so, that sounds a bit harsh to me.

>  }
>  
>  static struct twl4030_gpio_platform_data ldp_gpio_data = {
> @@ -346,7 +346,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
>  
>  static struct platform_device *ldp_devices[] __initdata = {
>  	&ldp_gpio_keys_device,
> -	&ldp_lcd_device,
>  };
>  
>  #ifdef CONFIG_OMAP_MUX
> 

Looks right to me:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Rather ugly, though, but there's probably no point in trying to do it in
a cleaner way (the new GPIO API, I think?), as we'll move to DT soon.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131223/c560f9ab/attachment.sig>
