Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A64C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:12:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4437221906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A0kKoi3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4437221906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KmdsNO3lIDdTgrKyyYFBzFCQNiSB4umK69WP6710ZpE=; b=A0kKoi3PShYXMl
	PGp1qe4lZex9Oei0kDruLWy/INp4JDrcFpF2MNwgkgsP8RLN1hA39nOOJMIb43H7LW0HbFAM6Mx2s
	1A6/0Xy1sWYBOgmwBjot0ZVJobuCA+stFTE3AIcWGtaCRuaiGMWOl+0qI8gi+zmkqnNT5exua7rz1
	MHx3CyQhs8UudE0bXEk5r0YfiZxLhkE3EB0hWZMaWziBByMg4wcTVoyTBJMs2IA+Z2yMLHKkDGHOy
	R5cL8APhkUqWKnnJIvFiqYXYb/hdzs8kgmEAxJ9OoS/s3OhOMIcbfcZOSnP7yWzAE0Xxju5u0bS9X
	2P+g68U7xHIdSlwERDyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaJfH-0001WX-Ml; Fri, 21 Dec 2018 12:12:27 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaJfE-0001V5-M6; Fri, 21 Dec 2018 12:12:26 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 103EB207AE; Fri, 21 Dec 2018 13:12:07 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id B13DB2078E;
 Fri, 21 Dec 2018 13:12:06 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: bcm2835: Clear current message and count after a
 transaction
Date: Fri, 21 Dec 2018 13:11:35 +0100
Message-Id: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_041224_855529_EC0E5970 
X-CRM114-Status: GOOD (  13.67  )
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
 Ray Jui <rjui@broadcom.com>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Eric Anholt <eric@anholt.net>
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

Fix the issue by systematically clearing curr_msg and num_msgs in the
driver-wide device structure when a transfer is considered complete.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/i2c/busses/i2c-bcm2835.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 44deae78913e..5486252f5f2f 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 		return -ETIMEDOUT;
 	}
 
+	i2c_dev->curr_msg = NULL;
+	i2c_dev->num_msgs = 0;
+
 	if (!i2c_dev->msg_err)
 		return num;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
