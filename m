Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6A9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:13:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9B12082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MnMAcPYi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Pd0iD4MK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9B12082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/2lG6aW+S9PNFm2Vx00bgOBU4Xb2RE7RjiccAGzKNu8=; b=MnMAcPYiH7IKrFz5uJXWE38fhY
	Ei8eIgWGz6CpUWOZPDmYK21csV1csvaPTBN+m4iSIU8jx6T2jQpoWGoWJXAehHACh9PfjGcxhLBHK
	ybVKo4Rq2GV4hGVEH4qycLbENzDZ2OPQI1qetEBDTre5Ar5VDboAD2c/VoOYCkEKRg/B2O4IcEQKi
	6HQ1IjhGauoh9RicKkizg338rVZnjWQ4K6kt17pUqoLSCx/x5vP3XStvPRdml8udBaxzC+g/mI42r
	Ol4sWnIMLNs/b838+TPTIhc6RTnYRBqpydXtSmGz+Rz4knX9iGNSwCwB++2YeIbd1dmvQTrIntS0I
	UufZcb1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1tP-0008Fg-JA; Thu, 06 Dec 2018 22:13:11 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1rO-00021y-Ly
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:11:21 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id C1CA125BF40;
 Fri,  7 Dec 2018 08:58:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133540; bh=H+UsuF/FWws5hcbwk31WS9pXGcpzyZQUOhEEBRSW2J4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pd0iD4MKt7szcR63Im3W1bze4obXuQaGiQyJCRCvVgcoJrMIatG2se9vthWjYbt5B
 fGxezanSXokGcr0lvKdHaX869NB+Fkg1r5BOps9GofHPgXbusZpxQ1aZ8cPIdsX77R
 naF9+3YelC18x9hnQJcibQ/HeQkpHPgU31JGtXAw=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 3385FE22BAF; Thu,  6 Dec 2018 13:58:58 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 6/9] soc: renesas: r8a77990-sysc: Fix initialization order of
 3DG-{A, B}
Date: Thu,  6 Dec 2018 13:58:54 -0800
Message-Id: <b0d7fbf8b174168c580bb310964c3c809e5569a9.1544131943.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544131943.git.horms+renesas@verge.net.au>
References: <cover.1544131943.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141107_778254_143C6FAF 
X-CRM114-Status: GOOD (  12.63  )
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

The workaround for the wrong hierarchy of the 3DG-{A,B} power
domains on R-Car E3 ES1.0 corrected the parent domains.
However, the 3DG-{A,B} power domains were still initialized and powered
in the wrong order, causing 3DG operation to fail.

Fix this by changing the order in the table at runtime, when running on
an affected SoC.

Fixes: 086b399965a7ee7e ("soc: renesas: r8a77990-sysc: Add workaround for 3DG-{A,B}")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/r8a77990-sysc.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/renesas/r8a77990-sysc.c b/drivers/soc/renesas/r8a77990-sysc.c
index 15579ebc5ed2..664b244eb1dd 100644
--- a/drivers/soc/renesas/r8a77990-sysc.c
+++ b/drivers/soc/renesas/r8a77990-sysc.c
@@ -28,19 +28,6 @@ static struct rcar_sysc_area r8a77990_areas[] __initdata = {
 	{ "3dg-b",	0x100, 1, R8A77990_PD_3DG_B,	R8A77990_PD_3DG_A },
 };
 
-static void __init rcar_sysc_fix_parent(struct rcar_sysc_area *areas,
-					unsigned int num_areas, u8 id,
-					int new_parent)
-{
-	unsigned int i;
-
-	for (i = 0; i < num_areas; i++)
-		if (areas[i].isr_bit == id) {
-			areas[i].parent = new_parent;
-			return;
-		}
-}
-
 /* Fixups for R-Car E3 ES1.0 revision */
 static const struct soc_device_attribute r8a77990[] __initconst = {
 	{ .soc_id = "r8a77990", .revision = "ES1.0" },
@@ -50,12 +37,10 @@ static const struct soc_device_attribute r8a77990[] __initconst = {
 static int __init r8a77990_sysc_init(void)
 {
 	if (soc_device_match(r8a77990)) {
-		rcar_sysc_fix_parent(r8a77990_areas,
-				     ARRAY_SIZE(r8a77990_areas),
-				     R8A77990_PD_3DG_A, R8A77990_PD_3DG_B);
-		rcar_sysc_fix_parent(r8a77990_areas,
-				     ARRAY_SIZE(r8a77990_areas),
-				     R8A77990_PD_3DG_B, R8A77990_PD_ALWAYS_ON);
+		/* Fix incorrect 3DG hierarchy */
+		swap(r8a77990_areas[7], r8a77990_areas[8]);
+		r8a77990_areas[7].parent = R8A77990_PD_ALWAYS_ON;
+		r8a77990_areas[8].parent = R8A77990_PD_3DG_B;
 	}
 
 	return 0;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
