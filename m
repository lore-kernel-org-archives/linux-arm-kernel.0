From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:55:56 +0200
Subject: [RESEND PATCH 04/12] ARM: integrator: convert PCIv3 bridge to
 platform device
Message-ID: <1366466156-15463-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the PCIv3 driver to a platform device driver, and
registers the device only on the Integrator/AP instead of bailing
out in the initcall if the platform is not correct.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_ap.c | 17 +++++++++++++++++
 arch/arm/mach-integrator/pci_v3.c        | 30 ++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index ea96144..f190bab 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -494,6 +494,15 @@ static struct of_dev_auxdata ap_auxdata_lookup[] __initdata = {
 	{ /* sentinel */ },
 };
 
+/*
+ * This is a placeholder that will get deleted when we move the PCI
+ * device over to the device tree.
+ */
+static struct platform_device pci_v3_device_of = {
+	.name		= "pci-v3",
+	.id		= 0,
+};
+
 static void __init ap_init_of(void)
 {
 	unsigned long sc_dec;
@@ -550,6 +559,8 @@ static void __init ap_init_of(void)
 	of_platform_populate(root, of_default_bus_match_table,
 			ap_auxdata_lookup, parent);
 
+	platform_device_register(&pci_v3_device_of);
+
 	sc_dec = readl(ap_syscon_base + INTEGRATOR_SC_DEC_OFFSET);
 	for (i = 0; i < 4; i++) {
 		struct lm_device *lmdev;
@@ -617,6 +628,11 @@ static void __init ap_map_io_atag(void)
  * for eventual deletion.
  */
 
+static struct platform_device pci_v3_device = {
+	.name		= "pci-v3",
+	.id		= 0,
+};
+
 static struct resource cfi_flash_resource = {
 	.start		= INTEGRATOR_FLASH_BASE,
 	.end		= INTEGRATOR_FLASH_BASE + INTEGRATOR_FLASH_SIZE - 1,
@@ -674,6 +690,7 @@ static void __init ap_init(void)
 	unsigned long sc_dec;
 	int i;
 
+	platform_device_register(&pci_v3_device);
 	platform_device_register(&cfi_flash_device);
 
 	ap_syscon_base = __io_address(INTEGRATOR_SC_BASE);
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index b8d7033..2733c6c 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
@@ -35,7 +36,6 @@
 #include <asm/signal.h>
 #include <asm/mach/pci.h>
 #include <asm/irq_regs.h>
-#include <asm/mach-types.h>
 
 #include <asm/hardware/pci_v3.h>
 
@@ -649,7 +649,7 @@ static void __init pci_v3_postinit(void)
 /*
  * This routine handles multiple bridges.
  */
-static u8 __init integrator_swizzle(struct pci_dev *dev, u8 *pinp)
+static u8 __init pci_v3_swizzle(struct pci_dev *dev, u8 *pinp)
 {
 	if (*pinp == 0)
 		*pinp = 1;
@@ -665,16 +665,16 @@ static int irq_tab[4] __initdata = {
  * map the specified device/slot/pin to an IRQ.  This works out such
  * that slot 9 pin 1 is INT0, pin 2 is INT1, and slot 10 pin 1 is INT1.
  */
-static int __init integrator_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+static int __init pci_v3_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int intnr = ((slot - 9) + (pin - 1)) & 3;
 
 	return irq_tab[intnr];
 }
 
-static struct hw_pci integrator_pci __initdata = {
-	.swizzle		= integrator_swizzle,
-	.map_irq		= integrator_map_irq,
+static struct hw_pci pci_v3 __initdata = {
+	.swizzle		= pci_v3_swizzle,
+	.map_irq		= pci_v3_map_irq,
 	.setup			= pci_v3_setup,
 	.nr_controllers		= 1,
 	.ops			= &pci_v3_ops,
@@ -682,11 +682,21 @@ static struct hw_pci integrator_pci __initdata = {
 	.postinit		= pci_v3_postinit,
 };
 
-static int __init integrator_pci_init(void)
+static int __init pci_v3_probe(struct platform_device *pdev)
 {
-	if (machine_is_integrator())
-		pci_common_init(&integrator_pci);
+	pci_common_init(&pci_v3);
 	return 0;
 }
 
-subsys_initcall(integrator_pci_init);
+static struct platform_driver pci_v3_driver = {
+	.driver = {
+		.name = "pci-v3",
+	},
+};
+
+static int __init pci_v3_init(void)
+{
+	return platform_driver_probe(&pci_v3_driver, pci_v3_probe);
+}
+
+subsys_initcall(pci_v3_init);
-- 
1.8.1.4
