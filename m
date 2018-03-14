From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Mar 2018 12:38:18 -0700
Subject: [PATCH] ARM: B15: Update to support Brahma-B53
In-Reply-To: <20180223204110.6350-1-f.fainelli@gmail.com>
References: <20180223204110.6350-1-f.fainelli@gmail.com>
Message-ID: <a7fcb8a8-cbf2-ac4e-056c-e942f1756994@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2018 12:41 PM, Florian Fainelli wrote:
> The B53 CPU design supports up to 8 processors, which moved the RAC_FLUSH_REG
> offset 0x4 bytes below to make room for a RAC_CONFIG2_REG to control RAC
> settings for CPU4-7.
> 
> Lookup the processor type (B15 or B53) and adjust the RAC_FLUSH_REG offset
> accordingly, if we do not know the processor, bail out.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Russell, should this be sent to your patch tracker, or would you prefer
that these changes be part of future Broadcom ARM SoC pull requests?
Either way is fine with me.

Thanks!

> ---
>  arch/arm/mm/cache-b15-rac.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-b15-rac.c b/arch/arm/mm/cache-b15-rac.c
> index d9586ba2e63c..c6ed14840c3c 100644
> --- a/arch/arm/mm/cache-b15-rac.c
> +++ b/arch/arm/mm/cache-b15-rac.c
> @@ -33,7 +33,10 @@ extern void v7_flush_kern_cache_all(void);
>  #define  RAC_CPU_SHIFT			(8)
>  #define  RACCFG_MASK			(0xff)
>  #define RAC_CONFIG1_REG			(0x7c)
> -#define RAC_FLUSH_REG			(0x80)
> +/* Brahma-B15 is a quad-core only design */
> +#define B15_RAC_FLUSH_REG		(0x80)
> +/* Brahma-B53 is an octo-core design */
> +#define B53_RAC_FLUSH_REG		(0x84)
>  #define  FLUSH_RAC			(1 << 0)
>  
>  /* Bitmask to enable instruction and data prefetching with a 256-bytes stride */
> @@ -52,6 +55,7 @@ static void __iomem *b15_rac_base;
>  static DEFINE_SPINLOCK(rac_lock);
>  
>  static u32 rac_config0_reg;
> +static u32 rac_flush_offset;
>  
>  /* Initialization flag to avoid checking for b15_rac_base, and to prevent
>   * multi-platform kernels from crashing here as well.
> @@ -70,14 +74,14 @@ static inline void __b15_rac_flush(void)
>  {
>  	u32 reg;
>  
> -	__raw_writel(FLUSH_RAC, b15_rac_base + RAC_FLUSH_REG);
> +	__raw_writel(FLUSH_RAC, b15_rac_base + rac_flush_offset);
>  	do {
>  		/* This dmb() is required to force the Bus Interface Unit
>  		 * to clean oustanding writes, and forces an idle cycle
>  		 * to be inserted.
>  		 */
>  		dmb();
> -		reg = __raw_readl(b15_rac_base + RAC_FLUSH_REG);
> +		reg = __raw_readl(b15_rac_base + rac_flush_offset);
>  	} while (reg & FLUSH_RAC);
>  }
>  
> @@ -287,7 +291,7 @@ static struct syscore_ops b15_rac_syscore_ops = {
>  
>  static int __init b15_rac_init(void)
>  {
> -	struct device_node *dn;
> +	struct device_node *dn, *cpu_dn;
>  	int ret = 0, cpu;
>  	u32 reg, en_mask = 0;
>  
> @@ -305,6 +309,24 @@ static int __init b15_rac_init(void)
>  		goto out;
>  	}
>  
> +	cpu_dn = of_get_cpu_node(0, NULL);
> +	if (!cpu_dn) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (of_device_is_compatible(cpu_dn, "brcm,brahma-b15"))
> +		rac_flush_offset = B15_RAC_FLUSH_REG;
> +	else if (of_device_is_compatible(cpu_dn, "brcm,brahma-b53"))
> +		rac_flush_offset = B53_RAC_FLUSH_REG;
> +	else {
> +		pr_err("Unsupported CPU\n");
> +		of_node_put(cpu_dn);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	of_node_put(cpu_dn);
> +
>  	ret = register_reboot_notifier(&b15_rac_reboot_nb);
>  	if (ret) {
>  		pr_err("failed to register reboot notifier\n");
> 


-- 
Florian
