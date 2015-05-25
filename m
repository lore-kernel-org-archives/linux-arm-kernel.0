From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 25 May 2015 08:43:38 +0300
Subject: [PATCH] video: omap/h3: fix tps65010 dependency
In-Reply-To: <4416278.oVFvT3Eyqf@wuerfel>
References: <4416278.oVFvT3Eyqf@wuerfel>
Message-ID: <5562B68A.6030608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/05/15 17:22, Arnd Bergmann wrote:
> The h3 LCD driver fails to link when tps65010 is configured
> as a loadable module:
> 
> drivers/built-in.o: In function `h3_panel_disable':
> debugfs.c:(.text+0x206ac): undefined reference to `tps65010_set_gpio_out_value'
> debugfs.c:(.text+0x206cc): undefined reference to `tps65010_set_gpio_out_value'
> drivers/built-in.o: In function `h3_panel_enable':
> debugfs.c:(.text+0x206e0): undefined reference to `tps65010_set_gpio_out_value'
> debugfs.c:(.text+0x20704): undefined reference to `tps65010_set_gpio_out_value'
> 
> This clarifies the dependency so we can only select it if
> the dependnecy is built-in.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/video/fbdev/omap/Kconfig b/drivers/video/fbdev/omap/Kconfig
> index 18c4cb0d5690..29d250da8a3e 100644
> --- a/drivers/video/fbdev/omap/Kconfig
> +++ b/drivers/video/fbdev/omap/Kconfig
> @@ -42,7 +42,7 @@ config FB_OMAP_LCD_MIPID
>  config FB_OMAP_LCD_H3
>  	bool "TPS65010 LCD controller on OMAP-H3"
>  	depends on MACH_OMAP_H3
> -	depends on TPS65010
> +	depends on TPS65010=y
>  	default y
>  	help
>  	  Say Y here if you want to have support for the LCD on the
> 

Thanks, queued for 4.2.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150525/e9ff5ed6/attachment.sig>
