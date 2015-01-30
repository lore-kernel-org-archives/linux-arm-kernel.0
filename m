From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 30 Jan 2015 09:46:22 +0200
Subject: [PATCH] video/mmpfb: allow modular build
In-Reply-To: <8150312.I9dm5QVFgr@wuerfel>
References: <8150312.I9dm5QVFgr@wuerfel>
Message-ID: <54CB36CE.3090404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/15 22:13, Arnd Bergmann wrote:
> The frame buffer core can be a module, which means any fb drivers
> should be able to build as modules too. This turns mmpfb into
> a tristate option to allow that and fix a possible randconfig
> build error.
> 
> drivers/built-in.o: In function `modes_setup':
> :(.text+0x11b34): undefined reference to `fb_videomode_to_modelist'
> :(.text+0x11b5c): undefined reference to `fb_videomode_to_var'
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/video/fbdev/mmp/Makefile b/drivers/video/fbdev/mmp/Makefile
> index a014cb358bf8..924dd0930cc7 100644
> --- a/drivers/video/fbdev/mmp/Makefile
> +++ b/drivers/video/fbdev/mmp/Makefile
> @@ -1 +1,3 @@
> -obj-y += core.o hw/ panel/ fb/
> +obj-$(CONFIG_MMP_DISP) += mmp_disp.o hw/ panel/ fb/
> +
> +mmp_disp-y		+= core.o
> diff --git a/drivers/video/fbdev/mmp/fb/Kconfig b/drivers/video/fbdev/mmp/fb/Kconfig
> index 9b0141f105f5..985e1a7cd254 100644
> --- a/drivers/video/fbdev/mmp/fb/Kconfig
> +++ b/drivers/video/fbdev/mmp/fb/Kconfig
> @@ -1,7 +1,7 @@
>  if MMP_DISP
>  
>  config MMP_FB
> -	bool "fb driver for Marvell MMP Display Subsystem"
> +	tristate "fb driver for Marvell MMP Display Subsystem"
>  	depends on FB
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
> 

Thanks, queued for 3.20.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150130/1b19b5db/attachment.sig>
