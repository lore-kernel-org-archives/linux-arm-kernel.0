From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  2 Sep 2015 15:46:47 -0700
Subject: [PATCH v2 4/8] soc: qcom: smd: Use __iowrite32_copy() instead of
 open-coding it
In-Reply-To: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
References: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1441234011-4259-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already have a function to do this and it silences some sparse
warnings along the way.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

No changes

 drivers/soc/qcom/smd.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/smd.c b/drivers/soc/qcom/smd.c
index 15edef1dc58a..069724b8189e 100644
--- a/drivers/soc/qcom/smd.c
+++ b/drivers/soc/qcom/smd.c
@@ -371,20 +371,15 @@ static void qcom_smd_channel_set_state(struct qcom_smd_channel *channel,
 /*
  * Copy count bytes of data using 32bit accesses, if that's required.
  */
-static void smd_copy_to_fifo(void __iomem *_dst,
-			     const void *_src,
+static void smd_copy_to_fifo(void __iomem *dst,
+			     const void *src,
 			     size_t count,
 			     bool word_aligned)
 {
-	u32 *dst = (u32 *)_dst;
-	u32 *src = (u32 *)_src;
-
 	if (word_aligned) {
-		count /= sizeof(u32);
-		while (count--)
-			writel_relaxed(*src++, dst++);
+		__iowrite32_copy(dst, src, count / sizeof(u32));
 	} else {
-		memcpy_toio(_dst, _src, count);
+		memcpy_toio(dst, src, count);
 	}
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
