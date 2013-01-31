From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 31 Jan 2013 16:36:26 +0100
Subject: [PATCH 1/2] ARM: use read_cpuid_id() instead of read_cpuid(CPUID_ID)
Message-ID: <1359646587-1788-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both calls are identical currently. This patch prepares to deprecate
read_cpuid on machines without cp15.

Also move an unconditional usage of read_cpuid_cachetype to a more local
scope as read_cpuid_cachetype uses read_cpuid, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/setup.c        |    2 +-
 arch/arm/kernel/smp_scu.c      |    2 +-
 arch/arm/mach-omap2/id.c       |    4 ++--
 arch/arm/mach-omap2/omap-smp.c |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 3f6cbb2..1cc9e17 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -291,10 +291,10 @@ static int cpu_has_aliasing_icache(unsigned int arch)
 
 static void __init cacheid_init(void)
 {
-	unsigned int cachetype = read_cpuid_cachetype();
 	unsigned int arch = cpu_architecture();
 
 	if (arch >= CPU_ARCH_ARMv6) {
+		unsigned int cachetype = read_cpuid_cachetype();
 		if ((cachetype & (7 << 29)) == 4 << 29) {
 			/* ARMv7 register format */
 			arch = CPU_ARCH_ARMv7;
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index b9f015e..743a3bf 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -41,7 +41,7 @@ void scu_enable(void __iomem *scu_base)
 
 #ifdef CONFIG_ARM_ERRATA_764369
 	/* Cortex-A9 only */
-	if ((read_cpuid(CPUID_ID) & 0xff0ffff0) == 0x410fc090) {
+	if ((read_cpuid_id() & 0xff0ffff0) == 0x410fc090) {
 		scu_ctrl = __raw_readl(scu_base + 0x30);
 		if (!(scu_ctrl & 1))
 			__raw_writel(scu_ctrl | 0x1, scu_base + 0x30);
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 45cc7ed4..1377c36 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -300,7 +300,7 @@ void __init omap3xxx_check_revision(void)
 	 * If the processor type is Cortex-A8 and the revision is 0x0
 	 * it means its Cortex r0p0 which is 3430 ES1.0.
 	 */
-	cpuid = read_cpuid(CPUID_ID);
+	cpuid = read_cpuid_id();
 	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
 		omap_revision = OMAP3430_REV_ES1_0;
 		cpu_rev = "1.0";
@@ -450,7 +450,7 @@ void __init omap4xxx_check_revision(void)
 	 * Use ARM register to detect the correct ES version
 	 */
 	if (!rev && (hawkeye != 0xb94e) && (hawkeye != 0xb975)) {
-		idcode = read_cpuid(CPUID_ID);
+		idcode = read_cpuid_id();
 		rev = (idcode & 0xf) - 1;
 	}
 
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index cd42d92..707098e 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -209,7 +209,7 @@ static void __init omap4_smp_init_cpus(void)
 	unsigned int i = 0, ncores = 1, cpu_id;
 
 	/* Use ARM cpuid check here, as SoC detection will not work so early */
-	cpu_id = read_cpuid(CPUID_ID) & CPU_MASK;
+	cpu_id = read_cpuid_id() & CPU_MASK;
 	if (cpu_id == CPU_CORTEX_A9) {
 		/*
 		 * Currently we can't call ioremap here because
-- 
1.7.10.4
