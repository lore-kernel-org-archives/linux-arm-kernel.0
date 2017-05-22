From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon, 22 May 2017 21:50:42 +0800
Subject: [PATCH] Bluetooth: hci_ll: Fix download_firmware() return when
 __hci_cmd_sync fails
Message-ID: <20170522135042.10921-1-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When __hci_cmd_sync() fails, download_firmware() should also fail, and
the same error value should be returned as PTR_ERR(skb).

Without this fix, download_firmware() will return a success when it actually
failed in __hci_cmd_sync().

Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/bluetooth/hci_ll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index adc444f..200288c 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -624,6 +624,7 @@ static int download_firmware(struct ll_device *lldev)
 			skb = __hci_cmd_sync(lldev->hu.hdev, cmd->opcode, cmd->plen, &cmd->speed, HCI_INIT_TIMEOUT);
 			if (IS_ERR(skb)) {
 				bt_dev_err(lldev->hu.hdev, "send command failed\n");
+				err = PTR_ERR(skb);
 				goto out_rel_fw;
 			}
 			kfree_skb(skb);
-- 
2.10.2
