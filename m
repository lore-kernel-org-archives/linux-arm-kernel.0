From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Thu, 19 Nov 2015 11:50:10 +0100
Subject: [PATCH 3/3] rtc: sunxi: use of_device_get_match_data
In-Reply-To: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1447930210-27008-3-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usage of of_device_get_match_data reduce the code size a bit.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/rtc/rtc-sunxi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index 0c08a5b..abada60 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -436,7 +436,6 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 {
 	struct sunxi_rtc_dev *chip;
 	struct resource *res;
-	const struct of_device_id *of_id;
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
@@ -463,12 +462,11 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	of_id = of_match_device(sunxi_rtc_dt_ids, &pdev->dev);
-	if (!of_id) {
+	chip->data_year = of_device_get_match_data(&pdev->dev);
+	if (!chip->data_year) {
 		dev_err(&pdev->dev, "Unable to setup RTC data\n");
 		return -ENODEV;
 	}
-	chip->data_year = of_id->data;
 
 	/* clear the alarm count value */
 	writel(0, chip->base + SUNXI_ALRM_DHMS);
-- 
2.4.10
