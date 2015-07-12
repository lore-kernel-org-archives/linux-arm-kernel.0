From: robh@kernel.org (Rob Herring)
Date: Sun, 12 Jul 2015 09:26:41 -0500
Subject: [PATCH v2 03/13] dma: kill off set_irq_flags usage
In-Reply-To: <1436711211-18223-1-git-send-email-robh@kernel.org>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
Message-ID: <1436711211-18223-4-git-send-email-robh@kernel.org>
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
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine at vger.kernel.org
---
 drivers/dma/ipu/ipu_irq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ipu/ipu_irq.c b/drivers/dma/ipu/ipu_irq.c
index 2e284a4..667ebba 100644
--- a/drivers/dma/ipu/ipu_irq.c
+++ b/drivers/dma/ipu/ipu_irq.c
@@ -377,9 +377,7 @@ int __init ipu_irq_attach_irq(struct ipu *ipu, struct platform_device *dev)
 		irq_map[i].irq = irq;
 		irq_map[i].source = -EINVAL;
 		irq_set_handler(irq, handle_level_irq);
-#ifdef CONFIG_ARM
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-#endif
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	irq_set_handler_data(ipu->irq_fn, ipu);
@@ -406,9 +404,7 @@ void ipu_irq_detach_irq(struct ipu *ipu, struct platform_device *dev)
 	irq_set_handler_data(ipu->irq_err, NULL);
 
 	for (irq = irq_base; irq < irq_base + CONFIG_MX3_IPU_IRQS; irq++) {
-#ifdef CONFIG_ARM
-		set_irq_flags(irq, 0);
-#endif
+		irq_set_status_flags(irq, IRQ_NOREQUEST);
 		irq_set_chip(irq, NULL);
 		irq_set_chip_data(irq, NULL);
 	}
-- 
2.1.0
