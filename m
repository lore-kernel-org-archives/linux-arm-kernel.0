From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Feb 2016 14:46:40 +0100
Subject: [PATCH 2/3] soc: versatile: dynamically detect RealView HBI numbers
Message-ID: <1455803200-22797-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We cannot pile all numbers on this list, just print the three hex
digits representing the board ID so we can handle all the new
RealView boards.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/soc/versatile/soc-realview.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/versatile/soc-realview.c b/drivers/soc/versatile/soc-realview.c
index c337764de867..282e371378ce 100644
--- a/drivers/soc/versatile/soc-realview.c
+++ b/drivers/soc/versatile/soc-realview.c
@@ -31,18 +31,6 @@ static const struct of_device_id realview_soc_of_match[] = {
 
 static u32 realview_coreid;
 
-static const char *realview_board_str(u32 id)
-{
-	switch ((id >> 16) & 0xfff) {
-	case 0x0147:
-		return "HBI-0147";
-	case 0x0159:
-		return "HBI-0159";
-	default:
-		return "Unknown";
-	}
-}
-
 static const char *realview_arch_str(u32 id)
 {
 	switch ((id >> 8) & 0xf) {
@@ -69,7 +57,7 @@ static ssize_t realview_get_board(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return sprintf(buf, "%s\n", realview_board_str(realview_coreid));
+	return sprintf(buf, "HBI-%03x\n", ((realview_coreid >> 16) & 0xfff));
 }
 
 static struct device_attribute realview_board_attr =
@@ -133,8 +121,9 @@ static int realview_soc_probe(struct platform_device *pdev)
 	device_create_file(soc_device_to_device(soc_dev), &realview_arch_attr);
 	device_create_file(soc_device_to_device(soc_dev), &realview_build_attr);
 
-	dev_info(&pdev->dev, "RealView Syscon Core ID: 0x%08x\n",
-		 realview_coreid);
+	dev_info(&pdev->dev, "RealView Syscon Core ID: 0x%08x, HBI-%03x\n",
+		 realview_coreid,
+		 ((realview_coreid >> 16) & 0xfff));
 	/* FIXME: add attributes for SoC to sysfs */
 	return 0;
 }
-- 
2.4.3
