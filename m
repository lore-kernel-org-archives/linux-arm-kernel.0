From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 26 Feb 2018 10:21:29 +0100
Subject: [PATCH] drm/sun4i: link in front-end code if needed
In-Reply-To: <20180223131112.715992-1-arnd@arndb.de>
References: <20180223131112.715992-1-arnd@arndb.de>
Message-ID: <20180226092129.t4uogg2q7jkeolbu@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 23, 2018 at 02:06:52PM +0100, Arnd Bergmann wrote:
> When the base sun4i DRM driver is built-in but the back-end is
> a loadable module, we run into a link error:
> 
> drivers/gpu/drm/sun4i/sun4i_drv.o: In function `sun4i_drv_probe':
> sun4i_drv.c:(.text+0x60c): undefined reference to `sun4i_frontend_of_table'
> 
> The dependency is a bit tricky, the best workaround I have come up
> with is to use a Makefile hack to to interpret both
> CONFIG_DRM_SUN4I_BACKEND=m and CONFIG_DRM_SUN4I_BACKEND=y
> as a directive to build the front-end the same way as the main module.
> 
> Fixes: dd0421f47505 ("drm/sun4i: Add a driver for the display frontend")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/sun4i/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
> index 582607c0c488..db14e023256b 100644
> --- a/drivers/gpu/drm/sun4i/Makefile
> +++ b/drivers/gpu/drm/sun4i/Makefile
> @@ -25,6 +25,9 @@ obj-$(CONFIG_DRM_SUN4I)		+= sun4i-tcon.o
>  obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
>  obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
>  
> -obj-$(CONFIG_DRM_SUN4I_BACKEND)	+= sun4i-backend.o sun4i-frontend.o
> +obj-$(CONFIG_DRM_SUN4I_BACKEND)	+= sun4i-backend.o
> +ifdef CONFIG_DRM_SUN4I_BACKEND
> +obj-$(CONFIG_DRM_SUN4I)		+= sun4i-frontend.o
> +endif

Can we just create a Kconfig symbol, selected by DRM_SUN4I_BACKEND,
and we would export the symbol?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/a8044cad/attachment-0001.sig>
