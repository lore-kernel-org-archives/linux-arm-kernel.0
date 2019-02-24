Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6F8C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:00:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E36A20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 13:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fV/jM+wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E36A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=CXuhvBvJG6ljyjCDsZnQL+gpYt3uYxp9mPojYLKaMvQ=; b=fV/
	jM+wuRVF20fomBZQHkErVFEyciqeMxqpl2WwUPCRoIjoRjXl4P9bpp0QuX0ZZ/QHX9uGHjpKpnlND
	FlyOsL3PON7tUxv6vxYm5WJ/dZ4GxMFacHWffGfZwB21lje6CjyeG0VBfGWCaYFeBllPTpqaKI+gg
	yscw/zz8L7tx7QQCyr2ZiIjoynv3ZusanmiwpN6Y58m18zpDw+OaRFR4Ki20ayY0/Q+TuQKQOvV4l
	n5Adi3fD0DA6z1dQyWszwGAUW1D/cPsTibP7XYBZmm+/MY8r/y9NbVImMMgJ1HfrkTCTlXc8sDZDE
	EqTF07sCkPS4H691pNwIc4WMcwyeMLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxtJf-0001gJ-6i; Sun, 24 Feb 2019 12:55:35 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxtJV-0001f9-63; Sun, 24 Feb 2019 12:55:27 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757559; Sun, 24 Feb 2019 12:55:07 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Hubert Denkmair <h.denkmair@intence.de>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/9] spi: bcm2835aux: bug fixes and improvements
Date: Sun, 24 Feb 2019 12:54:31 +0000
Message-Id: <20190224125440.16117-1-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_045525_396136_3BF0AB71 
X-CRM114-Status: UNSURE (   8.75  )
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

Set of patches improving the spi-bcm2835aux driver and fixing
a data read corruption bug.

The main motivation is a rare data corruption fix that is mostly
observed in polling mode first reported by Hubert Denkmair.

So this patchset first implements a means to control the parameters
of when polling mode is used via module parameters and exports
the corresponding statistics.

As stated in original patch the driver does not support native CS.
But when cs-gpios is not configured in the dt (so a buggy dt) it is
still working with a lot of limitations, but the driver does not report
this fact.

So this patchset adds reporting and allows for a single native CS
(with limited functionality) to continue working with a buggy DT.
One question here remains: do we need to legacy support DTs
that are not following specs in the first place?

Then there is the real fix for the data-corruption which is split
into 3 parts: some code cleanup with code reuse, removing "dangerous"
fifo read (possibly introducing fifo data corruption) and safe fifo read

Finally we remove some dead code.

Martin Sperl (9):
  spi: bcm2835aux: fix driver to not allow 65535 (=-1) cs-gpios
  spi: bcm2835aux: warn in dmesg that native cs is not really supported
  spi: bcm2835aux: setup gpio-cs to output and correct level during
    setup
  spi: bcm2835aux: add driver specific stats to debugfs
  spi: bcm2835aux: make the polling duration limits configurable
  spi: bcm2835aux: unifying code between polling and interrupt driven
    code
  spi: bcm2835aux: remove dangerous uncontrolled read of fifo
  spi: bcm2835aux: use BCM2835_AUX_SPI_STAT_RX_LVL
  spi: bcm2835aux: remove dead code

 drivers/spi/spi-bcm2835aux.c | 205 +++++++++++++++++++++++++++++++------------
 1 file changed, 149 insertions(+), 56 deletions(-)

--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
