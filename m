From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 08 Apr 2014 08:36:05 +0200
Subject: [PATCH v12][ 07/12] drm: drm_display_mode: add signal polarity
 flags
In-Reply-To: <1396874691-27954-7-git-send-email-denis@eukrea.com>
References: <1396874691-27954-1-git-send-email-denis@eukrea.com>
 <1396874691-27954-7-git-send-email-denis@eukrea.com>
Message-ID: <534398D5.4090600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On 04/07/2014 02:44 PM, Denis Carikli wrote:
> We need a way to pass signal polarity informations
>   between DRM panels, and the display drivers.
> 
> To do that, a pol_flags field was added to drm_display_mode.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v11->v12:
> - Rebased: This patch now applies against drm_modes.h
> - Rebased: It now uses the new DRM_MODE_FLAG_POL_DE flags defines names
> 
> ChangeLog v10->v11:
> - Since the imx-drm won't be able to retrive its regulators
>   from the device tree when using display-timings nodes,
>   and that I was told that the drm simple-panel driver 
>   already supported that, I then, instead, added what was
>   lacking to make the eukrea displays work with the
>   drm-simple-panel driver.
> 
>   That required a way to get back the display polarity
>   informations from the imx-drm driver without affecting
>   userspace.
> ---
>  include/drm/drm_modes.h |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
> index 2dbbf99..b3789e2 100644
> --- a/include/drm/drm_modes.h
> +++ b/include/drm/drm_modes.h
> @@ -93,6 +93,13 @@ enum drm_mode_status {
>  
>  #define DRM_MODE_FLAG_3D_MAX	DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF
>  
> +#define DRM_MODE_FLAG_POL_PIXDATA_NEGEDGE	BIT(1)
> +#define DRM_MODE_FLAG_POL_PIXDATA_POSEDGE	BIT(2)
> +#define DRM_MODE_FLAG_POL_PIXDATA_PRESERVE	BIT(3)

What is the purpose of DRM_MODE_FLAG_POL_PIXDATA_PRESERVE?
If 'preserve' means 'ignore' we can set to zero negedge and posedge bits
instead of adding new bit. If it is something different please describe it.

> +#define DRM_MODE_FLAG_POL_DE_LOW		BIT(4)
> +#define DRM_MODE_FLAG_POL_DE_HIGH		BIT(5)
> +#define DRM_MODE_FLAG_POL_DE_PRESERVE		BIT(6)
> +

The same comments here.

>  struct drm_display_mode {
>  	/* Header */
>  	struct list_head head;
> @@ -144,6 +151,7 @@ struct drm_display_mode {
>  	int vrefresh;		/* in Hz */
>  	int hsync;		/* in kHz */
>  	enum hdmi_picture_aspect picture_aspect_ratio;
> +	unsigned int pol_flags;

Adding field and macros description to the DocBook would be nice.

Regards
Andrzej

>  };
>  
>  /* mode specified on the command line */
> 
