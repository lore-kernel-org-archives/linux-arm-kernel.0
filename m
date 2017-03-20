From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 11:26:26 +0100
Subject: [PATCH v2 4/8] drm/sun4i: add support for sun8i DE2 mixers and
 display engines
In-Reply-To: <20170316204748.8596-5-icenowy@aosc.xyz>
References: <20170316204748.8596-1-icenowy@aosc.xyz>
 <20170316204748.8596-5-icenowy@aosc.xyz>
Message-ID: <20170320102626.24awzyrq32gomntt@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 17, 2017 at 04:47:44AM +0800, Icenowy Zheng wrote:
> Allwinner have a new "Display Engine 2.0" in there new SoCs, which comes
> in a new "Display Engine" (mixers instead of old backends and
> frontends).
> 
> Add support for the mixer on Allwinner V3s SoC; it's the simplest one.
> 
> Currently a lot of functions are still missing -- more investigations
> are needed to gain enough infomation for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v2:
> - Rebase on current linux-next (with Chen-Yu's some refactors)
> - Removed currently broken overlay plane.
> 
>  drivers/gpu/drm/sun4i/Kconfig       |   9 +
>  drivers/gpu/drm/sun4i/Makefile      |   3 +-
>  drivers/gpu/drm/sun4i/sun4i_crtc.c  |  14 +-
>  drivers/gpu/drm/sun4i/sun4i_crtc.h  |   2 +
>  drivers/gpu/drm/sun4i/sun4i_drv.c   |   1 +
>  drivers/gpu/drm/sun4i/sun4i_drv.h   |   1 +
>  drivers/gpu/drm/sun4i/sun4i_layer.c |  94 +++++++--
>  drivers/gpu/drm/sun4i/sun4i_layer.h |   3 +
>  drivers/gpu/drm/sun4i/sun4i_tcon.c  |   2 +-
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 385 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_mixer.h | 166 ++++++++++++++++
>  11 files changed, 658 insertions(+), 22 deletions(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.h
> 
> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
> index a4b357db8856..0fa989f955e7 100644
> --- a/drivers/gpu/drm/sun4i/Kconfig
> +++ b/drivers/gpu/drm/sun4i/Kconfig
> @@ -12,3 +12,12 @@ config DRM_SUN4I
>  	  Choose this option if you have an Allwinner SoC with a
>  	  Display Engine. If M is selected the module will be called
>  	  sun4i-drm.
> +
> +config DRM_SUN4I_DE2
> +	bool "Support Display Engine 2.0"
> +	depends on DRM_SUN4I
> +	default MACH_SUN8I
> +	select SUN8I_DE2_CCU
> +	help
> +	  Choose this option if you have an Allwinner SoC with a
> +	  "Display Engine 2.0".
> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
> index 59b757350a1f..3e7e2b2eb386 100644
> --- a/drivers/gpu/drm/sun4i/Makefile
> +++ b/drivers/gpu/drm/sun4i/Makefile
> @@ -1,5 +1,7 @@
>  sun4i-drm-y += sun4i_drv.o
>  sun4i-drm-y += sun4i_framebuffer.o
> +sun4i-drm-y += sun4i_backend.o
> +sun4i-drm-$(CONFIG_DRM_SUN4I_DE2) += sun8i_mixer.o
>  
>  sun4i-tcon-y += sun4i_tcon.o
>  sun4i-tcon-y += sun4i_rgb.o
> @@ -8,6 +10,5 @@ sun4i-tcon-y += sun4i_crtc.o
>  sun4i-tcon-y += sun4i_layer.o
>  
>  obj-$(CONFIG_DRM_SUN4I)		+= sun4i-drm.o sun4i-tcon.o
> -obj-$(CONFIG_DRM_SUN4I)		+= sun4i_backend.o
>  obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
>  obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> index 3c876c3a356a..bf2aa0ffd35c 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> @@ -26,8 +26,8 @@
>  #include <video/videomode.h>
>  
>  #include "sun4i_backend.h"
> +#include "sun8i_mixer.h"
>  #include "sun4i_crtc.h"
> -#include "sun4i_drv.h"
>  #include "sun4i_layer.h"
>  #include "sun4i_tcon.h"
>  
> @@ -56,7 +56,10 @@ static void sun4i_crtc_atomic_flush(struct drm_crtc *crtc,
>  
>  	DRM_DEBUG_DRIVER("Committing plane changes\n");
>  
> -	sun4i_backend_commit(scrtc->backend);
> +	if (scrtc->backend)
> +		sun4i_backend_commit(scrtc->backend);
> +	else if (scrtc->mixer)
> +		sun8i_mixer_commit(scrtc->mixer);

As I told you already, you should be using functions pointers and just
call whatever is stored in that pointer

>  	if (event) {
>  		crtc->state->event = NULL;
> @@ -136,6 +139,7 @@ static const struct drm_crtc_funcs sun4i_crtc_funcs = {
>  
>  struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
>  				   struct sun4i_backend *backend,
> +				   struct sun8i_mixer *mixer,
>  				   struct sun4i_tcon *tcon)
>  {
>  	struct sun4i_crtc *scrtc;
> @@ -146,10 +150,14 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
>  	if (!scrtc)
>  		return ERR_PTR(-ENOMEM);
>  	scrtc->backend = backend;
> +	scrtc->mixer = mixer;
>  	scrtc->tcon = tcon;
>  
>  	/* Create our layers */
> -	scrtc->layers = sun4i_layers_init(drm, scrtc->backend);
> +	if (backend)
> +		scrtc->layers = sun4i_layers_init(drm, backend);
> +	else if (mixer)
> +		scrtc->layers = sun8i_layers_init(drm, mixer);

Same thing here.

>  	if (IS_ERR(scrtc->layers)) {
>  		dev_err(drm->dev, "Couldn't create the planes\n");
>  		return NULL;
> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.h b/drivers/gpu/drm/sun4i/sun4i_crtc.h
> index 230cb8f0d601..5783579e9c3c 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.h
> @@ -18,6 +18,7 @@ struct sun4i_crtc {
>  	struct drm_pending_vblank_event	*event;
>  
>  	struct sun4i_backend		*backend;
> +	struct sun8i_mixer		*mixer;
>  	struct sun4i_tcon		*tcon;
>  	struct sun4i_layer		**layers;
>  };
> @@ -29,6 +30,7 @@ static inline struct sun4i_crtc *drm_crtc_to_sun4i_crtc(struct drm_crtc *crtc)
>  
>  struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
>  				   struct sun4i_backend *backend,
> +				   struct sun8i_mixer *mixer,
>  				   struct sun4i_tcon *tcon);
>  
>  #endif /* _SUN4I_CRTC_H_ */
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index 767bbadcc85d..e78b8aaa4019 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -304,6 +304,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
>  	{ .compatible = "allwinner,sun6i-a31-display-engine" },
>  	{ .compatible = "allwinner,sun6i-a31s-display-engine" },
>  	{ .compatible = "allwinner,sun8i-a33-display-engine" },
> +	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_drv_of_table);
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.h b/drivers/gpu/drm/sun4i/sun4i_drv.h
> index 5df50126ff52..00506b99816a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.h
> @@ -18,6 +18,7 @@
>  
>  struct sun4i_drv {
>  	struct sun4i_backend	*backend;
> +	struct sun8i_mixer	*mixer;

I don't think you need to store the mixer pointer both in the CRTC and
the main structure.

>  	struct sun4i_tcon	*tcon;
>  
>  	struct drm_fbdev_cma	*fbdev;
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
> index f26bde5b9117..356253142c60 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -16,49 +16,63 @@
>  #include <drm/drmP.h>
>  
>  #include "sun4i_backend.h"
> +#include "sun8i_mixer.h"
>  #include "sun4i_layer.h"
>  
>  struct sun4i_plane_desc {
>  	       enum drm_plane_type     type;
> +	       /* Pipe is not used in sun8i-mixer */
>  	       u8                      pipe;
>  	       const uint32_t          *formats;
>  	       uint32_t                nformats;
>  };
>  
> -static int sun4i_backend_layer_atomic_check(struct drm_plane *plane,
> +static int sun4i_layer_atomic_check(struct drm_plane *plane,
>  					    struct drm_plane_state *state)
>  {
>  	return 0;
>  }

And there's no reason to share the layers code. The formats supported
are likely to be different, the constraints will be, and there's no
code to share at all, since the registers are not the same.

Just create a new one.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/3eb7b871/attachment-0001.sig>
