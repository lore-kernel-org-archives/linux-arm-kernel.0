From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Thu,  2 Jun 2016 19:02:55 +0530
Subject: [PATCH] [media] c8sectpfe: fix memory leak
Message-ID: <1464874375-12114-1-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have assigned memory while requesting the firmware but if the sanity
check fails then we are not releasing the firmware.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 7dddf77..30c148b 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -1161,6 +1161,7 @@ static int load_c8sectpfe_fw(struct c8sectpfei *fei)
 	if (err) {
 		dev_err(fei->dev, "c8sectpfe_elf_sanity_check failed err=(%d)\n"
 			, err);
+		release_firmware(fw);
 		return err;
 	}
 
-- 
1.9.1
