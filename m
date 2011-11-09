From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed,  9 Nov 2011 10:47:25 +0800
Subject: [PATCH v7 05/11] ARM: pxa: recognize gpio number and type
In-Reply-To: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1320806851-13928-6-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use cpuid to recognize the gpio number and type. CPU_PXA26x is the
special case since we can't identify it by cpuid.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/gpio/gpio-pxa.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 3e76c58..aebc4e8 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -347,12 +347,51 @@ static struct irq_chip pxa_muxed_gpio_chip = {
 	.irq_set_type	= pxa_gpio_irq_type,
 };
 
+static int pxa_gpio_nums(void)
+{
+	int count = 0;
+
+#ifdef CONFIG_ARCH_PXA
+	if (cpu_is_pxa25x()) {
+#ifdef CONFIG_CPU_PXA26x
+		count = 89;
+		gpio_type = PXA26X_GPIO;
+#elif defined(CONFIG_PXA25x)
+		count = 84;
+		gpio_type = PXA26X_GPIO;
+#endif /* CONFIG_CPU_PXA26x */
+	} else if (cpu_is_pxa27x()) {
+		count = 120;
+		gpio_type = PXA27X_GPIO;
+	} else if (cpu_is_pxa93x() || cpu_is_pxa95x()) {
+		count = 191;
+		gpio_type = PXA93X_GPIO;
+	} else if (cpu_is_pxa3xx()) {
+		count = 127;
+		gpio_type = PXA3XX_GPIO;
+	}
+#endif /* CONFIG_ARCH_PXA */
+
+#ifdef CONFIG_ARCH_MMP
+	if (cpu_is_pxa168() || cpu_is_pxa910()) {
+		count = 127;
+		gpio_type = MMP_GPIO;
+	} else if (cpu_is_mmp2()) {
+		count = 191;
+		gpio_type = MMP2_GPIO;
+	}
+#endif /* CONFIG_ARCH_MMP */
+	return count;
+}
+
 void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
 {
 	struct pxa_gpio_chip *c;
 	int gpio, irq;
 
-	pxa_last_gpio = end;
+	pxa_last_gpio = pxa_gpio_nums();
+	if (!pxa_last_gpio)
+		return;
 
 	/* Initialize GPIO chips */
 	pxa_init_gpio_chip(end);
-- 
1.7.4.1
