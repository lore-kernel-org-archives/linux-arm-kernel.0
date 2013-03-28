From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Mar 2013 21:46:44 +0100
Subject: [PATCH 1/2] ARM: irq: Call irqchit_init if no init_irq function is
 specified
In-Reply-To: <1364503606-10597-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1364503606-10597-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1364503606-10597-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More and more sub-architectures are using only the irqchip_init
function. Make the core code call this function if no init_irq field is
provided in the machine description to remove some boilerplate code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/kernel/irq.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 8e4ef4c..9723d17 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -26,6 +26,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/random.h>
 #include <linux/smp.h>
 #include <linux/init.h>
@@ -114,7 +115,10 @@ EXPORT_SYMBOL_GPL(set_irq_flags);
 
 void __init init_IRQ(void)
 {
-	machine_desc->init_irq();
+	if (IS_ENABLED(CONFIG_OF) && !machine_desc->init_irq)
+		irqchip_init();
+	else
+		machine_desc->init_irq();
 }
 
 #ifdef CONFIG_MULTI_IRQ_HANDLER
-- 
1.7.10.4
