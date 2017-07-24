From: alex.williamson@redhat.com (Alex Williamson)
Date: Mon, 24 Jul 2017 11:24:06 -0600
Subject: [PATCH v2 1/2] vfio: Allow No-IOMMU mode without checking
 iommu_present()
In-Reply-To: <1500525154-5200-2-git-send-email-anup.patel@broadcom.com>
References: <1500525154-5200-1-git-send-email-anup.patel@broadcom.com>
 <1500525154-5200-2-git-send-email-anup.patel@broadcom.com>
Message-ID: <20170724112406.42b69c8b@w520.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Jul 2017 10:02:33 +0530
Anup Patel <anup.patel@broadcom.com> wrote:

> Not allowing No-IOMMU mode for devices already having
> iommu_ops on their bus is very conservative.
> 
> We now have IOMMU (such as ARM SMMU) which can bypass
> transcations when IOMMU is not configured for a given
> device. In addition, it is not necessary to have all
> devices on bus to be upstream to an IOMMU on that bus.
> 
> Due above reasons, having iommu_present() check for
> VFIO No-IOMMU mode is not appropriate.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> ---
>  drivers/vfio/vfio.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 330d505..9d90de7 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -124,11 +124,10 @@ struct iommu_group *vfio_iommu_group_get(struct device *dev)
>  #ifdef CONFIG_VFIO_NOIOMMU
>  	/*
>  	 * With noiommu enabled, an IOMMU group will be created for a device
> -	 * that doesn't already have one and doesn't have an iommu_ops on their
> -	 * bus.  We set iommudata simply to be able to identify these groups
> -	 * as special use and for reclamation later.
> +	 * that doesn't already have one.  We set iommudata simply to be able
> +	 * to identify these groups as special use and for reclamation later.
>  	 */
> -	if (group || !noiommu || iommu_present(dev->bus))
> +	if (group || !noiommu)
>  		return group;
>  
>  	group = iommu_group_alloc();

Nak, no-iommu is intentionally conservative.  How do we tell the
difference between the iommu_ops available to us with a fake group vs
a proper group created by the iommu if we ignore iommu_present()?  If
an iommu exists, use it.  Thanks,

Alex
