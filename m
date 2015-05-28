From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 May 2015 13:52:12 -0700
Subject: [PATCH] amba: Support clk parents and rates assigned in DT
Message-ID: <1432846332-17692-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the call to of_clk_set_defaults() into the amba probe path so
that devices on the amba bus can use the assigned rates and
parents feature of the common clock framework.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Russell,

Can you please ack this change? We're going to send it through the clk tree
because hisi clock requires it.

Thanks,
Stephen

 drivers/amba/bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f0099360039e..350ed93d4281 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -19,6 +19,7 @@
 #include <linux/amba/bus.h>
 #include <linux/sizes.h>
 #include <linux/limits.h>
+#include <linux/clk/clk-conf.h>
 
 #include <asm/irq.h>
 
@@ -237,6 +238,10 @@ static int amba_probe(struct device *dev)
 	int ret;
 
 	do {
+		ret = of_clk_set_defaults(dev->of_node, false);
+		if (ret < 0)
+			break;
+
 		ret = dev_pm_domain_attach(dev, true);
 		if (ret == -EPROBE_DEFER)
 			break;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
