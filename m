From: stano@meduna.org (Stanislav Meduna)
Date: Wed, 27 Apr 2016 13:53:21 +0200
Subject: [PATCH] nvmem/mxs-ocotp: fix buffer overflow in read
Message-ID: <201ccd58-8735-02d8-b4e4-9d2eda828fd8@meduna.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the issue where the mxs_ocotp_read is reading
the ocotp in reg_size steps but decrements the remaining size
by 1. The number of iterations is thus four times higher,
overwriting the area behind the output buffer.

Fixes: c01e9a11ab6f ("nvmem: add driver for ocotp in i.MX23 and i.MX28")
---
 drivers/nvmem/mxs-ocotp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 8ba19bb..2bb3c57 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -94,7 +94,7 @@ static int mxs_ocotp_read(void *context, const void *reg, size_t reg_size,
 	if (ret)
 		goto close_banks;

-	while (val_size) {
+	while (val_size >= reg_size) {
 		if ((offset < OCOTP_DATA_OFFSET) || (offset % 16)) {
 			/* fill up non-data register */
 			*buf = 0;
@@ -103,7 +103,7 @@ static int mxs_ocotp_read(void *context, const void *reg, size_t reg_size,
 		}

 		buf++;
-		val_size--;
+		val_size -= reg_size;
 		offset += reg_size;
 	}

-- 
2.1.4
