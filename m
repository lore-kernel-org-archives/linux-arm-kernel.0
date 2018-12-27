Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7716AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:43:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458E120882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DxonFP6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458E120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sRVUBVsJLx+SLUKd1bOurXV+XbipwT1hHl4O0jfXbQQ=; b=DxonFP6r5hZvLK
	OoXt0RFscaKAPzm1Id+U38YjUEScr72d8SyjGSXIa9iWlif3DvjXpj7ErRhU7r8VtjKJZTMs6ngTp
	eXD5jjD+sdgm9BzAoFR9qegNVFZ+4uI0dH2QDzHB57RnUwufdZ/UEsUKYqzbxtz+WUFANGZar7Lbo
	/QJDtfqZHoonDWx/qeD5MWeKRj8o6LkK1mpf3cp1O0QxJ+lukgmVrdpwqCPEDGlbFicBbFNKMYTq0
	e+uAmHyh+5/f/TWC9rU7XLUzWDyuVA4aWka8gCh5Jzd1b/SMxGKWqmTcSEyrlZDHoPg8H+lmBgPHV
	BMPSLpBsd8Fy6jocIadw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcXoN-0007jv-Ij; Thu, 27 Dec 2018 15:43:03 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcXoK-0007hw-3C; Thu, 27 Dec 2018 15:43:01 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 0C8952072F; Thu, 27 Dec 2018 16:42:49 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-80-230.w90-88.abo.wanadoo.fr [90.88.22.230])
 by mail.bootlin.com (Postfix) with ESMTPSA id 603C12070E;
 Thu, 27 Dec 2018 16:42:48 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: bcm2835: Clear current buffer pointers and counts
 after a transfer
Date: Thu, 27 Dec 2018 16:42:25 +0100
Message-Id: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_074300_268399_46D8F823 
X-CRM114-Status: GOOD (  13.99  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Eben Upton <eben@raspberrypi.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Ray Jui <rjui@broadcom.com>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Eric Anholt <eric@anholt.net>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The driver's interrupt handler checks whether a message is currently
being handled with the curr_msg pointer. When it is NULL, the interrupt
is considered to be unexpected. Similarly, the i2c_start_transfer
routine checks for the remaining number of messages to handle in
num_msgs.

However, these values are never cleared and always keep the message and
number relevant to the latest transfer (which might be done already and
the underlying message memory might have been freed).

When an unexpected interrupt hits with the DONE bit set, the isr will
then try to access the flags field of the curr_msg structure, leading
to a fatal page fault.

The msg_buf and msg_buf_remaining fields are also never cleared at the
end of the transfer, which can lead to similar pitfalls.

Fix these issues by introducing a cleanup function and always calling
it after a transfer is finished.

Fixes: e2474541032d ("i2c: bcm2835: Fix hang for writing messages larger than 16 bytes")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---

Changes since v1:
* Added cleanup of msg_buf and msg_buf_remaining;
* Moved cleanups to a dedicated function;
* Performed cleanup on timeout as well;
* Added Fixes tag.

 drivers/i2c/busses/i2c-bcm2835.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 44deae78913e..4d19254f78c8 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -191,6 +191,15 @@ static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_dev *i2c_dev)
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
 }
 
+static void bcm2835_i2c_finish_transfer(struct bcm2835_i2c_dev *i2c_dev)
+{
+	i2c_dev->curr_msg = NULL;
+	i2c_dev->num_msgs = 0;
+
+	i2c_dev->msg_buf = NULL;
+	i2c_dev->msg_buf_remaining = 0;
+}
+
 /*
  * Note about I2C_C_CLEAR on error:
  * The I2C_C_CLEAR on errors will take some time to resolve -- if you were in
@@ -291,6 +300,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 
 	time_left = wait_for_completion_timeout(&i2c_dev->completion,
 						adap->timeout);
+
+	bcm2835_i2c_finish_transfer(i2c_dev);
+
 	if (!time_left) {
 		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C,
 				   BCM2835_I2C_C_CLEAR);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
