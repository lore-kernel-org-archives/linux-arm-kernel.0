From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Thu, 19 Nov 2015 11:50:09 +0100
Subject: [PATCH 2/3] rtc: sunxi: constify the data_year_param structure
In-Reply-To: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1447930210-27008-2-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The data_year_param struct is never modified, so lets constify it.
This permit to remove cast since of_device_id is const also.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/rtc/rtc-sunxi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index b4f35ac..0c08a5b 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -133,7 +133,7 @@ struct sunxi_rtc_data_year {
 	unsigned char leap_shift;	/* bit shift to get the leap year */
 };
 
-static struct sunxi_rtc_data_year data_year_param[] = {
+static const struct sunxi_rtc_data_year data_year_param[] = {
 	[0] = {
 		.min		= 2010,
 		.max		= 2073,
@@ -151,7 +151,7 @@ static struct sunxi_rtc_data_year data_year_param[] = {
 struct sunxi_rtc_dev {
 	struct rtc_device *rtc;
 	struct device *dev;
-	struct sunxi_rtc_data_year *data_year;
+	const struct sunxi_rtc_data_year *data_year;
 	void __iomem *base;
 	int irq;
 };
@@ -468,7 +468,7 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Unable to setup RTC data\n");
 		return -ENODEV;
 	}
-	chip->data_year = (struct sunxi_rtc_data_year *) of_id->data;
+	chip->data_year = of_id->data;
 
 	/* clear the alarm count value */
 	writel(0, chip->base + SUNXI_ALRM_DHMS);
-- 
2.4.10
