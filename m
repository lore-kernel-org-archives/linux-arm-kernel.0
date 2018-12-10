Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAB3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:14:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5498D20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="URLGhcV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5498D20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5SXVwWTE4Hc4wHSGuiFP3hrSwqaXL3fVPMjrBTymyXE=; b=URLGhcV0kvlL8h
	gcJeLf/PPythDec4BjBsrpj7rsIqmaWwbwBPGbmATpjkjmDraiAQRZd4C5uMUBQEDKA2O9naoZB+O
	OdXbNRY//lnCy9wd0/fjsr+b86IiO/myIukRJK1dtC2H9DHyQbbIPxV0WyBbNcxy8LStkOzTbt44L
	9hkEPfdS2nw4b+GjvQ8Gf4omnA/CLj1cRl+E1lumh+qnsXguJr2Ba0rPsYwl4Q7DZV4PhBpOjH6tI
	Voii9tqlfgVKEiOR80hjfnC6QwLcVxcwFSokX9qW9SV9uNUZk42/rs7UyFe/MiXYtet8QRkhgCkcZ
	ByMMIhpNkaYld64D2+Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWToM-0005H8-Vx; Mon, 10 Dec 2018 22:13:58 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWToD-00059R-26
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:13:50 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 8702F80F0;
 Mon, 10 Dec 2018 22:13:41 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH 1/2] ARM: OMAP2+: Check also the first dts child for hwmod
 flags
Date: Mon, 10 Dec 2018 14:13:33 -0800
Message-Id: <20181210221334.24982-1-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_141349_208207_6F230D43 
X-CRM114-Status: GOOD (  10.08  )
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
Cc: Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Dave Gerlach <d-gerlach@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
 Keerthy <j-keerthy@ti.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Until the board specific dts files are updated to have hwmod
flags at the interconnect target module level, we want to keep
things working both for old and new dts files.

So let's also check the first child for hwmod flags. The module
flags are for the whole module, so only the first child should
ever have them.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2345,6 +2345,17 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
 	return 0;
 }
 
+static void __init parse_module_flags(struct omap_hwmod *oh,
+				      struct device_node *np)
+{
+	if (of_find_property(np, "ti,no-reset-on-init", NULL))
+		oh->flags |= HWMOD_INIT_NO_RESET;
+	if (of_find_property(np, "ti,no-idle-on-init", NULL))
+		oh->flags |= HWMOD_INIT_NO_IDLE;
+	if (of_find_property(np, "ti,no-idle", NULL))
+		oh->flags |= HWMOD_NO_IDLE;
+}
+
 /**
  * _init - initialize internal data for the hwmod @oh
  * @oh: struct omap_hwmod *
@@ -2392,12 +2403,12 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 	}
 
 	if (np) {
-		if (of_find_property(np, "ti,no-reset-on-init", NULL))
-			oh->flags |= HWMOD_INIT_NO_RESET;
-		if (of_find_property(np, "ti,no-idle-on-init", NULL))
-			oh->flags |= HWMOD_INIT_NO_IDLE;
-		if (of_find_property(np, "ti,no-idle", NULL))
-			oh->flags |= HWMOD_NO_IDLE;
+		struct device_node *child;
+
+		parse_module_flags(oh, np);
+		child = of_get_next_child(np, NULL);
+		if (child)
+			parse_module_flags(oh, child);
 	}
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
