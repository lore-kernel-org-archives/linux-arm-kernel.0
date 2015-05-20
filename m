From: treding@nvidia.com (Thierry Reding)
Date: Wed, 20 May 2015 13:32:33 +0200
Subject: [PATCH] drm/nouveau/platform: fix compilation if !CONFIG_IOMMU
In-Reply-To: <1432102224-15169-1-git-send-email-acourbot@nvidia.com>
References: <555BD66A.5020704@nvidia.com>
 <1432102224-15169-1-git-send-email-acourbot@nvidia.com>
Message-ID: <20150520113231.GA21937@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 03:10:24PM +0900, Alexandre Courbot wrote:
> The lack of IOMMU API support can make nouveau_platform_probe_iommu()
> fail to compile because struct iommu_ops is then empty. Fix this by
> skipping IOMMU probe in that case - lack of IOMMU on platform devices
> is sub-optimal, but is not an error.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> This is an alternative to https://lkml.org/lkml/2015/5/19/484. Most users
> of Nouveau do not care about IOMMU support, so we should not impose that
> option on them.
> 
>  drm/nouveau/nouveau_platform.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_platform.c b/drivers/gpu/drm/nouveau/nouveau_platform.c
> index 775277f1edb0..dcfbbfaf1739 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_platform.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_platform.c
> @@ -92,6 +92,8 @@ static int nouveau_platform_power_down(struct nouveau_platform_gpu *gpu)
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_IOMMU_API)
> +
>  static void nouveau_platform_probe_iommu(struct device *dev,
>  					 struct nouveau_platform_gpu *gpu)
>  {
> @@ -158,6 +160,20 @@ static void nouveau_platform_remove_iommu(struct device *dev,
>  	}
>  }
>  
> +#else
> +
> +static void nouveau_platform_probe_iommu(struct device *dev,
> +					 struct nouveau_platform_gpu *gpu)
> +{
> +}
> +
> +static void nouveau_platform_remove_iommu(struct device *dev,
> +					  struct nouveau_platform_gpu *gpu)
> +{
> +}
> +
> +#endif
> +

Since these are all static functions, perhaps an "if (IS_ENABLED(...))"
would work here? That way you'd get compile coverage of the code in all
cases.

But perhaps that doesn't work for IOMMU. I have a vague memory of
running across something like this before and IOMMU has this quirk of
defining struct iommu_ops as empty if IOMMU_API is deselected so you'll
probably get compiler errors unless you actually preprocess the code
out.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150520/b2177925/attachment.sig>
