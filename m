From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 11 Apr 2017 17:10:27 +0800
Subject: [PATCH RFC 2/4] coresight: tmc: set read pointer before dump RAM
In-Reply-To: <1491901829-18477-1-git-send-email-leo.yan@linaro.org>
References: <1491901829-18477-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1491901829-18477-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When dump RAM, we need set read pointer so can make sure every time read
the consistent content. If the RAM is full by checking status register
(STS), so set the read pointer to same value with write pointer,
otherwise set read point to 0 so can read from the start of RAM.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 6150dac..43cfeaa 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -43,10 +43,28 @@ static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 {
+	u32 write_ptr, status;
 	char *bufp;
 	u32 read_data;
 	int i;
 
+	write_ptr = readl_relaxed(drvdata->base + TMC_RWP);
+
+	/*
+	 * Get a hold of the status register and see if a wrap around
+	 * has occurred.  If so adjust things accordingly.
+	 */
+	status = readl_relaxed(drvdata->base + TMC_STS);
+	if (status & TMC_STS_FULL)
+		/* Tell the HW the reading start point */
+		writel_relaxed(write_ptr, drvdata->base + TMC_RRP);
+	else
+		/*
+		 * In case this is not first time to read ETB RAM,
+		 * always write 0 for reading pointer.
+		 */
+		writel_relaxed(0x0, drvdata->base + TMC_RRP);
+
 	bufp = drvdata->buf;
 	drvdata->len = 0;
 	while (1) {
-- 
2.7.4
