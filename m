From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Jul 2015 02:22:03 +0200
Subject: [PATCH 17/20] power/reset: at91-reset: get and use slow clock
In-Reply-To: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438215726-27452-18-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
hang") added a workaround for the slow clock as it is not properly handled
by its users.

Get and use the slow clock as it is necessary for the at91 reset
controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm at vger.kernel.org
 drivers/power/reset/at91-reset.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 3e8f478385c1..cd277570af6e 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -46,6 +47,7 @@ enum reset_type {
 };
 
 static void __iomem *at91_ramc_base[2], *at91_rstc_base;
+static struct clk *sclk;
 
 /*
 * unless the SDRAM is cleanly shutdown before we hit the
@@ -199,6 +201,15 @@ static int at91_reset_probe(struct platform_device *pdev)
 {
 	int ret;
 
+	sclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sclk))
+		return PTR_ERR(sclk);
+
+	ret = clk_prepare_enable(sclk);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not enable slow clock\n");
+		return ret;
+	}
 
 	ret = at91_reset_of_probe(pdev);
 	if (ret)
-- 
2.1.4
