From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:13 -0800
Subject: [PATCH 31/35] davinci: support for EDMA resource sharing
In-Reply-To: <1262802737-6601-31-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-19-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-20-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-21-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-22-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-23-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-24-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-25-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-26-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-27-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-28-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-29-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-30-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-31-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-32-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Current EDMA driver is not taking care of EDMA channels/slots
which are allocated from other processor, say DSP. If a
channel/slot is allocated from DSP, the existing EDMA driver
can still allocate the same resource on ARM.

This patch enables the user to pass the channel/slots reserved
for DSP as platform data. EDMA driver scans this list during
probe and prepares a bitmap of channel/slots which can be used
on ARM side.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Cc: David Brownell <david-b@pacbell.net>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dma.c               |   36 ++++++++++++++++++++++++++++-
 arch/arm/mach-davinci/include/mach/edma.h |    2 +
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index 15dd886..d3e1702 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -206,6 +206,18 @@ static inline void edma_parm_or(unsigned ctlr, int offset, int param_no,
 	edma_or(ctlr, EDMA_PARM + offset + (param_no << 5), or);
 }
 
+static inline void set_bits(int offset, int len, unsigned long *p)
+{
+	for (; len > 0; len--)
+		set_bit(offset + (len - 1), p);
+}
+
+static inline void clear_bits(int offset, int len, unsigned long *p)
+{
+	for (; len > 0; len--)
+		clear_bit(offset + (len - 1), p);
+}
+
 /*****************************************************************************/
 
 /* actual number of DMA channels and slots on this silicon */
@@ -1379,8 +1391,10 @@ static int __init edma_probe(struct platform_device *pdev)
 	struct edma_soc_info	*info = pdev->dev.platform_data;
 	const s8		(*queue_priority_mapping)[2];
 	const s8		(*queue_tc_mapping)[2];
-	int			i, j, found = 0;
+	int			i, j, off, ln, found = 0;
 	int			status = -1;
+	const s16		(*rsv_chans)[2];
+	const s16		(*rsv_slots)[2];
 	int			irq[EDMA_MAX_CC] = {0, 0};
 	int			err_irq[EDMA_MAX_CC] = {0, 0};
 	struct resource		*r[EDMA_MAX_CC] = {NULL};
@@ -1447,6 +1461,26 @@ static int __init edma_probe(struct platform_device *pdev)
 		memset(edma_info[j]->edma_unused, 0xff,
 			sizeof(edma_info[j]->edma_unused));
 
+		/* Clear the reserved channels in unused list */
+		rsv_chans = info[j].rsv_chans;
+		if (rsv_chans) {
+			for (i = 0; rsv_chans[i][0] != -1; i++) {
+				off = rsv_chans[i][0];
+				ln = rsv_chans[i][1];
+				clear_bits(off, ln, edma_info[j]->edma_unused);
+			}
+		}
+
+		/* Set the reserved channels/slots in inuse list */
+		rsv_slots = info[j].rsv_slots;
+		if (rsv_slots) {
+			for (i = 0; rsv_slots[i][0] != -1; i++) {
+				off = rsv_slots[i][0];
+				ln = rsv_slots[i][1];
+				set_bits(off, ln, edma_info[j]->edma_inuse);
+			}
+		}
+
 		sprintf(irq_name, "edma%d", j);
 		irq[j] = platform_get_irq_byname(pdev, irq_name);
 		edma_info[j]->irq_res_start = irq[j];
diff --git a/arch/arm/mach-davinci/include/mach/edma.h b/arch/arm/mach-davinci/include/mach/edma.h
index ced3092..55e217e 100644
--- a/arch/arm/mach-davinci/include/mach/edma.h
+++ b/arch/arm/mach-davinci/include/mach/edma.h
@@ -280,6 +280,8 @@ struct edma_soc_info {
 	unsigned	n_cc;
 	enum dma_event_q	default_queue;
 
+	const s16	(*rsv_chans)[2];
+	const s16	(*rsv_slots)[2];
 	const s8	(*queue_tc_mapping)[2];
 	const s8	(*queue_priority_mapping)[2];
 };
-- 
1.6.6.rc2.1.g42108
