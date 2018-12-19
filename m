Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F5BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:49:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DB7218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XJjnJiGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DB7218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=opFYhuXH80GtB36wLrtSYca4kPFo8uASPkHTEHlBRyY=; b=XJj
	nJiGCD3i8xBw+4bJRjOcxw/eE3xbA2EBCbbzbnKUxAJHWu2Y4fkaVPcLwCbHMGLVsqW52hgeSWOgm
	dWWifascowBHuz2GZ3CvknUUZgAhVcmhycwN7yMB+FvVYCbrqJpZCTrE66Ys5YK1OhSFW78bU8JWr
	7D1lrj5zTGWS5sFPC1cpnBZv4+a02Z6k0EhDJ+vHN4sXPJs8grbZjV3jeZRJnUlLohqdrfwEmNcBw
	zeUf9bQcU9JhDfqCVwMX0iv33XBHiJRAwfEBdO2HHztqHt/GdqNasLSQ9lQ1mkaAKDpkrVVUbXX2+
	MdVEFgUVbsZKk7rx3PN1s6C6qrA0tcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZf2N-0001nn-Fz; Wed, 19 Dec 2018 16:49:35 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZf1e-00011S-FG
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:48:52 +0000
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
 by pokefinder.org (Postfix) with ESMTPSA id 7E6BA2E3542;
 Wed, 19 Dec 2018 17:48:33 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 00/10] i2c: move handling of suspended adapters to the core
Date: Wed, 19 Dec 2018 17:48:16 +0100
Message-Id: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_084850_718241_BAFB4C11 
X-CRM114-Status: UNSURE (   8.96  )
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
Cc: linux-samsung-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Finally, here is the implementation Hans and I agreed on. Plus, all potential
users I could spot already converted. Renesas R-Car driver was added on top.
This series was tested on a Renesas Lager board (R-Car H2). I had to hack some
error cases into the code to verify the workings. Thanks for all the tests so
far. Of course, more testing never hurts ;)

Please comment, review, test... a branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/core-pm-helpers

Thanks,

   Wolfram

Changes since RFC:

* don't use bitfields anymore but an unsigned long flags variable which is only
  meant for flags to be changed when the adapter lock is held

* split the genereic accessor into _mark_suspended() and _mark_resumed()

* added kerneldoc and noted that using these helpers is optional

* documented -ESHUTDOWN as the error code when trying to transfer using an
  already suspended adapter

* added acks from last series. Changes were minor enough to keep them. Please let
  me know if you disagree.


Wolfram Sang (10):
  i2c: add suspended flag and accessors for i2c adapters
  i2c: reject new transfers when adapters are suspended
  i2c: synquacer: remove unused is_suspended flag
  i2c: brcmstb: use core helper to mark adapter suspended
  i2c: zx2967: use core helper to mark adapter suspended
  i2c: sprd: don't use pdev as variable name for struct device *
  i2c: sprd: use core helper to mark adapter suspended
  i2c: exynos5: use core helper to mark adapter suspended
  i2c: s3c2410: use core helper to mark adapter suspended
  i2c: rcar: add suspend/resume support

 Documentation/i2c/fault-codes      |  4 ++++
 drivers/i2c/busses/i2c-brcmstb.c   | 13 ++-----------
 drivers/i2c/busses/i2c-exynos5.c   | 11 ++---------
 drivers/i2c/busses/i2c-rcar.c      | 25 +++++++++++++++++++++++++
 drivers/i2c/busses/i2c-s3c2410.c   |  8 ++------
 drivers/i2c/busses/i2c-sprd.c      | 34 ++++++++++++----------------------
 drivers/i2c/busses/i2c-synquacer.c |  5 -----
 drivers/i2c/busses/i2c-zx2967.c    |  8 ++------
 drivers/i2c/i2c-core-base.c        |  3 +++
 include/linux/i2c.h                | 34 ++++++++++++++++++++++++++++++++++
 10 files changed, 86 insertions(+), 59 deletions(-)

-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
