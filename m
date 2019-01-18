Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA3FC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:33:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D94B2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RpynnzaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D94B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ty/Xbr6ovWqA3eFpWnQlXAYEJSgRB7bY6eiV6touxOY=; b=RpynnzaWxtrmRL
	E1w/XAQmaxoBlVgnKptO2MyWCh1A0NIpJPPX0/APjx/ZdriR2yYyK/6tWOVT9lGZGHv3hf0jQ0huW
	/kGS5fFDI5Sizbkr2X/olJBgFwXfx/UXk918UNLdtQmuglnES7jvkdlX4TEsIrZ36aL12c4OpKrXq
	mi43VNYiqKI8ufefSOYHvPAtIGbqrsPTs8UJumGJ08ac037XqgDg4H86/qSzZJj9zwslu2o9a2xlV
	nwkhWGEq0+eIok/CqhM/Vo5fpldCCeEAf4BPGAol3KCynPfNeEeJqf5SnKiQgym8EbWy+rEOXpC9A
	7bk/nq8HHpKmSCCkZDOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkKu9-0006O1-VU; Fri, 18 Jan 2019 03:33:13 +0000
Received: from mail.windriver.com ([147.11.1.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkKu6-0006N5-H3
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 03:33:11 +0000
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
 by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0I3X2ne007638
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
 Thu, 17 Jan 2019 19:33:02 -0800 (PST)
Received: from pek-jsun4-d1.corp.ad.wrs.com (128.224.155.96) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.3.408.0; Thu, 17 Jan 2019 19:33:02 -0800
From: Jiwei Sun <jiwei.sun@windriver.com>
To: <linus.walleij@linaro.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH]spi: pl022: add a message state STATE_TIMEOUT for timeout
 transfer
Date: Fri, 18 Jan 2019 11:32:29 +0800
Message-ID: <20190118033229.22553-1-jiwei.sun@windriver.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_193310_593675_EA798BB4 
X-CRM114-Status: UNSURE (   9.89  )
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
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When transfer timeout, give -EAGAIN to the message's status, and it can
make the spi device driver choose repeated transimation or not. And if
transfer timeout, output some useful information for tracing the issue.

Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
---
 drivers/spi/spi-pl022.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 0c793e31d60f..26684178786f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -253,6 +253,7 @@
 #define STATE_RUNNING			((void *) 1)
 #define STATE_DONE			((void *) 2)
 #define STATE_ERROR			((void *) -1)
+#define STATE_TIMEOUT			((void *) -2)
 
 /*
  * SSP State - Whether Enabled or Disabled
@@ -1484,6 +1485,30 @@ static void do_interrupt_dma_transfer(struct pl022 *pl022)
 	writew(irqflags, SSP_IMSC(pl022->virtbase));
 }
 
+static void print_current_status(struct pl022 *pl022)
+{
+	u32 read_cr0;
+	u16 read_cr1, read_dmacr, read_sr;
+
+	if (pl022->vendor->extended_cr)
+		read_cr0 = readl(SSP_CR0(pl022->virtbase));
+	else
+		read_cr0 = readw(SSP_CR0(pl022->virtbase));
+	read_cr1 = readw(SSP_CR1(pl022->virtbase));
+	read_dmacr = readw(SSP_DMACR(pl022->virtbase));
+	read_sr = readw(SSP_SR(pl022->virtbase));
+
+	dev_warn(&pl022->adev->dev, "spi-pl022 CR0: %x\n", read_cr0);
+	dev_warn(&pl022->adev->dev, "spi-pl022 CR1: %x\n", read_cr1);
+	dev_warn(&pl022->adev->dev, "spi-pl022 DMACR: %x\n", read_dmacr);
+	dev_warn(&pl022->adev->dev, "spi-pl022 SR: %x\n", read_sr);
+	dev_warn(&pl022->adev->dev,
+			"spi-pl022 exp_fifo_level/fifodepth: %u/%d\n",
+			pl022->exp_fifo_level,
+			pl022->vendor->fifodepth);
+
+}
+
 static void do_polling_transfer(struct pl022 *pl022)
 {
 	struct spi_message *message = NULL;
@@ -1535,7 +1560,8 @@ static void do_polling_transfer(struct pl022 *pl022)
 			if (time_after(time, timeout)) {
 				dev_warn(&pl022->adev->dev,
 				"%s: timeout!\n", __func__);
-				message->state = STATE_ERROR;
+				message->state = STATE_TIMEOUT;
+				print_current_status(pl022);
 				goto out;
 			}
 			cpu_relax();
@@ -1553,6 +1579,8 @@ static void do_polling_transfer(struct pl022 *pl022)
 	/* Handle end of message */
 	if (message->state == STATE_DONE)
 		message->status = 0;
+	else if (message->state == STATE_TIMEOUT)
+		message->status = -EAGAIN;
 	else
 		message->status = -EIO;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
