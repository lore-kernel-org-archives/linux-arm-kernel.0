From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 28 Oct 2015 08:59:11 +0100
Subject: [PATCH 2/5] cpufreq: imx6q: Fix wrong device in devm_kzalloc
In-Reply-To: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
References: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1446019154-16384-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_kzalloc must be called with the device that is actually probed,
not with cpu_dev which resources are not freed when probe fails.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/cpufreq/imx6q-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index fabd144..6fefd19 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -260,7 +260,8 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	/* Make imx6_soc_volt array's size same as arm opp number */
-	imx6_soc_volt = devm_kzalloc(cpu_dev, sizeof(*imx6_soc_volt) * num, GFP_KERNEL);
+	imx6_soc_volt = devm_kzalloc(&pdev->dev,
+				     sizeof(*imx6_soc_volt) * num, GFP_KERNEL);
 	if (imx6_soc_volt == NULL) {
 		ret = -ENOMEM;
 		goto free_freq_table;
-- 
2.6.1
