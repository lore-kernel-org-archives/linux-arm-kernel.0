From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 23 Sep 2014 13:46:06 +0530
Subject: [PATCH v2 2/5] pinctrl: exynos: Add irq_chip instance for Exynos7
 wakeup interrupts
In-Reply-To: <1411460169-30536-1-git-send-email-a.kesavan@samsung.com>
References: <1411460169-30536-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1411460169-30536-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos7 uses different offsets for wakeup interrupt configuration registers.
So a new irq_chip instance for Exynos7 wakeup interrupts is added. The irq_chip
selection is now based on the wakeup interrupt controller compatible string.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
Tested-by: Thomas Abraham <thomas.ab@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/pinctrl/samsung-pinctrl.txt           |    2 +
 drivers/pinctrl/samsung/pinctrl-exynos.c           |   48 +++++++++++++++-----
 drivers/pinctrl/samsung/pinctrl-exynos.h           |    3 ++
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index e82aaf4..f80519a 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -136,6 +136,8 @@ B. External Wakeup Interrupts: For supporting external wakeup interrupts, a
        found on Samsung S3C64xx SoCs,
      - samsung,exynos4210-wakeup-eint: represents wakeup interrupt controller
        found on Samsung Exynos4210 and S5PC110/S5PV210 SoCs.
+     - samsung,exynos7-wakeup-eint: represents wakeup interrupt controller
+       found on Samsung Exynos7 SoC.
    - interrupt-parent: phandle of the interrupt parent to which the external
      wakeup interrupts are forwarded to.
    - interrupts: interrupt used by multiplexed wakeup interrupts.
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index b5e1cd4..7072bfa 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -56,12 +56,6 @@ static struct samsung_pin_bank_type bank_type_alive = {
 	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
 };
 
-/* list of external wakeup controllers supported */
-static const struct of_device_id exynos_wkup_irq_ids[] = {
-	{ .compatible = "samsung,exynos4210-wakeup-eint", },
-	{ }
-};
-
 static void exynos_irq_mask(struct irq_data *irqd)
 {
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
@@ -383,9 +377,11 @@ static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 /*
  * irq_chip for wakeup interrupts
  */
-static struct exynos_irq_chip exynos_wkup_irq_chip = {
+static struct exynos_irq_chip *exynos_wkup_irq_chip;
+
+static struct exynos_irq_chip exynos4210_wkup_irq_chip __initdata = {
 	.chip = {
-		.name = "exynos_wkup_irq_chip",
+		.name = "exynos4210_wkup_irq_chip",
 		.irq_unmask = exynos_irq_unmask,
 		.irq_mask = exynos_irq_mask,
 		.irq_ack = exynos_irq_ack,
@@ -399,6 +395,31 @@ static struct exynos_irq_chip exynos_wkup_irq_chip = {
 	.eint_pend = EXYNOS_WKUP_EPEND_OFFSET,
 };
 
+static struct exynos_irq_chip exynos7_wkup_irq_chip __initdata = {
+	.chip = {
+		.name = "exynos7_wkup_irq_chip",
+		.irq_unmask = exynos_irq_unmask,
+		.irq_mask = exynos_irq_mask,
+		.irq_ack = exynos_irq_ack,
+		.irq_set_type = exynos_irq_set_type,
+		.irq_set_wake = exynos_wkup_irq_set_wake,
+		.irq_request_resources = exynos_irq_request_resources,
+		.irq_release_resources = exynos_irq_release_resources,
+	},
+	.eint_con = EXYNOS7_WKUP_ECON_OFFSET,
+	.eint_mask = EXYNOS7_WKUP_EMASK_OFFSET,
+	.eint_pend = EXYNOS7_WKUP_EPEND_OFFSET,
+};
+
+/* list of external wakeup controllers supported */
+static const struct of_device_id exynos_wkup_irq_ids[] = {
+	{ .compatible = "samsung,exynos4210-wakeup-eint",
+			.data = &exynos4210_wkup_irq_chip },
+	{ .compatible = "samsung,exynos7-wakeup-eint",
+			.data = &exynos7_wkup_irq_chip },
+	{ }
+};
+
 /* interrupt handler for wakeup interrupts 0..15 */
 static void exynos_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 {
@@ -459,7 +480,7 @@ static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 static int exynos_wkup_irq_map(struct irq_domain *h, unsigned int virq,
 					irq_hw_number_t hw)
 {
-	irq_set_chip_and_handler(virq, &exynos_wkup_irq_chip.chip,
+	irq_set_chip_and_handler(virq, &exynos_wkup_irq_chip->chip,
 					handle_level_irq);
 	irq_set_chip_data(virq, h->host_data);
 	set_irq_flags(virq, IRQF_VALID);
@@ -491,7 +512,12 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 	int idx, irq;
 
 	for_each_child_of_node(dev->of_node, np) {
-		if (of_match_node(exynos_wkup_irq_ids, np)) {
+		const struct of_device_id *match;
+
+		match = of_match_node(exynos_wkup_irq_ids, np);
+		if (match) {
+			exynos_wkup_irq_chip = kmemdup(match->data,
+				sizeof(struct exynos_irq_chip), GFP_KERNEL);
 			wkup_np = np;
 			break;
 		}
@@ -566,7 +592,7 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		muxed_data->banks[idx++] = bank;
 	}
 	muxed_data->nr_banks = muxed_banks;
-	muxed_data->chip = &exynos_wkup_irq_chip;
+	muxed_data->chip = exynos_wkup_irq_chip;
 
 	return 0;
 }
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index e060722..0db1e52 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -25,6 +25,9 @@
 #define EXYNOS_WKUP_ECON_OFFSET		0xE00
 #define EXYNOS_WKUP_EMASK_OFFSET	0xF00
 #define EXYNOS_WKUP_EPEND_OFFSET	0xF40
+#define EXYNOS7_WKUP_ECON_OFFSET	0x700
+#define EXYNOS7_WKUP_EMASK_OFFSET	0x900
+#define EXYNOS7_WKUP_EPEND_OFFSET	0xA00
 #define EXYNOS_SVC_OFFSET		0xB08
 #define EXYNOS_EINT_FUNC		0xF
 
-- 
1.7.9.5
