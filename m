Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EDBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:56:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8DD320652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AgG0NofT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DD320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oY2pauTAnUio3q+PcS2tAKfh+2PWSNSwZPtR0xtok/o=; b=AgG0NofTV2TgmTDeMmGmuDieBs
	GHk403ufeS3fykvpz8hDwb9cMXQelG9JdyA8roRAUNrQorjYsCyDiBx0xx1hVuQqycsZ4LdlXrpnL
	MiydCpNwgDYGm5zfMQIiqv+wySotmc61vmmkNf8fNrfkCH/nSPFQvh23vg5R2hAqLoOsDoZtPrD7D
	rTIgTRrH5uDvMK08wCZKv6e/0R+l1U6aUr/mIww9EkGKkMDWSmxtinEh+QD5yfcrlfRhbTcSUtlKI
	zGgks0W3ntsM95sJqNl2+hNGDFuJxeFDhsv4Q88MEVzxP0Mk7H1HV9Nwd57GmJaQdcpjfydBTj1pu
	Fk3SmroQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxtKh-000313-Ht; Sun, 24 Feb 2019 12:56:39 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxtJs-0001f9-6x; Sun, 24 Feb 2019 12:55:51 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757563; Sun, 24 Feb 2019 12:55:07 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Hubert Denkmair <h.denkmair@intence.de>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/9] spi: bcm2835aux: remove dangerous uncontrolled read of
 fifo
Date: Sun, 24 Feb 2019 12:54:38 +0000
Message-Id: <20190224125440.16117-8-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190224125440.16117-1-kernel@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_045548_422905_B9C38490 
X-CRM114-Status: UNSURE (   6.45  )
X-CRM114-Notice: Please train this message.
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

This read of the fifo is a potential candidate for a race condition
as the spi transfer is not necessarily finished and so can lead to
an early read of the fifo that still misses data.

So it has been removed - an additional loop will read the fifo
correctly.

Fixes: 1ea29b39f4c812ece2f936065a0a3d6fe44a263e
(Note: requires Patch 6)

Suggested-by: Hubert Denkmair <h.denkmair@intence.de>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

---
 drivers/spi/spi-bcm2835aux.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 9552f5343982..8821fc183ca0 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -246,13 +246,6 @@ static void bcm2835aux_spi_transfer_helper(struct bcm2835aux_spi *bs)
 		  BCM2835_AUX_SPI_STAT_TX_FULL))) {
 		bcm2835aux_wr_fifo(bs);
 	}
-
-	/* and check if we have reached "done" */
-	while (bs->rx_len &&
-	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
-		  BCM2835_AUX_SPI_STAT_BUSY))) {
-		bcm2835aux_rd_fifo(bs);
-	}
 }

 static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
