Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F50BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:07:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2700120675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XPJMVwEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2700120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=4jqB6RUShl/r8+7Kf6PtJZBss4cHDMJhc1pUNNQvLG4=; b=XPJ
	MVwEJYxpuFvQqhDHj4Vbqi98BPE2uvQtC//00c5f0gxeJZXrcSTCXoyhd54UbZ3MpsQz6fBRASH5m
	sKtHt8OVcQI3sLJBWSqEmL8U8omLO883TqXnJFYwjVXiW8YPapJCICjOFYuqZ9xkCXK/uLETIlRse
	OIHb4i1QH5wWaQhVs+eD/GLvc77FBed0FKYX/S3o+4hNLKSJGVGej0r2NUSjP7gEoK2gBbTgn1XkH
	bAegQimJgLHVGAM/W1ey1pox0POvzgHMFkVwo8Advpa0zgntOwupZCbN3bsNaEuJtDMjVv8N9HWmw
	yeN40ioZOWtVTw2U9S9jlDMpAVCBQFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxYth-0001mC-1m; Sat, 23 Feb 2019 15:07:25 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxYtc-0001lK-RR; Sat, 23 Feb 2019 15:07:23 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757537; Sat, 23 Feb 2019 15:07:17 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [resend] [PATCH 5/5] spi: bcm2835aux: support effective_speed_hz
Date: Sat, 23 Feb 2019 15:07:05 +0000
Message-Id: <20190223150705.10729-1-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_070721_060484_7790C933 
X-CRM114-Status: UNSURE (   7.07  )
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

Setting spi_transfer->effective_speed_hz in transfer_one so that
it can get used in cs_change_delay configured with delay as a muliple
of SPI clock cycles.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835aux.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 671e374e1b01..51ce76706073 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -325,7 +325,6 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 {
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, speed;
-	unsigned long spi_used_hz;

 	/* calculate the registers to handle
 	 *
@@ -353,7 +352,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	/* set the new speed */
 	bs->cntl[0] |= speed << BCM2835_AUX_SPI_CNTL0_SPEED_SHIFT;

-	spi_used_hz = clk_hz / (2 * (speed + 1));
+	tfr->effective_speed_hz = clk_hz / (2 * (speed + 1));

 	/* set transmit buffers and length */
 	bs->tx_buf = tfr->tx_buf;
@@ -371,7 +370,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	 */
 #define HZ_PER_BYTE ((9 * 1000000) / BCM2835_AUX_SPI_POLLING_LIMIT_US)
 	/* run in polling mode for short transfers */
-	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
+	if (tfr->len < tfr->effective_speed_hz / HZ_PER_BYTE)
 		return bcm2835aux_spi_transfer_one_poll(master, spi, tfr);

 	/* run in interrupt mode for all others */
--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
