Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:19:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55568214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UouXDLBz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="PBJu1RiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55568214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vqTDYMt0dkMPVVZqyQe1gY0f1Bh8fAW6diW3Ej8NypY=; b=UouXDLBzlNhvWIv8JOyK1YpDc3
	HubB/CamM9Gze/xfeUK9WYJ5+we5mQFAX91lg+21Crsn/x93V4BJmAjBMoHZyK8KXg6tBigreh82j
	nXpwUfmzIcd4KdJ0vZZyt8K8Y3lTjKQ6C7NODbzklf+3XEroW7OkFwnodiJINLTaEy26RpSKm5ROp
	6e81GaBmTjLMMvmrKPe4vrALnwt4koIYMBDFOucFsaRrEozpI5frSl9TS3RRxgMlH4RZuK6wzym7K
	dg3HL87thrhcZBz67OmiDmgWU2cDThpPaJ27o+80u9eYW8uL4iB9Dr6mVV2vSMezO/1kLOfEt0BZq
	1Pt80w5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghXQi-0000jL-Ay; Thu, 10 Jan 2019 10:19:16 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghXQF-0000Eh-M4
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 10:18:52 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 05F9D25BED4;
 Thu, 10 Jan 2019 21:18:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1547115521; bh=YCDZjYmxk4Z3QPKyyrQSn8Ri32Gtj0IKGnbSmDb49qI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PBJu1RiUOSj8FSyBN5Iu9YwiJTo8mu7F0CzNUNu7QgpFZiW+BaQY38vzmq3sZgZHA
 BIOrrMJG4MvZyivLqh/AJj7BCkMFp9kJqDtsjoARc7t/nevRYm1MAYXRbhiJEXJpFX
 cmbBl49pRqzMll0vm6+KP8FMTCQGpCGg5VoE9PYw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 428A59402F6; Thu, 10 Jan 2019 11:18:39 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] soc: renesas: r8a774c0-sysc: Fix initialization order of
 3DG-{A, B}
Date: Thu, 10 Jan 2019 11:18:38 +0100
Message-Id: <a64597227d0de5610407fcc95dc835745a53f5d0.1547115367.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1547115367.git.horms+renesas@verge.net.au>
References: <cover.1547115367.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_021848_160789_9F2DCE45 
X-CRM114-Status: GOOD (  13.98  )
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
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Biju Das <biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

The workaround for the wrong hierarchy of the 3DG-{A,B} power domains on
RZ/G2E ES1.0 corrected the parent domains. However, the 3DG-{A,B} power
domains were still initialized and powered in the wrong order, causing
3DG operation to fail.

Fix this by changing the order in the table at runtime, when running on
an affected SoC.

This work is based on the work done by Geert for R-Car E3.

Fixes: f37d211c687588328 ("soc: renesas: rcar-sysc: Add r8a774c0 support")

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/r8a774c0-sysc.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/renesas/r8a774c0-sysc.c b/drivers/soc/renesas/r8a774c0-sysc.c
index e1ac4c0f6640..11050e17ea81 100644
--- a/drivers/soc/renesas/r8a774c0-sysc.c
+++ b/drivers/soc/renesas/r8a774c0-sysc.c
@@ -28,19 +28,6 @@ static struct rcar_sysc_area r8a774c0_areas[] __initdata = {
 	{ "3dg-b",	0x100, 1, R8A774C0_PD_3DG_B,	R8A774C0_PD_3DG_A },
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
 /* Fixups for RZ/G2E ES1.0 revision */
 static const struct soc_device_attribute r8a774c0[] __initconst = {
 	{ .soc_id = "r8a774c0", .revision = "ES1.0" },
@@ -50,12 +37,10 @@ static const struct soc_device_attribute r8a774c0[] __initconst = {
 static int __init r8a774c0_sysc_init(void)
 {
 	if (soc_device_match(r8a774c0)) {
-		rcar_sysc_fix_parent(r8a774c0_areas,
-				     ARRAY_SIZE(r8a774c0_areas),
-				     R8A774C0_PD_3DG_A, R8A774C0_PD_3DG_B);
-		rcar_sysc_fix_parent(r8a774c0_areas,
-				     ARRAY_SIZE(r8a774c0_areas),
-				     R8A774C0_PD_3DG_B, R8A774C0_PD_ALWAYS_ON);
+		/* Fix incorrect 3DG hierarchy */
+		swap(r8a774c0_areas[6], r8a774c0_areas[7]);
+		r8a774c0_areas[6].parent = R8A774C0_PD_ALWAYS_ON;
+		r8a774c0_areas[7].parent = R8A774C0_PD_3DG_B;
 	}
 
 	return 0;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
