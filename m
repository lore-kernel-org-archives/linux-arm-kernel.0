From: tanxiaojun@huawei.com (Tan Xiaojun)
Date: Mon, 14 Sep 2015 10:23:30 +0800
Subject: [PATCH] CMA: fix CONFIG_CMA_SIZE_MBYTES overflow in 64bit
In-Reply-To: <1441599672-1360-1-git-send-email-tanxiaojun@huawei.com>
References: <1441599672-1360-1-git-send-email-tanxiaojun@huawei.com>
Message-ID: <55F62FA2.8000006@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, please review and give some suggestions.

Any suggestion by anyone is fine to me.

Thanks
Xiaojun

On 2015/9/7 12:21, Tan Xiaojun wrote:
> In 64bit system, if you set CONFIG_CMA_SIZE_MBYTES>=2048, it will
> overflow and size_bytes will be a big wrong number.
> 
> Set CONFIG_CMA_SIZE_MBYTES=2048 and you will get an info below
> during system boot:
> 
> *********
> cma: Failed to reserve 17592186042368 MiB
> *********
> 
> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
> ---
>  drivers/base/dma-contiguous.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 950fff9..426ba27 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -46,7 +46,7 @@ struct cma *dma_contiguous_default_area;
>   * Users, who want to set the size of global CMA area for their system
>   * should use cma= kernel parameter.
>   */
> -static const phys_addr_t size_bytes = CMA_SIZE_MBYTES * SZ_1M;
> +static const phys_addr_t size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
>  static phys_addr_t size_cmdline = -1;
>  static phys_addr_t base_cmdline;
>  static phys_addr_t limit_cmdline;
> 
