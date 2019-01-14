Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6D2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:40:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6542E20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i0IQ545/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6542E20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z6BU97wAu+z0tYyARh7koHoLHaODGLAqTsjJdWgVC2o=; b=i0IQ545/VhASQC
	S6UFhRurgx2eGCB5F24fjQEqX3Q5fNlInXoCC2okvLJyZyjI3vAVu8bTS83NYYw6bKdEm21uV9G9O
	0x4A2sGuaVvWCc4ya73Hue0KSedQ3/tuN+6RSz46T2uPVV9578q35IEmMrTgVeQEex1kFTP4xaD/Y
	W5jSnbAqOyNXg0SJfFfORvY+NLrK7Rtvu1Ni6UmFKsB2RpKrqBZyf0wxHqQ26mfd23xYLdtnB/08K
	BbX5afu47r8XXPCNG+k3IRD+PfmUY+wZl8i9tUEw2R8lsot1pAMKIflWOS8ibRH+RN/qfo1xB313J
	6OnOpxM+AnJO/h0axqGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2TO-0004iA-J3; Mon, 14 Jan 2019 13:40:14 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2SI-000366-F0
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:39:10 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A9B9D20A0F; Mon, 14 Jan 2019 14:39:01 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 3D02E20728;
 Mon, 14 Jan 2019 14:39:01 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH RFC 3/4] media: cedrus: Request access to reference buffers
 when decoding
Date: Mon, 14 Jan 2019 14:38:38 +0100
Message-Id: <20190114133839.29967-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114133839.29967-1-paul.kocialkowski@bootlin.com>
References: <20190114133839.29967-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_053906_811764_08B9B301 
X-CRM114-Status: GOOD (  13.38  )
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
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Alexandre Courbot <acourbot@chromium.org>, Pawel Osciak <pawel@osciak.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Randy Li <ayaka@soulik.info>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Because we need to request and release access to reference buffers
that are backed by a dma-buf import, keep track of the buffers used
as reference and add the appropriate calls in the device_run and
job_done m2m callbacks. The latter is introduced for this purpose.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c    |  1 +
 drivers/staging/media/sunxi/cedrus/cedrus.h    |  1 +
 .../staging/media/sunxi/cedrus/cedrus_dec.c    | 18 ++++++++++++++++++
 .../staging/media/sunxi/cedrus/cedrus_dec.h    |  1 +
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c  |  8 ++++++++
 5 files changed, 29 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index ff11cbeba205..a2c75eb01c2c 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -250,6 +250,7 @@ static const struct video_device cedrus_video_device = {
 
 static const struct v4l2_m2m_ops cedrus_m2m_ops = {
 	.device_run	= cedrus_device_run,
+	.job_done	= cedrus_job_done,
 };
 
 static const struct media_device_ops cedrus_m2m_media_ops = {
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 4aedd24a9848..c1ce3c4ae2a1 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -77,6 +77,7 @@ struct cedrus_ctx {
 	struct v4l2_ctrl		**ctrls;
 
 	struct vb2_buffer		*dst_bufs[VIDEO_MAX_FRAME];
+	bool				reference_bufs[VIDEO_MAX_FRAME];
 };
 
 struct cedrus_dec_ops {
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
index 2c295286766c..90bf51e71f4f 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
@@ -41,6 +41,7 @@ void cedrus_device_run(void *priv)
 	struct cedrus_dev *dev = ctx->dev;
 	struct cedrus_run run = {};
 	struct media_request *src_req;
+	unsigned int i;
 
 	run.src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	run.dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
@@ -63,10 +64,17 @@ void cedrus_device_run(void *priv)
 		break;
 	}
 
+	for (i = 0; i < VIDEO_MAX_FRAME; i++)
+		ctx->reference_bufs[i] = false;
+
 	v4l2_m2m_buf_copy_data(run.src, run.dst, true);
 
 	dev->dec_ops[ctx->current_codec]->setup(ctx, &run);
 
+	for (i = 0; i < VIDEO_MAX_FRAME; i++)
+		if (ctx->reference_bufs[i] && ctx->dst_bufs[i])
+			vb2_buffer_access_request(ctx->dst_bufs[i]);
+
 	/* Complete request(s) controls if needed. */
 
 	if (src_req)
@@ -74,3 +82,13 @@ void cedrus_device_run(void *priv)
 
 	dev->dec_ops[ctx->current_codec]->trigger(ctx);
 }
+
+void cedrus_job_done(void *priv)
+{
+	struct cedrus_ctx *ctx = priv;
+	unsigned int i;
+
+	for (i = 0; i < VIDEO_MAX_FRAME; i++)
+		if (ctx->reference_bufs[i] && ctx->dst_bufs[i])
+			vb2_buffer_access_release(ctx->dst_bufs[i]);
+}
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.h b/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
index 8d0fc248220f..9265f28e6dbe 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
@@ -19,5 +19,6 @@
 int cedrus_reference_index_find(struct vb2_queue *queue,
 				struct vb2_buffer *vb2_buf, u64 timestamp);
 void cedrus_device_run(void *priv);
+void cedrus_job_done(void *priv);
 
 #endif
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
index 81c66a8aa1ac..2e7deded17aa 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
@@ -162,6 +162,10 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	/* Forward and backward prediction reference buffers. */
 	forward_idx = cedrus_reference_index_find(cap_q, &run->dst->vb2_buf,
 						  slice_params->forward_ref_ts);
+	if (forward_idx < 0)
+		return;
+
+	ctx->reference_bufs[forward_idx] = true;
 
 	fwd_luma_addr = cedrus_dst_buf_addr(ctx, forward_idx, 0);
 	fwd_chroma_addr = cedrus_dst_buf_addr(ctx, forward_idx, 1);
@@ -171,6 +175,10 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 
 	backward_idx = cedrus_reference_index_find(cap_q, &run->dst->vb2_buf,
 						   slice_params->backward_ref_ts);
+	if (forward_idx < 0)
+		return;
+
+	ctx->reference_bufs[backward_idx] = true;
 
 	bwd_luma_addr = cedrus_dst_buf_addr(ctx, backward_idx, 0);
 	bwd_chroma_addr = cedrus_dst_buf_addr(ctx, backward_idx, 1);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
