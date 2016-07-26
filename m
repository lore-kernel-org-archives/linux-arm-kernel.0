From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 26 Jul 2016 10:26:35 +0200
Subject: [PATCH 1/3] drm: introduce share plane
In-Reply-To: <1469519194-23133-1-git-send-email-mark.yao@rock-chips.com>
References: <1469519194-23133-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20160726082635.GA31475@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 03:46:32PM +0800, Mark Yao wrote:
> What is share plane:
> Plane hardware only be used when the display scanout run into plane active
> scanout, that means we can reuse the plane hardware resources on plane
> non-active scanout.
> 
>      --------------------------------------------------
>     |  scanout                                       |
>     |         ------------------                     |
>     |         | parent plane   |                     |
>     |         | active scanout |                     |
>     |         |                |   ----------------- |
>     |         ------------------   | share plane 1 | |
>     |  -----------------           |active scanout | |
>     |  | share plane 0 |           |               | |
>     |  |active scanout |           ----------------- |
>     |  |               |                             |
>     |  -----------------                             |
>     --------------------------------------------------
> One plane hardware can be reuse for multi-planes, we assume the first
> plane is parent plane, other planes share the resource with first one.
>     parent plane
>         |---share plane 0
>         |---share plane 1
>         ...
> 
> Because resource share, There are some limit on share plane: one group
> of share planes need use same zpos, can not overlap, etc.
> 
> We assume share plane is a universal plane with some limit flags.
> people who use the share plane need know the limit, should call the ioctl
> DRM_CLIENT_CAP_SHARE_PLANES, and judge the planes limit before use it.
> 
> A group of share planes would has same shard id, so userspace can
> group them, judge share plane's limit.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>

This seems extremely hw specific, why exactly do we need to add a new
relationship on planes? What does this buy on _other_ drivers?

Imo this should be solved by virtualizing planes in the driver. Start out
by assigning planes, and if you can reuse one for sharing then do that,
otherwise allocate a new one. If there's not enough real planes, fail the
atomic_check.

This seems way to hw specific to be useful as a generic concept.
-Daniel

> ---
>  drivers/gpu/drm/drm_crtc.c  | 110 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_ioctl.c |   5 ++
>  include/drm/drmP.h          |   5 ++
>  include/drm/drm_crtc.h      |  14 ++++++
>  include/uapi/drm/drm.h      |   7 +++
>  5 files changed, 141 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 9d3f80e..3a8257e 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -1426,6 +1426,96 @@ int drm_plane_init(struct drm_device *dev, struct drm_plane *plane,
>  EXPORT_SYMBOL(drm_plane_init);
>  
>  /**
> + * drm_share_plane_init - Initialize a share plane
> + * @dev: DRM device
> + * @plane: plane object to init
> + * @parent: this plane share some resources with parent plane.
> + * @possible_crtcs: bitmask of possible CRTCs
> + * @funcs: callbacks for the new plane
> + * @formats: array of supported formats (%DRM_FORMAT_*)
> + * @format_count: number of elements in @formats
> + * @type: type of plane (overlay, primary, cursor)
> + *
> + * With this API, the plane can share hardware resources with other planes.
> + *
> + *   --------------------------------------------------
> + *   |  scanout                                       |
> + *   |         ------------------                     |
> + *   |         |  parent plane  |                     |
> + *   |         | active scanout |                     |
> + *   |         |                |   ----------------- |
> + *   |         ------------------   | share plane 1 | |
> + *   |  -----------------           |active scanout | |
> + *   |  | share plane 0 |           |               | |
> + *   |  |active scanout |           ----------------- |
> + *   |  |               |                             |
> + *   |  -----------------                             |
> + *   --------------------------------------------------
> + *
> + *    parent plane
> + *        |---share plane 0
> + *        |---share plane 1
> + *        ...
> + *
> + * The plane hardware is used when the display scanout run into plane active
> + * scanout, that means we can reuse the plane hardware resources on plane
> + * non-active scanout.
> + *
> + * Because resource share, There are some limit on share plane: one group
> + * of share planes need use same zpos, can't not overlap, etc.
> + *
> + * Here assume share plane is a universal plane with some limit flags.
> + * people who use the share plane need know the limit, should call the ioctl
> + * DRM_CLIENT_CAP_SHARE_PLANES, and judge the planes limit before use it.
> + *
> + * Returns:
> + * Zero on success, error code on failure.
> + */
> +
> +int drm_share_plane_init(struct drm_device *dev, struct drm_plane *plane,
> +			 struct drm_plane *parent,
> +			 unsigned long possible_crtcs,
> +			 const struct drm_plane_funcs *funcs,
> +			 const uint32_t *formats, unsigned int format_count,
> +			 enum drm_plane_type type)
> +{
> +	struct drm_mode_config *config = &dev->mode_config;
> +	int ret;
> +	int share_id;
> +
> +	/*
> +	 * TODO: only verified on ATOMIC drm driver.
> +	 */
> +	if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
> +		return -EINVAL;
> +
> +	ret = drm_universal_plane_init(dev, plane, possible_crtcs, funcs,
> +				       formats, format_count, type, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (parent) {
> +		/*
> +		 * Can't support more than two level plane share.
> +		 */
> +		WARN_ON(parent->parent);
> +		share_id = parent->base.id;
> +		plane->parent = parent;
> +
> +		config->num_share_plane++;
> +		if (plane->type == DRM_PLANE_TYPE_OVERLAY)
> +			config->num_share_overlay_plane++;
> +	} else {
> +		share_id = plane->base.id;
> +	}
> +
> +	drm_object_attach_property(&plane->base,
> +				   config->prop_share_id, share_id);
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_share_plane_init);
> +
> +/**
>   * drm_plane_cleanup - Clean up the core plane usage
>   * @plane: plane to cleanup
>   *
> @@ -1452,6 +1542,11 @@ void drm_plane_cleanup(struct drm_plane *plane)
>  	dev->mode_config.num_total_plane--;
>  	if (plane->type == DRM_PLANE_TYPE_OVERLAY)
>  		dev->mode_config.num_overlay_plane--;
> +	if (plane->parent) {
> +		dev->mode_config.num_share_plane--;
> +		if (plane->type == DRM_PLANE_TYPE_OVERLAY)
> +			dev->mode_config.num_share_overlay_plane--;
> +	}
>  	drm_modeset_unlock_all(dev);
>  
>  	WARN_ON(plane->state && !plane->funcs->atomic_destroy_state);
> @@ -1600,6 +1695,13 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
>  		return -ENOMEM;
>  	dev->mode_config.plane_type_property = prop;
>  
> +	prop = drm_property_create_range(dev, DRM_MODE_PROP_IMMUTABLE,
> +					 "SHARE_ID", 0, UINT_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	dev->mode_config.prop_share_id = prop;
> +
>  	prop = drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
>  			"SRC_X", 0, UINT_MAX);
>  	if (!prop)
> @@ -2431,6 +2533,12 @@ int drm_mode_getplane_res(struct drm_device *dev, void *data,
>  		num_planes = config->num_total_plane;
>  	else
>  		num_planes = config->num_overlay_plane;
> +	if (!file_priv->share_planes) {
> +		if (file_priv->universal_planes)
> +			num_planes -= config->num_share_plane;
> +		else
> +			num_planes -= config->num_share_overlay_plane;
> +	}
>  
>  	/*
>  	 * This ioctl is called twice, once to determine how much space is
> @@ -2449,6 +2557,8 @@ int drm_mode_getplane_res(struct drm_device *dev, void *data,
>  			if (plane->type != DRM_PLANE_TYPE_OVERLAY &&
>  			    !file_priv->universal_planes)
>  				continue;
> +			if (plane->parent && !file_priv->share_planes)
> +				continue;
>  
>  			if (put_user(plane->base.id, plane_ptr + copied))
>  				return -EFAULT;
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 33af4a5..8b0120d 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -294,6 +294,11 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
>  			return -EINVAL;
>  		file_priv->universal_planes = req->value;
>  		break;
> +	case DRM_CLIENT_CAP_SHARE_PLANES:
> +		if (req->value > 1)
> +			return -EINVAL;
> +		file_priv->share_planes = req->value;
> +		break;
>  	case DRM_CLIENT_CAP_ATOMIC:
>  		if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
>  			return -EINVAL;
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index c2fe2cf..285d177 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -314,6 +314,11 @@ struct drm_file {
>  	/* true if client understands atomic properties */
>  	unsigned atomic:1;
>  	/*
> +	 * true if client understands share planes and
> +	 * hardware support share planes.
> +	 */
> +	unsigned share_planes:1;
> +	/*
>  	 * This client is the creator of @master.
>  	 * Protected by struct drm_device::master_mutex.
>  	 */
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 9e6ab4a..a3fe9b0 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -1660,6 +1660,7 @@ enum drm_plane_type {
>  /**
>   * struct drm_plane - central DRM plane control structure
>   * @dev: DRM device this plane belongs to
> + * @parent: this plane share some resources with parent plane.
>   * @head: for list management
>   * @name: human readable name, can be overwritten by the driver
>   * @base: base mode object
> @@ -1679,6 +1680,7 @@ enum drm_plane_type {
>   */
>  struct drm_plane {
>  	struct drm_device *dev;
> +	struct drm_plane *parent;
>  	struct list_head head;
>  
>  	char *name;
> @@ -2408,6 +2410,8 @@ struct drm_mode_config {
>  	 */
>  	int num_overlay_plane;
>  	int num_total_plane;
> +	int num_share_plane;
> +	int num_share_overlay_plane;
>  	struct list_head plane_list;
>  
>  	int num_crtc;
> @@ -2428,6 +2432,9 @@ struct drm_mode_config {
>  
>  	struct mutex blob_lock;
>  
> +	/* pointers to share properties */
> +	struct drm_property *prop_share_id;
> +
>  	/* pointers to standard properties */
>  	struct list_head property_blob_list;
>  	struct drm_property *edid_property;
> @@ -2636,6 +2643,13 @@ extern int drm_plane_init(struct drm_device *dev,
>  			  const struct drm_plane_funcs *funcs,
>  			  const uint32_t *formats, unsigned int format_count,
>  			  bool is_primary);
> +extern int drm_share_plane_init(struct drm_device *dev, struct drm_plane *plane,
> +				struct drm_plane *parent,
> +				unsigned long possible_crtcs,
> +				const struct drm_plane_funcs *funcs,
> +				const uint32_t *formats,
> +				unsigned int format_count,
> +				enum drm_plane_type type);
>  extern void drm_plane_cleanup(struct drm_plane *plane);
>  
>  /**
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 452675f..01979a4 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -677,6 +677,13 @@ struct drm_get_cap {
>   */
>  #define DRM_CLIENT_CAP_ATOMIC	3
>  
> +/**
> + * DRM_CLIENT_CAP_SHARE_PLANES
> + *
> + * If set to 1, the DRM core will expose share planes to userspace.
> + */
> +#define DRM_CLIENT_CAP_SHARE_PLANES	4
> +
>  /** DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
>  struct drm_set_client_cap {
>  	__u64 capability;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
