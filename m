From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 9 Jul 2018 23:57:01 +0800
Subject: [PATCH v5 5/7] Bluetooth: Extend btuart driver for join more vendor
 devices
In-Reply-To: <cover.1531150733.git.sean.wang@mediatek.com>
References: <cover.1531150733.git.sean.wang@mediatek.com>
Message-ID: <85d449cdd34bf47d72935a821915e825c64a2145.1531150733.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Adding an independent btuart.h header allows these essential definitions
can be reused in vendor driver. Also, struct btuart_vnd is extended with
additional callbacks such as .init initializing vendor data, .shtudown,
.recv and .send supporting SoC specific framing for that btuart can
simply adapt to various Bluetooth uart-based devices.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btuart.c | 73 ++++++++++++++++++++++++----------------------
 drivers/bluetooth/btuart.h | 30 +++++++++++++++++++
 2 files changed, 68 insertions(+), 35 deletions(-)
 create mode 100644 drivers/bluetooth/btuart.h

diff --git a/drivers/bluetooth/btuart.c b/drivers/bluetooth/btuart.c
index a900aac..65d0086 100644
--- a/drivers/bluetooth/btuart.c
+++ b/drivers/bluetooth/btuart.c
@@ -33,35 +33,11 @@
 #include <net/bluetooth/hci_core.h>
 
 #include "h4_recv.h"
+#include "btuart.h"
 #include "btbcm.h"
 
 #define VERSION "1.0"
 
-struct btuart_vnd {
-	const struct h4_recv_pkt *recv_pkts;
-	int recv_pkts_cnt;
-	unsigned int manufacturer;
-	int (*open)(struct hci_dev *hdev);
-	int (*close)(struct hci_dev *hdev);
-	int (*setup)(struct hci_dev *hdev);
-};
-
-struct btuart_dev {
-	struct hci_dev *hdev;
-	struct serdev_device *serdev;
-
-	struct work_struct tx_work;
-	unsigned long tx_state;
-	struct sk_buff_head txq;
-
-	struct sk_buff *rx_skb;
-
-	const struct btuart_vnd *vnd;
-};
-
-#define BTUART_TX_STATE_ACTIVE	1
-#define BTUART_TX_STATE_WAKEUP	2
-
 static void btuart_tx_work(struct work_struct *work)
 {
 	struct btuart_dev *bdev = container_of(work, struct btuart_dev,
@@ -187,13 +163,27 @@ static int btuart_setup(struct hci_dev *hdev)
 	return 0;
 }
 
+static int btuart_shutdown(struct hci_dev *hdev)
+{
+	struct btuart_dev *bdev = hci_get_drvdata(hdev);
+
+	if (bdev->vnd->shutdown)
+		return bdev->vnd->shutdown(hdev);
+
+	return 0;
+}
+
 static int btuart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btuart_dev *bdev = hci_get_drvdata(hdev);
 
-	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
-	skb_queue_tail(&bdev->txq, skb);
+	if (bdev->vnd->send) {
+		bdev->vnd->send(hdev, skb);
+	} else {
+		/* Prepend skb with frame type */
+		memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+		skb_queue_tail(&bdev->txq, skb);
+	}
 
 	btuart_tx_wakeup(bdev);
 	return 0;
@@ -204,14 +194,23 @@ static int btuart_receive_buf(struct serdev_device *serdev, const u8 *data,
 {
 	struct btuart_dev *bdev = serdev_device_get_drvdata(serdev);
 	const struct btuart_vnd *vnd = bdev->vnd;
+	int err;
 
-	bdev->rx_skb = h4_recv_buf(bdev->hdev, bdev->rx_skb, data, count,
-				   vnd->recv_pkts, vnd->recv_pkts_cnt);
-	if (IS_ERR(bdev->rx_skb)) {
-		int err = PTR_ERR(bdev->rx_skb);
-		bt_dev_err(bdev->hdev, "Frame reassembly failed (%d)", err);
-		bdev->rx_skb = NULL;
-		return err;
+	if (bdev->vnd->recv) {
+		err = bdev->vnd->recv(bdev->hdev, data, count);
+		if (err < 0)
+			return err;
+	} else {
+		bdev->rx_skb = h4_recv_buf(bdev->hdev, bdev->rx_skb,
+					   data, count, vnd->recv_pkts,
+					   vnd->recv_pkts_cnt);
+		if (IS_ERR(bdev->rx_skb)) {
+			err = PTR_ERR(bdev->rx_skb);
+			bt_dev_err(bdev->hdev,
+				   "Frame reassembly failed (%d)", err);
+			bdev->rx_skb = NULL;
+			return err;
+		}
 	}
 
 	bdev->hdev->stat.byte_rx += count;
@@ -429,6 +428,9 @@ static int btuart_probe(struct serdev_device *serdev)
 	if (!bdev->vnd)
 		bdev->vnd = &default_vnd;
 
+	if (bdev->vnd->init)
+		bdev->data = bdev->vnd->init(&serdev->dev);
+
 	bdev->serdev = serdev;
 	serdev_device_set_drvdata(serdev, bdev);
 
@@ -460,6 +462,7 @@ static int btuart_probe(struct serdev_device *serdev)
 	hdev->close = btuart_close;
 	hdev->flush = btuart_flush;
 	hdev->setup = btuart_setup;
+	hdev->shutdown = btuart_shutdown;
 	hdev->send  = btuart_send_frame;
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
diff --git a/drivers/bluetooth/btuart.h b/drivers/bluetooth/btuart.h
new file mode 100644
index 0000000..6c1fe31
--- /dev/null
+++ b/drivers/bluetooth/btuart.h
@@ -0,0 +1,30 @@
+struct btuart_vnd {
+	const struct h4_recv_pkt *recv_pkts;
+	int recv_pkts_cnt;
+	unsigned int manufacturer;
+	void *(*init)(struct device *dev);
+
+	int (*open)(struct hci_dev *hdev);
+	int (*close)(struct hci_dev *hdev);
+	int (*setup)(struct hci_dev *hdev);
+	int (*shutdown)(struct hci_dev *hdev);
+	int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv)(struct hci_dev *hdev, const u8 *data, size_t count);
+};
+
+struct btuart_dev {
+	struct hci_dev *hdev;
+	struct serdev_device *serdev;
+
+	struct work_struct tx_work;
+	unsigned long tx_state;
+	struct sk_buff_head txq;
+
+	struct sk_buff *rx_skb;
+
+	const struct btuart_vnd *vnd;
+	void *data;
+};
+
+#define BTUART_TX_STATE_ACTIVE	1
+#define BTUART_TX_STATE_WAKEUP	2
-- 
2.7.4
