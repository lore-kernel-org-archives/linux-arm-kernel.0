From: robh@kernel.org (Rob Herring)
Date: Sun, 12 Jul 2015 09:26:49 -0500
Subject: [PATCH v2 11/13] sh: kill off set_irq_flags usage
In-Reply-To: <1436711211-18223-1-git-send-email-robh@kernel.org>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
Message-ID: <1436711211-18223-12-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_irq_flags is ARM specific with custom flags which have genirq
equivalents. Convert drivers to use the genirq interfaces directly, so we
can kill off set_irq_flags. The translation of flags is as follows:

IRQF_VALID -> !IRQ_NOREQUEST
IRQF_PROBE -> !IRQ_NOPROBE
IRQF_NOAUTOEN -> IRQ_NOAUTOEN

For IRQs managed by an irqdomain, the irqdomain core code handles clearing
and setting IRQ_NOREQUEST already, so there is no need to do this in
.map() functions and we can simply remove the set_irq_flags calls. Some
users also set IRQ_NOPROBE and this has been maintained although it is not
clear that is really needed. There appears to be a great deal of blind
copy and paste of this code.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh at vger.kernel.org
---
 drivers/sh/intc/internals.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
index 7dff08e..897ffb1 100644
--- a/drivers/sh/intc/internals.h
+++ b/drivers/sh/intc/internals.h
@@ -99,15 +99,7 @@ static inline struct intc_desc_int *get_intc_desc(unsigned int irq)
  */
 static inline void activate_irq(int irq)
 {
-#ifdef CONFIG_ARM
-	/* ARM requires an extra step to clear IRQ_NOREQUEST, which it
-	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
-	 */
-	set_irq_flags(irq, IRQF_VALID);
-#else
-	/* same effect on other architectures */
-	irq_set_noprobe(irq);
-#endif
+	irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 }
 
 static inline int intc_handle_int_cmp(const void *a, const void *b)
-- 
2.1.0
