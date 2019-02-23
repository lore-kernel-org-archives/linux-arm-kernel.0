Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B0AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:50:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F0120684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NfkeK0DC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F0120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=i5DXWcE/LmOB9+aTdqyuxh0tKXoUc+sSfisTolGNQSo=; b=NfkeK0DCkiWLK0KCitqASUFDX7
	2hFMrzyEgN8UsQefqxg9IzjU5AT15p3iyMp88ycZCmJjwJdhstk6WEnLHaoMd2P/+NIW4WYihia4Z
	qsCVGeYqWPc7SdxWCVinLQD4geF3dWgRqgb0S8m5CjGyJnFxTI54yld97N9oEr5Kew/GIhhusXKCT
	X0oq2QZHkw6C6JsS2s69jMjqKfbb1qZmWbcjqPv6hdw/AHbkIiheX6Nf22zVBb++E6bDloaP7nh/Y
	ErpufxHqqRVU3yeFzm5xe2E0Vx0/u2Fn5i6hxiqM62XTSC6ch7GRPRQP2lgQFxCnaJC4k3jH1eElm
	22FHp7AA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxT1F-0001lK-9R; Sat, 23 Feb 2019 08:50:49 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxT0v-0001PS-BB; Sat, 23 Feb 2019 08:50:32 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757391; Sat, 23 Feb 2019 08:50:05 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] spi: core: allow defining time that cs is deasserted
Date: Sat, 23 Feb 2019 08:49:48 +0000
Message-Id: <20190223084952.14758-2-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190223084952.14758-1-kernel@martin.sperl.org>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_005029_835091_83F5133F 
X-CRM114-Status: GOOD (  16.31  )
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

For some SPI devices that support speed_hz > 1MHz the default 10 us delay
when cs_change = 1 is typically way to long and may result in poor spi bus
utilization.

This patch makes it possible to control the delay at micro or nano second
resolution on a per spi_transfer basis. It even allows an "as fast as
possible" mode with:
    xfer.cs_change_delay_unit = SPI_DELAY_UNIT_NSECS;
    xfer.cs_change_delay = 0;

The delay code is shared between delay_usecs and cs_change_delay for
consistency and reuse, so in the future this change_delay_unit could also
apply to delay_usec as well.

Note that on slower SOCs/CPU actually reaching ns deasserts on cs is not
realistic as the gpio overhead alone (without any delays added ) may
already leave cs deasserted for more than 1us - at least on a raspberry pi.
But at the very least this way we can keep it as short as possible.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi.c       | 59 ++++++++++++++++++++++++++++++++++++++++---------
 include/linux/spi/spi.h |  7 ++++++
 2 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9a7def7c3237..90659eb29660 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1071,6 +1071,52 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 	return 0;
 }

+static void _spi_transfer_delay_ns(u32 ns)
+{
+	if (!ns)
+		return;
+	if (ns <= 1000) {
+		ndelay(ns);
+	} else {
+		u32 us = DIV_ROUND_UP(ns, 1000);
+
+		if (us <= 10)
+			udelay(us);
+		else
+			usleep_range(us, us + DIV_ROUND_UP(us, 10));
+	}
+}
+
+static void _spi_transfer_cs_change_delay(struct spi_message *msg,
+					  struct spi_transfer *xfer)
+{
+	u32 delay = xfer->cs_change_delay;
+	u32 unit = xfer->cs_change_delay_unit;
+
+	/* return early on "fast" mode - for everything but USECS */
+	if (!delay && unit != SPI_DELAY_UNIT_USECS)
+		return;
+
+	switch (unit) {
+	case SPI_DELAY_UNIT_USECS:
+		/* for compatibility use default of 10us */
+		if (!delay)
+			delay = 10000;
+		else
+			delay *= 1000;
+		break;
+	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
+		break;
+	default:
+		dev_err_once(&msg->spi->dev,
+			     "Use of unsupported delay unit %i, using default of 10us\n",
+			     xfer->cs_change_delay_unit);
+		delay = 10000;
+	}
+	/* now sleep for the requested amount of time */
+	_spi_transfer_delay_ns(delay);
+}
+
 /*
  * spi_transfer_one_message - Default implementation of transfer_one_message()
  *
@@ -1129,14 +1175,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 		if (msg->status != -EINPROGRESS)
 			goto out;

-		if (xfer->delay_usecs) {
-			u16 us = xfer->delay_usecs;
-
-			if (us <= 10)
-				udelay(us);
-			else
-				usleep_range(us, us + DIV_ROUND_UP(us, 10));
-		}
+		if (xfer->delay_usecs)
+			_spi_transfer_delay_ns(xfer->delay_usecs * 1000);

 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list,
@@ -1144,7 +1184,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				keep_cs = true;
 			} else {
 				spi_set_cs(msg->spi, false);
-				udelay(10);
+				_spi_transfer_cs_change_delay(msg, xfer);
 				spi_set_cs(msg->spi, true);
 			}
 		}
@@ -3642,4 +3682,3 @@ static int __init spi_init(void)
  * include needing to have boardinfo data structures be much more public.
  */
 postcore_initcall(spi_init);
-
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 314d922ca607..f2ce1fb403ef 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -703,6 +703,9 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @bits_per_word: select a bits_per_word other than the device default
  *      for this transfer. If 0 the default (from @spi_device) is used.
  * @cs_change: affects chipselect after this transfer completes
+ * @cs_change_delay: delay between cs deassert and assert when
+ *      @cs_change is set and @spi_transfer is not the last in @spi_message
+ * @cs_change_delay_unit: unit of cs_change_delay
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
@@ -789,6 +792,10 @@ struct spi_transfer {
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
 	u16		delay_usecs;
+	u16		cs_change_delay;
+	u8		cs_change_delay_unit;
+#define SPI_DELAY_UNIT_USECS	0
+#define SPI_DELAY_UNIT_NSECS	1
 	u32		speed_hz;
 	u16		word_delay;

--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
