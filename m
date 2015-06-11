From: alex.williamson@redhat.com (Alex Williamson)
Date: Thu, 11 Jun 2015 15:11:55 -0600
Subject: [PATCH v3 1/4] VFIO: platform: add reset struct and lookup table
In-Reply-To: <1434024527-13869-2-git-send-email-eric.auger@linaro.org>
References: <1434024527-13869-1-git-send-email-eric.auger@linaro.org>
 <1434024527-13869-2-git-send-email-eric.auger@linaro.org>
Message-ID: <1434057115.4927.211.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-06-11 at 14:08 +0200, Eric Auger wrote:
> This patch introduces the vfio_platform_reset_combo struct that
> stores all the information useful to handle the reset modality:
> compat string, name of the reset function, name of the module that
> implements the reset function. A lookup table of such structures
> is added, currently containing a single sentinel element. A new
> type field is added in vfio_platform_device to store what kind of
> reset is associated to the device, if any.

The commit log no longer matches the code.

The only other thing I'm struggling with in this series is that in 0/4
you suggest that the reset modules can be in-kernel or external, but
we're making a static list here, so there's really no support for
random, user-provided reset modules.  So are we missing the mark on the
requirements?

One way I thought you could achieve your requirement would be if we did
away with the lookup table and looked for the module and function using
a pre-defined transform on the compat ID.  For instance, a compat ID of
"calxeda,hb-xgmac" would automatically request a module named
"vfio-platform-reset-calxedahb-xgmac" and look for a symbol of the same
name for the reset function (I wonder if we can actually have a module
and symbol of the same name).  It seems fairly safe since an external
module would need to be explicitly placed in the search path for the
userspace module loader.

Otherwise the table would need to become a list, the external module
would need to be manually loaded, and the module_init() would need to
register an entry on that list.  Thanks,

Alex

> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> 
> v2 -> v3:
> - add const in struct vfio_platform_reset_combo
> - remove enum vfio_platform_reset_type
> 
> v2: creation
> ---
>  drivers/vfio/platform/vfio_platform_common.c  | 3 +++
>  drivers/vfio/platform/vfio_platform_private.h | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index abcff7a..611597e 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -25,6 +25,9 @@
>  
>  static DEFINE_MUTEX(driver_lock);
>  
> +static const struct vfio_platform_reset_combo reset_lookup_table[] = {
> +};
> +
>  static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
>  {
>  	int cnt = 0, i;
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index 5d31e04..9e37b9f 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -69,6 +69,12 @@ struct vfio_platform_device {
>  	int	(*get_irq)(struct vfio_platform_device *vdev, int i);
>  };
>  
> +struct vfio_platform_reset_combo {
> +	const char *compat;
> +	const char *reset_function_name;
> +	const char *module_name;
> +};
> +
>  extern int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>  				      struct device *dev);
>  extern struct vfio_platform_device *vfio_platform_remove_common
