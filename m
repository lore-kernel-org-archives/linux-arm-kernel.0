From: ludovic.Barre@st.com (Ludovic Barre)
Date: Thu, 26 Apr 2018 18:18:31 +0200
Subject: [PATCH 08/11] irqchip: stm32: add suspend/resume support for
 hierarchy domain
In-Reply-To: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
References: <1524759514-12392-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1524759514-12392-9-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds suspend/resume feature for exti hierarchy domain.
-suspend function sets wake_active into imr of each banks
-resume function restores the mask_cache interrupt into
 imr of each banks

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index ebf7146..5089c1e 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -14,6 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/syscore_ops.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -59,6 +60,8 @@ struct stm32_exti_host_data {
 	const struct stm32_exti_drv_data *drv_data;
 };
 
+static struct stm32_exti_host_data *stm32_host_data;
+
 static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.imr_ofst	= 0x00,
 	.emr_ofst	= 0x04,
@@ -498,6 +501,48 @@ static int stm32_exti_h_set_affinity(struct irq_data *d,
 	return -EINVAL;
 }
 
+#ifdef CONFIG_PM
+static int stm32_exti_h_suspend(void)
+{
+	struct stm32_exti_chip_data *chip_data;
+	int i;
+
+	for (i = 0; i < stm32_host_data->drv_data->bank_nr; i++) {
+		chip_data = &stm32_host_data->chips_data[i];
+		raw_spin_lock(&chip_data->rlock);
+		stm32_chip_suspend(chip_data, chip_data->wake_active);
+		raw_spin_unlock(&chip_data->rlock);
+	}
+
+	return 0;
+}
+
+static void stm32_exti_h_resume(void)
+{
+	struct stm32_exti_chip_data *chip_data;
+	int i;
+
+	for (i = 0; i < stm32_host_data->drv_data->bank_nr; i++) {
+		chip_data = &stm32_host_data->chips_data[i];
+		raw_spin_lock(&chip_data->rlock);
+		stm32_chip_resume(chip_data, chip_data->mask_cache);
+		raw_spin_unlock(&chip_data->rlock);
+	}
+}
+
+static struct syscore_ops stm32_exti_h_syscore_ops = {
+	.suspend	= stm32_exti_h_suspend,
+	.resume		= stm32_exti_h_resume,
+};
+
+static void stm32_exti_h_syscore_init(void)
+{
+	register_syscore_ops(&stm32_exti_h_syscore_ops);
+}
+#else
+static inline void stm32_exti_h_syscore_init(void) {}
+#endif
+
 static struct irq_chip stm32_exti_h_chip = {
 	.name			= "stm32-exti-h",
 	.irq_eoi		= stm32_exti_h_eoi,
@@ -567,6 +612,8 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 		return NULL;
 	}
 
+	stm32_host_data = host_data;
+
 	return host_data;
 }
 
@@ -725,6 +772,8 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
 		goto out_unmap;
 	}
 
+	stm32_exti_h_syscore_init();
+
 	return 0;
 
 out_unmap:
-- 
2.7.4
