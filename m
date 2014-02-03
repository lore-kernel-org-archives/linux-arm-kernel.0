From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Mon,  3 Feb 2014 17:46:01 +0100
Subject: [PATCH] at91: pmc: Fixed irq's name allocation for programmable clocks
Message-ID: <1391445961-20755-1-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The name provided to request_irq() must be valid until the irq is
released.
This patch allocates and formats the string with kasprintf().

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 drivers/clk/at91/clk-programmable.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 8e242c7..0f8bf0f 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/string.h>
 
 #include "pmc.h"
 
@@ -247,7 +248,7 @@ at91_clk_register_programmable(struct at91_pmc *pmc, unsigned int irq,
 	struct clk_programmable *prog;
 	struct clk *clk = NULL;
 	struct clk_init_data init;
-	char irq_name[11];
+	char *irq_name;
 
 	if (id > PROG_ID_MAX)
 		return ERR_PTR(-EINVAL);
@@ -269,7 +270,7 @@ at91_clk_register_programmable(struct at91_pmc *pmc, unsigned int irq,
 	prog->irq = irq;
 	init_waitqueue_head(&prog->wait);
 	irq_set_status_flags(prog->irq, IRQ_NOAUTOEN);
-	snprintf(irq_name, sizeof(irq_name), "clk-prog%d", id);
+	irq_name = kasprintf(GFP_KERNEL, "clk-prog%d", id);
 	ret = request_irq(prog->irq, clk_programmable_irq_handler,
 			  IRQF_TRIGGER_HIGH, irq_name, prog);
 	if (ret)
-- 
1.8.5.2
