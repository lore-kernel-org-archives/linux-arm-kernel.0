Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C72C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:54:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68C921916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mhGYPTpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68C921916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4fc0gmuxe8bkQZG+C0a4CKUFVisP4KRH+D1usN3C4ok=; b=mhGYPTpHngXOVA
	Z7h8Rv2g4ndsrSp+mY1MS6XA3EeCFWCJ5bOZr8zmJbSff04W0sQgL2MV0dXvT8/e1R4WSTJ1qjKul
	3NtHuX2xS9dRZFPrC+4vXq9Li+JHFNy/6Og8tQCSEqe70yT4IHXfPNUg5Cq5/N26uWsWpTk1ftu1K
	6cr3m0YuP0YS9lLqPzqa5BkxAJw+GR88ojL6uNaRCMZPnfIL5lZr1k8IdfCTR0Zryr9mZ6B8Na9ZB
	HFkbcHnAgtlpOjxTopnhvnFhroGy7ld5wWclFSOl0frqF+mmNlskW0/VEHOPKoiawX1aRxbkaqG2M
	C6yYvdBLVdc7rPv3Xn/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs2rv-0004ZT-RS; Fri, 08 Feb 2019 09:54:47 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs2qx-0003UT-6p
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 09:53:53 +0000
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4163A200008;
 Fri,  8 Feb 2019 09:53:44 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 7/9] drm/sun4i: dsi: Rework a bit the hblk calculation
Date: Fri,  8 Feb 2019 10:53:20 +0100
Message-Id: <d79a21b09847579ce907212a59737af21a729dd0.1549619502.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.23dbbc9b943ff8f36253ac7c617e2eda142b1b69.1549619502.git-series.maxime.ripard@bootlin.com>
References: <cover.23dbbc9b943ff8f36253ac7c617e2eda142b1b69.1549619502.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_015348_074673_9C2A28BC 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: bbrezillon@kernel.org, dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It turns out that the hblk calculation actually follows a similar pattern
than the other packets. Rework a bit the calculation and add a comment.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 8e6392831e9d..e0288e7dc64e 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -488,9 +488,13 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
 
 	/*
-	 * hblk seems to be the line + porches length.
+	 * The blanking is set using a sync event (4 bytes) and a
+	 * blanking packet (4 bytes + payload + 2 bytes). Its minimal
+	 * size is therefore 10 bytes.
 	 */
-	hblk = mode->htotal * Bpp - hsa;
+#define HBLK_PACKET_OVERHEAD	10
+	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
+		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp - HBLK_PACKET_OVERHEAD);
 
 	/*
 	 * And I'm not entirely sure what vblk is about. The driver in
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
