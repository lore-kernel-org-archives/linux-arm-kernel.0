From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri,  9 Jan 2015 16:57:17 -0700
Subject: [PATCH 06/11] coresight-etm: Fix initial trace ID value
In-Reply-To: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
References: <1420847842-31769-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1420847842-31769-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

The coresight TRM specify that a component's trace ID should
be other than 0.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-etm3x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/coresight/coresight-etm3x.c b/drivers/coresight/coresight-etm3x.c
index 369cac00afaa..73c36696f1b6 100644
--- a/drivers/coresight/coresight-etm3x.c
+++ b/drivers/coresight/coresight-etm3x.c
@@ -1749,7 +1749,11 @@ static void etm_init_arch_data(void *info)
 
 static void etm_init_default_data(struct etm_drvdata *drvdata)
 {
-	static int etm3x_traceid;
+	/*
+	 * A trace ID of value 0 is invalid, so let's start at some
+	 * random value that fits in 7 bits and will be just as good.
+	 */
+	static int etm3x_traceid = 0x10;
 
 	u32 flags = (1 << 0 | /* instruction execute*/
 		     3 << 3 | /* ARM instruction */
-- 
1.9.1
