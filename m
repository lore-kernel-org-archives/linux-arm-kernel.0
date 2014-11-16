From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 17 Nov 2014 11:40:07 +1300
Subject: [RFC PATCHv3] ARM: mvebu: Let the device-tree determine smp_ops
In-Reply-To: <1415327626-16079-1-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <1415327626-16079-1-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <1416177607-11305-1-git-send-email-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The machine specific SMP operations can be configured either via
setup_arch or via arm_dt_init_cpu_maps. For the ARMADA_370_XP_DT devices
both of these are called and setup_arch wins because it is called last.
This means that it is not possible to substitute a different set of SMP
operations via the device-tree.

Add a new smp_ops_is_set API that tells us if something else has already
set smp_ops. Use this new API in a smp_init function for the
ARMADA_370_XP_DT compatible devices to prevent setup_arch from
overriding the operations configured earlier.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Hi,

I didn't see any comment's on v2[1]. I'm not sure if I should take this as
disapproval with that approach or just a sign that people are busy.

This is an alternative solution that addresses one issue I had with the v2
implementation namely we now know whether smp_ops have been set or not and can
use this information to avoid setting them again. The downside is I'm now
modifying core code.

Thanks,
Chris
--
[1] - http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300480.html

 arch/arm/include/asm/smp.h     |  1 +
 arch/arm/kernel/smp.c          | 10 +++++++++-
 arch/arm/mach-mvebu/board-v7.c |  6 ++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 18f5a55..aa55889 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -122,5 +122,6 @@ struct of_cpu_method {
  * set platform specific SMP operations
  */
 extern void smp_set_ops(struct smp_operations *);
+extern bool smp_ops_is_set(void);
 
 #endif /* ifndef __ASM_ARM_SMP_H */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 13396d3..f303655 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -77,13 +77,21 @@ enum ipi_msg_type {
 static DECLARE_COMPLETION(cpu_running);
 
 static struct smp_operations smp_ops;
+static bool smp_ops_set = false;
 
 void __init smp_set_ops(struct smp_operations *ops)
 {
-	if (ops)
+	if (ops) {
 		smp_ops = *ops;
+		smp_ops_set = true;
+	}
 };
 
+bool smp_ops_is_set(void)
+{
+	return smp_ops_set;
+}
+
 static unsigned long get_arch_pgd(pgd_t *pgd)
 {
 	phys_addr_t pgdir = virt_to_idmap(pgd);
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 6478626..86b4b5d 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -198,6 +198,11 @@ static void __init mvebu_dt_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+static bool __init armada_smp_init(void)
+{
+	return smp_ops_is_set();
+}
+
 static const char * const armada_370_xp_dt_compat[] = {
 	"marvell,armada-370-xp",
 	NULL,
@@ -206,6 +211,7 @@ static const char * const armada_370_xp_dt_compat[] = {
 DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
+	.smp_init	= armada_smp_init,
 	.smp		= smp_ops(armada_xp_smp_ops),
 	.init_machine	= mvebu_dt_init,
 	.init_irq       = mvebu_init_irq,
-- 
2.2.0.rc0
