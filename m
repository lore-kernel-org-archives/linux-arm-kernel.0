Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69792C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:11:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3820220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T5A35Sxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3820220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yO6VYyIXDY2JsuVyaiDhSfAM9Qaqhn+rJunRY7sEmwU=; b=T5A35Sxm8V9p1o
	sZYd9r3YOMRSJO97wHCmy3hN1d2OgxMnhLirmHBfDjkE0rbL4xIizopmd0TPfjSSmQX/tmykM751V
	6W8BtTASkE8HDGoQUFBSLkTsjohXHa5ZclVoj3TxvHopJbrZjPyeisXGJYVNbZCo9/qsCERpDYF7Q
	xXIfv+JEcTCMP0Uj869Z34KnvdTs5BV2t8Mz0TL0yAzrRrydIxeiHY0wa+x3fyqaEa+HhnNLNtStv
	R9yamC/RuTWA9rjuOTlObO/TvAdz445BYixn1hA0tCVVAqBi0D46e6lWiZU33MdogW13BceNhroJV
	QWlTzgD9GhzJ6u97gu5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs8kL-0005In-SV; Fri, 08 Feb 2019 16:11:21 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs8jJ-0004Br-Rb
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 16:10:20 +0000
X-Originating-IP: 109.213.164.40
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr
 [109.213.164.40]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 130F2C0002;
 Fri,  8 Feb 2019 16:10:06 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 5/5] iio:adc:lpc32xx Add scale feature
Date: Fri,  8 Feb 2019 17:09:44 +0100
Message-Id: <20190208160944.13281-6-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208160944.13281-1-gregory.clement@bootlin.com>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_081018_291289_858F83B2 
X-CRM114-Status: GOOD (  16.65  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Until now this driver only exposed the raw value of the channels. With
this patch, the scale value is also exposed.

It depends of a regulator supply, and unlike most of the other driver, do
not having this regulator won't prevent to use the driver. The reason for
it is to allow to continue to use this driver with an old device tree. If
there is no regulator supply then the scale won't be exposed.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/iio/adc/lpc32xx_adc.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index f391c1e10136..e36ca307f065 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 /*
  * LPC32XX registers definitions
@@ -45,6 +46,7 @@ struct lpc32xx_adc_state {
 	void __iomem *adc_base;
 	struct clk *clk;
 	struct completion completion;
+	struct regulator *vref;
 
 	u32 value;
 };
@@ -57,7 +59,9 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
 {
 	struct lpc32xx_adc_state *st = iio_priv(indio_dev);
 	int ret;
-	if (mask == IIO_CHAN_INFO_RAW) {
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&indio_dev->mlock);
 		ret = clk_prepare_enable(st->clk);
 		if (ret) {
@@ -77,6 +81,12 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&indio_dev->mlock);
 
 		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = regulator_get_voltage(st->vref) / 1000;
+		*val2 =  chan->scan_type.realbits;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 
 	return -EINVAL;
@@ -93,9 +103,10 @@ static const struct iio_info lpc32xx_adc_iio_info = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 	.address = LPC32XXAD_IN * _index,		\
 	.scan_index = _index,				\
+	.scan_type.realbits = 10			\
 }
 
-static const struct iio_chan_spec lpc32xx_adc_iio_channels[] = {
+static struct iio_chan_spec lpc32xx_adc_iio_channels[] = {
 	LPC32XX_ADC_CHANNEL(0),
 	LPC32XX_ADC_CHANNEL(1),
 	LPC32XX_ADC_CHANNEL(2),
@@ -119,7 +130,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	struct resource *res;
 	int retval = -ENODEV;
 	struct iio_dev *iodev = NULL;
-	int irq;
+	int irq, i;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -159,6 +170,15 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 		return retval;
 	}
 
+	st->vref = devm_regulator_get(&pdev->dev, "vref");
+	if (IS_ERR(st->vref))
+		dev_err(&pdev->dev,
+			"Missing vref regulator: No scaling available\n");
+	else
+		for (i = 0; i <  ARRAY_SIZE(lpc32xx_adc_iio_channels); i++)
+			lpc32xx_adc_iio_channels[i].info_mask_shared_by_type =
+				BIT(IIO_CHAN_INFO_SCALE);
+
 	platform_set_drvdata(pdev, iodev);
 
 	init_completion(&st->completion);
@@ -175,7 +195,6 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 		return retval;
 
 	dev_info(&pdev->dev, "LPC32XX ADC driver loaded, IRQ %d\n", irq);
-
 	return 0;
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
