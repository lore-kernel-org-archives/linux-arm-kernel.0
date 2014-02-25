From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 25 Feb 2014 22:13 +0100
Subject: [PATCHv2 02/16] iommu/omap: omap_iommu_attach() should return
 ENODEV, not NULL
In-Reply-To: <1392315347-32967-3-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
 <1392315347-32967-3-git-send-email-s-anna@ti.com>
Message-ID: <2290716.T9AJoGfoRd@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

Thank you for the patch.

On Thursday 13 February 2014 12:15:33 Suman Anna wrote:
> From: Florian Vaussard <florian.vaussard@epfl.ch>
> 
> omap_iommu_attach() returns NULL or ERR_PTR in case of error, but
> omap_iommu_attach_dev() only checks for IS_ERR. Thus a NULL return value (in
> case driver_find_device fails) will cause the kernel to panic when
> omap_iommu_attach_dev() dereferences the pointer.
> 
> In such case, omap_iommu_attach() should return ENODEV, not NULL.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> Acked-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/iommu/omap-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index fff2ffd..6272c36 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -863,7 +863,7 @@ static int device_match_by_alias(struct device *dev,
> void *data) **/
>  static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
>  {
> -	int err = -ENOMEM;
> +	int err = -ENODEV;
>  	struct device *dev;
>  	struct omap_iommu *obj;
> 
> @@ -871,7 +871,7 @@ static struct omap_iommu *omap_iommu_attach(const char
> *name, u32 *iopgd) (void *)name,
>  				device_match_by_alias);
>  	if (!dev)
> -		return NULL;
> +		return ERR_PTR(err);

I would return ERR_PTR(-ENODEV) here, and remove the initialization at 
declaration of err above.

> 
>  	obj = to_iommu(dev);

-- 
Regards,

Laurent Pinchart
