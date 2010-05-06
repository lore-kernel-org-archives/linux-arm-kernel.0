From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:25 -0700
Subject: [PATCH 34/34] davinci: edma: fix coding style issue related to usage
	of braces
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-35-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

In the edma driver, there are couple of instances where braces
are used for a single statement 'if' construct.

There are other instances where 'else' part of the if-else construct
does not use braces even if the 'if' part is a multi-line statement.

This patch fixes both.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dma.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index b705089..cc5fcda 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -310,10 +310,9 @@ setup_dma_interrupt(unsigned lch,
 	ctlr = EDMA_CTLR(lch);
 	lch = EDMA_CHAN_SLOT(lch);
 
-	if (!callback) {
+	if (!callback)
 		edma_shadow0_write_array(ctlr, SH_IECR, lch >> 5,
 				(1 << (lch & 0x1f)));
-	}
 
 	edma_cc[ctlr]->intr_data[lch].callback = callback;
 	edma_cc[ctlr]->intr_data[lch].data = data;
@@ -376,12 +375,11 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 				/* Clear the corresponding IPR bits */
 				edma_shadow0_write_array(ctlr, SH_ICR, j,
 							(1 << i));
-				if (edma_cc[ctlr]->intr_data[k].callback) {
+				if (edma_cc[ctlr]->intr_data[k].callback)
 					edma_cc[ctlr]->intr_data[k].callback(
 						k, DMA_COMPLETE,
 						edma_cc[ctlr]->intr_data[k].
 						data);
-				}
 			}
 		}
 		cnt++;
@@ -473,9 +471,8 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 		if ((edma_read_array(ctlr, EDMA_EMR, 0) == 0)
 		    && (edma_read_array(ctlr, EDMA_EMR, 1) == 0)
 		    && (edma_read(ctlr, EDMA_QEMR) == 0)
-		    && (edma_read(ctlr, EDMA_CCERR) == 0)) {
+		    && (edma_read(ctlr, EDMA_CCERR) == 0))
 			break;
-		}
 		cnt++;
 		if (cnt > 10)
 			break;
@@ -531,8 +528,9 @@ static int reserve_contiguous_slots(int ctlr, unsigned int id,
 			if (id == EDMA_CONT_PARAMS_FIXED_EXACT) {
 				stop_slot = i;
 				break;
-			} else
+			} else {
 				count = num_slots;
+			}
 		}
 	}
 
@@ -1402,8 +1400,9 @@ static int __init edma_probe(struct platform_device *pdev)
 				break;
 			else
 				return -ENODEV;
-		} else
+		} else {
 			found = 1;
+		}
 
 		len[j] = resource_size(r[j]);
 
-- 
1.7.0.2
