From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 13 Feb 2012 16:13:58 -0600
Subject: [PATCH 03/15] ARM: provide runtime hook for ioremap
In-Reply-To: <1329169408-17253-4-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-4-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FCB4EB0@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 13, 2012 2:43 PM, Rob Herring wrote:
>
> We have compile time over-ride of ioremap, but an run-time override is
> needed for multi-platform builds.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/include/asm/io.h |    5 ++++-
>  arch/arm/mm/ioremap.c     |    3 +++
>  2 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 9275828..f5c6968 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -264,8 +264,11 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>   * Documentation/io-mapping.txt.
>   *
>   */
> +
> +extern void __iomem * (*arch_ioremap)(unsigned long, size_t, unsigned int);
> +
>  #ifndef __arch_ioremap
> -#define __arch_ioremap			__arm_ioremap
> +#define __arch_ioremap			arch_ioremap
>  #define __arch_iounmap			__iounmap
>  #endif
>  
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index 80632e8..f551c13 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -314,6 +314,9 @@ __arm_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
>  }
>  EXPORT_SYMBOL(__arm_ioremap);
>  
> +void __iomem * (*arch_ioremap)(unsigned long , size_t , unsigned int ) = __arm_ioremap;
> +EXPORT_SYMBOL(arch_ioremap);
> +
>  /*
>   * Remap an arbitrary physical address space into the kernel virtual
>   * address space as memory. Needed when the kernel wants to execute

On EP93xx:

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
