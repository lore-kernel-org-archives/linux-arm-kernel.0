From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 20 Jul 2018 13:12:28 +0800
Subject: [PATCH v6 2/4] Bluetooth: Add new quirk for non-persistent setup
 settings
In-Reply-To: <cover.1532060309.git.sean.wang@mediatek.com>
References: <cover.1532060309.git.sean.wang@mediatek.com>
Message-ID: <d20e070679bb40bff011f5a74f531e1b662d08a5.1532060309.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add a new quirk HCI_QUIRK_NON_PERSISTENT_SETUP allowing that a quirk that
runs setup() after every open() and not just after the first open().

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/net/bluetooth/hci.h | 9 +++++++++
 net/bluetooth/hci_core.c    | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1668211..b37d973 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -183,6 +183,15 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_NON_PERSISTENT_DIAG,
+
+	/* When this quirk is set, setup() would be run after every
+	 * open() and not just after the first open().
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 *
+	 */
+	HCI_QUIRK_NON_PERSISTENT_SETUP,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 40d260f..7de712e2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1377,7 +1377,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	atomic_set(&hdev->cmd_cnt, 1);
 	set_bit(HCI_INIT, &hdev->flags);
 
-	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
+	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
 
 		if (hdev->setup)
-- 
2.7.4
