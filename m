From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 07 Jul 2011 19:14:02 -0700
Subject: [RFC PATCH 12/17] ARM: kernel: add SCU reset hook
In-Reply-To: <1310053830-23779-13-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-13-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <4E1667EA.5090509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/7/2011 8:50 AM, Lorenzo Pieralisi wrote:
> When a CLUSTER is powered down the SCU must be reinitialized on
> warm-boot.
> This patch adds a hook to reset the SCU, which implies invalidating
> TAG RAMs and renabling it.
>
> The scu virtual address is saved in a static variable when the SCU
> is first enabled at boot; this allows common idle code to be
> generic and avoid relying on platform code to get the address at
> run-time.
> On warm-boot the SCU TAG RAM is invalidated and the SCU enabled if
> it is not already enabled.
>
> The reset can be skipped altogether thanks to save/restore
> framework flags.
>
> Flushing D$ cache is cumbersome since the system just comes out of
> reset, which invalidates caches in the process if needed (A9), that
> is why the scu_enable function is not reused as it is to reset the SCU.
>
> If the init function is extended, there might not be a need for
> a SCU specific hook, since the init function can be reused to
> reinitialize the SCU at boot provided it is removed from the init
> section and kept in memory.
>
> Signed-off-by: Lorenzo Pieralisi<lorenzo.pieralisi@arm.com>
> ---
>   arch/arm/include/asm/smp_scu.h |    3 ++-
>   arch/arm/kernel/smp_scu.c      |   33 ++++++++++++++++++++++++++++++---
>   2 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
> index 4eb6d00..cfaa68e 100644
> --- a/arch/arm/include/asm/smp_scu.h
> +++ b/arch/arm/include/asm/smp_scu.h
> @@ -8,7 +8,8 @@
>   #ifndef __ASSEMBLER__
>   unsigned int scu_get_core_count(void __iomem *);
>   void scu_enable(void __iomem *);
> -int scu_power_mode(void __iomem *, unsigned int);
> +int scu_power_mode(unsigned int);
> +void scu_reset(void);
>   #endif
>
>   #endif
> diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
> index a1e757c..980ced9 100644
> --- a/arch/arm/kernel/smp_scu.c
> +++ b/arch/arm/kernel/smp_scu.c
> @@ -20,6 +20,7 @@
>   #define SCU_INVALIDATE		0x0c
>   #define SCU_FPGA_REVISION	0x10
>
> +static void __iomem *scu_va;

Change log and patch doesn't seems to match. I remember suggesting
this change to Russell when "scu_power_mode()" was introduced.
His preference was to have scu_base passed as part of the API.
>   /*
>    * Get the number of CPU cores from the SCU configuration
>    */
> @@ -36,6 +37,7 @@ void __init scu_enable(void __iomem *scu_base)
>   {
>   	u32 scu_ctrl;
>
> +	scu_va = scu_base;
>   	scu_ctrl = __raw_readl(scu_base + SCU_CTRL);
>   	/* already enabled? */
>   	if (scu_ctrl&  1)
> @@ -59,7 +61,7 @@ void __init scu_enable(void __iomem *scu_base)
>    * has the side effect of disabling coherency, caches must have been
>    * flushed.  Interrupts must also have been disabled.
>    */
> -int scu_power_mode(void __iomem *scu_base, unsigned int mode)
> +int scu_power_mode(unsigned int mode)
>   {
>   	unsigned int val;
>   	int cpu = smp_processor_id();
> @@ -67,9 +69,34 @@ int scu_power_mode(void __iomem *scu_base, unsigned int mode)
>   	if (mode>  3 || mode == 1 || cpu>  3)
>   		return -EINVAL;
>
> -	val = __raw_readb(scu_base + SCU_CPU_STATUS + cpu)&  ~0x03;
> +	val = __raw_readb(scu_va + SCU_CPU_STATUS + cpu)&  ~0x03;
>   	val |= mode;
> -	__raw_writeb(val, scu_base + SCU_CPU_STATUS + cpu);
> +	__raw_writeb(val, scu_va + SCU_CPU_STATUS + cpu);
>
>   	return 0;
>   }
> +
> +/*
> + * Reinitialise the SCU after power-down
> + */
> +
> +void scu_reset(void)
> +{
> +	u32 scu_ctrl;
> +
> +	scu_ctrl = __raw_readl(scu_va + SCU_CTRL);
> +	/* already enabled? */
> +	if (scu_ctrl&  1)
> +		return;
> +	/*
> +	 * SCU TAGS should be invalidated on boot-up
> +	 */
> +	__raw_writel(0xffff, scu_va + SCU_INVALIDATE);
> +	/*
> +	 *  Coming out of reset, dcache invalidated
> +	 *  no need to go through the whole hog again
> +	 *  just enable the SCU and pop out
> +	 */
> +	scu_ctrl |= 1;
> +	__raw_writel(scu_ctrl, scu_va + SCU_CTRL);
> +}
