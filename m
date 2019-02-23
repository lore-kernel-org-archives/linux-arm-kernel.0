Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC78C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:51:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFBE20684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H0+O9ACy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFBE20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=LVTZhdLNNvqnJdXfq/Prypbs54vKJ0qBmkmn2hXouKY=; b=H0+O9ACyZHBGjs2tC4bkz7iFZr
	reoIAe+kV1vugg6dliR3B/+R7PkxcpJUSvKpokW4M3NBDXS7m/lWbkyxmCDjNUGkDYyqGWGS53dEu
	OjZPZyDv4Eq93cYd61cn1lw4pyVzUYwKk1NdlwmFqbivLY56Ih098yVr8lTnx1roZqffTn7MPucJ3
	MaDZhkBrtivivwKFTllEPVmb6+i5p2ICj/rdZ7dJ4FXtCbqwWKc4iCHo0Gk11W/nHwqYnFe9v3KUK
	KJPrWIOOg6aiwNDPZfi8uVxXYs7fDi0z4I+rjfDLmQsl/v+DYjs7QMukUUAfz+txssmdH9Ep4Tot2
	4XoHRyxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxT1c-0002Fy-5Z; Sat, 23 Feb 2019 08:51:12 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxT14-0001PS-DD; Sat, 23 Feb 2019 08:50:42 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757393; Sat, 23 Feb 2019 08:50:05 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] spi: core: allow defining time that cs is deasserted as a
 multiple of SCK
Date: Sat, 23 Feb 2019 08:49:50 +0000
Message-Id: <20190223084952.14758-4-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190223084952.14758-1-kernel@martin.sperl.org>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_005039_343676_C9355E63 
X-CRM114-Status: UNSURE (   8.84  )
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

Support setting a delay between cs assert and deassert as
a multiple of spi clock length.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi.c       | 8 ++++++++
 include/linux/spi/spi.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5a4616894d57..d5259bdd4b88 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1092,6 +1092,7 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 {
 	u32 delay = xfer->cs_change_delay;
 	u32 unit = xfer->cs_change_delay_unit;
+	u32 hz;

 	/* return early on "fast" mode - for everything but USECS */
 	if (!delay && unit != SPI_DELAY_UNIT_USECS)
@@ -1107,6 +1108,13 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 		break;
 	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
 		break;
+	case SPI_DELAY_UNIT_SCK:
+		/* if there is no effective speed know, then approximate
+		 * by underestimating with half the requested hz
+		 */
+		hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
+		delay *= DIV_ROUND_UP(1000000000, hz);
+		break;
 	default:
 		dev_err_once(&msg->spi->dev,
 			     "Use of unsupported delay unit %i, using default of 10us\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f503a712423d..0b1d5e2b8b8b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -799,6 +799,7 @@ struct spi_transfer {
 	u8		cs_change_delay_unit;
 #define SPI_DELAY_UNIT_USECS	0
 #define SPI_DELAY_UNIT_NSECS	1
+#define SPI_DELAY_UNIT_SCK	2
 	u32		speed_hz;
 	u16		word_delay;

--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
