From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 14:37:19 +0100
Subject: [PATCH] mmc: dw_mmc: fix 32bit little-endian access of des1 field
Message-ID: <1465306639-9537-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IDMAC_SET_BUFFER1_SIZE() macro modifies des1, but does
not check if the value being passed is big or little endian
desptire the des1 field being marked as __le32.

Fix the issue by ensuring the values are changed from the
cpu endian to the descriptor endian by using cpu_to_le32.

Spotted whilst doing big endian conversion work on Exynos,
and stops the mmc worker thread from stalling.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Matthew Leach <matt.leach@codethink.co.uk>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2cc6123..544397e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -92,7 +92,7 @@ struct idmac_desc {
 
 	__le32		des1;	/* Buffer sizes */
 #define IDMAC_SET_BUFFER1_SIZE(d, s) \
-	((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
+	((d)->des1 = ((d)->des1 & cpu_to_le32(0x03ffe000)) | (cpu_to_le32((s) & 0x1fff)))
 
 	__le32		des2;	/* buffer 1 physical address */
 
-- 
2.8.1
