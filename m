From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  1 Jun 2018 12:08:22 +0100
Subject: [PATCH] coresight: Fix check in
 coresight_tmc_etr_buf_insert_barrier_packet
Message-ID: <1527851302-5843-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We request for "CORESIGHT_BARRIER_PKT_SIZE" length and we should
be happy when we get that size.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---

Mathieu,

Please could you pull this patch, if you are happy with it ?
This fixes a problem in the ETR buf series, which I just
noticed while testing the part2 of the series.

Suzuki
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index e2bcef3..c736250 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -862,7 +862,7 @@ tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
 
 	len = tmc_etr_buf_get_data(etr_buf, offset,
 				   CORESIGHT_BARRIER_PKT_SIZE, &bufp);
-	if (WARN_ON(len <= CORESIGHT_BARRIER_PKT_SIZE))
+	if (WARN_ON(len < CORESIGHT_BARRIER_PKT_SIZE))
 		return -EINVAL;
 	coresight_insert_barrier_packet(bufp);
 	return offset + CORESIGHT_BARRIER_PKT_SIZE;
-- 
2.7.4
