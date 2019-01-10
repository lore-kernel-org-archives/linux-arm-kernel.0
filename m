Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5413C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:28:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A554721783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fZbcWjz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A554721783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lBFo5WSXzedhV/LyOsbz8NoYHn08JaPfq17bTGkNCO0=; b=fZbcWjz86dbrye
	xb2BDA8J7FFoXQd90guef865zwrMdb+95FZIRS4yMA5o12UGrWDVIbnlvsi5JRKY3y2tW/xQtp+bA
	MaeG9bnGrETbV8lxAufh4yBgDWr8kR6tFPAtXszOadRAHpwzEUqJTjyHhf4afkwLh/QUbXGg7OMxY
	9RxIl2ougTBL84Vr8q/zZ22ADUK57I629T5urXOMEbxi+AXXqJO5SW5Bx8FKVVAQeCRwbzWEQQ5E4
	c5jGBG3Ul510HaIsPODAL1n7o3kgUUivwHeXvlNdmmGGRjwWRA4l+wTFTlNQviOYsaX2xShym6dCM
	BrmhrAlYjJQtLEoh3sYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZRO-0005b9-9H; Thu, 10 Jan 2019 12:28:06 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZRJ-0005a1-JH
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 12:28:03 +0000
Received: from tarshish.tkos.co.il (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id D820B44011A;
 Thu, 10 Jan 2019 14:27:54 +0200 (IST)
From: Baruch Siach <baruch@tkos.co.il>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] gpio: mvebu: implement get_direction
Date: Thu, 10 Jan 2019 14:26:21 +0200
Message-Id: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_042801_856588_BBEB791A 
X-CRM114-Status: GOOD (  10.19  )
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
Cc: linux-pwm@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
 Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

struct gpio_chip documentation recommends to always implement this
callback function.

A more concrete motivation is to be able (in combination with
GPIOD_ASIS) to detect whether the bootloader has changed the state of a
GPIO signal.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/gpio-mvebu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 7d5c55494ccd..f97ed32b8beb 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -376,6 +376,16 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
 	return 0;
 }
 
+static int mvebu_gpio_get_direction(struct gpio_chip *chip, unsigned int pin)
+{
+	struct mvebu_gpio_chip *mvchip = gpiochip_get_data(chip);
+	u32 u;
+
+	regmap_read(mvchip->regs, GPIO_IO_CONF_OFF + mvchip->offset, &u);
+
+	return !!(u & BIT(pin));
+}
+
 static int mvebu_gpio_to_irq(struct gpio_chip *chip, unsigned int pin)
 {
 	struct mvebu_gpio_chip *mvchip = gpiochip_get_data(chip);
@@ -1130,6 +1140,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	mvchip->chip.parent = &pdev->dev;
 	mvchip->chip.request = gpiochip_generic_request;
 	mvchip->chip.free = gpiochip_generic_free;
+	mvchip->chip.get_direction = mvebu_gpio_get_direction;
 	mvchip->chip.direction_input = mvebu_gpio_direction_input;
 	mvchip->chip.get = mvebu_gpio_get;
 	mvchip->chip.direction_output = mvebu_gpio_direction_output;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
