Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C95C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:42:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35698218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lQSCqsWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35698218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rLSJrJZ9HHgEXgMw7NOsXTs+PmQojk9LC8qBXtKh3eg=; b=lQSCqsWXCdXMvd
	Q94VY88tTMn4tlZqN0zYHccMywWfVlDle2oZcsU0HlYHBnw615FD4BalvHAAUYSuQRiZGrqdTol7w
	MoRa05TpUoe99knRX4dCAj7oZY/InWC+6QQB38mdq+p15zmFZ7hwlLUHHUSNGIU42gWlKnZo/VFgP
	91iHli8gB8HJw9I7ikhMDkrjbeMxzDYsDzA2tNBqmrR2tRc2jU3TPmpaCc1VXCkPPrepz3AE4KV8R
	XUvbe7sD8KLj8w+gsGK5t3hkB7rzpVVme73NUJqPeK+dmIQEAaGnmHfjxk+lC+KTyvn+ptB5nmSMG
	NkihkKO0FifItNWYIJKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2s0-0003Mh-Qi; Tue, 05 Feb 2019 15:42:44 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2rl-00038O-0r
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 15:42:31 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 608235FCC3; Tue,  5 Feb 2019 23:42:26 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 0/3] mmc: sunxi: Fix eMMC usage on H5 boards
Date: Tue,  5 Feb 2019 23:42:22 +0800
Message-Id: <20190205154225.14264-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_074229_271219_9A50F8C3 
X-CRM114-Status: GOOD (  14.81  )
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
Cc: devicetree@vger.kernel.org, Chris Blake <chrisrblake93@gmail.com>,
 linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi everyone,

This is v2 of my H5 eMMC fix series. Changes since v1:

  - Don't block HS200 and UHS modes, since these have been tested

Original cover letter:

Since the HS-DDR mode was enabled for the A64 eMMC controller, there
have been reports of eMMC failing to work on some H5 boards. It seems
that while the H5 and A64 share the same controller for eMMC, some H5
boards don't have trace lengths that work under HS-DDR with the default
delay chain settings. Unfortunately we don't support tuning them at the
moment, and these boards didn't seem to come with any settings either.
Instead HS-DDR just wasn't enabled.

The failure is typically a data CRC error on data reads, such as the
partition scanning when the device is first probed. While this in itself
would result in the device being unusable, there seems to be a timing
issue in the recovery of the MMC controller. After the CRC error, the
driver manually issues a stop command to the device, which also fails.
After this a following command would stall: the MMC subsystem waits for
the completion notice of the request, which never happens. The stall
also blocks udev, which kind of blocks the whole boot process. However
if I turn on debug messages to try to narrow down the issue, it recovers
just fine. Any help on this issue would be much appreciated.

I propose we turn off HS-DDR on the H5 (maybe even the H6, but I don't
have anything to test right now) by default, and enable it per-board
using the common mmc binding properties for speed modes.

Patch 1 disables HS-DDR for H5 eMMC.

Patch 2 adds a check blocking (force disabling) any modes the driver
doesn't support. In retrospect this should have been added a long time
ago.

Patch 3 enables HS-DDR for the Libre Computer ALL-H3-CC H5, which works
normally.

If possible please merge all of them as fixes.


Regards
ChenYu

Chen-Yu Tsai (3):
  mmc: sunxi: Disable HS-DDR mode for H5 eMMC controller by default
  mmc: sunxi: Filter out unsupported modes declared in the device tree
  arm64: dts: allwinner: h5: libretech-all-h3-cc: Mark eMMC HS-DDR 3.3V
    capable

 .../sun50i-h5-libretech-all-h3-cc.dts         |  4 +++
 drivers/mmc/host/sunxi-mmc.c                  | 26 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
