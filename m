From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 28 Mar 2014 14:06:57 +0100
Subject: [PATCH 01/10] ARM: mvebu: move Armada XP specific SMP initialization
 to platsmp.c
In-Reply-To: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396012026-5997-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pmsu.c driver contained an armada_xp_boot_cpu() function that sets
the boot address of a secondary CPUs and deasserts the reset. However,
the Armada 375 needs a slightly different logic, so it makes more
sense to move this code into the Armada XP specific platsmp.c.

In order to achieve this, the mvebu_pmsu_set_cpu_boot_addr() function
is exported. It will be needed for both the Armada XP and Armada 38x
SMP implementations.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/common.h  |  1 +
 arch/arm/mach-mvebu/platsmp.c | 10 +++++++++-
 arch/arm/mach-mvebu/pmsu.c    | 26 +-------------------------
 3 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index cfb129b..2b88eb0 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -19,6 +19,7 @@
 
 void mvebu_restart(enum reboot_mode mode, const char *cmd);
 int mvebu_cpu_reset_deassert(int cpu);
+void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr);
 
 void armada_xp_cpu_die(unsigned int cpu);
 
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index a6da03f..e98075f 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -77,9 +77,17 @@ static void armada_xp_secondary_init(unsigned int cpu)
 
 static int armada_xp_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
+	int ret, hw_cpu;
+
 	pr_info("Booting CPU %d\n", cpu);
 
-	armada_xp_boot_cpu(cpu, armada_xp_secondary_startup);
+	hw_cpu = cpu_logical_map(cpu);
+	mvebu_pmsu_set_cpu_boot_addr(hw_cpu, armada_xp_secondary_startup);
+	ret = mvebu_cpu_reset_deassert(hw_cpu);
+	if (ret) {
+		pr_warn("unable to boot CPU: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 8361281..a1508de 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -41,36 +41,12 @@ static struct of_device_id of_pmsu_table[] = {
 	{ /* end of list */ },
 };
 
-static void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
+void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
 {
 	writel(virt_to_phys(boot_addr), pmsu_mp_base +
 		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
 }
 
-#ifdef CONFIG_SMP
-int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
-{
-	int hw_cpu, ret;
-
-	if (!pmsu_mp_base) {
-		pr_warn("Can't boot CPU. PMSU is uninitialized\n");
-		return -ENODEV;
-	}
-
-	hw_cpu = cpu_logical_map(cpu_id);
-
-	mvebu_pmsu_set_cpu_boot_addr(hw_cpu, boot_addr);
-
-	ret = mvebu_cpu_reset_deassert(hw_cpu);
-	if (ret) {
-		pr_warn("unable to boot CPU: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-#endif
-
 static int __init armada_370_xp_pmsu_init(void)
 {
 	struct device_node *np;
-- 
1.8.3.2
