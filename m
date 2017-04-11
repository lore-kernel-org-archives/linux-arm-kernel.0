From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 11 Apr 2017 17:10:26 +0800
Subject: [PATCH RFC 1/4] coresight: tmc: check dump buffer is overflow
In-Reply-To: <1491901829-18477-1-git-send-email-leo.yan@linaro.org>
References: <1491901829-18477-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1491901829-18477-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the code dumping ETB buffer is terminated when read back value
0xFFFF_FFFF. This is not safe and introduce infinite looping for some
cases, e.g. when reset the CPU and read out ETB RAM.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 3a1c181..6150dac 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -54,6 +54,13 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 			read_data = readl_relaxed(drvdata->base + TMC_RRD);
 			if (read_data == 0xFFFFFFFF)
 				return;
+
+			/* Check if allocated buffer is overflow */
+			if (drvdata->len >= drvdata->size) {
+				dev_info(drvdata->dev, "TMC dump overflow!\n");
+				return;
+			}
+
 			memcpy(bufp, &read_data, 4);
 			bufp += 4;
 			drvdata->len += 4;
-- 
2.7.4
