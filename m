From: cengelma@gmx.at (Christian Engelmayer)
Date: Sat, 19 Sep 2015 01:57:37 +0200
Subject: [PATCH] [media] c8sectpfe: Fix uninitialized return in
 load_c8sectpfe_fw_step1()
Message-ID: <1442620657-31671-1-git-send-email-cengelma@gmx.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of failure loading the firmware, function
load_c8sectpfe_fw_step1() uses the uninitialized variable ret as return
value instead of the retrieved error value. Make sure the result is
deterministic. Detected by Coverity CID 1324230.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
Compile tested only. Applies against linux-next.
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 486aef50d99b..16aa494f22be 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -1192,7 +1192,6 @@ err:
 
 static int load_c8sectpfe_fw_step1(struct c8sectpfei *fei)
 {
-	int ret;
 	int err;
 
 	dev_info(fei->dev, "Loading firmware: %s\n", FIRMWARE_MEMDMA);
@@ -1207,7 +1206,7 @@ static int load_c8sectpfe_fw_step1(struct c8sectpfei *fei)
 	if (err) {
 		dev_err(fei->dev, "request_firmware_nowait err: %d.\n", err);
 		complete_all(&fei->fw_ack);
-		return ret;
+		return err;
 	}
 
 	return 0;
-- 
1.9.1
