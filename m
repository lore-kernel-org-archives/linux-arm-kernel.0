From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Tue, 23 Aug 2011 16:07:46 +0200
Subject: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
In-Reply-To: <1313622608-30397-2-git-send-email-ohad@wizery.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-2-git-send-email-ohad@wizery.com>
Message-ID: <20110823140746.GP2079@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2011 at 07:10:02PM -0400, Ohad Ben-Cohen wrote:
> +/**
> + * omap_iommu_attach() - attach iommu device to an iommu domain
> + * @dev:       target omap iommu device
> + * @iopgd:     page table
>   **/
> -struct iommu *iommu_get(const char *name)
> +static struct iommu *omap_iommu_attach(struct device *dev, u32 *iopgd)
>  {
>         int err = -ENOMEM;
> -       struct device *dev;
> -       struct iommu *obj;
> -
> -       dev = driver_find_device(&omap_iommu_driver.driver, NULL, (void *)name,
> -                                device_match_by_alias);
> -       if (!dev)
> -               return ERR_PTR(-ENODEV);
> -
> -       obj = to_iommu(dev);
> +       struct iommu *obj = to_iommu(dev);
> 
>         mutex_lock(&obj->iommu_lock);

I don't think using a mutex here is a good idea. This prevents this
function to be called from atomic context. The iommu_map and _unmap
functions need to allowed in atomic-context and I don't want different
context constraints within the iommu-api. Can this be easily converted
to a spin_lock?

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
