From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu,  5 May 2011 12:22:16 +0200
Subject: [PATCH 1/6] rtc: remove IRQF_DISABLED
In-Reply-To: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
References: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1304590941-11813-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is deprecated and currently a NOP.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/rtc/rtc-at91sam9.c  |    3 +--
 drivers/rtc/rtc-cmos.c      |    5 ++---
 drivers/rtc/rtc-coh901331.c |    2 +-
 drivers/rtc/rtc-davinci.c   |    2 +-
 drivers/rtc/rtc-ds1511.c    |    2 +-
 drivers/rtc/rtc-ds1553.c    |    2 +-
 drivers/rtc/rtc-lpc32xx.c   |    2 +-
 drivers/rtc/rtc-mpc5121.c   |    4 ++--
 drivers/rtc/rtc-mrst.c      |    5 ++---
 drivers/rtc/rtc-mv.c        |    3 +--
 drivers/rtc/rtc-nuc900.c    |    2 +-
 drivers/rtc/rtc-omap.c      |    4 ++--
 drivers/rtc/rtc-pl030.c     |    3 +--
 drivers/rtc/rtc-pl031.c     |    2 +-
 drivers/rtc/rtc-pxa.c       |    6 ++----
 drivers/rtc/rtc-s3c.c       |    4 ++--
 drivers/rtc/rtc-sa1100.c    |    4 ++--
 drivers/rtc/rtc-sh.c        |    8 ++++----
 drivers/rtc/rtc-stk17ta8.c  |    3 +--
 drivers/rtc/rtc-stmp3xxx.c  |    4 ++--
 drivers/rtc/rtc-tx4939.c    |    2 +-
 drivers/rtc/rtc-vr41xx.c    |    4 ++--
 22 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index a3ad957..4f04a08 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -330,8 +330,7 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 	}
 
 	/* register irq handler after we know what name we'll use */
-	ret = request_irq(AT91_ID_SYS, at91_rtc_interrupt,
-				IRQF_DISABLED | IRQF_SHARED,
+	ret = request_irq(AT91_ID_SYS, at91_rtc_interrupt, IRQF_SHARED,
 				dev_name(&rtc->rtcdev->dev), rtc);
 	if (ret) {
 		dev_dbg(&pdev->dev, "can't share IRQ %d?\n", AT91_ID_SYS);
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 911e75c..1c29245 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -713,9 +713,8 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 		} else
 			rtc_cmos_int_handler = cmos_interrupt;
 
-		retval = request_irq(rtc_irq, rtc_cmos_int_handler,
-				IRQF_DISABLED, dev_name(&cmos_rtc.rtc->dev),
-				cmos_rtc.rtc);
+		retval = request_irq(rtc_irq, rtc_cmos_int_handler, 0,
+				dev_name(&cmos_rtc.rtc->dev), cmos_rtc.rtc);
 		if (retval < 0) {
 			dev_dbg(dev, "IRQ %d is already in use\n", rtc_irq);
 			goto cleanup1;
diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index 80f9c88..a5b8a0c 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -199,7 +199,7 @@ static int __init coh901331_probe(struct platform_device *pdev)
 	}
 
 	rtap->irq = platform_get_irq(pdev, 0);
-	if (request_irq(rtap->irq, coh901331_interrupt, IRQF_DISABLED,
+	if (request_irq(rtap->irq, coh901331_interrupt, 0,
 			"RTC COH 901 331 Alarm", rtap)) {
 		ret = -EIO;
 		goto out_no_irq;
diff --git a/drivers/rtc/rtc-davinci.c b/drivers/rtc/rtc-davinci.c
index 8d46838..cf5e4f9 100644
--- a/drivers/rtc/rtc-davinci.c
+++ b/drivers/rtc/rtc-davinci.c
@@ -540,7 +540,7 @@ static int __init davinci_rtc_probe(struct platform_device *pdev)
 	rtcss_write(davinci_rtc, 0, PRTCSS_RTC_CCTRL);
 
 	ret = request_irq(davinci_rtc->irq, davinci_rtc_interrupt,
-			  IRQF_DISABLED, "davinci_rtc", davinci_rtc);
+			  0, "davinci_rtc", davinci_rtc);
 	if (ret < 0) {
 		dev_err(dev, "unable to register davinci RTC interrupt\n");
 		goto fail4;
diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index fbabc77..df14c43 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -531,7 +531,7 @@ ds1511_rtc_probe(struct platform_device *pdev)
 	if (pdata->irq > 0) {
 		rtc_read(RTC_CMD1);
 		if (devm_request_irq(&pdev->dev, pdata->irq, ds1511_interrupt,
-			IRQF_DISABLED | IRQF_SHARED, pdev->name, pdev) < 0) {
+			IRQF_SHARED, pdev->name, pdev) < 0) {
 
 			dev_warn(&pdev->dev, "interrupt not available.\n");
 			pdata->irq = 0;
diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index fee41b9..95a85c0 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -319,7 +319,7 @@ static int __devinit ds1553_rtc_probe(struct platform_device *pdev)
 		writeb(0, ioaddr + RTC_INTERRUPTS);
 		if (devm_request_irq(&pdev->dev, pdata->irq,
 				ds1553_rtc_interrupt,
-				IRQF_DISABLED, pdev->name, pdev) < 0) {
+				0, pdev->name, pdev) < 0) {
 			dev_warn(&pdev->dev, "interrupt not available.\n");
 			pdata->irq = 0;
 		}
diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index ae16250..ba11a19 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -287,7 +287,7 @@ static int __devinit lpc32xx_rtc_probe(struct platform_device *pdev)
 	if (rtc->irq >= 0) {
 		if (devm_request_irq(&pdev->dev, rtc->irq,
 				     lpc32xx_rtc_alarm_interrupt,
-				     IRQF_DISABLED, pdev->name, rtc) < 0) {
+				     0, pdev->name, rtc) < 0) {
 			dev_warn(&pdev->dev, "Can't request interrupt.\n");
 			rtc->irq = -1;
 		} else {
diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
index 09ccd8d..a8b603f 100644
--- a/drivers/rtc/rtc-mpc5121.c
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -270,7 +270,7 @@ static int __devinit mpc5121_rtc_probe(struct platform_device *op)
 	dev_set_drvdata(&op->dev, rtc);
 
 	rtc->irq = irq_of_parse_and_map(op->dev.of_node, 1);
-	err = request_irq(rtc->irq, mpc5121_rtc_handler, IRQF_DISABLED,
+	err = request_irq(rtc->irq, mpc5121_rtc_handler, 0,
 						"mpc5121-rtc", &op->dev);
 	if (err) {
 		dev_err(&op->dev, "%s: could not request irq: %i\n",
@@ -280,7 +280,7 @@ static int __devinit mpc5121_rtc_probe(struct platform_device *op)
 
 	rtc->irq_periodic = irq_of_parse_and_map(op->dev.of_node, 0);
 	err = request_irq(rtc->irq_periodic, mpc5121_rtc_handler_upd,
-				IRQF_DISABLED, "mpc5121-rtc_upd", &op->dev);
+				0, "mpc5121-rtc_upd", &op->dev);
 	if (err) {
 		dev_err(&op->dev, "%s: could not request irq: %i\n",
 						__func__, rtc->irq_periodic);
diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index b2f0968..90dfcb2 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -363,9 +363,8 @@ vrtc_mrst_do_probe(struct device *dev, struct resource *iomem, int rtc_irq)
 		dev_dbg(dev, "TODO: support more than 24-hr BCD mode\n");
 
 	if (rtc_irq) {
-		retval = request_irq(rtc_irq, mrst_rtc_irq,
-				IRQF_DISABLED, dev_name(&mrst_rtc.rtc->dev),
-				mrst_rtc.rtc);
+		retval = request_irq(rtc_irq, mrst_rtc_irq, 0,
+				dev_name(&mrst_rtc.rtc->dev), mrst_rtc.rtc);
 		if (retval < 0) {
 			dev_dbg(dev, "IRQ %d is already in use, err %d\n",
 				rtc_irq, retval);
diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index 60627a7..99bce5c 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -272,8 +272,7 @@ static int __devinit mv_rtc_probe(struct platform_device *pdev)
 	if (pdata->irq >= 0) {
 		writel(0, pdata->ioaddr + RTC_ALARM_INTERRUPT_MASK_REG_OFFS);
 		if (devm_request_irq(&pdev->dev, pdata->irq, mv_rtc_interrupt,
-				     IRQF_DISABLED | IRQF_SHARED,
-				     pdev->name, pdata) < 0) {
+				     IRQF_SHARED, pdev->name, pdata) < 0) {
 			dev_warn(&pdev->dev, "interrupt not available.\n");
 			pdata->irq = -1;
 		}
diff --git a/drivers/rtc/rtc-nuc900.c b/drivers/rtc/rtc-nuc900.c
index 781068d..b790109 100644
--- a/drivers/rtc/rtc-nuc900.c
+++ b/drivers/rtc/rtc-nuc900.c
@@ -269,7 +269,7 @@ static int __devinit nuc900_rtc_probe(struct platform_device *pdev)
 
 	nuc900_rtc->irq_num = platform_get_irq(pdev, 0);
 	if (request_irq(nuc900_rtc->irq_num, nuc900_rtc_interrupt,
-				IRQF_DISABLED, "nuc900rtc", nuc900_rtc)) {
+				0, "nuc900rtc", nuc900_rtc)) {
 		dev_err(&pdev->dev, "NUC900 RTC request irq failed\n");
 		err = -EBUSY;
 		goto fail4;
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index bcae8dd..243f3cf 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -348,14 +348,14 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
 
 	/* handle periodic and alarm irqs */
-	if (request_irq(omap_rtc_timer, rtc_irq, IRQF_DISABLED,
+	if (request_irq(omap_rtc_timer, rtc_irq, 0,
 			dev_name(&rtc->dev), rtc)) {
 		pr_debug("%s: RTC timer interrupt IRQ%d already claimed\n",
 			pdev->name, omap_rtc_timer);
 		goto fail1;
 	}
 	if ((omap_rtc_timer != omap_rtc_alarm) &&
-		(request_irq(omap_rtc_alarm, rtc_irq, IRQF_DISABLED,
+		(request_irq(omap_rtc_alarm, rtc_irq, 0,
 			dev_name(&rtc->dev), rtc))) {
 		pr_debug("%s: RTC alarm interrupt IRQ%d already claimed\n",
 			pdev->name, omap_rtc_alarm);
diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index 1d28d44..d18ec8c 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -123,8 +123,7 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 
 	amba_set_drvdata(dev, rtc);
 
-	ret = request_irq(dev->irq[0], pl030_interrupt, IRQF_DISABLED,
-			  "rtc-pl030", rtc);
+	ret = request_irq(dev->irq[0], pl030_interrupt, 0, "rtc-pl030", rtc);
 	if (ret)
 		goto err_irq;
 
diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index ff1b84b..d2df59d 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -352,7 +352,7 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	if (request_irq(adev->irq[0], pl031_interrupt,
-			IRQF_DISABLED, "rtc-pl031", ldata)) {
+			0, "rtc-pl031", ldata)) {
 		ret = -EIO;
 		goto out_no_irq;
 	}
diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index fc9f499..15b892c 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -174,15 +174,13 @@ static int pxa_rtc_open(struct device *dev)
 	struct pxa_rtc *pxa_rtc = dev_get_drvdata(dev);
 	int ret;
 
-	ret = request_irq(pxa_rtc->irq_1Hz, pxa_rtc_irq, IRQF_DISABLED,
-			  "rtc 1Hz", dev);
+	ret = request_irq(pxa_rtc->irq_1Hz, pxa_rtc_irq, 0, "rtc 1Hz", dev);
 	if (ret < 0) {
 		dev_err(dev, "can't get irq %i, err %d\n", pxa_rtc->irq_1Hz,
 			ret);
 		goto err_irq_1Hz;
 	}
-	ret = request_irq(pxa_rtc->irq_Alrm, pxa_rtc_irq, IRQF_DISABLED,
-			  "rtc Alrm", dev);
+	ret = request_irq(pxa_rtc->irq_Alrm, pxa_rtc_irq, 0, "rtc Alrm", dev);
 	if (ret < 0) {
 		dev_err(dev, "can't get irq %i, err %d\n", pxa_rtc->irq_Alrm,
 			ret);
diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index b3466c4..82dc1dc 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -307,7 +307,7 @@ static int s3c_rtc_open(struct device *dev)
 	int ret;
 
 	ret = request_irq(s3c_rtc_alarmno, s3c_rtc_alarmirq,
-			  IRQF_DISABLED,  "s3c2410-rtc alarm", rtc_dev);
+			  0, "s3c2410-rtc alarm", rtc_dev);
 
 	if (ret) {
 		dev_err(dev, "IRQ%d error %d\n", s3c_rtc_alarmno, ret);
@@ -315,7 +315,7 @@ static int s3c_rtc_open(struct device *dev)
 	}
 
 	ret = request_irq(s3c_rtc_tickno, s3c_rtc_tickirq,
-			  IRQF_DISABLED,  "s3c2410-rtc tick", rtc_dev);
+			  0, "s3c2410-rtc tick", rtc_dev);
 
 	if (ret) {
 		dev_err(dev, "IRQ%d error %d\n", s3c_rtc_tickno, ret);
diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index 0b40bb8..7ca247e 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -161,13 +161,13 @@ static int sa1100_rtc_open(struct device *dev)
 	struct platform_device *plat_dev = to_platform_device(dev);
 	struct rtc_device *rtc = platform_get_drvdata(plat_dev);
 
-	ret = request_irq(IRQ_RTC1Hz, sa1100_rtc_interrupt, IRQF_DISABLED,
+	ret = request_irq(IRQ_RTC1Hz, sa1100_rtc_interrupt, 0,
 		"rtc 1Hz", dev);
 	if (ret) {
 		dev_err(dev, "IRQ %d already in use.\n", IRQ_RTC1Hz);
 		goto fail_ui;
 	}
-	ret = request_irq(IRQ_RTCAlrm, sa1100_rtc_interrupt, IRQF_DISABLED,
+	ret = request_irq(IRQ_RTCAlrm, sa1100_rtc_interrupt, 0,
 		"rtc Alrm", dev);
 	if (ret) {
 		dev_err(dev, "IRQ %d already in use.\n", IRQ_RTCAlrm);
diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 6ac55fd..e55a763 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -666,7 +666,7 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 	if (rtc->carry_irq <= 0) {
 		/* register shared periodic/carry/alarm irq */
 		ret = request_irq(rtc->periodic_irq, sh_rtc_shared,
-				  IRQF_DISABLED, "sh-rtc", rtc);
+				  0, "sh-rtc", rtc);
 		if (unlikely(ret)) {
 			dev_err(&pdev->dev,
 				"request IRQ failed with %d, IRQ %d\n", ret,
@@ -676,7 +676,7 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 	} else {
 		/* register periodic/carry/alarm irqs */
 		ret = request_irq(rtc->periodic_irq, sh_rtc_periodic,
-				  IRQF_DISABLED, "sh-rtc period", rtc);
+				  0, "sh-rtc period", rtc);
 		if (unlikely(ret)) {
 			dev_err(&pdev->dev,
 				"request period IRQ failed with %d, IRQ %d\n",
@@ -685,7 +685,7 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 		}
 
 		ret = request_irq(rtc->carry_irq, sh_rtc_interrupt,
-				  IRQF_DISABLED, "sh-rtc carry", rtc);
+				  0, "sh-rtc carry", rtc);
 		if (unlikely(ret)) {
 			dev_err(&pdev->dev,
 				"request carry IRQ failed with %d, IRQ %d\n",
@@ -695,7 +695,7 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 		}
 
 		ret = request_irq(rtc->alarm_irq, sh_rtc_alarm,
-				  IRQF_DISABLED, "sh-rtc alarm", rtc);
+				  0, "sh-rtc alarm", rtc);
 		if (unlikely(ret)) {
 			dev_err(&pdev->dev,
 				"request alarm IRQ failed with %d, IRQ %d\n",
diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index 3b94367..77f608a 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -327,8 +327,7 @@ static int __devinit stk17ta8_rtc_probe(struct platform_device *pdev)
 	if (pdata->irq > 0) {
 		writeb(0, ioaddr + RTC_INTERRUPTS);
 		if (devm_request_irq(&pdev->dev, pdata->irq,
-				stk17ta8_rtc_interrupt,
-				IRQF_DISABLED | IRQF_SHARED,
+				stk17ta8_rtc_interrupt, IRQF_SHARED,
 				pdev->name, pdev) < 0) {
 			dev_warn(&pdev->dev, "interrupt not available.\n");
 			pdata->irq = 0;
diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 572e953..12a9eb9 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -208,14 +208,14 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 
 	rtc_data->irq_count = 0;
 	err = request_irq(rtc_data->irq_alarm, stmp3xxx_rtc_interrupt,
-			IRQF_DISABLED, "RTC alarm", &pdev->dev);
+			0, "RTC alarm", &pdev->dev);
 	if (err) {
 		dev_err(&pdev->dev, "Cannot claim IRQ%d\n",
 			rtc_data->irq_alarm);
 		goto out_irq_alarm;
 	}
 	err = request_irq(rtc_data->irq_1msec, stmp3xxx_rtc_interrupt,
-			IRQF_DISABLED, "RTC tick", &pdev->dev);
+			0, "RTC tick", &pdev->dev);
 	if (err) {
 		dev_err(&pdev->dev, "Cannot claim IRQ%d\n",
 			rtc_data->irq_1msec);
diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index ec6313d..f4421c0 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -265,7 +265,7 @@ static int __init tx4939_rtc_probe(struct platform_device *pdev)
 	spin_lock_init(&pdata->lock);
 	tx4939_rtc_cmd(pdata->rtcreg, TX4939_RTCCTL_COMMAND_NOP);
 	if (devm_request_irq(&pdev->dev, irq, tx4939_rtc_interrupt,
-			     IRQF_DISABLED, pdev->name, &pdev->dev) < 0)
+			     0, pdev->name, &pdev->dev) < 0)
 		return -EBUSY;
 	rtc = rtc_device_register(pdev->name, &pdev->dev,
 				  &tx4939_rtc_ops, THIS_MODULE);
diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index c5698cd..6aef17d 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -333,7 +333,7 @@ static int __devinit rtc_probe(struct platform_device *pdev)
 		goto err_device_unregister;
 	}
 
-	retval = request_irq(aie_irq, elapsedtime_interrupt, IRQF_DISABLED,
+	retval = request_irq(aie_irq, elapsedtime_interrupt, 0,
 	                     "elapsed_time", pdev);
 	if (retval < 0)
 		goto err_device_unregister;
@@ -342,7 +342,7 @@ static int __devinit rtc_probe(struct platform_device *pdev)
 	if (pie_irq <= 0)
 		goto err_free_irq;
 
-	retval = request_irq(pie_irq, rtclong1_interrupt, IRQF_DISABLED,
+	retval = request_irq(pie_irq, rtclong1_interrupt, 0,
 		             "rtclong1", pdev);
 	if (retval < 0)
 		goto err_free_irq;
-- 
1.7.2.5
