From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:23:56 -0700
Subject: [PATCH 05/34] davinci: edma: clear interrupt status for interrupt
	enabled channels only
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-6-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anuj Aggarwal <anuj.aggarwal@ti.com>

Currently, the ISR in the EDMA driver clears the pending interrupt for all
channels without regard to whether that channel has a registered callback
or not.

This causes problems for devices like DM355/DM365 where the multimedia
accelerator uses EDMA by polling on the interrupt pending bits of some of the
EDMA channels. Since these channels are actually allocated through the Linux
EDMA driver (by an out-of-kernel module), the same shadow region is used by
Linux and accelerator. There a race between the Linux ISR and the polling code
running on the accelerator on the IPR (interrupt pending register).

This patch fixes the issue by making the ISR clear the interrupts only for
those channels which have interrupt enabled. The channels which are allocated
for the purpose of being polled on by the accelerator will not have a callback
function provided and so will not have IER (interrupt enable register) bits set.

Tested on DM365 and OMAP-L137/L138 with audio and MMC/SD (as EDMA users).

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
CC: Archith John Bency <archith@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dma.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index 5313738..0bf290b 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -359,9 +359,11 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 
 	while (1) {
 		int j;
-		if (edma_shadow0_read_array(ctlr, SH_IPR, 0))
+		if (edma_shadow0_read_array(ctlr, SH_IPR, 0) &
+				edma_shadow0_read_array(ctlr, SH_IER, 0))
 			j = 0;
-		else if (edma_shadow0_read_array(ctlr, SH_IPR, 1))
+		else if (edma_shadow0_read_array(ctlr, SH_IPR, 1) &
+				edma_shadow0_read_array(ctlr, SH_IER, 1))
 			j = 1;
 		else
 			break;
@@ -369,8 +371,9 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 				edma_shadow0_read_array(ctlr, SH_IPR, j));
 		for (i = 0; i < 32; i++) {
 			int k = (j << 5) + i;
-			if (edma_shadow0_read_array(ctlr, SH_IPR, j) &
-							(1 << i)) {
+			if ((edma_shadow0_read_array(ctlr, SH_IPR, j) & BIT(i))
+					&& (edma_shadow0_read_array(ctlr,
+							SH_IER, j) & BIT(i))) {
 				/* Clear the corresponding IPR bits */
 				edma_shadow0_write_array(ctlr, SH_ICR, j,
 							(1 << i));
-- 
1.7.0.2
