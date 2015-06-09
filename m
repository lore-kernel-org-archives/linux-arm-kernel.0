From: alex.williamson@redhat.com (Alex Williamson)
Date: Tue, 09 Jun 2015 12:26:14 -0600
Subject: [PATCH v2 1/4] VFIO: platform: add reset struct and lookup table
In-Reply-To: <1433516792-16397-2-git-send-email-eric.auger@linaro.org>
References: <1433516792-16397-1-git-send-email-eric.auger@linaro.org>
 <1433516792-16397-2-git-send-email-eric.auger@linaro.org>
Message-ID: <1433874374.4927.114.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-06-05 at 17:06 +0200, Eric Auger wrote:
> This patch introduces the vfio_platform_reset_combo struct that
> stores all the information useful to handle the reset modality:
> compat string, name of the reset function, name of the module that
> implements the reset function. A lookup table of such structures
> is added, currently containing a single sentinel element. A new
> type field is added in vfio_platform_device to store what kind of
> reset is associated to the device, if any.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> ---
>  drivers/vfio/platform/vfio_platform_common.c  |  6 ++++++
>  drivers/vfio/platform/vfio_platform_private.h | 12 ++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index abcff7a..d970776 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -25,6 +25,12 @@
>  
>  static DEFINE_MUTEX(driver_lock);
>  
> +static const struct vfio_platform_reset_combo reset_lookup_table[] = {
> +	{
> +		.type = VFIO_PLATFORM_RESET_TYPE_MAX
> +	},
> +};
> +
>  static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
>  {
>  	int cnt = 0, i;
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index 5d31e04..d864124 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -49,6 +49,10 @@ struct vfio_platform_region {
>  	void __iomem		*ioaddr;
>  };
>  
> +enum vfio_platform_reset_type {
> +	VFIO_PLATFORM_RESET_TYPE_MAX /* last element */,
> +};
> +
>  struct vfio_platform_device {
>  	struct vfio_platform_region	*regions;
>  	u32				num_regions;
> @@ -56,6 +60,7 @@ struct vfio_platform_device {
>  	u32				num_irqs;
>  	int				refcnt;
>  	struct mutex			igate;
> +	enum vfio_platform_reset_type	type;
>  
>  	/*
>  	 * These fields should be filled by the bus specific binder
> @@ -69,6 +74,13 @@ struct vfio_platform_device {
>  	int	(*get_irq)(struct vfio_platform_device *vdev, int i);
>  };
>  
> +struct vfio_platform_reset_combo {
> +	enum vfio_platform_reset_type type;
> +	char *compat;
> +	char *reset_function_name;
> +	char *module_name;
> +};
> +

I don't really understand the benefit of vfio_platform_reset_type, what
does it add?  If we want an array end marker, we could just use NULL,
but if we're dealing with a static table, we could always use ARRAY_SIZE
and avoid an end marker altogether.  If the concern is matching the
symbol to put when the device is released, we could just use
symbol_put_addr() and avoid any sort of lookup.  Seems like there could
also be a smattering of "const" in this struct definition too.

>  extern int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>  				      struct device *dev);
>  extern struct vfio_platform_device *vfio_platform_remove_common
