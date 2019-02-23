Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642D7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:51:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DDD720684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PES/xeKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDD720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=lt4OKczlwATP2cteMOfTkiPvwtf0gujTJq+Ii3kYNJ4=; b=PES/xeKdJkE+KwalucJC3PF3Ip
	dc5qeKqO7eHNLt0vFOQZn5sXiP4budyeCCBf4aBhKFYFRG3H31crYnWmH9e9BxcgMC7+nYn4MtTQQ
	Uni3+t+rSyCP8LInVFV8Zv2EFpnP4Mjh++Wv6LoX/tbjxXQORhg8UkPVbeiR0El6aF3el8E1N9yiN
	8Ek+dhpICOjKRxVtJTvLmPh+efxGW3u4HaFGxlKQbFDhTLGcjs0H8P9vQV3DQ2QvMUOaPQSa+L+TM
	5ANjV9Nv4p4v1A0MZUhAaP8gqnz7tGu5xd8+HlwQzz+ABO/HU8fKWgVR43bO7gqqF6EgL0z38THYR
	9aXUQVpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxT1o-0002XY-Tp; Sat, 23 Feb 2019 08:51:24 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxT19-0001PS-0g; Sat, 23 Feb 2019 08:50:45 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757394; Sat, 23 Feb 2019 08:50:05 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] spi: bcm2835: support effective_speed_hz
Date: Sat, 23 Feb 2019 08:49:51 +0000
Message-Id: <20190223084952.14758-5-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190223084952.14758-1-kernel@martin.sperl.org>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_005043_318327_B99A39F6 
X-CRM114-Status: UNSURE (   7.76  )
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

Setting spi_transfer->effective_speed_hz in transfer_one so that
it can get used in cs_change_delay configured with delay as a muliple
of SPI clock cycles.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 35aebdfd3b4e..c2912c1e09c5 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -777,7 +777,6 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, cdiv;
-	unsigned long spi_used_hz;
 	unsigned long long xfer_time_us;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);

@@ -797,7 +796,7 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	} else {
 		cdiv = 0; /* 0 is the slowest we can go */
 	}
-	spi_used_hz = cdiv ? (clk_hz / cdiv) : (clk_hz / 65536);
+	tfr->effective_speed_hz = cdiv ? (clk_hz / cdiv) : (clk_hz / 65536);
 	bcm2835_wr(bs, BCM2835_SPI_CLK, cdiv);

 	/* handle all the 3-wire mode */
@@ -823,7 +822,7 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	xfer_time_us = (unsigned long long)tfr->len
 		* 9 /* clocks/byte - SPI-HW waits 1 clock after each byte */
 		* 1000000;
-	do_div(xfer_time_us, spi_used_hz);
+	do_div(xfer_time_us, tfr->effective_speed_hz);

 	/* for short requests run polling*/
 	if (xfer_time_us <= BCM2835_SPI_POLLING_LIMIT_US)
--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
