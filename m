From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Sep 2012 10:13:38 +0200
Subject: [PATCH 5/5] ARM: EXYNOS: Add secure firmware support to secondary CPU
 bring-up
In-Reply-To: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
References: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
Message-ID: <1347524018-19301-6-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards using secure firmware must use different CPU boot registers and
call secure firmware to boot the CPU.

This is a follow-up on the patch by Kyungmin Park:
[PATCH v5 2/2] ARM: EXYNOS: SMC instruction (aka firmware) support
http://thread.gmane.org/gmane.linux.ports.arm.kernel/183608/focus=184109

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 816a27d..9d65b1b 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -25,6 +25,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
+#include <asm/firmware.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-clock.h>
@@ -43,6 +44,9 @@ static inline void __iomem *cpu_boot_reg_base(void)
 
 static inline void __iomem *cpu_boot_reg(int cpu)
 {
+	void __iomem *fw_boot_reg = call_firmware_op(cpu_boot_reg, cpu);
+	if (fw_boot_reg)
+		return fw_boot_reg;
 	if (soc_is_exynos4412())
 		return cpu_boot_reg_base() + 4*cpu;
 	return cpu_boot_reg_base();
@@ -151,6 +155,10 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		__raw_writel(virt_to_phys(exynos4_secondary_startup),
 							cpu_boot_reg(phys_cpu));
+
+		/* Call Exynos specific smc call */
+		call_firmware_op(cpu_boot, phys_cpu);
+
 		gic_raise_softirq(cpumask_of(cpu), 1);
 
 		if (pen_release == -1)
-- 
1.7.12
