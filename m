From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Feb 2014 14:26:06 +0100
Subject: [PATCH] rtc: mv: reset date if after year 2038
Message-ID: <1392729966-25394-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dates after January, 19th 2038 are badly handled by userspace due to
the time being stored on 32 bits. This causes issues on some Marvell
platform on which the RTC is initialized by default to a date that's
beyond 2038, causing a really weird behavior of the RTC.

In order to avoid that, reset the date to a sane value if the RTC is
beyond 2038.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/rtc/rtc-mv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index d536c59..f124dc6 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -222,6 +222,7 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct rtc_plat_data *pdata;
 	u32 rtc_time;
+	u32 rtc_date;
 	int ret = 0;
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
@@ -257,6 +258,17 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * A date after January 19th, 2038 does not fit on 32 bits and
+	 * will confuse the kernel and userspace. Reset to a sane date
+	 * (January 1st, 2013) if we're after 2038.
+	 */
+	rtc_date = readl(pdata->ioaddr + RTC_DATE_REG_OFFS);
+	if (bcd2bin((rtc_date >> RTC_YEAR_OFFS) & 0xff) >= 38) {
+		dev_info(&pdev->dev, "invalid RTC date, resetting to January, 1st 2013\n");
+		writel(0x130101, pdata->ioaddr + RTC_DATE_REG_OFFS);
+	}
+
 	pdata->irq = platform_get_irq(pdev, 0);
 
 	platform_set_drvdata(pdev, pdata);
-- 
1.8.3.2
