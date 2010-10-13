From: EXT-Eugeny.Kuznetsov@nokia.com (Evgeny Kuznetsov)
Date: Wed, 13 Oct 2010 14:04:50 +0400
Subject: [PATCHv2 1/1] omap: Ptr "isr_reg" tracked as NULL was dereferenced
In-Reply-To: <cover.1286961160.git.EXT-Eugeny.Kuznetsov@nokia.com>
References: <cover.1286961160.git.EXT-Eugeny.Kuznetsov@nokia.com>
Message-ID: <7bb69801f49283c3bde78aa008c15308ac8a5fbf.1286961160.git.EXT-Eugeny.Kuznetsov@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Evgeny Kuznetsov <ext-eugeny.kuznetsov@nokia.com>

Value of "isr_reg" pointer is depend on configuration and GPIO method.
Potentially it may have NULL value and it is dereferenced later
in code. If pointer is NULL there is some kernel issue.
Warning and exit from function are added in this case.
Also compilation check is added for correct architecture
configuration.

Signed-off-by: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>
---
 arch/arm/plat-omap/gpio.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c05c653..d04913c 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1318,6 +1318,23 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	if (bank->method == METHOD_GPIO_44XX)
 		isr_reg = bank->base + OMAP4_GPIO_IRQSTATUS0;
 #endif
+
+#if !defined(CONFIG_ARCH_OMAP1) &&		\
+		!defined(CONFIG_ARCH_OMAP15XX) &&	\
+		!defined(CONFIG_ARCH_OMAP16XX) &&	\
+		!defined(CONFIG_ARCH_OMAP730) &&	\
+		!defined(CONFIG_ARCH_OMAP850) &&	\
+		!defined(CONFIG_ARCH_OMAP2) &&	\
+		!defined(CONFIG_ARCH_OMAP3) &&	\
+		!defined(CONFIG_ARCH_OMAP4)
+	
+#error "Incorrect arch configuration"
+	
+#endif
+	
+	if (WARN_ON(!isr_reg))
+		goto exit;
+
 	while(1) {
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
@@ -1377,6 +1394,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	configured, we must unmask the bank interrupt only after
 	handler(s) are executed in order to avoid spurious bank
 	interrupt */
+exit:
 	if (!unmasked)
 		desc->chip->unmask(irq);
 
-- 
1.6.3.3
