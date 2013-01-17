From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 16 Jan 2013 21:13:00 -0800
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
References: <20130111153206.e075edb9b1e4a38d90f23ab6@canb.auug.org.au>
 <20130117145324.3f1f27fb5902b5a03135bf06@canb.auug.org.au>
Message-ID: <0c9401cdf471$53f7c140$fbe743c0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:

[...]

> Hmm, updating timer patches in Samsung tree cause the merge conflicts with
> arm-soc, so for now I dropped them in my tree just now.
> And note that regarding topic branch which are including it will be
re-worked
> soon :-)
> 
> Now to merge Samsung tree for linux-next should be fine.
> 
> Thanks again.
> 
One more, following is my preferred resolution when merge conflict happens
between Samsung tree and arm-soc tree:

8<---------------------------------------------------

diff --cc arch/arm/common/Makefile
index 55d4182,dc8dd0d..7a5df8b
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@@ -2,10 -2,6 +2,8 @@@
  # Makefile for the linux kernel.
  #
  
 +obj-y += firmware.o
 +
- obj-$(CONFIG_ARM_GIC)		+= gic.o
- obj-$(CONFIG_ARM_VIC)		+= vic.o
  obj-$(CONFIG_ICST)		+= icst.o
  obj-$(CONFIG_SA1111)		+= sa1111.o
  obj-$(CONFIG_PCI_HOST_VIA82C505) += via82c505.o
diff --cc arch/arm/mach-exynos/mach-exynos4-dt.c
index ab1dacc,112d10e..3ac73ed
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@@ -107,11 -106,9 +106,10 @@@ DT_MACHINE_START(EXYNOS4210_DT, "Samsun
  	.smp		= smp_ops(exynos_smp_ops),
  	.init_irq	= exynos4_init_irq,
  	.map_io		= exynos4_dt_map_io,
- 	.handle_irq	= gic_handle_irq,
 +	.init_early	= exynos_firmware_init,
  	.init_machine	= exynos4_dt_machine_init,
  	.init_late	= exynos_init_late,
- 	.timer		= &exynos4_timer,
+ 	.init_time	= exynos4_timer_init,
  	.dt_compat	= exynos4_dt_compat,
  	.restart        = exynos4_restart,
  MACHINE_END
diff --cc arch/arm/mach-exynos/platsmp.c
index 3226893,60f7c5b..a083e05
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@@ -20,12 -20,11 +20,12 @@@
  #include <linux/jiffies.h>
  #include <linux/smp.h>
  #include <linux/io.h>
+ #include <linux/irqchip/arm-gic.h>
  
  #include <asm/cacheflush.h>
- #include <asm/hardware/gic.h>
  #include <asm/smp_plat.h>
  #include <asm/smp_scu.h>
 +#include <asm/firmware.h>
  
  #include <mach/hardware.h>
  #include <mach/regs-clock.h>
@@@ -146,22 -145,11 +146,22 @@@ static int __cpuinit exynos_boot_second
  
  	timeout = jiffies + (1 * HZ);
  	while (time_before(jiffies, timeout)) {
 +		unsigned long boot_addr;
 +
  		smp_rmb();
  
 -		__raw_writel(virt_to_phys(exynos4_secondary_startup),
 -
cpu_boot_reg(phys_cpu));
 +		boot_addr = virt_to_phys(exynos4_secondary_startup);
 +
 +		/*
 +		 * Try to set boot address using firmware first
 +		 * and fall back to boot register if it fails.
 +		 */
 +		if (call_firmware_op(set_cpu_boot_addr, phys_cpu,
boot_addr))
 +			__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
 +
 +		call_firmware_op(cpu_boot, phys_cpu);
 +
- 		gic_raise_softirq(cpumask_of(cpu), 0);
+ 		arch_send_wakeup_ipi_mask(cpumask_of(cpu));
  
  		if (pen_release == -1)
  			break;
