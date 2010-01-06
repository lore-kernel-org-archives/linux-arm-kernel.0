From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:12 -0800
Subject: [PATCH 30/35] davinci: build list of unused EDMA events dynamically
In-Reply-To: <1262802737-6601-30-git-send-email-khilman@deeprootsystems.com>
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
Message-ID: <1262802737-6601-31-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Currently, the edma_noevent list is passed from platform data.
But on some architectures, there will be many EDMA channels
which will not be used at all. This patch scans all the
platform devices and then builds a list of events which are
not being used. The unused event list will be used to allocate
EDMA channels in case of EDMA_CHANNEL_ANY usage instead of the
edma_noevent being used earlier for this purpose.

This patch is based on David Brownells's suggestion at
http://article.gmane.org/gmane.linux.davinci/15176.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/devices-da8xx.c     |    6 ---
 arch/arm/mach-davinci/dm355.c             |    8 ----
 arch/arm/mach-davinci/dm644x.c            |   10 -----
 arch/arm/mach-davinci/dm646x.c            |    9 -----
 arch/arm/mach-davinci/dma.c               |   55 ++++++++++++++++++++++------
 arch/arm/mach-davinci/include/mach/edma.h |    2 -
 6 files changed, 43 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 5df27f7..40647c4 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -83,11 +83,6 @@ struct platform_device da8xx_serial_device = {
 	},
 };
 
-static const s8 da8xx_dma_chan_no_event[] = {
-	20, 21,
-	-1
-};
-
 static const s8 da8xx_queue_tc_mapping[][2] = {
 	/* {event queue no, TC no} */
 	{0, 0},
@@ -109,7 +104,6 @@ static struct edma_soc_info da8xx_edma_info[] = {
 		.n_slot			= 128,
 		.n_tc			= 2,
 		.n_cc			= 1,
-		.noevent		= da8xx_dma_chan_no_event,
 		.queue_tc_mapping	= da8xx_queue_tc_mapping,
 		.queue_priority_mapping	= da8xx_queue_priority_mapping,
 	},
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 2244e8c..9b2c40e 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -564,13 +564,6 @@ static u8 dm355_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 
 /*----------------------------------------------------------------------*/
 
-static const s8 dma_chan_dm355_no_event[] = {
-	12, 13, 24, 56, 57,
-	58, 59, 60, 61, 62,
-	63,
-	-1
-};
-
 static const s8
 queue_tc_mapping[][2] = {
 	/* {event queue no, TC no} */
@@ -594,7 +587,6 @@ static struct edma_soc_info dm355_edma_info[] = {
 		.n_slot			= 128,
 		.n_tc			= 2,
 		.n_cc			= 1,
-		.noevent		= dma_chan_dm355_no_event,
 		.queue_tc_mapping	= queue_tc_mapping,
 		.queue_priority_mapping	= queue_priority_mapping,
 	},
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index e65e29e..61856f8 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -479,15 +479,6 @@ static u8 dm644x_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 
 /*----------------------------------------------------------------------*/
 
-static const s8 dma_chan_dm644x_no_event[] = {
-	 0,  1, 12, 13, 14,
-	15, 25, 30, 31, 45,
-	46, 47, 55, 56, 57,
-	58, 59, 60, 61, 62,
-	63,
-	-1
-};
-
 static const s8
 queue_tc_mapping[][2] = {
 	/* {event queue no, TC no} */
@@ -511,7 +502,6 @@ static struct edma_soc_info dm644x_edma_info[] = {
 		.n_slot			= 128,
 		.n_tc			= 2,
 		.n_cc			= 1,
-		.noevent		= dma_chan_dm644x_no_event,
 		.queue_tc_mapping	= queue_tc_mapping,
 		.queue_priority_mapping	= queue_priority_mapping,
 	},
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 6f80616..de306ca 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -511,14 +511,6 @@ static u8 dm646x_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 
 /*----------------------------------------------------------------------*/
 
-static const s8 dma_chan_dm646x_no_event[] = {
-	 0,  1,  2,  3, 13,
-	14, 15, 24, 25, 26,
-	27, 30, 31, 54, 55,
-	56,
-	-1
-};
-
 /* Four Transfer Controllers on DM646x */
 static const s8
 dm646x_queue_tc_mapping[][2] = {
@@ -547,7 +539,6 @@ static struct edma_soc_info dm646x_edma_info[] = {
 		.n_slot			= 512,
 		.n_tc			= 4,
 		.n_cc			= 1,
-		.noevent		= dma_chan_dm646x_no_event,
 		.queue_tc_mapping	= dm646x_queue_tc_mapping,
 		.queue_priority_mapping	= dm646x_queue_priority_mapping,
 	},
diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index 89a3dcc..15dd886 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -226,11 +226,11 @@ struct edma {
 	 */
 	DECLARE_BITMAP(edma_inuse, EDMA_MAX_PARAMENTRY);
 
-	/* The edma_noevent bit for each channel is clear unless
-	 * it doesn't trigger DMA events on this platform.  It uses a
-	 * bit of SOC-specific initialization code.
+	/* The edma_unused bit for each channel is clear unless
+	 * it is not being used on this platform. It uses a bit
+	 * of SOC-specific initialization code.
 	 */
-	DECLARE_BITMAP(edma_noevent, EDMA_MAX_DMACH);
+	DECLARE_BITMAP(edma_unused, EDMA_MAX_DMACH);
 
 	unsigned	irq_res_start;
 	unsigned	irq_res_end;
@@ -556,8 +556,27 @@ static int reserve_contiguous_slots(int ctlr, unsigned int id,
 	return EDMA_CTLR_CHAN(ctlr, i - num_slots + 1);
 }
 
+static int prepare_unused_channel_list(struct device *dev, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int i, ctlr;
+
+	for (i = 0; i < pdev->num_resources; i++) {
+		if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
+				(int)pdev->resource[i].start >= 0) {
+			ctlr = EDMA_CTLR(pdev->resource[i].start);
+			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
+					edma_info[ctlr]->edma_unused);
+		}
+	}
+
+	return 0;
+}
+
 /*-----------------------------------------------------------------------*/
 
+static bool unused_chan_list_done;
+
 /* Resource alloc/free:  dma channels, parameter RAM slots */
 
 /**
@@ -596,6 +615,21 @@ int edma_alloc_channel(int channel,
 		enum dma_event_q eventq_no)
 {
 	unsigned i, done = 0, ctlr = 0;
+	int ret = 0;
+
+	if (!unused_chan_list_done) {
+		/*
+		 * Scan all the platform devices to find out the EDMA channels
+		 * used and clear them in the unused list, making the rest
+		 * available for ARM usage.
+		 */
+		ret = bus_for_each_dev(&platform_bus_type, NULL, NULL,
+				prepare_unused_channel_list);
+		if (ret < 0)
+			return ret;
+
+		unused_chan_list_done = true;
+	}
 
 	if (channel >= 0) {
 		ctlr = EDMA_CTLR(channel);
@@ -607,7 +641,7 @@ int edma_alloc_channel(int channel,
 			channel = 0;
 			for (;;) {
 				channel = find_next_bit(edma_info[i]->
-						edma_noevent,
+						edma_unused,
 						edma_info[i]->num_channels,
 						channel);
 				if (channel == edma_info[i]->num_channels)
@@ -1222,7 +1256,7 @@ int edma_start(unsigned channel)
 		unsigned int mask = (1 << (channel & 0x1f));
 
 		/* EDMA channels without event association */
-		if (test_bit(channel, edma_info[ctlr]->edma_noevent)) {
+		if (test_bit(channel, edma_info[ctlr]->edma_unused)) {
 			pr_debug("EDMA: ESR%d %08x\n", j,
 				edma_shadow0_read_array(ctlr, SH_ESR, j));
 			edma_shadow0_write_array(ctlr, SH_ESR, j, mask);
@@ -1347,7 +1381,6 @@ static int __init edma_probe(struct platform_device *pdev)
 	const s8		(*queue_tc_mapping)[2];
 	int			i, j, found = 0;
 	int			status = -1;
-	const s8		*noevent;
 	int			irq[EDMA_MAX_CC] = {0, 0};
 	int			err_irq[EDMA_MAX_CC] = {0, 0};
 	struct resource		*r[EDMA_MAX_CC] = {NULL};
@@ -1410,11 +1443,9 @@ static int __init edma_probe(struct platform_device *pdev)
 			memcpy_toio(edmacc_regs_base[j] + PARM_OFFSET(i),
 					&dummy_paramset, PARM_SIZE);
 
-		noevent = info[j].noevent;
-		if (noevent) {
-			while (*noevent != -1)
-				set_bit(*noevent++, edma_info[j]->edma_noevent);
-		}
+		/* Mark all channels as unused */
+		memset(edma_info[j]->edma_unused, 0xff,
+			sizeof(edma_info[j]->edma_unused));
 
 		sprintf(irq_name, "edma%d", j);
 		irq[j] = platform_get_irq_byname(pdev, irq_name);
diff --git a/arch/arm/mach-davinci/include/mach/edma.h b/arch/arm/mach-davinci/include/mach/edma.h
index eb8bfd7..ced3092 100644
--- a/arch/arm/mach-davinci/include/mach/edma.h
+++ b/arch/arm/mach-davinci/include/mach/edma.h
@@ -280,8 +280,6 @@ struct edma_soc_info {
 	unsigned	n_cc;
 	enum dma_event_q	default_queue;
 
-	/* list of channels with no even trigger; terminated by "-1" */
-	const s8	*noevent;
 	const s8	(*queue_tc_mapping)[2];
 	const s8	(*queue_priority_mapping)[2];
 };
-- 
1.6.6.rc2.1.g42108
