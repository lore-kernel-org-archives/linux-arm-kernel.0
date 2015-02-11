From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 11 Feb 2015 09:20:54 +0100
Subject: [RFC v2 1/4] chip.c: complete the forwarded IRQ in case the handler
 is not reached
In-Reply-To: <1423642857-24240-1-git-send-email-eric.auger@linaro.org>
References: <1423642857-24240-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1423642857-24240-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With current handle_fasteoi_irq implementation, in case irqd_irq_disabled
is true (disable_irq was called) or !irq_may_run, the IRQ is not completed.
Only the running priority is dropped. IN those cases, the IRQ will
never be forwarded and hence will never be deactivated by anyone else.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 kernel/irq/chip.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 2f9571b..f12cce6 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -561,8 +561,12 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
 	raw_spin_unlock(&desc->lock);
 	return;
 out:
-	if (!(chip->flags & IRQCHIP_EOI_IF_HANDLED))
-		eoi_irq(desc, chip);
+	if (!(chip->flags & IRQCHIP_EOI_IF_HANDLED)) {
+		if (chip->irq_priority_drop)
+			chip->irq_priority_drop(&desc->irq_data);
+		if (chip->irq_eoi)
+			chip->irq_eoi(&desc->irq_data);
+	}
 	raw_spin_unlock(&desc->lock);
 }
 EXPORT_SYMBOL_GPL(handle_fasteoi_irq);
-- 
1.9.1
