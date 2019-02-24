Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1122C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:00:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE9220663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ok1mnhan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE9220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oEHSq7AzRz/LlFObW23DZqinrIbFsDHfp9Viv4Q4sxo=; b=Ok1mnhann/Yo5cMWDAGNd9K+Rx
	R4wghBljBHGvA9jMnxuMPI70m/PNPK8iq6ENvM9Pq+rv4l31N+wyFGRi8tGpwZJlvuICQU0Gxe9bm
	Gf0Lp0vmE+7MhuIyzMwy0NOt9ZREWWcF8DJjmsYncLaXJ0hCvwlIs2do/1Jmrzg2BnTynpEIDnRjl
	ZbArl/B3y4ncxU0i2jsCTwjkFed0BxHFsQwwLwBm590ptLeWKdyX2PQX/B51hrFcWajiLqBa5zUfd
	EuQs5EykFKYXmkDRkbOaOMEFyQQflod10z3y8nvfC1saAuhBTJW7zIHg5OPU6azY9E3Zd/MqMTso+
	Re4nYcJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxtKC-0002Ne-J1; Sun, 24 Feb 2019 12:56:08 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxtJf-0001f9-I1; Sun, 24 Feb 2019 12:55:38 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757558; Sun, 24 Feb 2019 12:55:07 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Hubert Denkmair <h.denkmair@intence.de>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/9] spi: bcm2835aux: add driver specific stats to debugfs
Date: Sun, 24 Feb 2019 12:54:35 +0000
Message-Id: <20190224125440.16117-5-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190224125440.16117-1-kernel@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_045536_194690_DF354507 
X-CRM114-Status: UNSURE (   8.54  )
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
(polling and interrupt) used via debugfs.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835aux.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 922fd798508e..0a5f21eb3b99 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -21,6 +21,7 @@

 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -102,8 +103,57 @@ struct bcm2835aux_spi {
 	int tx_len;
 	int rx_len;
 	int pending;
+
+#if defined(CONFIG_DEBUG_FS)
+#define BCM2835_AUX_INCR(field) ((field)++)
+	u64 count_transfer_polling;
+	u64 count_transfer_irq;
+	u64 count_transfer_irq_after_poll;
+
+	struct dentry *debugfs_dir;
+#else
+#define BCM2835_AUX_INCR(field)
+#endif /* CONFIG_DEBUG_FS */
 };

+#if defined(CONFIG_DEBUG_FS)
+static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs,
+				      const char *dname)
+{
+	char name[64];
+	struct dentry *dir;
+
+	/* get full name */
+	snprintf(name, sizeof(name), "spi-bcm2835aux-%s", dname);
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
+}
+
+static void bcm2835aux_debugfs_remove(struct bcm2835aux_spi *bs)
+{
+	debugfs_remove_recursive(bs->debugfs_dir);
+	bs->debugfs_dir = NULL;
+}
+#else
+static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs)
+{
+}
+
+static void bcm2835aux_debugfs_remove(struct bcm2835aux_spi *bs)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static inline u32 bcm2835aux_rd(struct bcm2835aux_spi *bs, unsigned reg)
 {
 	return readl(bs->regs + reg);
@@ -251,6 +301,9 @@ static int bcm2835aux_spi_transfer_one_irq(struct spi_master *master,
 {
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);

+	/* update statistics */
+	BCM2835_AUX_INCR(bs->count_transfer_irq);
+
 	/* fill in registers and fifos before enabling interrupts */
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
@@ -275,6 +328,9 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 	unsigned long timeout;
 	u32 stat;

+	/* update statistics */
+	BCM2835_AUX_INCR(bs->count_transfer_polling);
+
 	/* configure spi */
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
@@ -310,6 +366,7 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 					    jiffies - timeout,
 					    bs->tx_len, bs->rx_len);
 			/* forward to interrupt handler */
+			BCM2835_AUX_INCR(bs->count_transfer_irq_after_poll);
 			return __bcm2835aux_spi_transfer_one_irq(master,
 							       spi, tfr);
 		}
@@ -555,6 +612,8 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}

+	bcm2835aux_debugfs_create(bs, dev_name(&pdev->dev));
+
 	return 0;

 out_clk_disable:
@@ -569,6 +628,8 @@ static int bcm2835aux_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);

+	bcm2835aux_debugfs_remove(bs);
+
 	bcm2835aux_spi_reset_hw(bs);

 	/* disable the HW block by releasing the clock */
--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
