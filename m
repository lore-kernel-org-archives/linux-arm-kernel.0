Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1E4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:24:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31B320645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OBuLusfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31B320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GCYlGvFyNfFJ5AEyz4MA8k9N7wKO3sCKRbfLbGl4JXc=; b=OBuLusfPI7yPBxJEOUI4Ma1Zp+
	L5PPo1nRJxbkMX558eaSBZxI3m9/VTImctGGn6mKF6PB033ERj6D1mERH0BHQivdUlY8Vb15LXHcL
	Os4MTqHIKNqzEyH889vn+tHCE0YFWOZZx0Op90OiFpc5DKwtbpnztrqKyU4l+/hy2bF/O2LesJ35L
	kapeO/+OUPF421UBvhBycPgq0vaKjIfi0E5eYPIJX8gIhISHN88BbIxmJCL2WcoYlZ+x5YI2DooJT
	8myFYQex1+6GlvKoEyDeXgfh/6E7DrumQpusoK2coDqdsUc7Rry5gQpjgF+7A6u+Dc+JXmrEOnal4
	xmlX6mvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxwZE-0006p2-UO; Sun, 24 Feb 2019 16:23:52 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxwYp-0006IK-Nf; Sun, 24 Feb 2019 16:23:31 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757585; Sun, 24 Feb 2019 16:23:15 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] spi: bcm2835: add module parameter to configure minimum
 length for dma
Date: Sun, 24 Feb 2019 16:23:11 +0000
Message-Id: <20190224162311.23899-3-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190224162311.23899-1-kernel@martin.sperl.org>
References: <20190224162311.23899-1-kernel@martin.sperl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_082328_114135_116A0358 
X-CRM114-Status: GOOD (  12.14  )
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

Allow setting the length of the transfer at which dma is used by
setting a module parameter.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index dcf922ca2603..ef4b3468a97d 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -31,6 +31,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -44,6 +45,39 @@ module_param(polling_limit_us, uint, 0664);
 MODULE_PARM_DESC(polling_limit_us,
 		 "time in us to run a transfer in polling mode\n");

+/* define dma min number of bytes to use in dma mode with value validation */
+static int dma_min_bytes_limit_set(const char *val,
+				   const struct kernel_param *kp)
+{
+	unsigned int v;
+
+	if (kstrtouint(val, 10, &v))
+		return -EINVAL;
+	/* value needs to be a multiple of 4 */
+	if (v % 4) {
+		pr_err("dma_min_bytes_limit needs to be a multiple of 4\n");
+		return -EINVAL;
+	}
+	/* value needs to be at least 6 - so actually 8 - rational below */
+	if (v < 6) {
+		pr_err("dma_min_bytes_limit needs to be at least 8\n");
+		return -EINVAL;
+	}
+
+	return param_set_uint(val, kp);
+}
+
+static const struct kernel_param_ops dma_min_bytes_limit_ops = {
+	.set	= dma_min_bytes_limit_set,
+	.get	= param_get_int,
+};
+
+unsigned int dma_min_bytes_limit = 96;
+module_param_cb(dma_min_bytes_limit, &dma_min_bytes_limit_ops,
+		&dma_min_bytes_limit, 0664);
+MODULE_PARM_DESC(dma_min_bytes_limit,
+		 "minimum number of bytes to run a transfer in dma mode\n");
+
 /* SPI register offsets */
 #define BCM2835_SPI_CS			0x00
 #define BCM2835_SPI_FIFO		0x04
@@ -80,7 +114,6 @@ MODULE_PARM_DESC(polling_limit_us,

 #define BCM2835_SPI_FIFO_SIZE		64
 #define BCM2835_SPI_FIFO_SIZE_3_4	48
-#define BCM2835_SPI_DMA_MIN_LENGTH	96
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)

@@ -447,7 +480,8 @@ static int bcm2835_spi_transfer_one_irq(struct spi_master *master,
  * if the length of the first is *exactly* 1.
  *
  * At most 6 bytes are written and at most 3 bytes read.  Do we know the
- * transfer has this many bytes?  Yes, see BCM2835_SPI_DMA_MIN_LENGTH.
+ * transfer has this many bytes?  Yes, see validation in
+ * dma_min_bytes_limit_set.
  *
  * The FIFO is normally accessed with 8-bit width by the CPU and 32-bit width
  * by the DMA engine.  Toggling the DMA Enable flag in the CS register switches
@@ -690,7 +724,7 @@ static bool bcm2835_spi_can_dma(struct spi_master *master,
 				struct spi_transfer *tfr)
 {
 	/* we start DMA efforts only on bigger transfers */
-	if (tfr->len < BCM2835_SPI_DMA_MIN_LENGTH)
+	if (tfr->len < dma_min_bytes_limit)
 		return false;

 	/* BCM2835_SPI_DLEN has defined a max transfer size as
--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
