From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 19 Jul 2018 18:00:44 +0200
Subject: [RFT 04/10] pinctrl: samsung: Add dedicated compatible for S5Pv210
 wakeup interrupts
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Message-ID: <20180719160050.22566-5-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S5Pv210 external wakeup interrupts differ from Exynos therefore
separate compatible is needed.  Duplicate existing flavor specific data
from exynos4210_wkup_irq_chip and add new compatible for S5Pv210.
At this point this new compatible does not bring anything new and works
exactly as "samsung,exynos4210-wakeup-eint".

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/pinctrl/samsung-pinctrl.txt    |  2 ++
 drivers/pinctrl/samsung/pinctrl-exynos.c               | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index f7700c9e0d0b..843a6cbf4774 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -161,6 +161,8 @@ B. External Wakeup Interrupts: For supporting external wakeup interrupts, a
        found on Samsung S3C2412 and S3C2413 SoCs,
      - samsung,s3c64xx-wakeup-eint: represents wakeup interrupt controller
        found on Samsung S3C64xx SoCs,
+     - samsung,s5pv210-wakeup-eint: represents wakeup interrupt controller
+       found on Samsung S5Pv210 SoCs,
      - samsung,exynos4210-wakeup-eint: represents wakeup interrupt controller
        found on Samsung Exynos4210 and S5PC110/S5PV210 SoCs.
      - samsung,exynos7-wakeup-eint: represents wakeup interrupt controller
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index a263ddd94945..29d86d704b0c 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -346,6 +346,22 @@ static int exynos_wkup_irq_set_wake(struct irq_data *irqd, unsigned int on)
 /*
  * irq_chip for wakeup interrupts
  */
+static const struct exynos_irq_chip s5pv210_wkup_irq_chip __initconst = {
+	.chip = {
+		.name = "s5pv210_wkup_irq_chip",
+		.irq_unmask = exynos_irq_unmask,
+		.irq_mask = exynos_irq_mask,
+		.irq_ack = exynos_irq_ack,
+		.irq_set_type = exynos_irq_set_type,
+		.irq_set_wake = exynos_wkup_irq_set_wake,
+		.irq_request_resources = exynos_irq_request_resources,
+		.irq_release_resources = exynos_irq_release_resources,
+	},
+	.eint_con = EXYNOS_WKUP_ECON_OFFSET,
+	.eint_mask = EXYNOS_WKUP_EMASK_OFFSET,
+	.eint_pend = EXYNOS_WKUP_EPEND_OFFSET,
+};
+
 static const struct exynos_irq_chip exynos4210_wkup_irq_chip __initconst = {
 	.chip = {
 		.name = "exynos4210_wkup_irq_chip",
@@ -380,6 +396,8 @@ static const struct exynos_irq_chip exynos7_wkup_irq_chip __initconst = {
 
 /* list of external wakeup controllers supported */
 static const struct of_device_id exynos_wkup_irq_ids[] = {
+	{ .compatible = "samsung,s5pv210-wakeup-eint",
+			.data = &s5pv210_wkup_irq_chip },
 	{ .compatible = "samsung,exynos4210-wakeup-eint",
 			.data = &exynos4210_wkup_irq_chip },
 	{ .compatible = "samsung,exynos7-wakeup-eint",
-- 
2.14.1
