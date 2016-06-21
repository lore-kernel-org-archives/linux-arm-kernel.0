From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 11:20:24 +0100
Subject: [[PATCH v2] 03/11] ARM: EXYNOS: fixups for big-endian operation
In-Reply-To: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466504432-24187-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the kernel is built big endian, then using the __raw read and write IO
accessors is not going to work as they end up writing big-endian data to
little-endian IO registers. Fix this by using the readl and writel relaxed
versions which ensure little endian IO.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-exynos/firmware.c | 16 ++++++++--------
 arch/arm/mach-exynos/headsmp.S  |  3 +++
 arch/arm/mach-exynos/platsmp.c  |  4 ++--
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index 1bfd1b0..96b5e92 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -41,9 +41,9 @@ static int exynos_do_idle(unsigned long mode)
 	case FW_DO_IDLE_AFTR:
 		if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
 			exynos_save_cp15();
-		__raw_writel(virt_to_phys(exynos_cpu_resume_ns),
+		writel_relaxed(virt_to_phys(exynos_cpu_resume_ns),
 			     sysram_ns_base_addr + 0x24);
-		__raw_writel(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
+		writel_relaxed(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
 		if (soc_is_exynos3250()) {
 			flush_cache_all();
 			exynos_smc(SMC_CMD_SAVE, OP_TYPE_CORE,
@@ -97,7 +97,7 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 	if (soc_is_exynos4412())
 		boot_reg += 4 * cpu;
 
-	__raw_writel(boot_addr, boot_reg);
+	writel_relaxed(boot_addr, boot_reg);
 	return 0;
 }
 
@@ -113,7 +113,7 @@ static int exynos_get_cpu_boot_addr(int cpu, unsigned long *boot_addr)
 	if (soc_is_exynos4412())
 		boot_reg += 4 * cpu;
 
-	*boot_addr = __raw_readl(boot_reg);
+	*boot_addr = readl_relaxed(boot_reg);
 	return 0;
 }
 
@@ -234,20 +234,20 @@ void exynos_set_boot_flag(unsigned int cpu, unsigned int mode)
 {
 	unsigned int tmp;
 
-	tmp = __raw_readl(REG_CPU_STATE_ADDR + cpu * 4);
+	tmp = readl_relaxed(REG_CPU_STATE_ADDR + cpu * 4);
 
 	if (mode & BOOT_MODE_MASK)
 		tmp &= ~BOOT_MODE_MASK;
 
 	tmp |= mode;
-	__raw_writel(tmp, REG_CPU_STATE_ADDR + cpu * 4);
+	writel_relaxed(tmp, REG_CPU_STATE_ADDR + cpu * 4);
 }
 
 void exynos_clear_boot_flag(unsigned int cpu, unsigned int mode)
 {
 	unsigned int tmp;
 
-	tmp = __raw_readl(REG_CPU_STATE_ADDR + cpu * 4);
+	tmp = readl_relaxed(REG_CPU_STATE_ADDR + cpu * 4);
 	tmp &= ~mode;
-	__raw_writel(tmp, REG_CPU_STATE_ADDR + cpu * 4);
+	writel_relaxed(tmp, REG_CPU_STATE_ADDR + cpu * 4);
 }
diff --git a/arch/arm/mach-exynos/headsmp.S b/arch/arm/mach-exynos/headsmp.S
index b54f970..d3d24ab 100644
--- a/arch/arm/mach-exynos/headsmp.S
+++ b/arch/arm/mach-exynos/headsmp.S
@@ -12,12 +12,15 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
+#include <asm/assembler.h>
+
 /*
  * exynos4 specific entry point for secondary CPUs.  This provides
  * a "holding pen" into which all secondary cores are held until we're
  * ready for them to initialise.
  */
 ENTRY(exynos4_secondary_startup)
+ARM_BE8(setend	be)
 	mrc	p15, 0, r0, c0, c0, 5
 	and	r0, r0, #15
 	adr	r4, 1f
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 85c3be6..98ffe1e 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -264,7 +264,7 @@ int exynos_set_boot_addr(u32 core_id, unsigned long boot_addr)
 			ret = PTR_ERR(boot_reg);
 			goto fail;
 		}
-		__raw_writel(boot_addr, boot_reg);
+		writel_relaxed(boot_addr, boot_reg);
 		ret = 0;
 	}
 fail:
@@ -289,7 +289,7 @@ int exynos_get_boot_addr(u32 core_id, unsigned long *boot_addr)
 			ret = PTR_ERR(boot_reg);
 			goto fail;
 		}
-		*boot_addr = __raw_readl(boot_reg);
+		*boot_addr = readl_relaxed(boot_reg);
 		ret = 0;
 	}
 fail:
-- 
2.8.1
