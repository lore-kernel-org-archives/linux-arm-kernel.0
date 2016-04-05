From: jroedel@suse.de (Joerg Roedel)
Date: Tue, 5 Apr 2016 13:25:36 +0200
Subject: [PATCH] iommu: provide of_xlate pointer unconditionally
In-Reply-To: <1458077877-474066-1-git-send-email-arnd@arndb.de>
References: <1458077877-474066-1-git-send-email-arnd@arndb.de>
Message-ID: <20160405112536.GB4203@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 10:37:17PM +0100, Arnd Bergmann wrote:
> iommu drivers that support the standard DT bindings use a of_xlate
> callback pointer, but that is only part of struct iommu_ops when
> CONFIG_OF_IOMMU is enabled, leading to build errors in randconfig
> builds when that is not provided:
> 
> drivers/iommu/mtk_iommu.c:497:2: error: unknown field 'of_xlate' specified in initializer
>   .of_xlate = mtk_iommu_of_xlate,
>   ^
> drivers/iommu/mtk_iommu.c:497:14: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>   .of_xlate = mtk_iommu_of_xlate,
>               ^~~~~~~~~~~~~~~~~~
> drivers/iommu/mtk_iommu.c:497:14: note: (near initialization for 'mtk_iommu_ops.domain_get_attr')
> 
> We can work around it by adding more #ifdefs in each driver, but
> it seems nicer to just allow setting the pointer even if it is
> unused. This makes the driver code look nicer, and it gives better
> compile-time coverage when test building on other architectures.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")

Applied to iommu/fixes, thanks Arnd.
