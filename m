From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri,  3 Nov 2017 20:01:57 -0600
Subject: [PATCH v2 1/2] media: s5p-mfc: remove firmware buf null check in
 s5p_mfc_load_firmware()
In-Reply-To: <cover.1509760483.git.shuahkh@osg.samsung.com>
References: <cover.1509760483.git.shuahkh@osg.samsung.com>
Message-ID: <af2205b4a377fa0a77e01ac60893fc5f63bffd4a.1509760484.git.shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s5p_mfc_load_firmware() will not get called if fw_buf.virt allocation
fails. The allocation happens very early on in the probe routine and
probe fails if allocation fails.

There is no need to check if it is null in s5p_mfc_load_firmware().
Remove the check.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
index 69ef9c2..46c9d67 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
@@ -75,11 +75,6 @@ int s5p_mfc_load_firmware(struct s5p_mfc_dev *dev)
 		release_firmware(fw_blob);
 		return -ENOMEM;
 	}
-	if (!dev->fw_buf.virt) {
-		mfc_err("MFC firmware is not allocated\n");
-		release_firmware(fw_blob);
-		return -EINVAL;
-	}
 	memcpy(dev->fw_buf.virt, fw_blob->data, fw_blob->size);
 	wmb();
 	release_firmware(fw_blob);
-- 
2.7.4
