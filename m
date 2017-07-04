From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  4 Jul 2017 11:10:40 +0200
Subject: [PATCH 2/3] irqchip/atmel-aic: Fix unbalanced refcount in
 aic_common_rtc_irq_fixup()
In-Reply-To: <1499159441-29801-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1499159441-29801-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1499159441-29801-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_find_compatible_node() is calling of_node_put() on its first argument
thus leading to an unbalanced of_node_get/put() issue if the node has not
been retained before that.

Instead of passing the root node, pass NULL, which does exactly the same:
iterate over all DT nodes, starting from the root node.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Fixes: 3d61467f9bab ("irqchip: atmel-aic: Implement RTC irq fixup")
Cc: <stable@vger.kernel.org>
---
 drivers/irqchip/irq-atmel-aic-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic-common.c b/drivers/irqchip/irq-atmel-aic-common.c
index 7c5a43488d27..056507099725 100644
--- a/drivers/irqchip/irq-atmel-aic-common.c
+++ b/drivers/irqchip/irq-atmel-aic-common.c
@@ -142,9 +142,9 @@ void __init aic_common_rtc_irq_fixup(struct device_node *root)
 	struct device_node *np;
 	void __iomem *regs;
 
-	np = of_find_compatible_node(root, NULL, "atmel,at91rm9200-rtc");
+	np = of_find_compatible_node(NULL, NULL, "atmel,at91rm9200-rtc");
 	if (!np)
-		np = of_find_compatible_node(root, NULL,
+		np = of_find_compatible_node(NULL, NULL,
 					     "atmel,at91sam9x5-rtc");
 
 	if (!np)
-- 
2.7.4
