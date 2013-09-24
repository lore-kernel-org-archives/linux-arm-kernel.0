From: m.krawczuk@partner.samsung.com (Mateusz Krawczuk)
Date: Tue, 24 Sep 2013 17:59:23 +0200
Subject: [PATCH v2] ARM: SAMSUNG: S5P: If detected device tree skip irq init
Message-ID: <1380038363-487-1-git-send-email-m.krawczuk@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It prevents from executing things already handled by pinctrl-exynos driver,
when device tree is available.

Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/s5p-irq-eint.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/plat-samsung/s5p-irq-eint.c b/arch/arm/plat-samsung/s5p-irq-eint.c
index faa6516..ebee4dc 100644
--- a/arch/arm/plat-samsung/s5p-irq-eint.c
+++ b/arch/arm/plat-samsung/s5p-irq-eint.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/gpio.h>
 #include <linux/irqchip/arm-vic.h>
+#include <linux/of.h>
 
 #include <plat/regs-irqtype.h>
 
@@ -202,6 +203,9 @@ static int __init s5p_init_irq_eint(void)
 {
 	int irq;
 
+	if (of_have_populated_dt())
+		return -ENODEV;
+
 	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(15); irq++)
 		irq_set_chip(irq, &s5p_irq_vic_eint);
 
-- 
1.8.1.2
