From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Fri, 16 Feb 2018 20:20:41 +0200
Subject: [PATCH v3 1/8] drm/blend: Add a generic alpha property
In-Reply-To: <9403570d73b6eb63ab87488d5e8eb767ba6f1ac7.1518802627.git-series.maxime.ripard@bootlin.com>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
 <9403570d73b6eb63ab87488d5e8eb767ba6f1ac7.1518802627.git-series.maxime.ripard@bootlin.com>
Message-ID: <20180216182041.GU5453@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 16, 2018 at 06:39:29PM +0100, Maxime Ripard wrote:
> Some drivers duplicate the logic to create a property to store a per-plane
> alpha.
> 
> This is especially useful if we ever want to support extra protocols for
> Wayland like:
> https://lists.freedesktop.org/archives/wayland-devel/2017-August/034741.html
> 
> Let's create a helper in order to move that to the core.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/gpu/kms-properties.csv |  2 +-
>  drivers/gpu/drm/drm_atomic.c         |  4 ++++-
>  drivers/gpu/drm/drm_atomic_helper.c  |  4 ++++-
>  drivers/gpu/drm/drm_blend.c          | 32 +++++++++++++++++++++++++++++-
>  include/drm/drm_blend.h              |  1 +-
>  include/drm/drm_plane.h              |  6 +++++-
>  6 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/kms-properties.csv b/Documentation/gpu/kms-properties.csv
> index 927b65e14219..25ad3503d663 100644
> --- a/Documentation/gpu/kms-properties.csv
> +++ b/Documentation/gpu/kms-properties.csv
> @@ -99,5 +99,5 @@ radeon,DVI-I,?coherent?,RANGE,"Min=0, Max=1",Connector,TBD
>  ,,"""underscan vborder""",RANGE,"Min=0, Max=128",Connector,TBD
>  ,Audio,?audio?,ENUM,"{ ""off"", ""on"", ""auto"" }",Connector,TBD
>  ,FMT Dithering,?dither?,ENUM,"{ ""off"", ""on"" }",Connector,TBD
> -rcar-du,Generic,"""alpha""",RANGE,"Min=0, Max=255",Plane,TBD
> +,,"""alpha""",RANGE,"Min=0, Max=Driver dependant",Plane,Opacity of the plane from transparent (0) to fully opaque (MAX). If this property is set to a value different than max, and that the pixel will define an alpha component, the property will have precendance and the pixel value will be ignored.

Those semantics don't seem particularly good to me. I think we would want the
per-pixel alpha and global alpha both to be effecive at the same time. You can
always decide to ignore the per-pixel alpha by using a pixel format without
alpha.

Also, where's the userspace that wants this feature?

<snip>
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 8185e3468a23..5a6f29524f12 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -42,6 +42,7 @@ struct drm_modeset_acquire_ctx;
>   *	plane (in 16.16)
>   * @src_w: width of visible portion of plane (in 16.16)
>   * @src_h: height of visible portion of plane (in 16.16)
> + * @alpha: opacity of the plane
>   * @rotation: rotation of the plane
>   * @zpos: priority of the given plane on crtc (optional)
>   *	Note that multiple active planes on the same crtc can have an identical
> @@ -105,6 +106,9 @@ struct drm_plane_state {
>  	uint32_t src_x, src_y;
>  	uint32_t src_h, src_w;
>  
> +	/* Plane opacity */
> +	u8 alpha;

We may want to make that u16. The general we expect 16bpc for most color
related things, but since this is a range prop I suppose we should just
expose the actual hardware range. But making it u16 might avoid some head
scratching for the first person to have hardware with higher precision.
Either that or we should make the prop creation fail if the driver asks
for more bits than we have in the state.

Oh, and you should plug this into the state dumper as well.

> +
>  	/* Plane rotation */
>  	unsigned int rotation;
>  
> @@ -481,6 +485,7 @@ enum drm_plane_type {
>   * @funcs: helper functions
>   * @properties: property tracking for this plane
>   * @type: type of plane (overlay, primary, cursor)
> + * @alpha_property: alpha property for this plane
>   * @zpos_property: zpos property for this plane
>   * @rotation_property: rotation property for this plane
>   * @helper_private: mid-layer private data
> @@ -556,6 +561,7 @@ struct drm_plane {
>  	 */
>  	struct drm_plane_state *state;
>  
> +	struct drm_property *alpha_property;
>  	struct drm_property *zpos_property;
>  	struct drm_property *rotation_property;
>  };
> -- 
> git-series 0.9.1
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrj?l?
Intel OTC
