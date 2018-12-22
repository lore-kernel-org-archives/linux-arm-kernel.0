Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200C2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:26:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6F22195D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qdo/N2r5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6F22195D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=N6AxbmpcK2NAl7C/SvRMik+Qf5Fbj/F+yoQyn8wnTdg=; b=Qdo/N2r5tpx6t+
	nwjkNdBBueHl0P/OO/7iMqMrJqCoIMCG5hJ/Uf/jL15kbqpCaCQlqfYYE2O4ykV0y+dGjcHcxL0Zz
	YTLWYCU+SrpT9RUcMnzDd3HMhU5kegRK5P25ECHp6MiqcysuxfozkiB9uD9bX4U74e6Yf3J+DZyzD
	sJE+0lSjJpXb/K8prXG7B3HVeDQxYWjnhGdYCJiK2vyA62Q8i+fba0trDcQK6qP3WHCVBCdP4p4x+
	vOVQpgnEV7jmfLnAa/tagwGiPYueGFQDqk9Bmi6OdsXTZfHYDJ1LFX+iuhTahSPNAK72ZjOBN0pzv
	tInYhhEutcKs8UNETHKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ganrF-0008B6-Cq; Sat, 22 Dec 2018 20:26:49 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ganrA-000880-Te
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 20:26:47 +0000
Received: from localhost (p54B67A8B.dip0.t-ipconnect.de [84.182.122.139])
 by pokefinder.org (Postfix) with ESMTPSA id 208C22E3542;
 Sat, 22 Dec 2018 21:26:30 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH v2 0/9] i2c: move handling of suspended adapters to the core
Date: Sat, 22 Dec 2018 21:26:14 +0100
Message-Id: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_122645_102054_48102EF0 
X-CRM114-Status: GOOD (  10.14  )
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
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Here is the new version without specific I2C helpers but using the
'is_suspended' flag from the PM core. I didn't like messing with the
flag directly, so I did a helper in patch 1. So far, I like the
approach. The diffstat looks nice, and i2c-rcar.c and i2c-sh_mobile.c
rejected rightfully too later transfers without further modifications.
Tested on a Renesas Lager board (R-Car H2).

I dropped a few Tested-by tags because I think this approach is too
different from V1 to keep them. I hope you guys can have a look again.
Thanks for all the testing, so far!

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/reject-when-suspended

If this series is acceptable, I'd suggest to take it via my i2c tree
after rc1. And then I'll provide an immutable branch for the PM tree to
pick. Let me know if this works for you.

And thanks to Renesas for funding this work!

Thanks and kind regards,

   Wolfram

Wolfram Sang (9):
  PM / core: add helper to return suspend status of a device
  i2c: reject new transfers when adapters are suspended
  i2c: synquacer: remove unused is_suspended flag
  i2c: brcmstb: don't open code to reject transfers when suspended
  i2c: zx2967: don't open code to reject transfers when suspended
  i2c: sprd: don't use pdev as variable name for struct device *
  i2c: sprd: don't open code to reject transfers when suspended
  i2c: exynos5: don't open code to reject transfers when suspended
  i2c: s3c2410: don't open code to reject transfers when suspended

 Documentation/i2c/fault-codes      |  4 ++++
 drivers/i2c/busses/i2c-brcmstb.c   | 22 +-------------------
 drivers/i2c/busses/i2c-exynos5.c   | 10 ----------
 drivers/i2c/busses/i2c-s3c2410.c   |  7 -------
 drivers/i2c/busses/i2c-sprd.c      | 32 ++++++++++--------------------
 drivers/i2c/busses/i2c-synquacer.c |  5 -----
 drivers/i2c/busses/i2c-zx2967.c    |  8 --------
 drivers/i2c/i2c-core-base.c        |  3 +++
 drivers/i2c/i2c-core-smbus.c       |  4 ++++
 include/linux/device.h             |  5 +++++
 10 files changed, 27 insertions(+), 73 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
