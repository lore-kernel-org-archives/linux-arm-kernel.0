From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu,  1 Dec 2011 16:19:08 +0800
Subject: [PATCH 1/2] arm/imx: fix return type of callback passed to
 of_irq_init()
Message-ID: <1322727549-10852-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_irq_init() expects the callback passed by .data of of_device_id
return 'int' instead of 'void'.  This patch fixes it to have
irq_init_cb() return the correct value, and in turn have the secondary
interrupt controller (gpio in this case) initialized properly and also
eliminate the error message 'of_irq_init: children remain, but no
parents' which was overlooked before.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-imx6q.c |    4 +++-
 arch/arm/mach-mx5/imx51-dt.c   |    7 +++++--
 arch/arm/mach-mx5/imx53-dt.c   |    7 +++++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 8bf5fa3..eb7531b 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -36,7 +36,7 @@ static void __init imx6q_map_io(void)
 	imx_scu_map_io();
 }
 
-static void __init imx6q_gpio_add_irq_domain(struct device_node *np,
+static int __init imx6q_gpio_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
 	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
@@ -44,6 +44,8 @@ static void __init imx6q_gpio_add_irq_domain(struct device_node *np,
 
 	irq_domain_add_simple(np, gpio_irq_base);
 	gpio_irq_base += 32;
+
+	return 0;
 }
 
 static const struct of_device_id imx6q_irq_match[] __initconst = {
diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
index ccc6158..3451a46 100644
--- a/arch/arm/mach-mx5/imx51-dt.c
+++ b/arch/arm/mach-mx5/imx51-dt.c
@@ -44,13 +44,14 @@ static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
 	{ /* sentinel */ }
 };
 
-static void __init imx51_tzic_add_irq_domain(struct device_node *np,
+static int __init imx51_tzic_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
 	irq_domain_add_simple(np, 0);
+	return 0;
 }
 
-static void __init imx51_gpio_add_irq_domain(struct device_node *np,
+static int __init imx51_gpio_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
 	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
@@ -58,6 +59,8 @@ static void __init imx51_gpio_add_irq_domain(struct device_node *np,
 
 	irq_domain_add_simple(np, gpio_irq_base);
 	gpio_irq_base += 32;
+
+	return 0;
 }
 
 static const struct of_device_id imx51_irq_match[] __initconst = {
diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-mx5/imx53-dt.c
index ccaa0b8..022bc03 100644
--- a/arch/arm/mach-mx5/imx53-dt.c
+++ b/arch/arm/mach-mx5/imx53-dt.c
@@ -48,13 +48,14 @@ static const struct of_dev_auxdata imx53_auxdata_lookup[] __initconst = {
 	{ /* sentinel */ }
 };
 
-static void __init imx53_tzic_add_irq_domain(struct device_node *np,
+static int __init imx53_tzic_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
 	irq_domain_add_simple(np, 0);
+	return 0;
 }
 
-static void __init imx53_gpio_add_irq_domain(struct device_node *np,
+static int __init imx53_gpio_add_irq_domain(struct device_node *np,
 				struct device_node *interrupt_parent)
 {
 	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
@@ -62,6 +63,8 @@ static void __init imx53_gpio_add_irq_domain(struct device_node *np,
 
 	irq_domain_add_simple(np, gpio_irq_base);
 	gpio_irq_base += 32;
+
+	return 0;
 }
 
 static const struct of_device_id imx53_irq_match[] __initconst = {
-- 
1.7.4.1
