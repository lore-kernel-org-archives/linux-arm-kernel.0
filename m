From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 Oct 2015 13:01:51 -0700
Subject: [PATCH v3 3/4] soc: qcom: smd: Use __ioread32_copy() instead of
 open-coding it
In-Reply-To: <1445630512-10888-1-git-send-email-sboyd@codeaurora.org>
References: <1445630512-10888-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1445630512-10888-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a generic library function for this, replace the
open-coded instance.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/soc/qcom/smd.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/smd.c b/drivers/soc/qcom/smd.c
index 86b598cff91a..498fd0581a45 100644
--- a/drivers/soc/qcom/smd.c
+++ b/drivers/soc/qcom/smd.c
@@ -434,20 +434,15 @@ static void smd_copy_to_fifo(void __iomem *dst,
 /*
  * Copy count bytes of data using 32bit accesses, if that is required.
  */
-static void smd_copy_from_fifo(void *_dst,
-			       const void __iomem *_src,
+static void smd_copy_from_fifo(void *dst,
+			       const void __iomem *src,
 			       size_t count,
 			       bool word_aligned)
 {
-	u32 *dst = (u32 *)_dst;
-	u32 *src = (u32 *)_src;
-
 	if (word_aligned) {
-		count /= sizeof(u32);
-		while (count--)
-			*dst++ = __raw_readl(src++);
+		__ioread32_copy(dst, src, count / sizeof(u32));
 	} else {
-		memcpy_fromio(_dst, _src, count);
+		memcpy_fromio(dst, src, count);
 	}
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
