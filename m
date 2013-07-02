From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 02 Jul 2013 18:28:30 +0900
Subject: [PATCH 08/08] ARM: shmobile: Disconnect EMEV2 SMP code from clocks
In-Reply-To: <20130702092725.32066.54861.sendpatchset@w520>
References: <20130702092725.32066.54861.sendpatchset@w520>
Message-ID: <20130702092830.32066.8431.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the EMEV2 SMP code to access the SMU directly
instead of relying on help from the legacy clock code.

This change moves us one step closer to common clocks.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-emev2.c        |   18 ------------------
 arch/arm/mach-shmobile/include/mach/emev2.h |    1 -
 arch/arm/mach-shmobile/smp-emev2.c          |   11 +++++++++--
 3 files changed, 9 insertions(+), 21 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-emev2.c
+++ work/arch/arm/mach-shmobile/clock-emev2.c	2013-07-02 15:31:52.000000000 +0900
@@ -40,7 +40,6 @@
 #define USIB2SCLKDIV 0x65c
 #define USIB3SCLKDIV 0x660
 #define STI_CLKSEL 0x688
-#define SMU_GENERAL_REG0 0x7c0
 
 /* not pretty, but hey */
 static void __iomem *smu_base;
@@ -51,11 +50,6 @@ static void emev2_smu_write(unsigned lon
 	iowrite32(value, smu_base + offs);
 }
 
-void emev2_set_boot_vector(unsigned long value)
-{
-	emev2_smu_write(value, SMU_GENERAL_REG0);
-}
-
 static struct clk_mapping smu_mapping = {
 	.phys	= EMEV2_SMU_BASE,
 	.len	= PAGE_SIZE,
@@ -205,18 +199,6 @@ static struct clk_lookup lookups[] = {
 void __init emev2_clock_init(void)
 {
 	int k, ret = 0;
-	static int is_setup;
-
-	/* yuck, this is ugly as hell, but the non-smp case of clocks
-	 * code is now designed to rely on ioremap() instead of static
-	 * entity maps. in the case of smp we need access to the SMU
-	 * register earlier than ioremap() is actually working without
-	 * any static maps. to enable SMP in ugly but with dynamic
-	 * mappings we have to call emev2_clock_init() from different
-	 * places depending on UP and SMP...
-	 */
-	if (is_setup++)
-		return;
 
 	smu_base = ioremap(EMEV2_SMU_BASE, PAGE_SIZE);
 	BUG_ON(!smu_base);
--- 0004/arch/arm/mach-shmobile/include/mach/emev2.h
+++ work/arch/arm/mach-shmobile/include/mach/emev2.h	2013-07-02 15:32:05.000000000 +0900
@@ -5,7 +5,6 @@ extern void emev2_map_io(void);
 extern void emev2_init_delay(void);
 extern void emev2_add_standard_devices(void);
 extern void emev2_clock_init(void);
-extern void emev2_set_boot_vector(unsigned long value);
 
 #define EMEV2_GPIO_BASE 200
 #define EMEV2_GPIO_IRQ(n) (EMEV2_GPIO_BASE + (n))
--- 0005/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2013-07-02 15:31:01.000000000 +0900
@@ -29,6 +29,8 @@
 #include <asm/smp_scu.h>
 
 #define EMEV2_SCU_BASE 0x1e000000
+#define EMEV2_SMU_BASE 0xe0110000
+#define SMU_GENERAL_REG0 0x7c0
 
 static int __cpuinit emev2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
@@ -38,13 +40,18 @@ static int __cpuinit emev2_boot_secondar
 
 static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
 {
+	void __iomem *smu;
+
 	/* setup EMEV2 specific SCU base, enable */
 	shmobile_scu_base = ioremap(EMEV2_SCU_BASE, PAGE_SIZE);
 	scu_enable(shmobile_scu_base);
 
 	/* Tell ROM loader about our vector (in headsmp-scu.S, headsmp.S) */
-	emev2_clock_init(); /* need ioremapped SMU */
-	emev2_set_boot_vector(__pa(shmobile_boot_vector));
+	smu = ioremap(EMEV2_SMU_BASE, PAGE_SIZE);
+	if (smu) {
+		iowrite32(__pa(shmobile_boot_vector), smu + SMU_GENERAL_REG0);
+		iounmap(smu);
+	}
 	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
 	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
 
