From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 19 Jul 2017 15:25:41 +0530
Subject: [PATCH 5/6] mailbox: bcm-flexrm-mailbox: Set msg_queue_len for each
 channel
In-Reply-To: <1500458142-19243-1-git-send-email-anup.patel@broadcom.com>
References: <1500458142-19243-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1500458142-19243-6-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom FlexRM ring (i.e. mailbox channel) can handle
larger number of messages queued in one FlexRM ring hence
this patch sets msg_queue_len for each mailbox channel to
be same as RING_MAX_REQ_COUNT.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 46ad305..ec3d57b 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1674,8 +1674,11 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto fail_free_debugfs_root;
 	}
-	for (index = 0; index < mbox->num_rings; index++)
+	for (index = 0; index < mbox->num_rings; index++) {
+		mbox->controller.chans[index].msg_queue_len =
+						RING_MAX_REQ_COUNT;
 		mbox->controller.chans[index].con_priv = &mbox->rings[index];
+	}
 
 	/* Register mailbox controller */
 	ret = mbox_controller_register(&mbox->controller);
-- 
2.7.4
