From: joelf@ti.com (Joel Fernandes)
Date: Mon, 29 Jul 2013 08:29:49 -0500
Subject: [PATCH 3/9] ARM: edma: Add function to manually trigger an EDMA
 channel
In-Reply-To: <1375104595-16018-1-git-send-email-joelf@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
Message-ID: <1375104595-16018-4-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Manual trigger for events missed as a result of splitting a
scatter gather list and DMA'ing it in batches. Add a helper
function to trigger a channel incase any such events are missed.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/common/edma.c             |   21 +++++++++++++++++++++
 include/linux/platform_data/edma.h |    2 ++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 3567ba1..10995b2 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1236,6 +1236,27 @@ void edma_resume(unsigned channel)
 }
 EXPORT_SYMBOL(edma_resume);
 
+int edma_manual_trigger(unsigned channel)
+{
+	unsigned ctlr;
+	int j;
+	unsigned int mask;
+
+	ctlr = EDMA_CTLR(channel);
+	channel = EDMA_CHAN_SLOT(channel);
+	mask = BIT(channel & 0x1f);
+
+	j = channel >> 5;
+
+	/* EDMA channels without event association */
+	edma_shadow0_write_array(ctlr, SH_ESR, j, mask);
+
+	pr_debug("EDMA: ESR%d %08x\n", j,
+		 edma_shadow0_read_array(ctlr, SH_ESR, j));
+	return 0;
+}
+EXPORT_SYMBOL(edma_manual_trigger);
+
 /**
  * edma_start - start dma on a channel
  * @channel: channel being activated
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index 57300fd..0e11eca 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -180,4 +180,6 @@ struct edma_soc_info {
 	const s16	(*xbar_chans)[2];
 };
 
+int edma_manual_trigger(unsigned);
+
 #endif
-- 
1.7.9.5
