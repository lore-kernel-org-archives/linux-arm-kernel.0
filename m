Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DC5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:13:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045062082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rXNGvejs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="XbVVIpl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045062082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9upg+SGRP3sxX0Fx3k0ZSBrbPhsC7BjCkiGqdzQB2f8=; b=rXNGvejsFxtpKV46awKxW1rGvz
	uagye0wfDF/Uu283HflxwxheVWHGODQbTVd8ETlNH1uyqLvxBLiIgohZUc2PtWH3hiNARUojclWlV
	0uimy/vWp8AJLnoP5E2xgl4WcgGZ/8aC8ZOaJvxvosw2jGuwbLMhlbKvhIF0LsVTDHlJKktOGPD4n
	vkHpuclE/0jRwcAbxoYMnVUokEwJ4kpFh61tBvpuK32WhiuQ3/TGIvKYvTTCZv5yI5Of/QCYVR58R
	D1jry4xmDv0M7k4vMBIQmkCvByZKLpXYyVAVMV4hGvf4ZN5nPj/xvwsnnKPv8d8Cx3Ip5+BS4U91q
	gnEX3Ttw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1tw-0000K6-31; Thu, 06 Dec 2018 22:13:44 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1s0-00021y-TS
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:12:18 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id DEA7825BF44;
 Fri,  7 Dec 2018 08:59:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133541; bh=eOwbPEFHLNV5AJyT4tA9eW2gacS1Nnvorks48oQmOYE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XbVVIpl8/5y2WD+ErsA7sXHtSuoBLSHPUllFmpPxnnZc+W4UWmRDD7mvIUJN7NoYC
 5Pk4uC2wiRWWUe/9QUyN1c3hb9tLUvKP7f9iFhYtXhAQ85Sleux6NDRNao0J93zJ1a
 BF0Zn0i/Scxfbh47oqb3hlDRuPh7AijfJZrbjWJM=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 3BC6BE23292; Thu,  6 Dec 2018 13:58:58 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 8/9] soc: renesas: rcar-sysc: Merge PM Domain registration and
 linking
Date: Thu,  6 Dec 2018 13:58:56 -0800
Message-Id: <1585124d9563da64f481dc0e7c568c344002bc13.1544131943.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544131943.git.horms+renesas@verge.net.au>
References: <cover.1544131943.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141145_933242_EF283274 
X-CRM114-Status: GOOD (  11.62  )
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

Commit 977d5ba4507dfe5b ("soc: renesas: rcar-sysc: Make PM domain
initialization more robust") split PM Domain registration and the
linking of children to their parents, to accommodate PM Domain tables
that list child domains before their parents.

However, this failed to realize that parent power domains must be
powered up before their children anyway, and that this thus must be
reflected by the order in the PM Domain tables.

Revert the split, as it did not help anyway.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/rcar-sysc.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 73fae6a9728d..123e553510e8 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -381,9 +381,6 @@ static int __init rcar_sysc_pd_init(void)
 	pr_debug("%pOF: syscier = 0x%08x\n", np, syscier);
 	iowrite32(syscier, base + SYSCIER);
 
-	/*
-	 * First, create all PM domains
-	 */
 	for (i = 0; i < info->num_areas; i++) {
 		const struct rcar_sysc_area *area = &info->areas[i];
 		struct rcar_sysc_pd *pd;
@@ -411,22 +408,17 @@ static int __init rcar_sysc_pd_init(void)
 			goto out_put;
 
 		domains->domains[area->isr_bit] = &pd->genpd;
-	}
 
-	/*
-	 * Second, link all PM domains to their parents
-	 */
-	for (i = 0; i < info->num_areas; i++) {
-		const struct rcar_sysc_area *area = &info->areas[i];
-
-		if (!area->name || area->parent < 0)
+		if (area->parent < 0)
 			continue;
 
 		error = pm_genpd_add_subdomain(domains->domains[area->parent],
-					       domains->domains[area->isr_bit]);
-		if (error)
+					       &pd->genpd);
+		if (error) {
 			pr_warn("Failed to add PM subdomain %s to parent %u\n",
 				area->name, area->parent);
+			goto out_put;
+		}
 	}
 
 	error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
