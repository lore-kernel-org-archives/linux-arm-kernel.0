Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01341C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:13:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13F12082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dglxqjoI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="kMFTwJGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13F12082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tzzYihBFWeNcX4s2LCgwjwUg2Rj+fW6O5drc3JYIBPM=; b=dglxqjoIP1jYTbB3wNmchtRcMY
	hJA8Qv+vNQHFC0cCwknhIyzKVsYuSrCDb9oUiuzMUwHIpONXBnS//j7En93NkWpbAKfgmPpeqhTmz
	fZ3XiNszXw4LWpfstTyDTgD03Vn/DgQldN26wUOwSOlyo/uqYxELkxxX/DuLUJPfqNpYf4Pxna9X8
	xAh5yQ8IDbn4vzQKsIHRHRL8nRFKSX1MzxkUCDDvshdcsAIJu4PGhPlB+/2mPMk3jC5xGAfFA00bN
	rObK+cn/ohqabYCRZ7yr+WB3bXmuetbv2btEe1o0OboETmIX0cFNvHr5xKMSCKOJyAsZxNHMsVL2Z
	ES+xl0eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1tl-00008Z-32; Thu, 06 Dec 2018 22:13:33 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1re-00021y-13
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:11:44 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id DE91125BF43;
 Fri,  7 Dec 2018 08:59:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133541; bh=5MX/LbvjzzkgTOdbi3PU2xOGyfxfRYacurA0G9sHZhI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kMFTwJGFHahBNwWXnuPmJtGI8UoAFmQxXmTLh/LUZl/mcWPXobLI+qiWteOwb/OSh
 NUiWS6fHTBgc8cZSYU9dOTQWtQR8cApXG6lp+SwicPMI6KNS3PJNloAMk8UDmQUQ9G
 WI/4sl7VRAPDLMZIuHUkd8bnz720gTDb8/RYwv70=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 37967E23291; Thu,  6 Dec 2018 13:58:58 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 7/9] soc: renesas: rcar-sysc: Remove rcar_sysc_power_{down,
 up}() helpers
Date: Thu,  6 Dec 2018 13:58:55 -0800
Message-Id: <319c84090696517f377a80225534677adf192e92.1544131943.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544131943.git.horms+renesas@verge.net.au>
References: <cover.1544131943.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141122_959275_44DE2FD5 
X-CRM114-Status: GOOD (  10.50  )
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

Until commit 7e8a50df26f4e700 ("soc: renesas: rcar-sysc: Drop legacy
handling"), the rcar_sysc_power_{down,up}() helpers were public, as they
were called by the legacy (pre-DT) CPU power management code on R-Car H1
and R-Car Gen2 before.

As they are just one-line wrappers around rcar_sysc_power(), it makes
sense to just remove them.

This also avoids a bool/helper/bool conversion in rcar_sysc_power_cpu(),
where a bool is checked to call one of two helper functions, which
just call rcar_sysc_power() with hardcoded boolean values again.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/rcar-sysc.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index af53363eda03..73fae6a9728d 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -146,16 +146,6 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
 	return ret;
 }
 
-static int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch)
-{
-	return rcar_sysc_power(sysc_ch, false);
-}
-
-static int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
-{
-	return rcar_sysc_power(sysc_ch, true);
-}
-
 static bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
 {
 	unsigned int st;
@@ -184,7 +174,7 @@ static int rcar_sysc_pd_power_off(struct generic_pm_domain *genpd)
 	struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
 
 	pr_debug("%s: %s\n", __func__, genpd->name);
-	return rcar_sysc_power_down(&pd->ch);
+	return rcar_sysc_power(&pd->ch, false);
 }
 
 static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
@@ -192,7 +182,7 @@ static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
 	struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
 
 	pr_debug("%s: %s\n", __func__, genpd->name);
-	return rcar_sysc_power_up(&pd->ch);
+	return rcar_sysc_power(&pd->ch, true);
 }
 
 static bool has_cpg_mstp;
@@ -252,7 +242,7 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 		goto finalize;
 	}
 
-	rcar_sysc_power_up(&pd->ch);
+	rcar_sysc_power(&pd->ch, true);
 
 finalize:
 	error = pm_genpd_init(genpd, gov, false);
@@ -478,8 +468,7 @@ static int rcar_sysc_power_cpu(unsigned int idx, bool on)
 		if (!(pd->flags & PD_CPU) || pd->ch.chan_bit != idx)
 			continue;
 
-		return on ? rcar_sysc_power_up(&pd->ch)
-			  : rcar_sysc_power_down(&pd->ch);
+		return rcar_sysc_power(&pd->ch, on);
 	}
 
 	return -ENOENT;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
