From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 18 Jan 2013 14:28:19 +1100
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20130118142819.5d82c1ff9e3f909a92b5a12d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm/mach-exynos/platsmp.c between commit b1cffebf1029 ("ARM: GIC:
remove direct use of gic_raise_softirq") from the arm-soc tree and commit
3c49d3583839 ("ARM: EXYNOS: Add secure firmware support to secondary CPU
bring-up") from the samsung tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-exynos/platsmp.c
index 60f7c5b,3226893..0000000
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@@ -20,11 -20,12 +20,12 @@@
  #include <linux/jiffies.h>
  #include <linux/smp.h>
  #include <linux/io.h>
 +#include <linux/irqchip/arm-gic.h>
  
  #include <asm/cacheflush.h>
 -#include <asm/hardware/gic.h>
  #include <asm/smp_plat.h>
  #include <asm/smp_scu.h>
+ #include <asm/firmware.h>
  
  #include <mach/hardware.h>
  #include <mach/regs-clock.h>
@@@ -145,11 -146,22 +146,22 @@@ static int __cpuinit exynos_boot_second
  
  	timeout = jiffies + (1 * HZ);
  	while (time_before(jiffies, timeout)) {
+ 		unsigned long boot_addr;
+ 
  		smp_rmb();
  
- 		__raw_writel(virt_to_phys(exynos4_secondary_startup),
- 							cpu_boot_reg(phys_cpu));
+ 		boot_addr = virt_to_phys(exynos4_secondary_startup);
+ 
+ 		/*
+ 		 * Try to set boot address using firmware first
+ 		 * and fall back to boot register if it fails.
+ 		 */
+ 		if (call_firmware_op(set_cpu_boot_addr, phys_cpu, boot_addr))
+ 			__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
+ 
+ 		call_firmware_op(cpu_boot, phys_cpu);
+ 
 -		gic_raise_softirq(cpumask_of(cpu), 0);
 +		arch_send_wakeup_ipi_mask(cpumask_of(cpu));
  
  		if (pen_release == -1)
  			break;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130118/905533b2/attachment.sig>
