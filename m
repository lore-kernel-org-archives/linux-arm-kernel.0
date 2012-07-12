From: toddpoynor@google.com (Todd Poynor)
Date: Wed, 11 Jul 2012 19:12:11 -0700
Subject: [PATCH] ARM: samsung: adc: fix race in s3c_adc_start
Message-ID: <1342059131-31251-1-git-send-email-toddpoynor@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checking for adc->ts_pend already claimed should be done with the
lock held.

Change-Id: Ic9f15e26bd19934ab8c2885ce5df265933ac304a
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 arch/arm/plat-samsung/adc.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 33ecd0c..b1e05cc 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -157,11 +157,13 @@ int s3c_adc_start(struct s3c_adc_client *client,
 		return -EINVAL;
 	}
 
-	if (client->is_ts && adc->ts_pend)
-		return -EAGAIN;
-
 	spin_lock_irqsave(&adc->lock, flags);
 
+	if (client->is_ts && adc->ts_pend) {
+		spin_unlock_irqrestore(&adc->lock, flags);
+		return -EAGAIN;
+	}
+
 	client->channel = channel;
 	client->nr_samples = nr_samples;
 
-- 
1.7.7.3
