From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  7 Aug 2017 13:01:54 +0200
Subject: [PATCH 1/8] gpio: zynq: Add support for suspend resume
In-Reply-To: <cover.1502103715.git.michal.simek@xilinx.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
Message-ID: <7a7b593881f94318d3d9e318b183f05adeadf449.1502103715.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add support for suspend resume. Now that we can lose context across
a suspend/ resume cycle. Add support for the context restore.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/gpio/gpio-zynq.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index df0851464006..064033803449 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -99,6 +99,17 @@
 /* set to differentiate zynq from zynqmp, 0=zynqmp, 1=zynq */
 #define ZYNQ_GPIO_QUIRK_IS_ZYNQ	BIT(0)
 
+struct gpio_regs {
+	u32 datamsw[ZYNQMP_GPIO_MAX_BANK];
+	u32 datalsw[ZYNQMP_GPIO_MAX_BANK];
+	u32 dirm[ZYNQMP_GPIO_MAX_BANK];
+	u32 outen[ZYNQMP_GPIO_MAX_BANK];
+	u32 int_en[ZYNQMP_GPIO_MAX_BANK];
+	u32 int_dis[ZYNQMP_GPIO_MAX_BANK];
+	u32 int_type[ZYNQMP_GPIO_MAX_BANK];
+	u32 int_polarity[ZYNQMP_GPIO_MAX_BANK];
+	u32 int_any[ZYNQMP_GPIO_MAX_BANK];
+};
 /**
  * struct zynq_gpio - gpio device private data structure
  * @chip:	instance of the gpio_chip
@@ -106,6 +117,7 @@
  * @clk:	clock resource for this controller
  * @irq:	interrupt for the GPIO device
  * @p_data:	pointer to platform data
+ * @context:	context registers
  */
 struct zynq_gpio {
 	struct gpio_chip chip;
@@ -113,6 +125,7 @@ struct zynq_gpio {
 	struct clk *clk;
 	int irq;
 	const struct zynq_platform_data *p_data;
+	struct gpio_regs context;
 };
 
 /**
@@ -560,14 +573,72 @@ static void zynq_gpio_irqhandler(struct irq_desc *desc)
 	chained_irq_exit(irqchip, desc);
 }
 
+static void zynq_gpio_save_context(struct zynq_gpio *gpio)
+{
+	unsigned int bank_num;
+
+	for (bank_num = 0; bank_num < gpio->p_data->max_bank; bank_num++) {
+		gpio->context.datalsw[bank_num] =
+				readl_relaxed(gpio->base_addr +
+				ZYNQ_GPIO_DATA_LSW_OFFSET(bank_num));
+		gpio->context.datamsw[bank_num] =
+				readl_relaxed(gpio->base_addr +
+				ZYNQ_GPIO_DATA_MSW_OFFSET(bank_num));
+		gpio->context.dirm[bank_num] = readl_relaxed(gpio->base_addr +
+				ZYNQ_GPIO_DIRM_OFFSET(bank_num));
+		gpio->context.int_en[bank_num] = readl_relaxed(gpio->base_addr +
+				ZYNQ_GPIO_INTMASK_OFFSET(bank_num));
+		gpio->context.int_type[bank_num] =
+				readl_relaxed(gpio->base_addr +
+				ZYNQ_GPIO_INTTYPE_OFFSET(bank_num));
+		gpio->context.int_polarity[bank_num] =
+				readl_relaxed(gpio->base_addr +
+				ZYNQ_GPIO_INTPOL_OFFSET(bank_num));
+		gpio->context.int_any[bank_num] =
+				readl_relaxed(gpio->base_addr +
+				ZYNQ_GPIO_INTANY_OFFSET(bank_num));
+	}
+}
+
+static void zynq_gpio_restore_context(struct zynq_gpio *gpio)
+{
+	unsigned int bank_num;
+
+	for (bank_num = 0; bank_num < gpio->p_data->max_bank; bank_num++) {
+		writel_relaxed(gpio->context.datalsw[bank_num],
+			       gpio->base_addr +
+			       ZYNQ_GPIO_DATA_LSW_OFFSET(bank_num));
+		writel_relaxed(gpio->context.datamsw[bank_num],
+			       gpio->base_addr +
+			       ZYNQ_GPIO_DATA_MSW_OFFSET(bank_num));
+		writel_relaxed(gpio->context.dirm[bank_num],
+			       gpio->base_addr +
+			       ZYNQ_GPIO_DIRM_OFFSET(bank_num));
+		writel_relaxed(gpio->context.int_en[bank_num],
+			       gpio->base_addr +
+			       ZYNQ_GPIO_INTEN_OFFSET(bank_num));
+		writel_relaxed(gpio->context.int_type[bank_num],
+			       gpio->base_addr +
+			       ZYNQ_GPIO_INTTYPE_OFFSET(bank_num));
+		writel_relaxed(gpio->context.int_polarity[bank_num],
+			       gpio->base_addr +
+			       ZYNQ_GPIO_INTPOL_OFFSET(bank_num));
+		writel_relaxed(gpio->context.int_any[bank_num],
+			       gpio->base_addr +
+			       ZYNQ_GPIO_INTANY_OFFSET(bank_num));
+	}
+}
 static int __maybe_unused zynq_gpio_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	int irq = platform_get_irq(pdev, 0);
 	struct irq_data *data = irq_get_irq_data(irq);
+	struct zynq_gpio *gpio = platform_get_drvdata(pdev);
 
-	if (!irqd_is_wakeup_set(data))
+	if (!irqd_is_wakeup_set(data)) {
+		zynq_gpio_save_context(gpio);
 		return pm_runtime_force_suspend(dev);
+	}
 
 	return 0;
 }
@@ -577,9 +648,14 @@ static int __maybe_unused zynq_gpio_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	int irq = platform_get_irq(pdev, 0);
 	struct irq_data *data = irq_get_irq_data(irq);
+	struct zynq_gpio *gpio = platform_get_drvdata(pdev);
+	int ret;
 
-	if (!irqd_is_wakeup_set(data))
-		return pm_runtime_force_resume(dev);
+	if (!irqd_is_wakeup_set(data)) {
+		ret = pm_runtime_force_resume(dev);
+		zynq_gpio_restore_context(gpio);
+		return ret;
+	}
 
 	return 0;
 }
-- 
1.9.1
