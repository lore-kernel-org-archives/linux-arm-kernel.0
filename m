From: anders.roxell@linaro.org (Anders Roxell)
Date: Fri, 16 Mar 2018 12:44:42 +0100
Subject: [PATCH] firmware: arm_scmi: prevent accessing rate_discrete
 uninitialized
Message-ID: <20180316114442.9536-1-anders.roxell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-5.3 and earlier warns that rate_discrete maybe-uninitialized
    ../drivers/firmware/arm_scmi/clock.c:185:5: warning: 'rate_discrete'
        may be used uninitialized in this function [-Wmaybe-uninitialized]
      if (rate_discrete)
         ^
    ../drivers/firmware/arm_scmi/clock.c:128:7: note:
        'rate_discrete' was declared here
      bool rate_discrete;
           ^

Fixes: 5f6c6430e904 ("firmware: arm_scmi: add initial support for clock protocol")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/firmware/arm_scmi/clock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index e8ffad33a0ff..e6f17825db79 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -125,7 +125,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 {
 	u64 *rate;
 	int ret, cnt;
-	bool rate_discrete;
+	bool rate_discrete = false;
 	u32 tot_rate_cnt = 0, rates_flag;
 	u16 num_returned, num_remaining;
 	struct scmi_xfer *t;
@@ -147,7 +147,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 
 		ret = scmi_do_xfer(handle, t);
 		if (ret)
-			break;
+			goto err;
 
 		rates_flag = le32_to_cpu(rlist->num_rates_flags);
 		num_remaining = NUM_REMAINING(rates_flag);
@@ -185,6 +185,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 	if (rate_discrete)
 		clk->list.num_rates = tot_rate_cnt;
 
+err:
 	scmi_one_xfer_put(handle, t);
 	return ret;
 }
-- 
2.11.0
