Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8193C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:40:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8710E206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PDQqcYI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8710E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yhbnK7C910QkEk2CJGp+eMmv0R6FLir65f3nGIbuCSk=; b=PDQqcYI6oP5MOx
	u0NpzRBk+WC04JQR8PaIqrxuHhqY/iI0nWVSGCC3D0H2XSgRSCEu/TzEUkpX+Dk5Mnbsr19DGIQQn
	o+C/UxHQ5aU7t7RAdvpbYmbpeJTMgQ+dGQsNQWb5lUj3FD3FU8PZroyNvsd4w0UtEPu/IW71/7iXg
	W/5BEIRqLXy/2E4RjC/Es6Pzq4FS/ppSupryH8JF+7YqcODh6ou9CwnRvqHwEe0DTSy3wtb/aQvCR
	Flu3/22L3wBIg4EuMpbMBG5VePjW8SCv7YWUlX6Xy3KWegCHaB9c+ygxYfFs7xvaANzcymgI+vsYq
	BWYCznjSRRM9ePbnwnDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSjZ-0000Ry-1I; Wed, 05 Dec 2018 08:40:41 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSh0-0004uH-PR
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:38:13 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 1BACC20D23; Wed,  5 Dec 2018 09:37:56 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 59AC020DC0;
 Wed,  5 Dec 2018 09:37:29 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/22] drm/sun4i: Move access control before setting the
 register as documented
Date: Wed,  5 Dec 2018 09:36:58 +0100
Message-Id: <20181205083703.21488-18-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_003803_585154_192E9F4F 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-sunxi@googlegroups.com,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

Unlike what is currently being done, the ACCESS_CTRL bit documentation asks
that this bit should be set before modifying any register. The code in the
BSP also does this, so make sure we do this as well.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 1153539f3aef..88ac77518610 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -75,6 +75,10 @@ static void sun4i_frontend_scaler_init(struct sun4i_frontend *frontend)
 {
 	int i;
 
+	regmap_write_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
+			  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL,
+			  SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL);
+
 	for (i = 0; i < 32; i++) {
 		regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZCOEF0_REG(i),
 			     sun4i_frontend_horz_coef[2 * i]);
@@ -90,9 +94,6 @@ static void sun4i_frontend_scaler_init(struct sun4i_frontend *frontend)
 			     sun4i_frontend_vert_coef[i]);
 	}
 
-	regmap_update_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
-			   SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL,
-			   SUN4I_FRONTEND_FRM_CTRL_COEF_ACCESS_CTRL);
 }
 
 int sun4i_frontend_init(struct sun4i_frontend *frontend)
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
