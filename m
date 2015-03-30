From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 30 Mar 2015 13:24:20 +0800
Subject: [PATCH v2 1/5] clk: hisi: refine parameter checking for init
In-Reply-To: <1427693064-11062-1-git-send-email-leo.yan@linaro.org>
References: <1427693064-11062-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1427693064-11062-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*of_iomap()* will check the device node pointer, and if the pointer is
NULL it will return error code. So refine clock's init flow by checking
the device node with this simple way; and polish a little for the print
out message.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/clk/hisilicon/clk.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index a078e84..1951b37 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -45,14 +45,9 @@ struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
 	struct clk **clk_table;
 	void __iomem *base;
 
-	if (np) {
-		base = of_iomap(np, 0);
-		if (!base) {
-			pr_err("failed to map Hisilicon clock registers\n");
-			goto err;
-		}
-	} else {
-		pr_err("failed to find Hisilicon clock node in DTS\n");
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("%s: failed to map clock registers\n", __func__);
 		goto err;
 	}
 
-- 
1.9.1
