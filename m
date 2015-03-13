From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Mar 2015 16:05:37 +0000
Subject: [PATCH v2] ARM: imx6: Warn when an old DT is detected
Message-ID: <1426262737-32762-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the GPC has been converted to be a full blown irqchip
(and not a mole on the side of the GIC), booting a new kernel
with an old DT is likely to result in a rough ride for the user.

This patch makes sure such a situation is promptly detected and
the user made aware that a DT update is in order.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
* From v1:
- Moved the DT check as early as possible (reported by Shawn)

 arch/arm/mach-imx/common.h      |  1 +
 arch/arm/mach-imx/gpc.c         | 10 ++++++++++
 arch/arm/mach-imx/mach-imx6q.c  |  1 +
 arch/arm/mach-imx/mach-imx6sl.c |  1 +
 arch/arm/mach-imx/mach-imx6sx.c |  1 +
 5 files changed, 14 insertions(+)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index f22e400..aba6831 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -71,6 +71,7 @@ unsigned int imx_get_soc_revision(void);
 void imx_init_revision_from_anatop(void);
 struct device *imx_soc_device_init(void);
 void imx6_enable_rbc(bool enable);
+void imx_gpc_check_dt(void);
 void imx_gpc_set_arm_power_in_lpm(bool power_off);
 void imx_gpc_set_arm_power_up_timing(u32 sw2iso, u32 sw);
 void imx_gpc_set_arm_power_down_timing(u32 sw2iso, u32 sw);
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index db89c35..7017f02 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -249,3 +249,13 @@ static int __init imx_gpc_init(struct device_node *node,
  * drivers/irqchip, so we're forced to roll our own. Not very nice.
  */
 OF_DECLARE_2(irqchip, imx_gpc, "fsl,imx6q-gpc", imx_gpc_init);
+
+void __init imx_gpc_check_dt(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
+	if (WARN_ON(!np ||
+		    !of_find_property(np, "interrupt-controller", NULL)))
+		pr_warn("Outdated DT detected, system is about to crash!!!\n");
+}
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 6fc2b7e..e21a693 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -387,6 +387,7 @@ static void __init imx6q_map_io(void)
 
 static void __init imx6q_init_irq(void)
 {
+	imx_gpc_check_dt();
 	imx_init_revision_from_anatop();
 	imx_init_l2cache();
 	imx_src_init();
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index d39c274..12a1b09 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -61,6 +61,7 @@ static void __init imx6sl_init_machine(void)
 
 static void __init imx6sl_init_irq(void)
 {
+	imx_gpc_check_dt();
 	imx_init_revision_from_anatop();
 	imx_init_l2cache();
 	imx_src_init();
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index 8595f9e..f17b700 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -81,6 +81,7 @@ static void __init imx6sx_init_machine(void)
 
 static void __init imx6sx_init_irq(void)
 {
+	imx_gpc_check_dt();
 	imx_init_revision_from_anatop();
 	imx_init_l2cache();
 	imx_src_init();
-- 
2.1.4
