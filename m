Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E997C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:00:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35A120663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jOBaupfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35A120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YcKFvFu1dKIECViwjeX/801fpg6mjhgcBklJl3QRI/w=; b=jOBaupfzR6AJ4682nF/JvF383q
	weeQUhEXgcOP4BYCqunWdwj0jRXU37SmG0CRrjpNGMx4IaD03mB5M7KVZe26o5JQhN0TyWHdNOsZi
	EWZbbv3UePznH3jOFF1ipb+g3X0XHbMCRvgsWoPwyj0M6VPYE++7WVUc/mjxcFsQEnVhFghoen32W
	jIR0WyFRdhIY4i9UbSvB6YEmipX+rpSVmbnYjwwHRwK91XrThommLd/yZEKxc7XUGxPUjRoss1Ek5
	4eGUxUUGq/+rXCeP5bQD3KIsQObmP8w5wgLaWVUiCzbTTUny27o2gGnViKC3KKHLjq8z+l1DKrc9b
	JfDWTrfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxtKU-0002l2-N6; Sun, 24 Feb 2019 12:56:26 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxtJn-0001f9-SY; Sun, 24 Feb 2019 12:55:47 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757562; Sun, 24 Feb 2019 12:55:07 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Hubert Denkmair <h.denkmair@intence.de>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/9] spi: bcm2835aux: unifying code between polling and
 interrupt driven code
Date: Sun, 24 Feb 2019 12:54:37 +0000
Message-Id: <20190224125440.16117-7-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190224125440.16117-1-kernel@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_045544_613171_D63B1B77 
X-CRM114-Status: GOOD (  11.33  )
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

Sharing code between polling and interrupt-driven mode.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835aux.c | 51 ++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index af668cb6b38b..9552f5343982 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -230,23 +230,13 @@ static void bcm2835aux_spi_reset_hw(struct bcm2835aux_spi *bs)
 		      BCM2835_AUX_SPI_CNTL0_CLEARFIFO);
 }

-static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
+static void bcm2835aux_spi_transfer_helper(struct bcm2835aux_spi *bs)
 {
-	struct spi_master *master = dev_id;
-	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
-	irqreturn_t ret = IRQ_NONE;
-
-	/* IRQ may be shared, so return if our interrupts are disabled */
-	if (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_CNTL1) &
-	      (BCM2835_AUX_SPI_CNTL1_TXEMPTY | BCM2835_AUX_SPI_CNTL1_IDLE)))
-		return ret;
-
 	/* check if we have data to read */
 	while (bs->rx_len &&
 	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
 		  BCM2835_AUX_SPI_STAT_RX_EMPTY))) {
 		bcm2835aux_rd_fifo(bs);
-		ret = IRQ_HANDLED;
 	}

 	/* check if we have data to write */
@@ -255,7 +245,6 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
 		  BCM2835_AUX_SPI_STAT_TX_FULL))) {
 		bcm2835aux_wr_fifo(bs);
-		ret = IRQ_HANDLED;
 	}

 	/* and check if we have reached "done" */
@@ -263,8 +252,21 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
 		  BCM2835_AUX_SPI_STAT_BUSY))) {
 		bcm2835aux_rd_fifo(bs);
-		ret = IRQ_HANDLED;
 	}
+}
+
+static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
+{
+	struct spi_master *master = dev_id;
+	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+
+	/* IRQ may be shared, so return if our interrupts are disabled */
+	if (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_CNTL1) &
+	      (BCM2835_AUX_SPI_CNTL1_TXEMPTY | BCM2835_AUX_SPI_CNTL1_IDLE)))
+		return IRQ_NONE;
+
+	/* do common fifo handling */
+	bcm2835aux_spi_transfer_helper(bs);

 	if (!bs->tx_len) {
 		/* disable tx fifo empty interrupt */
@@ -278,8 +280,7 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 		complete(&master->xfer_completion);
 	}

-	/* and return */
-	return ret;
+	return IRQ_HANDLED;
 }

 static int __bcm2835aux_spi_transfer_one_irq(struct spi_master *master,
@@ -328,7 +329,6 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 {
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	unsigned long timeout;
-	u32 stat;

 	/* update statistics */
 	BCM2835_AUX_INCR(bs->count_transfer_polling);
@@ -342,24 +342,9 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,

 	/* loop until finished the transfer */
 	while (bs->rx_len) {
-		/* read status */
-		stat = bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT);
-
-		/* fill in tx fifo with remaining data */
-		if ((bs->tx_len) && (!(stat & BCM2835_AUX_SPI_STAT_TX_FULL))) {
-			bcm2835aux_wr_fifo(bs);
-			continue;
-		}

-		/* read data from fifo for both cases */
-		if (!(stat & BCM2835_AUX_SPI_STAT_RX_EMPTY)) {
-			bcm2835aux_rd_fifo(bs);
-			continue;
-		}
-		if (!(stat & BCM2835_AUX_SPI_STAT_BUSY)) {
-			bcm2835aux_rd_fifo(bs);
-			continue;
-		}
+		/* do common fifo handling */
+		bcm2835aux_spi_transfer_helper(bs);

 		/* there is still data pending to read check the timeout */
 		if (bs->rx_len && time_after(jiffies, timeout)) {
--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
