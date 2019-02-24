Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7305FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:01:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4C820663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HkyM3Twd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4C820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=aZparjNT/zUQM+gmI8eoC+fE7pOcWv3LrxDOtENEjGg=; b=HkyM3TwdCH2qImffEDVV2+FQjg
	uIp7dpdUdYTuyC68G8rO1nMOGXfluJQrTJS4o/Hxog7cViIds1nrWgVAKKCOF5KUWmuV/mUHFj/1R
	Zk2hys8YTBRC3YLMf3kbLZM5wR7wX0cA9UkHTu1GEobVwRYZy5U3w8zHaU39TRWi+mo9j8k7EVvjW
	F2O1uhEzq6DS/V7H72G0XCVqAKsZV7XBZyYPpe42I4C147HcDkTEc1EwPR4jT3lj+gbuWCF1lTv78
	3QpjjMYriETFSCGTNA4OUQHJ1ID9oXBaeHqyjsOi7AIu25NsIDYBFmT2whxVaPoXF+uSir/key5SM
	7kaHEEIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxtL4-0003IS-DC; Sun, 24 Feb 2019 12:57:02 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxtJw-0001f9-0P; Sun, 24 Feb 2019 12:55:54 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757564; Sun, 24 Feb 2019 12:55:08 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Hubert Denkmair <h.denkmair@intence.de>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 8/9] spi: bcm2835aux: use BCM2835_AUX_SPI_STAT_RX_LVL
Date: Sun, 24 Feb 2019 12:54:39 +0000
Message-Id: <20190224125440.16117-9-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190224125440.16117-1-kernel@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_045552_411433_65F06E0F 
X-CRM114-Status: UNSURE (   9.48  )
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

On long running tests with a mcp2517fd can controller it showed that
on rare occations the data read shows corruptions for longer spi transfers.

Example of a 22 byte transfer:

expected (as captured on logic analyzer):
FF FF 78 00 00 00 08 06 00 00 91 20 77 56 84 85 86 87 88 89 8a 8b

read by the driver:
FF FF 78 00 00 00 08 06 00 00 91 20 77 56 84 88 89 8a 00 00 8b 9b

To fix this use BCM2835_AUX_SPI_STAT_RX_LVL to determine when we may
read data from the fifo reliably without any corruption.

Surprisingly the only values ever empirically read in
BCM2835_AUX_SPI_STAT_RX_LVL are 0x00, 0x10, 0x20 and 0x30.
So whenever the mask is not 0 we can read from the fifo in a safe manner.

The patch has now been tested intensively and we are no longer
able to reproduce the "RX" issue any longer.

Fixes: 1ea29b39f4c812ece2f936065a0a3d6fe44a263e
(Note: requires Patch 6)

Reported-by: Hubert Denkmair <h.denkmair@intence.de>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835aux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 8821fc183ca0..8cd273d0fef2 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -232,12 +232,12 @@ static void bcm2835aux_spi_reset_hw(struct bcm2835aux_spi *bs)

 static void bcm2835aux_spi_transfer_helper(struct bcm2835aux_spi *bs)
 {
+	u32 stat = bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT);
+
 	/* check if we have data to read */
-	while (bs->rx_len &&
-	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
-		  BCM2835_AUX_SPI_STAT_RX_EMPTY))) {
+	for (; bs->rx_len && (stat & BCM2835_AUX_SPI_STAT_RX_LVL);
+	     stat = bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT))
 		bcm2835aux_rd_fifo(bs);
-	}

 	/* check if we have data to write */
 	while (bs->tx_len &&
--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
