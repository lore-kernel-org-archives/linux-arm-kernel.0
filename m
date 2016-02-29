From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 29 Feb 2016 18:12:45 +0200
Subject: [PATCH v2] video: exynos: fix modular build
In-Reply-To: <1456490307-823812-1-git-send-email-arnd@arndb.de>
References: <1456490307-823812-1-git-send-email-arnd@arndb.de>
Message-ID: <56D46DFD.6090706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26/02/16 14:38, Arnd Bergmann wrote:
> The s6e8ax0 driver has a dependency on BACKLIGHT_CLASS_DEVICE,
> which can be configured as a loadable module, so we have to
> make the driver a tristate symbol as well, to avoid this error:
> 
> drivers/built-in.o: In function `s6e8ax0_probe':
> :(.text+0x23a48): undefined reference to `devm_backlight_device_register'

If a 'bool' Kconfig option depends on BACKLIGHT_CLASS_DEVICE, shouldn't
the Kconfig dependency take care of having BACKLIGHT_CLASS_DEVICE as
built-in?

> This also means we get another error from a missing export, which
> this fixes as well:
> 
> ERROR: "exynos_mipi_dsi_register_lcd_driver" [drivers/video/fbdev/exynos/s6e8ax0.ko] undefined!
> 
> The drivers are all written to be loadable modules already,
> except the Kconfig options for that are missing, which makes
> the patch really easy.

Looks and sound fine, except doesn't this tell that the drivers have
never been tested as modules? Did you or someone else actually test these?

> diff --git a/drivers/video/fbdev/exynos/Makefile b/drivers/video/fbdev/exynos/Makefile
> index b5b1bd228abb..02d8dc522fea 100644
> --- a/drivers/video/fbdev/exynos/Makefile
> +++ b/drivers/video/fbdev/exynos/Makefile
> @@ -2,6 +2,8 @@
>  # Makefile for the exynos video drivers.
>  #
>  
> -obj-$(CONFIG_EXYNOS_MIPI_DSI)		+= exynos_mipi_dsi.o exynos_mipi_dsi_common.o \
> -				     	exynos_mipi_dsi_lowlevel.o
> +obj-$(CONFIG_EXYNOS_MIPI_DSI)		+= exynos-mipi-dsi-mod.o
> +
> +exynos-mipi-dsi-mod-objs		+= exynos_mipi_dsi.o exynos_mipi_dsi_common.o \
> +					   exynos_mipi_dsi_lowlevel.o

Hmm, why is this makefile change needed?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/6775bb1c/attachment.sig>
