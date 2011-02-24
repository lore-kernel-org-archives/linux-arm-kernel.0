From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Feb 2011 13:26:44 -0800
Subject: [PATCH resend] omap: Fix linker error in
	drivers/video/omap/lcd_2430sdp.c
In-Reply-To: <1298232248-347-1-git-send-email-jhnikula@gmail.com>
References: <1298193466-29534-1-git-send-email-jhnikula@gmail.com>
	<1298232248-347-1-git-send-email-jhnikula@gmail.com>
Message-ID: <20110224212644.GN20560@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Jarkko Nikula <jhnikula@gmail.com> [110220 12:13]:
> There is a linker error from lcd_2430sdp.c if CONFIG_TWL4030_CORE is not
> set. This can be triggered on OMAP2 builds where OMAP3 or OMAP4 are not set.
> 
> drivers/built-in.o: In function `sdp2430_panel_disable':
> drivers/video/omap/lcd_2430sdp.c:123: undefined reference to `twl_i2c_write_u8'
> drivers/video/omap/lcd_2430sdp.c:124: undefined reference to `twl_i2c_write_u8'
> drivers/built-in.o: In function `sdp2430_panel_enable':
> drivers/video/omap/lcd_2430sdp.c:110: undefined reference to `twl_i2c_write_u8'
> drivers/video/omap/lcd_2430sdp.c:112: undefined reference to `twl_i2c_write_u8'
> 
> Fix this by adding TWL4030_CORE dependency to CONFIG_MACH_OMAP_2430SDP as
> there is no own entry in drivers/video/omap/Kconfig.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> Resend = forgot to cc LAKML.
> Quite old issue most probably. Can be triggered in mainline anyway.
> ---
>  arch/arm/mach-omap2/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index b9d8a7b..bfdf240 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -132,6 +132,7 @@ config MACH_OMAP_2430SDP
>  	depends on SOC_OMAP2430
>  	default y
>  	select OMAP_PACKAGE_ZAC
> +	select TWL4030_CORE
>  
>  config MACH_OMAP3_BEAGLE
>  	bool "OMAP3 BEAGLE board"

We should avoid selecting driver related things, otherwise we can never
build a tiny kernel with initramfs with everything as modules.

Can you see if adding depends to the LCD panel option does the trick
instead?

Thanks,

Tony
