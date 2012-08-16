From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 16 Aug 2012 11:03:13 +0800
Subject: [PATCH] rtc: snvs: change timeout to use a fixed number of loop
In-Reply-To: <Message-ID: <1342164663-31351-1-git-send-email-shawn.guo@linaro.org>
References: <Message-ID: <1342164663-31351-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1345086193-23870-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> The timeout code here is fragile.  If acquiring the spinlock takes more
> than a millisecond or if this thread gets interrupted or preempted then
> we could easily execute that loop just a single time, and fail.
>
> It would be better to retry a fixed number of times, say 1000?  That
> would take around 1 millisecond, but might be overkill.

Take Andrew's suggestion to change the timeout code to retry 1000
times.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/rtc/rtc-snvs.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 912f116..3c0da33 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -83,8 +83,8 @@ static void rtc_write_sync_lp(void __iomem *ioaddr)
 
 static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(1);
 	unsigned long flags;
+	int timeout = 1000;
 	u32 lpcr;
 
 	spin_lock_irqsave(&data->lock, flags);
@@ -98,7 +98,7 @@ static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
-	while (1) {
+	while (--timeout) {
 		lpcr = readl(data->ioaddr + SNVS_LPCR);
 
 		if (enable) {
@@ -108,11 +108,11 @@ static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
 			if (!(lpcr & SNVS_LPCR_SRTC_ENV))
 				break;
 		}
-
-		if (time_after(jiffies, timeout))
-			return -ETIMEDOUT;
 	}
 
+	if (!timeout)
+		return -ETIMEDOUT;
+
 	return 0;
 }
 
-- 
1.7.5.4
