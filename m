From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu,  6 Oct 2016 18:21:29 -0400
Subject: [PATCH] dmaengine: qcom_hidma: remove useless debugfs file removal
Message-ID: <1475792489-1415-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 'commit acc29fb8f792 ("debugfs: ->d_parent is never NULL or
negative")', HIDMA object removal is no longer working. This is due to
redundant debugfs remove call in hidma_debug_uninit.

debugfs_remove_recursive(dmadev->debugfs);
debugfs_remove_recursive(dmadev->stats);

The first remove is for the directory. Second remove is for the file under
the directory. The directory remove makes file remove invalid.

Unable to handle kernel NULL pointer dereference at virtual address

[<ffff00000889f480>] down_write+0x18/0x68
[<ffff00000831c220>] debugfs_remove_recursive+0x50/0x1c0
[<ffff00000848e0a8>] hidma_debug_uninit+0x20/0x30
[<ffff00000848c5d8>] hidma_remove+0x48/0x98
[<ffff000008511b6c>] platform_drv_remove+0x24/0x68
[<ffff00000850fac8>] __device_release_driver+0x80/0x118
[<ffff00000850fb84>] device_release_driver+0x24/0x38
[<ffff00000850e928>] unbind_store+0xe8/0x110
[<ffff00000850dd30>] drv_attr_store+0x20/0x30
[<ffff000008253a48>] sysfs_kf_write+0x48/0x58
[<ffff000008252dd8>] kernfs_fop_write+0xb0/0x1d8
[<ffff0000081dab3c>] __vfs_write+0x1c/0x110
[<ffff0000081db940>] vfs_write+0xa0/0x1b8
[<ffff0000081dcd34>] SyS_write+0x44/0xa0
[<ffff000008082ef0>] el0_svc_naked+0x24/0x28

Removing the second line.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma_dbg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma_dbg.c b/drivers/dma/qcom/hidma_dbg.c
index 87db285..3bdcb80 100644
--- a/drivers/dma/qcom/hidma_dbg.c
+++ b/drivers/dma/qcom/hidma_dbg.c
@@ -165,7 +165,6 @@ static int hidma_dma_info_open(struct inode *inode, struct file *file)
 void hidma_debug_uninit(struct hidma_dev *dmadev)
 {
 	debugfs_remove_recursive(dmadev->debugfs);
-	debugfs_remove_recursive(dmadev->stats);
 }
 
 int hidma_debug_init(struct hidma_dev *dmadev)
-- 
1.9.1
