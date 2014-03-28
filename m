From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 28 Mar 2014 14:07:01 +0100
Subject: [PATCH 05/10] ARM: mvebu: add function to set the resume boot address
 for Armada 375
In-Reply-To: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396012026-5997-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

In order to boot the secondary CPUs on Armada 375, we need to set the
boot address of these CPUs, through a register part of the System
Controller (this deviates from the Armada XP design, where the boot
address was defined using a register part of the PMSU unit).

Therefore, this commit adds a new helper function in the System
Controller driver to set the secondary CPU boot address.

Moreover, it moves the System Controller initialization as an
early_initcall(), since arch_initcall() is too late for an SMP-related
initialization.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/common.h            |  1 +
 arch/arm/mach-mvebu/system-controller.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 2b88eb0..b67fb7a 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -20,6 +20,7 @@
 void mvebu_restart(enum reboot_mode mode, const char *cmd);
 int mvebu_cpu_reset_deassert(int cpu);
 void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr);
+void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr);
 
 void armada_xp_cpu_die(unsigned int cpu);
 
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index 1806187..3d4489e 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -37,6 +37,8 @@ struct mvebu_system_controller {
 
 	u32 rstoutn_mask_reset_out_en;
 	u32 system_soft_reset;
+
+	u32 resume_boot_addr;
 };
 static struct mvebu_system_controller *mvebu_sc;
 
@@ -52,6 +54,7 @@ static const struct mvebu_system_controller armada_375_system_controller = {
 	.system_soft_reset_offset = 0x58,
 	.rstoutn_mask_reset_out_en = 0x1,
 	.system_soft_reset = 0x1,
+	.resume_boot_addr = 0xd4,
 };
 
 static const struct mvebu_system_controller orion_system_controller = {
@@ -98,6 +101,16 @@ void mvebu_restart(enum reboot_mode mode, const char *cmd)
 		;
 }
 
+#ifdef CONFIG_SMP
+void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr)
+{
+	BUG_ON(system_controller_base == NULL);
+	BUG_ON(mvebu_sc->resume_boot_addr == 0);
+	writel(virt_to_phys(boot_addr), system_controller_base +
+	       mvebu_sc->resume_boot_addr);
+}
+#endif
+
 static int __init mvebu_system_controller_init(void)
 {
 	struct device_node *np;
@@ -115,4 +128,4 @@ static int __init mvebu_system_controller_init(void)
 	return 0;
 }
 
-arch_initcall(mvebu_system_controller_init);
+early_initcall(mvebu_system_controller_init);
-- 
1.8.3.2
