Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE45C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:23:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F7220663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MzmWUwg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F7220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=AIOZunx5aEf8MiuqZ4y7sv2mbbnDc1Ml+T+mgKpHBB0=; b=Mzm
	WUwg+8ErQKUN4xNMs7/rfQqBfCBJ2Y6ol032/qbSaAX7hlMd2H8caQYRXaBLYW2/trcr4g9AIP9rI
	0iyeabi8cUL21nyzsfW3NxjsFprczgwpoIChFqoz1nNewC9rtIrxiT3lNwaRDxcdAGXOQN1LD5eV5
	deR4z7H6Nho6WaBUdcG7XrrS80tNLEz8eVgB90mAlm9U9pzj38AfHrSg/1dgeqlCIdvi3/8LWTKOw
	JICxExQn+vKGhKpp38HLB3uIj60N62Wv63ZGx37rgyjnmvHd/wyvGMnK+MvlCfbnSYVAF4M1R4/7R
	sgGFmJQbzKzVYVakgGBd1TZLeiwujDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxwYp-0006Jv-AW; Sun, 24 Feb 2019 16:23:27 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxwYj-0006IK-HF; Sun, 24 Feb 2019 16:23:24 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757580; Sun, 24 Feb 2019 16:23:15 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] spi: bcm2835: add driver stats to debugfs
Date: Sun, 24 Feb 2019 16:23:09 +0000
Message-Id: <20190224162311.23899-1-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_082321_919375_A630978A 
X-CRM114-Status: UNSURE (   8.94  )
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

To estimate efficiency add statistics on transfer types
(polling, interrupt and dma) used to debugfs.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index c2912c1e09c5..0ccc6a2733c6 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -22,6 +22,7 @@

 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -111,8 +112,60 @@ struct bcm2835_spi {
 	int rx_prologue;
 	unsigned int tx_spillover;
 	unsigned int dma_pending;
+
+#if defined(CONFIG_DEBUG_FS)
+#define BCM2835_AUX_INCR(field) ((field)++)
+	u64 count_transfer_polling;
+	u64 count_transfer_irq;
+	u64 count_transfer_irq_after_poll;
+	u64 count_transfer_dma;
+
+	struct dentry *debugfs_dir;
+#else
+#define BCM2835_AUX_INCR(field)
+#endif /* CONFIG_DEBUG_FS */
 };

+#if defined(CONFIG_DEBUG_FS)
+static void bcm2835_debugfs_create(struct bcm2835_spi *bs,
+				   const char *dname)
+{
+	char name[64];
+	struct dentry *dir;
+
+	/* get full name */
+	snprintf(name, sizeof(name), "spi-bcm2835-%s", dname);
+
+	/* the base directory */
+	dir = debugfs_create_dir(name, NULL);
+	bs->debugfs_dir = dir;
+
+	/* the counters */
+	debugfs_create_u64("count_transfer_polling", 0444, dir,
+			   &bs->count_transfer_polling);
+	debugfs_create_u64("count_transfer_irq", 0444, dir,
+			   &bs->count_transfer_irq);
+	debugfs_create_u64("count_transfer_irq_after_poll", 0444, dir,
+			   &bs->count_transfer_irq_after_poll);
+	debugfs_create_u64("count_transfer_dma", 0444, dir,
+			   &bs->count_transfer_dma);
+}
+
+static void bcm2835_debugfs_remove(struct bcm2835_spi *bs)
+{
+	debugfs_remove_recursive(bs->debugfs_dir);
+	bs->debugfs_dir = NULL;
+}
+#else
+static void bcm2835_debugfs_create(struct bcm2835_spi *bs)
+{
+}
+
+static void bcm2835_debugfs_remove(struct bcm2835_spi *bs)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static inline u32 bcm2835_rd(struct bcm2835_spi *bs, unsigned reg)
 {
 	return readl(bs->regs + reg);
@@ -316,6 +369,9 @@ static int bcm2835_spi_transfer_one_irq(struct spi_master *master,
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);

+	/* update statistics */
+	BCM2835_AUX_INCR(bs->count_transfer_irq);
+
 	/*
 	 * Enable HW block, but with interrupts still disabled.
 	 * Otherwise the empty TX FIFO would immediately trigger an interrupt.
@@ -574,6 +630,9 @@ static int bcm2835_spi_transfer_one_dma(struct spi_master *master,
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	int ret;

+	/* update statistics */
+	BCM2835_AUX_INCR(bs->count_transfer_dma);
+
 	/*
 	 * Transfer first few bytes without DMA if length of first TX or RX
 	 * sglist entry is not a multiple of 4 bytes (hardware limitation).
@@ -731,6 +790,9 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long timeout;

+	/* update statistics */
+	BCM2835_AUX_INCR(bs->count_transfer_polling);
+
 	/* enable HW block without interrupts */
 	bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_TA);

@@ -759,6 +821,8 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 					    "timeout period reached: jiffies: %lu remaining tx/rx: %d/%d - falling back to interrupt mode\n",
 					    jiffies - timeout,
 					    bs->tx_len, bs->rx_len);
+			/* update statistics */
+			BCM2835_AUX_INCR(bs->count_transfer_irq_after_poll);
 			/* fall back to interrupt mode */
 			return bcm2835_spi_transfer_one_irq(master, spi,
 							    tfr, cs, false);
@@ -991,6 +1055,8 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}

+	bcm2835_debugfs_create(bs, dev_name(&pdev->dev));
+
 	return 0;

 out_clk_disable:
@@ -1005,6 +1071,8 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);

+	bcm2835_debugfs_remove(bs);
+
 	/* Clear FIFOs, and disable the HW block */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
