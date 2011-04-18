From: prakity@marvell.com (Philip Rakity)
Date: Mon, 18 Apr 2011 12:56:17 -0700
Subject: [PATCH] rtc: max8925 crash since driver data not set before interr=
Message-ID: <mailman.202.1303156790.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

upt

in probe set the platform data before setting up interrupts
avoids crash at start-up time.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/rtc/rtc-max8925.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-max8925.c b/drivers/rtc/rtc-max8925.c
index 174036d..24a326a 100644
--- a/drivers/rtc/rtc-max8925.c
+++ b/drivers/rtc/rtc-max8925.c
@@ -249,6 +249,9 @@ static int __devinit max8925_rtc_probe(struct platform_=
device *pdev)
 	info->dev =3D &pdev->dev;
 	irq =3D chip->irq_base + MAX8925_IRQ_RTC_ALARM0;
=20
+	dev_set_drvdata(&pdev->dev, info);
+	platform_set_drvdata(pdev, info);
+
 	ret =3D request_threaded_irq(irq, NULL, rtc_update_handler,
 				   IRQF_ONESHOT, "rtc-alarm0", info);
 	if (ret < 0) {
@@ -265,9 +268,6 @@ static int __devinit max8925_rtc_probe(struct platform_=
device *pdev)
 		goto out_rtc;
 	}
=20
-	dev_set_drvdata(&pdev->dev, info);
-	platform_set_drvdata(pdev, info);
-
 	return 0;
 out_rtc:
 	free_irq(chip->irq_base + MAX8925_IRQ_RTC_ALARM0, info);
--=20
1.7.0.4
