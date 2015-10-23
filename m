From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 Oct 2015 13:01:52 -0700
Subject: [PATCH v3 4/4] FIRMWARE: bcm47xx_nvram: Use __ioread32_copy() instead
 of open-coding
In-Reply-To: <1445630512-10888-1-git-send-email-sboyd@codeaurora.org>
References: <1445630512-10888-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1445630512-10888-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a generic library function for this, replace the
open-coded instance.

Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Rafa? Mi?ecki <zajec5@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: linux-mips at linux-mips.org
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index e41594510b97..0c2f0a61b0ea 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -56,9 +56,7 @@ static u32 find_nvram_size(void __iomem *end)
 static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 {
 	struct nvram_header __iomem *header;
-	int i;
 	u32 off;
-	u32 *src, *dst;
 	u32 size;
 
 	if (nvram_len) {
@@ -95,10 +93,7 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 	return -ENXIO;
 
 found:
-	src = (u32 *)header;
-	dst = (u32 *)nvram_buf;
-	for (i = 0; i < sizeof(struct nvram_header); i += 4)
-		*dst++ = __raw_readl(src++);
+	__ioread32_copy(nvram_buf, header, sizeof(*header) / 4);
 	header = (struct nvram_header *)nvram_buf;
 	nvram_len = header->len;
 	if (nvram_len > size) {
@@ -111,8 +106,8 @@ found:
 		nvram_len = NVRAM_SPACE - 1;
 	}
 	/* proceed reading data after header */
-	for (; i < nvram_len; i += 4)
-		*dst++ = readl(src++);
+	__ioread32_copy(nvram_buf + sizeof(*header), header + 1,
+			DIV_ROUND_UP(nvram_len, 4));
 	nvram_buf[NVRAM_SPACE - 1] = '\0';
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
