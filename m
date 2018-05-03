From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 3 May 2018 14:46:24 +0200
Subject: [PATCH] iommu: rockchip: fix building without CONFIG_OF
In-Reply-To: <20180404102401.3634085-1-arnd@arndb.de>
References: <20180404102401.3634085-1-arnd@arndb.de>
Message-ID: <20180503124623.wjnv6smvhpblpr76@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2018 at 12:23:53PM +0200, Arnd Bergmann wrote:
> We get a build error when compiling the iommu driver without CONFIG_OF:
> 
> drivers/iommu/rockchip-iommu.c: In function 'rk_iommu_of_xlate':
> drivers/iommu/rockchip-iommu.c:1101:2: error: implicit declaration of function 'of_dev_put'; did you mean 'of_node_put'? [-Werror=implicit-function-declaration]
> 
> This replaces the of_dev_put() with the equivalent platform_device_put(),
> and adds an error check for of_find_device_by_node() returning NULL,
> which seems to be appropriate here given that we pass the device into
> platform_get_drvdata() next, and that of_find_device_by_node() might
> theoretically return a NULL pointer.
> 
> Fixes: 5fd577c3eac3 ("iommu/rockchip: Use OF_IOMMU to attach devices automatically")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This warning appears to only have been introduced in linux-next after
> the merge window opened.
> ---
>  drivers/iommu/rockchip-iommu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Changed patch according to Robins comments and applied it, thanks.
