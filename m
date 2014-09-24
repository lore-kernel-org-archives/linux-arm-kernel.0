From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 24 Sep 2014 17:33:55 +0800
Subject: [RESEND PATCH] misc: atmel-ssc: prepare clock only when request
Message-ID: <1411551235-16502-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare SSC clock only when request SSC channel, the clock will be
enabled when initialize the SSC.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Send this patch to driver/misc maintainer as Mark Brown suggested.

 drivers/misc/atmel-ssc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index 60843a2..f9807a7 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -57,7 +57,7 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
 	ssc->user++;
 	spin_unlock(&user_lock);
 
-	clk_prepare_enable(ssc->clk);
+	clk_prepare(ssc->clk);
 
 	return ssc;
 }
@@ -77,7 +77,7 @@ void ssc_free(struct ssc_device *ssc)
 	spin_unlock(&user_lock);
 
 	if (disable_clk)
-		clk_disable_unprepare(ssc->clk);
+		clk_unprepare(ssc->clk);
 }
 EXPORT_SYMBOL(ssc_free);
 
-- 
2.1.0.24.g4109c28
