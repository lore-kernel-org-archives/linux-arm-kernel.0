Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00944C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:56:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01522087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KeVjyWtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01522087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JeUxkcOqenoykFh8X3joQ5SjjQRS2tgadpLtdTxIp10=; b=KeVjyWtF/k9FYZ
	OZV+JxT3swJx2tK6QJJDNXne9aNbY/uH1hULFxQJBqoR/Sj5YB4DCP9beKoUmSQPl7QN9n7OZut6N
	l4fgCGkzIZQ6iLEiTejBX/eqy8EABQAw/6vAlvtZxDk4nuurYmtOccqT5O+P2U2n9FWWUp2oa+QTz
	RITXmy9V/v0oAvfc5WWp+urcadXRabPEjNSu5isY/2ZmSVqCbP4a/tbY2ozn41rMsfhg87P1Q4fkx
	Za6I/pnHq3XYowizjYYWqMzrbUHvNq4FsOexbVaha2HEe09GqoNnwCN6hzFui5hKQuQfBQVbFA6gs
	YjVi3LZN5vHPQ/kyLzHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkVYy-0003ya-FD; Fri, 18 Jan 2019 14:56:04 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVVV-00074n-61
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:53:04 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 17F4B225A0; Fri, 18 Jan 2019 15:52:28 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 7562120C7E;
 Fri, 18 Jan 2019 15:51:46 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v5 21/23] drm/sun4i: frontend: Move the FIR filter
 phases to our quirks
Date: Fri, 18 Jan 2019 15:51:31 +0100
Message-Id: <20190118145133.21281-22-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_065229_996241_F8F3B3B1 
X-CRM114-Status: GOOD (  13.99  )
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The FIR filters phase depend on the SoC, so let's move it to our quirks
structure instead of removing them.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 28 ++++++++++++++++++++------
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  5 +++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 86c5033102b9..4a215d5202e2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -438,12 +438,18 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	 * I have no idea what this does exactly, but it seems to be
 	 * related to the scaler FIR filter phase parameters.
 	 */
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZPHASE_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_HORZPHASE_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE0_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE0_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE1_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE1_REG, 0x400);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZPHASE_REG,
+		     frontend->data->ch_phase[0].horzphase);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_HORZPHASE_REG,
+		     frontend->data->ch_phase[1].horzphase);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE0_REG,
+		     frontend->data->ch_phase[0].vertphase[0]);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE0_REG,
+		     frontend->data->ch_phase[1].vertphase[0]);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE1_REG,
+		     frontend->data->ch_phase[0].vertphase[1]);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE1_REG,
+		     frontend->data->ch_phase[1].vertphase[1]);
 
 	/*
 	 * Checking the input format is sufficient since we currently only
@@ -677,6 +683,16 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops = {
 };
 
 static const struct sun4i_frontend_data sun8i_a33_frontend = {
+	.ch_phase		= {
+		{
+			.horzphase = 0x400,
+			.vertphase = { 0x400, 0x400 },
+		},
+		{
+			.horzphase = 0x400,
+			.vertphase = { 0x400, 0x400 },
+		},
+	},
 	.has_coef_access_ctrl	= true,
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index e332bc1c6b68..0c382c1ddb0f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -115,6 +115,11 @@ struct reset_control;
 struct sun4i_frontend_data {
 	bool	has_coef_access_ctrl;
 	bool	has_coef_rdy;
+
+	struct {
+		u32	horzphase;
+		u32	vertphase[2];
+	} ch_phase[2];
 };
 
 struct sun4i_frontend {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
