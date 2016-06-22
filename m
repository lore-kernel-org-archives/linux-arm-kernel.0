From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 22 Jun 2016 10:49:29 +0100
Subject: [PATCH] mailbox: pl320: remove __raw IO
Message-ID: <1466588969-28051-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The use of __raw IO accesors is not endian safe and should be used
sparingly. The relaxed variants should be as lightweight and also
are endian safe.

Note, this has not been run-time tested.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: linux-arm-kernel at lists.infradead.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/mailbox/pl320-ipc.c | 46 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mailbox/pl320-ipc.c b/drivers/mailbox/pl320-ipc.c
index f80acb3..2dbed87 100644
--- a/drivers/mailbox/pl320-ipc.c
+++ b/drivers/mailbox/pl320-ipc.c
@@ -58,29 +58,29 @@ static ATOMIC_NOTIFIER_HEAD(ipc_notifier);
 
 static inline void set_destination(int source, int mbox)
 {
-	__raw_writel(CHAN_MASK(source), ipc_base + IPCMxDSET(mbox));
-	__raw_writel(CHAN_MASK(source), ipc_base + IPCMxMSET(mbox));
+	writel_relaxed(CHAN_MASK(source), ipc_base + IPCMxDSET(mbox));
+	writel_relaxed(CHAN_MASK(source), ipc_base + IPCMxMSET(mbox));
 }
 
 static inline void clear_destination(int source, int mbox)
 {
-	__raw_writel(CHAN_MASK(source), ipc_base + IPCMxDCLEAR(mbox));
-	__raw_writel(CHAN_MASK(source), ipc_base + IPCMxMCLEAR(mbox));
+	writel_relaxed(CHAN_MASK(source), ipc_base + IPCMxDCLEAR(mbox));
+	writel_relaxed(CHAN_MASK(source), ipc_base + IPCMxMCLEAR(mbox));
 }
 
 static void __ipc_send(int mbox, u32 *data)
 {
 	int i;
 	for (i = 0; i < 7; i++)
-		__raw_writel(data[i], ipc_base + IPCMxDR(mbox, i));
-	__raw_writel(0x1, ipc_base + IPCMxSEND(mbox));
+		writel_relaxed(data[i], ipc_base + IPCMxDR(mbox, i));
+	writel_relaxed(0x1, ipc_base + IPCMxSEND(mbox));
 }
 
 static u32 __ipc_rcv(int mbox, u32 *data)
 {
 	int i;
 	for (i = 0; i < 7; i++)
-		data[i] = __raw_readl(ipc_base + IPCMxDR(mbox, i));
+		data[i] = readl_relaxed(ipc_base + IPCMxDR(mbox, i));
 	return data[1];
 }
 
@@ -112,15 +112,15 @@ static irqreturn_t ipc_handler(int irq, void *dev)
 	u32 irq_stat;
 	u32 data[7];
 
-	irq_stat = __raw_readl(ipc_base + IPCMMIS(1));
+	irq_stat = readl_relaxed(ipc_base + IPCMMIS(1));
 	if (irq_stat & MBOX_MASK(IPC_TX_MBOX)) {
-		__raw_writel(0, ipc_base + IPCMxSEND(IPC_TX_MBOX));
+		writel_relaxed(0, ipc_base + IPCMxSEND(IPC_TX_MBOX));
 		complete(&ipc_completion);
 	}
 	if (irq_stat & MBOX_MASK(IPC_RX_MBOX)) {
 		__ipc_rcv(IPC_RX_MBOX, data);
 		atomic_notifier_call_chain(&ipc_notifier, data[0], data + 1);
-		__raw_writel(2, ipc_base + IPCMxSEND(IPC_RX_MBOX));
+		writel_relaxed(2, ipc_base + IPCMxSEND(IPC_RX_MBOX));
 	}
 
 	return IRQ_HANDLED;
@@ -146,7 +146,7 @@ static int pl320_probe(struct amba_device *adev, const struct amba_id *id)
 	if (ipc_base == NULL)
 		return -ENOMEM;
 
-	__raw_writel(0, ipc_base + IPCMxSEND(IPC_TX_MBOX));
+	writel_relaxed(0, ipc_base + IPCMxSEND(IPC_TX_MBOX));
 
 	ipc_irq = adev->irq[0];
 	ret = request_irq(ipc_irq, ipc_handler, 0, dev_name(&adev->dev), NULL);
@@ -154,20 +154,20 @@ static int pl320_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err;
 
 	/* Init slow mailbox */
-	__raw_writel(CHAN_MASK(A9_SOURCE),
-			ipc_base + IPCMxSOURCE(IPC_TX_MBOX));
-	__raw_writel(CHAN_MASK(M3_SOURCE),
-			ipc_base + IPCMxDSET(IPC_TX_MBOX));
-	__raw_writel(CHAN_MASK(M3_SOURCE) | CHAN_MASK(A9_SOURCE),
-		     ipc_base + IPCMxMSET(IPC_TX_MBOX));
+	writel_relaxed(CHAN_MASK(A9_SOURCE),
+		       ipc_base + IPCMxSOURCE(IPC_TX_MBOX));
+	writel_relaxed(CHAN_MASK(M3_SOURCE),
+		       ipc_base + IPCMxDSET(IPC_TX_MBOX));
+	writel_relaxed(CHAN_MASK(M3_SOURCE) | CHAN_MASK(A9_SOURCE),
+		       ipc_base + IPCMxMSET(IPC_TX_MBOX));
 
 	/* Init receive mailbox */
-	__raw_writel(CHAN_MASK(M3_SOURCE),
-			ipc_base + IPCMxSOURCE(IPC_RX_MBOX));
-	__raw_writel(CHAN_MASK(A9_SOURCE),
-			ipc_base + IPCMxDSET(IPC_RX_MBOX));
-	__raw_writel(CHAN_MASK(M3_SOURCE) | CHAN_MASK(A9_SOURCE),
-		     ipc_base + IPCMxMSET(IPC_RX_MBOX));
+	writel_relaxed(CHAN_MASK(M3_SOURCE),
+		       ipc_base + IPCMxSOURCE(IPC_RX_MBOX));
+	writel_relaxed(CHAN_MASK(A9_SOURCE),
+		       ipc_base + IPCMxDSET(IPC_RX_MBOX));
+	writel_relaxed(CHAN_MASK(M3_SOURCE) | CHAN_MASK(A9_SOURCE),
+		       ipc_base + IPCMxMSET(IPC_RX_MBOX));
 
 	return 0;
 err:
-- 
2.8.1
