From: davidb@codeaurora.org (David Brown)
Date: Tue, 12 Mar 2013 11:41:51 -0700
Subject: [PATCH v2 06/11] ssbi: Comment the use of udelay()
In-Reply-To: <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1363113716-25897-7-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ssbi driver uses a busywait loop to read its status register.  Add
a comment explaining the timing of the device itself so that future
developers can better understand this delay, and possibly diagnose any
problems.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/ssbi/ssbi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ssbi/ssbi.c b/drivers/ssbi/ssbi.c
index 6fbcb25..7ae8925 100644
--- a/drivers/ssbi/ssbi.c
+++ b/drivers/ssbi/ssbi.c
@@ -87,6 +87,15 @@ static inline void ssbi_writel(struct msm_ssbi *ssbi, u32 val, u32 reg)
 	writel(val, ssbi->base + reg);
 }
 
+/*
+ * Via private exchange with one of the original authors, the hardware
+ * should generally finish a transaction in about 5us.  The worst
+ * case, is when using the arbiter and both other CPUs have just
+ * started trying to use the SSBI bus will result in a time of about
+ * 20us.  It should never take longer than this.
+ *
+ * As such, this wait merely spins, with a udelay.
+ */
 static int ssbi_wait_mask(struct msm_ssbi *ssbi, u32 set_mask, u32 clr_mask)
 {
 	u32 timeout = SSBI_TIMEOUT_US;
@@ -161,6 +170,10 @@ err:
 	return ret;
 }
 
+/*
+ * See ssbi_wait_mask for an explanation of the time and the
+ * busywait.
+ */
 static inline int
 msm_ssbi_pa_transfer(struct msm_ssbi *ssbi, u32 cmd, u8 *data)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
