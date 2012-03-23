From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 23 Mar 2012 13:19:26 +0530
Subject: [PATCH 1/2] ARM: VIC: Create common infrastructure for vic DT bindings
Message-ID: <4bfe7af3761f6f40506a2089fd67866015f6d7f3.1332488625.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Few platforms define there own struct of_device_id[] for vic pl19*. They don't
do anything specific in init_irq() other than of_irq_init().

This patch creates this struct array in vic.c and make other platforms use it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/common/vic.c               |   14 +++++++++++++-
 arch/arm/include/asm/hardware/vic.h |    3 ++-
 arch/arm/mach-picoxcell/common.c    |   12 +-----------
 arch/arm/mach-spear6xx/spear6xx.c   |   12 +-----------
 4 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 7a66311..190813e 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -398,7 +398,8 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 }
 
 #ifdef CONFIG_OF
-int __init vic_of_init(struct device_node *node, struct device_node *parent)
+static int __init vic_of_init(struct device_node *node, struct device_node
+		*parent)
 {
 	void __iomem *regs;
 	int irq_base;
@@ -423,6 +424,17 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 
 	return -EIO;
 }
+
+static const struct of_device_id vic_of_match[] __initconst = {
+	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
+	{ .compatible = "arm,pl192-vic", .data = vic_of_init, },
+	{ /* Sentinel */ }
+};
+
+void __init vic_init_irq(void)
+{
+	of_irq_init(vic_of_match);
+}
 #endif /* CONFIG OF */
 
 /*
diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
index e14af1a..02056a8 100644
--- a/arch/arm/include/asm/hardware/vic.h
+++ b/arch/arm/include/asm/hardware/vic.h
@@ -42,6 +42,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/compiler.h>
+#include <linux/init.h>
 #include <linux/types.h>
 
 struct device_node;
@@ -50,7 +51,7 @@ struct pt_regs;
 void __vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources,
 		u32 resume_sources, struct device_node *node);
 void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
-int vic_of_init(struct device_node *node, struct device_node *parent);
+void __init vic_init_irq(void);
 void vic_handle_irq(struct pt_regs *regs);
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index a2e8ae8..fa0d7e9 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -68,16 +68,6 @@ static const char *picoxcell_dt_match[] = {
 	NULL
 };
 
-static const struct of_device_id vic_of_match[] __initconst = {
-	{ .compatible = "arm,pl192-vic", .data = vic_of_init, },
-	{ /* Sentinel */ }
-};
-
-static void __init picoxcell_init_irq(void)
-{
-	of_irq_init(vic_of_match);
-}
-
 static void picoxcell_wdt_restart(char mode, const char *cmd)
 {
 	/*
@@ -95,7 +85,7 @@ static void picoxcell_wdt_restart(char mode, const char *cmd)
 DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
 	.map_io		= picoxcell_map_io,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= picoxcell_init_irq,
+	.init_irq	= vic_init_irq,
 	.handle_irq	= vic_handle_irq,
 	.timer		= &picoxcell_timer,
 	.init_machine	= picoxcell_init_machine,
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 2ed8b14..d436118 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -102,19 +102,9 @@ static const char *spear600_dt_board_compat[] = {
 	NULL
 };
 
-static const struct of_device_id vic_of_match[] __initconst = {
-	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
-	{ /* Sentinel */ }
-};
-
-static void __init spear6xx_dt_init_irq(void)
-{
-	of_irq_init(vic_of_match);
-}
-
 DT_MACHINE_START(SPEAR600_DT, "ST SPEAr600 (Flattened Device Tree)")
 	.map_io		=	spear6xx_map_io,
-	.init_irq	=	spear6xx_dt_init_irq,
+	.init_irq	=	vic_init_irq,
 	.handle_irq	=	vic_handle_irq,
 	.timer		=	&spear6xx_timer,
 	.init_machine	=	spear600_dt_init,
-- 
1.7.8.110.g4cb5d
