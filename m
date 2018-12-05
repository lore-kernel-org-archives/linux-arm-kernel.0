Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD713C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:39:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC71620850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NxRdTOF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC71620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gZVm/XiWYttkl1cGvUglixPnOhohIHL8QxypK0cffi4=; b=NxRdTOF7ceEM9U
	VSdTKgeVccCED/mTEw2KxKrIQxscCy86Z0tdjVcjnILpYyL6xcbM2G9TvpodJV95zGmzHjphykjpX
	O9h0ZDmHZzCCufirI8dts1J9sAO8Db/Mb80UpiYQU94PvpW167MHXhgRIgCBtwkQhBwUC8SJy5P89
	xGGKaEILVJkhu3jn6QoVitc0FjYg0seA8vXE9Ga5cyIl3JCzUmgphjNwdmri4qVTbefmq4KeRczYh
	HMbfN/gumFSTBsv4aHaswPFmCSpywBitrOu4Mz6rIbGqtgV+OjWbLB0tPJP/FfpyZqR1h9V9THf80
	0EPzAMiTeCqlStx/2GeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSig-0006pW-6c; Wed, 05 Dec 2018 08:39:46 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSgx-0004rN-2R
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:38:02 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id ED7DE20E36; Wed,  5 Dec 2018 09:37:45 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6C9E420A58;
 Wed,  5 Dec 2018 09:37:26 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/22] drm/sun4i: frontend: Determine input format based on
 colorspace
Date: Wed,  5 Dec 2018 09:36:46 +0100
Message-Id: <20181205083703.21488-6-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_003759_608388_D70A26D2 
X-CRM114-Status: GOOD (  14.06  )
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

Since all the RGB input formats have the same value for the DATA_FMT
field of the INPUT_FMT register, we can group them when the format is
known to be RGB. Here, we assume that a non-YUV format is RGB, because
the hardware does not support any other colorspace than RGB and YUV.

Use the DRM format info structure to check whether the format uses a
YUV colorspace.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index dd5af3019099..7c7a5ea0cf58 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -108,14 +108,12 @@ static int
 sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
 				       u32 *val)
 {
-	switch (format->format) {
-	case DRM_FORMAT_XRGB8888:
+	if (!format->is_yuv)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
-		return 0;
-
-	default:
+	else
 		return -EINVAL;
-	}
+
+	return 0;
 }
 
 static int
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
