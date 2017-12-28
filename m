From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Thu, 28 Dec 2017 02:40:49 +0000
Subject: [PATCH -next] clk: meson-axg: fix return value check in
 axg_clkc_probe()
Message-ID: <1514428849-61681-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of error, the function devm_ioremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: 78b4af312f91 ("clk: meson-axg: add clock controller drivers")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/clk/meson/axg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index a66b3a5..717c02d 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -880,7 +880,7 @@ static int axg_clkc_probe(struct platform_device *pdev)
 	/*  Generic clocks and PLLs */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	clk_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (IS_ERR(clk_base)) {
+	if (!clk_base) {
 		dev_err(&pdev->dev, "Unable to map clk base\n");
 		return -ENXIO;
 	}
