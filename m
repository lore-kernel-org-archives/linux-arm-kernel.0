From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu,  1 Jun 2017 14:22:28 +0530
Subject: [PATCH] misc: atmel-ssc: Handle return value of clk_prepare_enable
 and clk_prepare
Message-ID: <cb2b3be8181a11c9d102bd2e7d4088e87f939e4d.1496302242.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() and clk_prepare() can fail here and
we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/misc/atmel-ssc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index b2a0340..4d2b090 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -30,6 +30,7 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
 {
 	int ssc_valid = 0;
 	struct ssc_device *ssc;
+	int ret;
 
 	spin_lock(&user_lock);
 	list_for_each_entry(ssc, &ssc_list, list) {
@@ -60,7 +61,11 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
 	ssc->user++;
 	spin_unlock(&user_lock);
 
-	clk_prepare(ssc->clk);
+	ret = clk_prepare(ssc->clk);
+	if (ret) {
+		pr_err("Failed to prepare clock\n");
+		return ret;
+	}
 
 	return ssc;
 }
@@ -195,6 +200,7 @@ static int ssc_probe(struct platform_device *pdev)
 	struct resource *regs;
 	struct ssc_device *ssc;
 	const struct atmel_ssc_platform_data *plat_dat;
+	int ret;
 
 	ssc = devm_kzalloc(&pdev->dev, sizeof(struct ssc_device), GFP_KERNEL);
 	if (!ssc) {
@@ -229,7 +235,9 @@ static int ssc_probe(struct platform_device *pdev)
 	}
 
 	/* disable all interrupts */
-	clk_prepare_enable(ssc->clk);
+	ret = clk_prepare_enable(ssc->clk);
+	if (ret)
+		return ret;
 	ssc_writel(ssc->regs, IDR, -1);
 	ssc_readl(ssc->regs, SR);
 	clk_disable_unprepare(ssc->clk);
-- 
1.9.1
