From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Fri, 14 Oct 2011 16:17:14 +0200
Subject: [PATCH v5 2/2] iommu/exynos: Add iommu driver for Exynos Platforms
In-Reply-To: <000501cc897f$fa0204f0$ee060ed0$%cho@samsung.com>
References: <000501cc897f$fa0204f0$ee060ed0$%cho@samsung.com>
Message-ID: <20111014141714.GD2198@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 04:13:23AM -0400, KyongHo Cho wrote:
> +struct exynos_iommu_domain {
> +       struct device *dev;
> +       unsigned long *pgtable;
> +       spinlock_t lock;
> +       spinlock_t pgtablelock;
> +};

Can you please add comments to document what these spinlocks protect?

> +static int exynos_iommu_attach_device(struct iommu_domain *domain,
> +                                  struct device *dev)
> +{
> +       struct exynos_iommu_domain *priv = domain->priv;
> +       int ret;
> +
> +       spin_lock(&priv->lock);
> +
> +       priv->dev = dev;
> +
> +       spin_unlock(&priv->lock);
> +
> +       ret = exynos_iommu_enable(domain);
> +
> +       return ret;
> +}
> +
> +static void exynos_iommu_detach_device(struct iommu_domain *domain,
> +                                   struct device *dev)
> +{
> +       struct exynos_iommu_domain *priv = domain->priv;
> +
> +       spin_lock(&priv->lock);
> +
> +       if (priv->dev == dev) {
> +               priv->dev = NULL;
> +
> +               spin_unlock(&priv->lock);
> +
> +               exynos_iommu_disable(domain);
> +       } else {
> +               spin_unlock(&priv->lock);
> +       }
> +}

That looks weird. As I read this code there is a 1-1 mapping between a
device and a domain. This breaks semantics of the iommu-api where a
domain can contain multiple devices.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
