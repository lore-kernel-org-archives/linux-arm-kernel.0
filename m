From: robherring2@gmail.com (Rob Herring)
Date: Fri, 14 Dec 2012 08:06:07 -0600
Subject: [PATCH 1/2] ARM: SH-Mobile: sh73a0: Secondary CPUs handle own
 SCU flags
In-Reply-To: <1354795719-5578-1-git-send-email-hechtb+renesas@gmail.com>
References: <1354795719-5578-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <50CB324F.4090405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2012 06:08 AM, Bastian Hecht wrote:
> From: Bastian Hecht <hechtb@gmail.com>
> 
> When booting secondary CPUs we have used the main CPU to set up the
> Snoop Control Unit flags of these CPUs. It is a cleaner approach
> if every CPU takes care of its own flags. We avoid the need for
> locking and the program logic is more concise. With this patch the file
> headsmp-sh73a0.S is added that contains a startup vector for secondary CPUs
> that sets up its own SCU flags.
> Further in sh73a0_smp_prepare_cpus() we can rely on the generic ARM helper
> scu_power_mode(). This is possible as we don't cross borders anymore (every
> CPU handles its own flags) and need no locking. So we can throw out the
> needless function modify_scu_cpu_psr().
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/Makefile              |    2 +-
>  arch/arm/mach-shmobile/headsmp-sh73a0.S      |   50 ++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/common.h |    1 +
>  arch/arm/mach-shmobile/smp-sh73a0.c          |   30 +++-------------
>  4 files changed, 56 insertions(+), 27 deletions(-)
>  create mode 100644 arch/arm/mach-shmobile/headsmp-sh73a0.S
> 
> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
> index fe2c97c..a7beb61 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -17,7 +17,7 @@ obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o clock-emev2.o
>  # SMP objects
>  smp-y				:= platsmp.o headsmp.o
>  smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
> -smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o
> +smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-sh73a0.o
>  smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o
>  smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o
>  
> diff --git a/arch/arm/mach-shmobile/headsmp-sh73a0.S b/arch/arm/mach-shmobile/headsmp-sh73a0.S
> new file mode 100644
> index 0000000..bec4c0d
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/headsmp-sh73a0.S
> @@ -0,0 +1,50 @@
> +/*
> + * SMP support for SoC sh73a0
> + *
> + * Copyright (C) 2012 Bastian Hecht
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA
> + */
> +
> +#include <linux/linkage.h>
> +#include <linux/init.h>
> +#include <asm/memory.h>
> +
> +	__CPUINIT
> +/*
> + * Reset vector for secondary CPUs.
> + *
> + * First we turn on L1 cache coherency for our CPU. Then we jump to
> + * shmobile_invalidate_start that invalidates the cache and hands over control
> + * to the common ARM startup code.
> + * This function will be mapped to address 0 by the SBAR register.
> + * A normal branch is out of range here so we need a long jump. We jump to
> + * the physical address as the MMU is still turned off.
> + */
> +	.align	12
> +ENTRY(sh73a0_secondary_vector)
> +	mrc     p15, 0, r0, c0, c0, 5	@ read MIPDR
> +	and	r0, r0, #3		@ mask out cpu ID
> +	lsl	r0, r0, #3		@ we will shift by cpu_id * 8 bits
> +	mov	r1, #0xf0000000		@ SCU base address


> +	ldr	r2, [r1, #8]		@ SCU Power Status Register
> +	mov	r3, #3
> +	bic	r2, r2, r3, lsl r0	@ Clear bits of our CPU (Run Mode)
> +	str	r2, [r1, #8]		@ write back
> +
> +	ldr	pc, 1f
> +1:	.long shmobile_invalidate_start - PAGE_OFFSET + PLAT_PHYS_OFFSET
> +ENDPROC(sh73a0_secondary_vector)
> diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
> index d47e215..f2e2c29 100644
> --- a/arch/arm/mach-shmobile/include/mach/common.h
> +++ b/arch/arm/mach-shmobile/include/mach/common.h
> @@ -54,6 +54,7 @@ extern void sh73a0_add_early_devices(void);
>  extern void sh73a0_add_standard_devices(void);
>  extern void sh73a0_clock_init(void);
>  extern void sh73a0_pinmux_init(void);
> +extern void sh73a0_secondary_vector(void);
>  extern struct clk sh73a0_extal1_clk;
>  extern struct clk sh73a0_extal2_clk;
>  extern struct clk sh73a0_extcki_clk;
> diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
> index 624f00f..5e36f5d 100644
> --- a/arch/arm/mach-shmobile/smp-sh73a0.c
> +++ b/arch/arm/mach-shmobile/smp-sh73a0.c
> @@ -41,9 +41,6 @@ static void __iomem *scu_base_addr(void)
>  	return (void __iomem *)0xf0000000;
>  }
>  
> -static DEFINE_SPINLOCK(scu_lock);
> -static unsigned long tmp;
> -
>  #ifdef CONFIG_HAVE_ARM_TWD
>  static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, 0xf0000600, 29);
>  void __init sh73a0_register_twd(void)
> @@ -52,20 +49,6 @@ void __init sh73a0_register_twd(void)
>  }
>  #endif
>  
> -static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
> -{
> -	void __iomem *scu_base = scu_base_addr();
> -
> -	spin_lock(&scu_lock);
> -	tmp = __raw_readl(scu_base + 8);
> -	tmp &= ~clr;
> -	tmp |= set;
> -	spin_unlock(&scu_lock);
> -
> -	/* disable cache coherency after releasing the lock */
> -	__raw_writel(tmp, scu_base + 8);

None of this locking was needed as the power status register is byte
accessible.

> -}
> -
>  static unsigned int __init sh73a0_get_core_count(void)
>  {
>  	void __iomem *scu_base = scu_base_addr();
> @@ -82,9 +65,6 @@ static int __cpuinit sh73a0_boot_secondary(unsigned int cpu, struct task_struct
>  {
>  	cpu = cpu_logical_map(cpu);
>  
> -	/* enable cache coherency */
> -	modify_scu_cpu_psr(0, 3 << (cpu * 8));
> -

So simply changing this to scu_power_mode call would accomplish the same
thing and avoid all the assembly.

Rob

>  	if (((__raw_readl(PSTR) >> (4 * cpu)) & 3) == 3)
>  		__raw_writel(1 << cpu, WUPCR);	/* wake up */
>  	else
> @@ -95,16 +75,14 @@ static int __cpuinit sh73a0_boot_secondary(unsigned int cpu, struct task_struct
>  
>  static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
>  {
> -	int cpu = cpu_logical_map(0);
> -
>  	scu_enable(scu_base_addr());
>  
> -	/* Map the reset vector (in headsmp.S) */
> +	/* Map the reset vector (in headsmp-sh73a0.S) */
>  	__raw_writel(0, APARMBAREA);      /* 4k */
> -	__raw_writel(__pa(shmobile_secondary_vector), SBAR);
> +	__raw_writel(__pa(sh73a0_secondary_vector), SBAR);
>  
> -	/* enable cache coherency on CPU0 */
> -	modify_scu_cpu_psr(0, 3 << (cpu * 8));
> +	/* enable cache coherency on booting CPU */
> +	scu_power_mode(scu_base_addr(), SCU_PM_NORMAL);
>  }
>  
>  static void __init sh73a0_smp_init_cpus(void)
> 
