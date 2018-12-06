Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC7BC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:16:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F382082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sa3cfTaa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="NVDIRhD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F382082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NWf/iVkiXlu+EHxXfYbJ24xoW4xnXWQkkoHlmebLpog=; b=sa3cfTaanK+A9thY4IB8eIZ83N
	iOqZmXunO81RtIZSntpV9XNKJQUv/4KryyuM7BRPm+RhUWfj5JoWEUsvw22YfYrjOQnlmtC00MtAV
	BdJ7hRYddN3Hcz7yT4O9fBeaFG1psyFwCsUVplf0KHE1dXULMn9hUm7MfyLGb1VhEwR8sgX1xdUsw
	HzajSXDFwvqtXBjb8SwMJFwXeUBifGeeuF+gJQGLUhhhJi3cZS+6c79mIl6T5xrNKrlvSPlydhnY2
	MwHamh3pE2BxqctQziquWWRjBgSXNjU1FRAnGcwT8o8oWdkjo02D6w+Hs+J+cQb3Lpa+hxAZc5afR
	XJ/7Bc/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1wB-0003xV-DN; Thu, 06 Dec 2018 22:16:03 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1v8-00085t-Gr
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:15:21 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 2471625BF7B;
 Fri,  7 Dec 2018 08:59:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133576; bh=YPWve80+ZATtElyuw1vD0xCDju6lLmOaQE8XFx2PpTw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NVDIRhD1UVHmE725QbZXsUWmKr5ZWRlANOVA4dvYsPwtL7EZyPLpqy78XY/aFeN+U
 vXIBgG9TwWA3at2I1E1ShA41SQD5XoNlIlPShl5ebxCUyiHeQ2aA2WeR57UODRfotJ
 ibZs9eIEiNqxwyYBwK7FUfnlqbJYUUlO+MrLWDCI=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 032D0E217D1; Thu,  6 Dec 2018 13:59:35 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/9] ARM: shmobile: Restrict SCU support to SoCs that have it
Date: Thu,  6 Dec 2018 13:59:27 -0800
Message-Id: <af3a03cded07f4d6637e5b3660b6622cf60af338.1544132474.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544132474.git.horms+renesas@verge.net.au>
References: <cover.1544132474.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141459_341353_6DE1576A 
X-CRM114-Status: GOOD (  10.04  )
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
 Magnus Damm <magnus.damm@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Currently support for the ARM Cortex-A9 Snoop Control Unit is included
unconditionally, while only Renesas multicore Cortex-A9 SoCs have this
kind of SCU.

This decreases kernel image size by ca. 300 bytes on SoCs without such
an SCU.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index b100c26a858f..32f8297d993a 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -30,7 +30,6 @@ menuconfig ARCH_RENESAS
 	depends on ARCH_MULTI_V7 && MMU
 	select ARM_GIC
 	select GPIOLIB
-	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select NO_IOPORT_MAP
 	select PINCTRL
@@ -43,6 +42,7 @@ if ARCH_RENESAS
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
+	select HAVE_ARM_SCU if SMP
 	select SYS_SUPPORTS_EM_STI
 
 config ARCH_R7S72100
@@ -94,6 +94,7 @@ config ARCH_R8A7778
 
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
+	select HAVE_ARM_SCU if SMP
 	select ARCH_RCAR_GEN1
 
 config ARCH_R8A7790
@@ -135,5 +136,6 @@ config ARCH_RZN1
 config ARCH_SH73A0
 	bool "SH-Mobile AG5 (R8A73A00)"
 	select ARCH_RMOBILE
+	select HAVE_ARM_SCU if SMP
 	select RENESAS_INTC_IRQPIN
 endif
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
