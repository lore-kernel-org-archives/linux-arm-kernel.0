From: ming.lei@canonical.com (ming.lei at canonical.com)
Date: Wed, 31 Aug 2011 00:03:13 +0800
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Message-ID: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ming Lei <ming.lei@canonical.com>

This patch introduces the helper of ehci_sync_mem to flush
qtd/qh into memory immediately on some ARM, so that HC can
see the up-to-date qtd/qh descriptor asap.

This patch fixs one performance bug on ARM Cortex A9 dual core
platform, which has been reported on quite a few ARM machines
(OMAP4, Tegra 2, snowball...), see details from link of
https://bugs.launchpad.net/bugs/709245.

The patch has been tested ok on OMAP4 panda A1 board, and the
performance of 'dd' over usb mass storage can be increased from
4~5MB/sec to 14~16MB/sec after applying this patch.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/usb/host/ehci-q.c |   18 ++++++++++++++++++
 drivers/usb/host/ehci.h   |   17 +++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 0917e3a..2719879 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -995,6 +995,12 @@ static void qh_link_async (struct ehci_hcd *ehci, struct ehci_qh *qh)
 	head->qh_next.qh = qh;
 	head->hw->hw_next = dma;
 
+	/*
+	 * flush qh descriptor into memory immediately,
+	 * see comments in qh_append_tds.
+	 * */
+	ehci_sync_mem();
+
 	qh_get(qh);
 	qh->xacterrs = 0;
 	qh->qh_state = QH_STATE_LINKED;
@@ -1082,6 +1088,18 @@ static struct ehci_qh *qh_append_tds (
 			wmb ();
 			dummy->hw_token = token;
 
+			/*
+			 * Writing to dma coherent buffer on ARM may
+			 * be delayed to reach memory, so HC may not see
+			 * hw_token of dummy qtd in time, which can cause
+			 * the qtd transaction to be executed very late,
+			 * and degrade performance a lot. ehci_sync_mem
+			 * is added to flush 'token' immediatelly into
+			 * memory, so that ehci can execute the transaction
+			 * ASAP.
+			 * */
+			ehci_sync_mem();
+
 			urb->hcpriv = qh_get (qh);
 		}
 	}
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index cc7d337..313d9d6 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -738,6 +738,23 @@ static inline u32 hc32_to_cpup (const struct ehci_hcd *ehci, const __hc32 *x)
 
 #endif
 
+/*
+ * Writing to dma coherent memory on ARM may be delayed via L2
+ * writing buffer, so introduce the helper which can flush L2 writing
+ * buffer into memory immediately, especially used to flush ehci
+ * descriptor to memory.
+ * */
+#ifdef	CONFIG_ARM_DMA_MEM_BUFFERABLE
+static inline void ehci_sync_mem()
+{
+	mb();
+}
+#else
+static inline void ehci_sync_mem()
+{
+}
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 #ifndef DEBUG
-- 
1.7.4.1
