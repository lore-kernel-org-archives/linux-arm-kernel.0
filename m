From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jun 2014 00:55:47 +0200
Subject: [PATCH 1/5] ARM: smp_scu: Used defined value instead of literal
 constant
In-Reply-To: <1403822608-31158-2-git-send-email-gregory.clement@free-electrons.com>
References: <1403822608-31158-1-git-send-email-gregory.clement@free-electrons.com>
 <1403822608-31158-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <53ACA4F3.2070206@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/06/2014 00:43, Gregory CLEMENT wrote:
> The first bit of the SCU control register is actually the enable
> it. So let's name it instead of using literal constant.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/kernel/smp_scu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
> index 1aafa0d785eb..cfea41b41ad0 100644
> --- a/arch/arm/kernel/smp_scu.c
> +++ b/arch/arm/kernel/smp_scu.c
> @@ -17,6 +17,7 @@
>  #include <asm/cputype.h>
>  
>  #define SCU_CTRL		0x00
> +#define SCU_CTRL_ENABLE		    BIT(1)

As Ezequiel rightly pointed it to me, this line is obviously wrong!
it should be
+#define SCU_CTRL_ENABLE		    BIT(0)

>  #define SCU_CONFIG		0x04
>  #define SCU_CPU_STATUS		0x08
>  #define SCU_INVALIDATE		0x0c
> @@ -43,17 +44,18 @@ void scu_enable(void __iomem *scu_base)
>  	/* Cortex-A9 only */
>  	if ((read_cpuid_id() & 0xff0ffff0) == 0x410fc090) {
>  		scu_ctrl = readl_relaxed(scu_base + 0x30);
> -		if (!(scu_ctrl & 1))
> -			writel_relaxed(scu_ctrl | 0x1, scu_base + 0x30);
> +		if (!(scu_ctrl & SCU_CTRL_ENABLE))
> +			writel_relaxed(scu_ctrl | SCU_CTRL_ENABLE,
> +				scu_base + 0x30);
>  	}
>  #endif
>  
>  	scu_ctrl = readl_relaxed(scu_base + SCU_CTRL);
>  	/* already enabled? */
> -	if (scu_ctrl & 1)
> +	if (scu_ctrl & SCU_CTRL_ENABLE)
>  		return;
>  
> -	scu_ctrl |= 1;
> +	scu_ctrl |= SCU_CTRL_ENABLE;
>  	writel_relaxed(scu_ctrl, scu_base + SCU_CTRL);
>  
>  	/*
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
