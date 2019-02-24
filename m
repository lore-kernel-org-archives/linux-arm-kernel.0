Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70838C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:00:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF2620663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NAJT/Gr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF2620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hoapJdMsEIZqMsnCQT9VMro5vklmCbTLMPl3CCDW6UQ=; b=NAJT/Gr5SaxxNYWb7o5rFB90Af
	OHwoLjrvCgeU9svKqeFxB0B/EinitGKOQSQSUqWZm3dlPgU8JHVe/a9qC6yb4AGvy8eoqiCjijmOv
	9O2VASTds9BZPjYki8MabKENhAJ4ZsGWreUfZRY42wsXuEo1Ya1Ww3KlwFbgFp6Q5KjLBxnrwOlf3
	zf/h7jzsfAM/6+t452rfv2K1Qc/5wLdWSbuAYADu3965pLcSeODG2nheHdB9kWkPRURG0RzvxAHmV
	kf4/G4bKf2NVjN/xWkhaM9+viDiQiwE2s1jg2rVU5aMZx9Ayhs3cwHuIIwzl6xWCbof9Z/R8GwzJo
	Ae5WFm7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxtK3-0002CS-U6; Sun, 24 Feb 2019 12:55:59 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxtJd-0001f9-8a; Sun, 24 Feb 2019 12:55:34 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757561; Sun, 24 Feb 2019 12:55:07 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Hubert Denkmair <h.denkmair@intence.de>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/9] spi: bcm2835aux: setup gpio-cs to output and correct
 level during setup
Date: Sun, 24 Feb 2019 12:54:34 +0000
Message-Id: <20190224125440.16117-4-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190224125440.16117-1-kernel@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_045533_468141_AAEA91D9 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: Martin Sperl <kernel@martin.sperl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Setup gpio-cs to the correct levels during setup and also make the
gpio definitely an output GPIO.

This is transparently fixing some badly configured DTs in the process
where cs-gpio is set but the gpios are still configured with native cs.

It also makes 100% sure that the initial CS levels are as expected -
especially on systems with devices on a bus with mixed CS_HIGH/CS_LOW
settings.

Fixes: 1ea29b39f4c812ece2f936065a0a3d6fe44a263e
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835aux.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 4b6fdcb2cf4b..922fd798508e 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -449,7 +449,17 @@ static int bcm2835aux_spi_setup(struct spi_device *spi)
 		return -EINVAL;
 	}

-	return 0;
+	/* with gpio-cs set the GPIO to the correct level
+	 * and as output (in case the dt has the gpio not configured
+	 * as output but native cs)
+	 */
+	ret = gpio_direction_output(spi->cs_gpio,
+				    (spi->mode & SPI_CS_HIGH) ? 0 : 1);
+	if (ret)
+		dev_err(&spi->dev, "could not set gpio %i as output: %i\n",
+			spi->cs_gpio, ret);
+
+	return ret;
 }

 static int bcm2835aux_spi_probe(struct platform_device *pdev)
--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
