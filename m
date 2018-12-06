Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A25C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:16:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445DB2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O+WNOy0/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="rND64F8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445DB2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=R35dDOzEP4QVChWjG+B4C6OTgjkCTMmjb2aBJ49dBjs=; b=O+WNOy0/zFVWQenwI4+TQ/F9KL
	D48FjQCwL1AdvWHNXA4D16J4yxc/XBdoJGuM9tc2QIkPUjGybZ8O5BdeLCXje4Mgmb/+QWNeUC+hP
	RrYmr8y8UOkvphN9Dyh+X1bcoxKQJvnFGO8ZBUUISgBax6qpfaIrbMuuN7Q5uOJZKW3lXbzVR06SQ
	FXhOJ2HA5P0p6EAZeEBpv3o1UtaWpORtt+ziCayP3OrpN04vDJQH3IEn8/Qf+07CDTwWJU1s4hq+7
	b+MXqb8KybNpvJf6ujUbC7JP2r36zf1AdX/uqnWExgK1tyaA1jYWekBY/e5ebDFrX+qulWaIJiFv2
	p1dhkaow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1x0-0004kU-Cc; Thu, 06 Dec 2018 22:16:54 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1vV-00085t-O5
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:15:47 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 284F925BF7C;
 Fri,  7 Dec 2018 08:59:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133576; bh=7kROtk+p9cGuq+RLgUVUln5pyRJtLSb19IqE50JGG0E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rND64F8Iq32NpcONbrn91IsdPDz0Tx6C1wfO+mWz8oRHYgZ14YiAarIS4m2iPQq31
 VD9r7Xz7DUCHj+/1vE4XBffihl/oriKCSWZbZUdzlMy/meAQQtoWDEZY3RnTXyJZcY
 lQDNJOSnClVyR2eyZInyH7EfGoYFDn2dDhvRZUj8=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id F2C9CE21709; Thu,  6 Dec 2018 13:59:34 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/9] arm64: renesas: Enable GPIOLIB to allow GPIO driver
 selection
Date: Thu,  6 Dec 2018 13:59:26 -0800
Message-Id: <9374eee32b666c92cf821a98eb3aeaa0bf4d5dd5.1544132474.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544132474.git.horms+renesas@verge.net.au>
References: <cover.1544132474.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141522_654171_906FED40 
X-CRM114-Status: UNSURE (   8.80  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Takeshi Kihara <takeshi.kihara.df@renesas.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

The R-Car GPIO driver cannot be enabled when Renesas SoC's ARCH configs
(ARCH_RENESAS, ARCH_R8A7795, ARCH_R8A7796 and ARCH_R8A77965) are enabled
only.

As GPIOs are a critical resource for proper operation on Renesas
platforms, this patch selects GPIOLIB, just like is done for other SoC
vendors, and on Renesas arm32 SoCs.

Reported-by: Alexandru Gheorghe <Alexandru_Gheorghe@mentor.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Improve patch description]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479334a4..2eb02734ae45 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -157,6 +157,7 @@ config ARCH_REALTEK
 
 config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
+	select GPIOLIB
 	select PINCTRL
 	select PM
 	select PM_GENERIC_DOMAINS
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
