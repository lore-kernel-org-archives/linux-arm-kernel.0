From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 27 Dec 2011 15:02:26 +0800
Subject: [PATCH 1/2] ARM: imx: add dt support of IRAM
In-Reply-To: <1324949596-27214-1-git-send-email-jason.chen@linaro.org>
References: <1324949596-27214-1-git-send-email-jason.chen@linaro.org>
Message-ID: <20111227070225.GA24136@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2011 at 09:33:16AM +0800, Jason Chen wrote:
> Signed-off-by: Jason Chen <jason.chen@linaro.org>
> Signed-off-by: Eric Miao <eric.miao@linaro.org>
> ---
>  arch/arm/plat-mxc/include/mach/iram.h |    6 ++++++
>  arch/arm/plat-mxc/iram_alloc.c        |   16 ++++++++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/iram.h b/arch/arm/plat-mxc/include/mach/iram.h
> index 022690c..f8372cf 100644
> --- a/arch/arm/plat-mxc/include/mach/iram.h
> +++ b/arch/arm/plat-mxc/include/mach/iram.h
> @@ -21,6 +21,7 @@
>  #ifdef CONFIG_IRAM_ALLOC
>  
>  int __init iram_init(unsigned long base, unsigned long size);
> +int __init of_iram_init(void);

It may be inherited from iram_init declaration on the above line.  But
it's really unnecessary to have '__init' for function declaration.

And I suggested the function name iram_of_init than of_iram_init for
some reason.  Looking at include/linux/of.h, you will find that all DT
core functions use naming convention of_xxx.  To differentiate from DT
core functions, we want to use iram_of_init just like what gic driver
does (gic_of_init in arch/arm/common/gic.c).

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

It's an valid case that iram starts at physical address 0.  And how
can we run into !(res.end > res.start)?  To me, it's an unnecessary
checking at all.

> +		return iram_init(res.start, res.end - res.start + 1);

We can use resource_size(&res) to help here.

Regards,
Shawn

> +	else
> +		return -EINVAL;
> +}
> -- 
> 1.7.4.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
