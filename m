From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Wed, 04 Apr 2018 19:04:49 +0800
Subject: [PATCH] iommu: rockchip: fix building without CONFIG_OF
In-Reply-To: <20180404102401.3634085-1-arnd@arndb.de>
References: <20180404102401.3634085-1-arnd@arndb.de>
Message-ID: <5AC4B151.7060307@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amd,

Thanks for your patch.

On 04/04/2018 06:23 PM, Arnd Bergmann wrote:
> We get a build error when compiling the iommu driver without CONFIG_OF:
>
> drivers/iommu/rockchip-iommu.c: In function 'rk_iommu_of_xlate':
> drivers/iommu/rockchip-iommu.c:1101:2: error: implicit declaration of function 'of_dev_put'; did you mean 'of_node_put'? [-Werror=implicit-function-declaration]
>
oops, didn't notice that.

and checking other iommu drivers which call of_find_device_by_node() 
too, seems they didn't put() it? maybe we should fix them too

> This replaces the of_dev_put() with the equivalent platform_device_put(),
> and adds an error check for of_find_device_by_node() returning NULL,
> which seems to be appropriate here given that we pass the device into
> platform_get_drvdata() next, and that of_find_device_by_node() might
> theoretically return a NULL pointer.
hmm, i thought the of_iommu_xlate() checked that before calling us:


static int of_iommu_xlate(struct device *dev,
               struct of_phandle_args *iommu_spec)
{
...
     if ((ops && !ops->of_xlate) ||
         !of_device_is_available(iommu_spec->np) ||
         (!ops && !of_iommu_driver_present(iommu_spec->np)))
         return NO_IOMMU;
...
     return ops->of_xlate(dev, iommu_spec);


but it's better to check it ourself :)


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
> +		kfree(data);
> +		return -ENODEV;
> +	}
>
>   	data->iommu = platform_get_drvdata(iommu_dev);
>   	dev->archdata.iommu = data;
>
> -	of_dev_put(iommu_dev);
> +	platform_device_put(iommu_dev);
>
>   	return 0;
>   }
>
