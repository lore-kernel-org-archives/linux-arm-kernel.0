From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 4 Apr 2018 12:12:33 +0100
Subject: [PATCH] iommu: rockchip: fix building without CONFIG_OF
In-Reply-To: <20180404102401.3634085-1-arnd@arndb.de>
References: <20180404102401.3634085-1-arnd@arndb.de>
Message-ID: <94d8f18d-28a3-1602-ea92-a821a2b9183c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 04/04/18 11:23, Arnd Bergmann wrote:
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
>   drivers/iommu/rockchip-iommu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 5fc8656c60f9..fe9c9cc1a9d4 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1094,11 +1094,15 @@ static int rk_iommu_of_xlate(struct device *dev,
>   		return -ENOMEM;
>   
>   	iommu_dev = of_find_device_by_node(args->np);
> +	if (!iommu_dev) {

Actually, though the logic is perhaps a bit subtle, this cannot 
reasonably happen - .of_xlate is only called via a set of iommu_ops 
associated with the IOMMU node (args->np here); those ops are only 
registered for the given node at the end of rk_iommu_probe(), by which 
point the IOMMU device exists and is otherwise successfully probed, so 
the platform bus lookup should never be able to fail.

> +		kfree(data);
> +		return -ENODEV;
> +	}
>   
>   	data->iommu = platform_get_drvdata(iommu_dev);
>   	dev->archdata.iommu = data;
>   
> -	of_dev_put(iommu_dev);
> +	platform_device_put(iommu_dev);

This bit looks reasonable, thanks for the fix.

Robin.

>   
>   	return 0;
>   }
> 
