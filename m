From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 9 Aug 2016 17:29:02 +0200
Subject: [PATCH] iommu/exynos: Modify error handling
In-Reply-To: <20160801061838.GA17805@amitoj-Inspiron-3542>
References: <20160801061838.GA17805@amitoj-Inspiron-3542>
Message-ID: <20160809152902.GC29650@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2016 at 11:48:38AM +0530, Amitoj Kaur Chawla wrote:
> of_platform_device_create returns NULL on error so an IS_ERR test is
> incorrect here and a NULL check is required.
> 
> The Coccinelle semantic patch used to make this change is as follows:
> @@
> expression e;
> @@
> 
>   e = of_platform_device_create(...);
> if(
> -    IS_ERR(e)
> +    !e
>     )
>     {
>   <+...
>   return
> - PTR_ERR(e)
> + -ENODEV
>   ;
>   ...+>
>   }
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
>  drivers/iommu/exynos-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch didn't apply cleanly against v4.8-rc1, but I fixed it up and it is
now in my tree, thanks.
