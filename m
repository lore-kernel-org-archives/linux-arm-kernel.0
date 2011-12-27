From: robherring2@gmail.com (Rob Herring)
Date: Tue, 27 Dec 2011 10:54:54 -0600
Subject: [PATCH 1/2] ARM: imx: add dt support of IRAM
In-Reply-To: <1324949596-27214-1-git-send-email-jason.chen@linaro.org>
References: <1324949596-27214-1-git-send-email-jason.chen@linaro.org>
Message-ID: <4EF9F85E.5020203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/26/2011 07:33 PM, Jason Chen wrote:
> Signed-off-by: Jason Chen <jason.chen@linaro.org>
> Signed-off-by: Eric Miao <eric.miao@linaro.org>
> ---
>  arch/arm/plat-mxc/include/mach/iram.h |    6 ++++++
>  arch/arm/plat-mxc/iram_alloc.c        |   16 ++++++++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> 

Whatever happened to the generic SRAM support? That with a common DT
binding and init would be better.

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-May/051472.html

Rob

> diff --git a/arch/arm/plat-mxc/include/mach/iram.h b/arch/arm/plat-mxc/include/mach/iram.h
> index 022690c..f8372cf 100644
> --- a/arch/arm/plat-mxc/include/mach/iram.h
> +++ b/arch/arm/plat-mxc/include/mach/iram.h
> @@ -21,6 +21,7 @@
>  #ifdef CONFIG_IRAM_ALLOC
>  
>  int __init iram_init(unsigned long base, unsigned long size);
> +int __init of_iram_init(void);
>  void __iomem *iram_alloc(unsigned int size, unsigned long *dma_addr);
>  void iram_free(unsigned long dma_addr, unsigned int size);
>  
> @@ -31,6 +32,11 @@ static inline int __init iram_init(unsigned long base, unsigned long size)
>  	return -ENOMEM;
>  }
>  
> +static inline int __init of_iram_init(void)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline void __iomem *iram_alloc(unsigned int size, unsigned long *dma_addr)
>  {
>  	return NULL;
> diff --git a/arch/arm/plat-mxc/iram_alloc.c b/arch/arm/plat-mxc/iram_alloc.c
> index 074c386..f73ca9d 100644
> --- a/arch/arm/plat-mxc/iram_alloc.c
> +++ b/arch/arm/plat-mxc/iram_alloc.c
> @@ -22,6 +22,8 @@
>  #include <linux/module.h>
>  #include <linux/spinlock.h>
>  #include <linux/genalloc.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <mach/iram.h>
>  
>  static unsigned long iram_phys_base;
> @@ -71,3 +73,17 @@ int __init iram_init(unsigned long base, unsigned long size)
>  	pr_debug("i.MX IRAM pool: %ld KB at 0x%p\n", size / 1024, iram_virt_base);
>  	return 0;
>  }
> +
> +int __init of_iram_init(void)
> +{
> +	struct device_node *np;
> +	struct resource res;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx-iram");
> +	if (of_address_to_resource(np, 0, &res))
> +		return -EINVAL;
> +	if (res.start && (res.end > res.start))
> +		return iram_init(res.start, res.end - res.start + 1);
> +	else
> +		return -EINVAL;
> +}
