From: colin.king@canonical.com (Colin King)
Date: Tue, 15 Sep 2015 12:42:27 +0100
Subject: [PATCH] [media] c8sectpfe: fix ininitialized error return on firmware
 load failure
Message-ID: <1442317347-6384-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

static analysis with cppcheck detected the following error:

[drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c:1210]:
  (error) Uninitialized variable: ret

ret is never initialised, so garbage is being returned. Instead
return the error return from the call of request_firmware_nowait

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 486aef5..16aa494 100644
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
2.5.0
