From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Tue, 23 Jan 2018 02:09:02 +0000
Subject: [PATCH -next] cpufreq: scpi: fix error return code in
 scpi_cpufreq_init()
Message-ID: <1516673342-170261-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix to return a negative error code from the clk_get() error handling
case instead of 0, as done elsewhere in this function.

Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 247fcbf..7095fc0 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -145,6 +145,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 	if (IS_ERR(priv->clk)) {
 		dev_err(cpu_dev, "%s: Failed to get clk for cpu: %d\n",
 			__func__, cpu_dev->id);
+		ret = PTR_ERR(priv->clk);
 		goto out_free_cpufreq_table;
 	}
