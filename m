Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A315C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:14:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295A92082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EfghYGxr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="kKImKpww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295A92082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HXH3lPXDMXz+8ihUP8cf84SYZOS9/U+nrXa7uINN3B8=; b=EfghYGxrt70QyalDvMHFyRaMiz
	Xh1WIbp3E+hZm1mYPGChsyIeh+6OjGdE3aG4TM7CaDeLg/2y+FJxk/lRNFeRfCG++aMlSI7eO9RtK
	2XS0MA/oEn5WwZ1OBX95JeElCpXkdemhh1urck09Ax86vEVGW/OfGqXPfdya+XwDFS6z7Uj4C2kbe
	zt9GU9FtnC14MNm9+GJFxN1onHlDjM2F1/yOnHEb3Sr/hM36cUZ7g/bRUBwiDpPusWRD3vDsMuPa7
	BpUuP+1vZ0C8IiU78YzBR4se03HziiO00553Lnx+5yJboYFC4c75swCSxIn7VvZNUKEjrLz0ocaia
	icnRIl8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1uC-0000cq-39; Thu, 06 Dec 2018 22:14:00 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1sZ-00021y-Gh
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:12:37 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 01D4225BF45;
 Fri,  7 Dec 2018 08:59:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133541; bh=BiM2lf2Uor9Zr2HRaRBAcHnLsGr8MWZ7mNH3jjxsfIo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kKImKpww9NaIyo20J+ra4Rq/mOTzhrUiZUi2m0gtqRaTghK5dBg17KwhyRUmgdgSE
 H4eYU1BvevPBsHYw1CEAZxYohWOHavcHu2y8PgoYfmVEX87cspfx/qdeUa/WGcPcSn
 xFqFeq0Aktoo0z0wEVouJH0ErR44xKOavw0HgXvU=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 40013E23295; Thu,  6 Dec 2018 13:58:58 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 9/9] soc: renesas: rcar-sysc: Fix power domain control after
 system resume
Date: Thu,  6 Dec 2018 13:58:57 -0800
Message-Id: <7fc4650cc2417d7a2907a000f6f88240baa42018.1544131943.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544131943.git.horms+renesas@verge.net.au>
References: <cover.1544131943.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141220_341256_F95A5F05 
X-CRM114-Status: GOOD (  14.34  )
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

To control power to a power domain, the System Controller (SYSC) needs
the corresponding interrupt source to be enabled, but masked, to prevent
the CPU from receiving it.

Currently this is handled in the driver's probe() routine, and set up
for every domain present, even if it will not be controlled directly by
SYSC (CPU domains are powered through the APMU on R-Car Gen2 and later).

On R-Car Gen3, PSCI powers down the SoC during system suspend, thus
losing any configured interrupt state.  Hence after system resume, power
domains not controlled through the APMU (e.g. A3IR, A3VC, A3VP) fail to
power up.

Fix this by replacing the global interrupt setup in the probe() routine
by a domain-specific interrupt setup in rcar_sysc_power(), where the
domain's power is actually controlled.  This brings the code more in
line with the flowchart in the Hardware User's Manual.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/rcar-sysc.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 123e553510e8..0c80fab4f8de 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -105,6 +105,15 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
 
 	spin_lock_irqsave(&rcar_sysc_lock, flags);
 
+	/*
+	 * The interrupt source needs to be enabled, but masked, to prevent the
+	 * CPU from receiving it.
+	 */
+	iowrite32(ioread32(rcar_sysc_base + SYSCIMR) | isr_mask,
+		  rcar_sysc_base + SYSCIMR);
+	iowrite32(ioread32(rcar_sysc_base + SYSCIER) | isr_mask,
+		  rcar_sysc_base + SYSCIER);
+
 	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
 
 	/* Submit power shutoff or resume request until it was accepted */
@@ -324,7 +333,6 @@ static int __init rcar_sysc_pd_init(void)
 	const struct of_device_id *match;
 	struct rcar_pm_domains *domains;
 	struct device_node *np;
-	u32 syscier, syscimr;
 	void __iomem *base;
 	unsigned int i;
 	int error;
@@ -363,24 +371,6 @@ static int __init rcar_sysc_pd_init(void)
 	domains->onecell_data.num_domains = ARRAY_SIZE(domains->domains);
 	rcar_sysc_onecell_data = &domains->onecell_data;
 
-	for (i = 0, syscier = 0; i < info->num_areas; i++)
-		syscier |= BIT(info->areas[i].isr_bit);
-
-	/*
-	 * Mask all interrupt sources to prevent the CPU from receiving them.
-	 * Make sure not to clear reserved bits that were set before.
-	 */
-	syscimr = ioread32(base + SYSCIMR);
-	syscimr |= syscier;
-	pr_debug("%pOF: syscimr = 0x%08x\n", np, syscimr);
-	iowrite32(syscimr, base + SYSCIMR);
-
-	/*
-	 * SYSC needs all interrupt sources enabled to control power.
-	 */
-	pr_debug("%pOF: syscier = 0x%08x\n", np, syscier);
-	iowrite32(syscier, base + SYSCIER);
-
 	for (i = 0; i < info->num_areas; i++) {
 		const struct rcar_sysc_area *area = &info->areas[i];
 		struct rcar_sysc_pd *pd;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
