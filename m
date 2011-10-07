From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 Oct 2011 16:16:47 +0100
Subject: [PATCH 5/7] ARM: EXYNOS4: Add support external GIC
In-Reply-To: <4E8ECA1B.5010005@arm.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
	<1308555258-4322-6-git-send-email-chaos.youn@samsung.com>
	<4E8C61C4.9090709@arm.com>
	<00ec01cc83f1$81f84430$85e8cc90$%kim@samsung.com>
	<4E8D645D.4020601@arm.com> <4E8ECA1B.5010005@arm.com>
Message-ID: <20111007151646.GA2398@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Fri, Oct 07, 2011 at 10:44:59AM +0100, Marc Zyngier wrote:
> So to make my suggestion completely clear, here's a patch I'm now
> carrying in my tree. It's only been test compiled on EXYNOS4, but works
> nicely on my 11MP. It turns both dist_base and cpu_base into per-cpu
> variables, removes these callbacks, removes your private copy of
> gic_cpu_init, and makes struct gic_chip_data private again.
> 
> What do you think?

This looks like the right sort of idea, although I'm deeply suspicious about
per-cpu base addresses for the GIC distributor. It would be nice if the
Samsung guys can elaborate on what's going on here. Few comments inline.

> Subject: [PATCH] ARM: gic: allow GIC to support non-banked setups
> 
> The GIC support code is heavily using the fact that hardware
> implementations are exposing banked registers. Unfortunately, it
> looks like at least one GIC implementation (EXYNOS4) offers both
> the distributor and the CPU interfaces at different addresses,
> depending on the CPU.
> 
> This problem is solved by turning the distributor and CPU interface
> addresses into per-cpu variables. The EXYNOS4 code is updated not
> to mess with the GIC internals while handling interrupts, and
> struct gic_chip_data is back to being private.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/common/gic.c               |   76 +++++++++++++++++++++++++++--------
>  arch/arm/include/asm/hardware/gic.h |   17 +------
>  arch/arm/mach-exynos4/cpu.c         |   14 ------
>  arch/arm/mach-exynos4/platsmp.c     |   28 ++-----------
>  4 files changed, 66 insertions(+), 69 deletions(-)
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index b574931..c7521dd 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -37,6 +37,20 @@
>  #include <asm/mach/irq.h>
>  #include <asm/hardware/gic.h>
>  
> +struct gic_chip_data {
> +	unsigned int irq_offset;
> +	void __percpu __iomem **dist_base;
> +	void __percpu __iomem **cpu_base;
> +#ifdef CONFIG_CPU_PM
> +	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
> +	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
> +	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
> +	u32 __percpu *saved_ppi_enable;
> +	u32 __percpu *saved_ppi_conf;
> +#endif
> +	unsigned int gic_irqs;
> +};

I think you can use DECLARE_PER_CPU(void __iomem *dist_base) etc. instead.

> +static inline void __iomem *gic_data_dist_base(struct gic_chip_data *data)
> +{
> +	return *__this_cpu_ptr(data->dist_base);
> +}

Then you can use __get_cpu_var here (same applies throughout).

> +static void __cpuinit exynos4_secondary_init(unsigned int cpu)
>  {
>  	void __iomem *dist_base = S5P_VA_GIC_DIST +
> -				(gic_bank_offset * smp_processor_id());
> +				(gic_bank_offset * cpu_logical_map(cpu));

Again, I'm deeply suspicious of this code :) Is there not a common memory
alias for the distributor across all of the CPUs?

Will
