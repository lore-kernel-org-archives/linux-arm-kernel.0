Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6579CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:55:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344C520848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fp/6YYTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344C520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=armUVZ5I5h2ba0MrU258VcTeeTMdSiAwZCMBcFuCwuY=; b=fp/6YYTf7WDvPLiQd1YnXpPTDU
	LJ1TLTbxyHks7B9KwEpNgCT1uHeWWcMdwpIgYktNRzqaJICvRqAy3WxU0OE+ha+iwkuYtM9lljbGz
	h7s23OdwwXq75J798ZnYYMwpdJG9ZA4S4qsdTz2J4JL9gATSEP4tYlJ2RPOGuj5WZkMWWP7fCsVL1
	exc61zWFKbZYc2r1omPfOtBEDCLdDdomN3N5Bin8fyM4IDFLMgwtd8vz8io86q2OVtm25A3U3wbc/
	xoJ2BPkbxfmRhZWrWv8oCabF31Gpv8WKbXx2j0L/w6K0S14VSUggnAJDdTrZP9AbxrgbJWEziz64Y
	pYV9AgTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxtJw-00021R-AW; Sun, 24 Feb 2019 12:55:52 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxtJa-0001f9-MA; Sun, 24 Feb 2019 12:55:32 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757560; Sun, 24 Feb 2019 12:55:07 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Hubert Denkmair <h.denkmair@intence.de>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/9] spi: bcm2835aux: warn in dmesg that native cs is not
 really supported
Date: Sun, 24 Feb 2019 12:54:33 +0000
Message-Id: <20190224125440.16117-3-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190224125440.16117-1-kernel@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_045531_065064_7BD006E6 
X-CRM114-Status: GOOD (  12.32  )
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

From personal bad experience (even as the author of the original driver)
it shows that native-cs is "somewhat" supported by the spi bus driver
when using a buggy device tree.

So make sure that the driver is warning in dmesg about this fact
that we are running in a not supported mode that may have surprizing
limitations.

Fixes: 1ea29b39f4c812ece2f936065a0a3d6fe44a263e
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835aux.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 2ece25250d86..4b6fdcb2cf4b 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -420,6 +420,38 @@ static void bcm2835aux_spi_handle_err(struct spi_master *master,
 	bcm2835aux_spi_reset_hw(bs);
 }

+static int bcm2835aux_spi_setup(struct spi_device *spi)
+{
+	int ret;
+
+	if (spi->mode & SPI_NO_CS)
+		return 0;
+	/* sanity check for native cs */
+	if (!gpio_is_valid(spi->cs_gpio)) {
+		/* for dt-backwards compatibility: only support native on CS0
+		 * known things not supported with broken native CS:
+		 * * multiple chip-selects: cs0-cs2 are all
+		 *     simultaniously asserted whenever there is a transfer
+		 *     this even includes SPI_NO_CS
+		 * * SPI_CS_HIGH: cs are always asserted low
+		 * * cs_change: cs is deasserted after each spi_transfer
+		 * * cs_delay_usec: cs is always deasserted one SCK cycle
+		 *     after the last transfer
+		 * probably more...
+		 */
+		if (spi->chip_select == 0) {
+			dev_err(&spi->dev,
+				"native CS is not supported but may work for some use-cases for cs = 0 -  please define a valid value cs-gpios in DT for complete feature set\n");
+			return 0;
+		}
+		dev_err(&spi->dev,
+			"native CS is not supported for cs > 0 -  please define a valid value cs-gpios in DT to enable multiple cs\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int bcm2835aux_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -449,6 +481,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	 *     a spi_transfer
 	 */
 	master->num_chipselect = 1;
+	master->setup = bcm2835aux_spi_setup;
 	master->transfer_one = bcm2835aux_spi_transfer_one;
 	master->handle_err = bcm2835aux_spi_handle_err;
 	master->prepare_message = bcm2835aux_spi_prepare_message;
--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
