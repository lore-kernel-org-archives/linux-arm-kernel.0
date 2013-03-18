From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 18 Mar 2013 15:00:50 +0100
Subject: [PATCH v3 4/9] MIPS: JZ4740: convert to usage of *pmask_cache within
 irq_chip_type
In-Reply-To: <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <1363615255-18200-5-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have now introduced pmask_cache within irq_chip_type to also
handle per-chip-type mask registers, convert jz4740 irq driver to use
this new pointer.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 arch/mips/jz4740/irq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index fc57ded..228ee33 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -68,7 +68,8 @@ void jz4740_irq_suspend(struct irq_data *data)
 void jz4740_irq_resume(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	jz4740_irq_set_mask(gc, gc->mask_cache);
+	struct irq_chip_type *ct = irq_data_get_irq_chip_type(data);
+	jz4740_irq_set_mask(gc, *ct->pmask_cache);
 }
 
 static struct irqaction jz4740_cascade_action = {
-- 
1.7.10.1
