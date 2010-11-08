From: EXT-Eugeny.Kuznetsov@nokia.com (Evgeny Kuznetsov)
Date: Mon,  8 Nov 2010 11:38:36 +0300
Subject: [PATCHv3 1/1] omap: Ptr "isr_reg" tracked as NULL was dereferenced
Message-ID: <cd6fa21776a4564d602cc072358a4bf79a9fe883.1289205105.git.EXT-Eugeny.Kuznetsov@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Evgeny Kuznetsov <ext-eugeny.kuznetsov@nokia.com>

Value of "isr_reg" pointer is depend on configuration and GPIO method.
Potentially it may have NULL value and it is dereferenced later
in code. Warning and exit from function are added in this case.

Signed-off-by: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>
---
 arch/arm/plat-omap/gpio.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c05c653..e0e2fa7 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1318,6 +1318,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	if (bank->method == METHOD_GPIO_44XX)
 		isr_reg = bank->base + OMAP4_GPIO_IRQSTATUS0;
 #endif
+
+	if (WARN_ON(!isr_reg))
+		goto exit;
+
 	while(1) {
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
@@ -1377,6 +1381,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	configured, we must unmask the bank interrupt only after
 	handler(s) are executed in order to avoid spurious bank
 	interrupt */
+exit:
 	if (!unmasked)
 		desc->chip->unmask(irq);
 
-- 
1.6.3.3
