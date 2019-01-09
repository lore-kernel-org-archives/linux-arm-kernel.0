Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74E0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:20:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B712075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ngfY7uhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B712075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I3JXksG8v8bZI1jFYOOdrgZBRcmkNX5E9438AT1E1YQ=; b=ngfY7uhwMSU8da
	g6JuzM637JgbKI82eB1iouItFGsacM+vo3KGRMwPW1xGhqJ4MPCVIbmGWUR2v/1YUM8JpVlzChWAU
	pjbhM2bLf3GsR464xgxTDw2cI/y02ApsuE5NBWrPUdM/rNEhik/inURcR7i1u07na7hqgewhhgMjR
	2ew4sq9VkrLghfbvASRxBp1iwKdyz2QWzuXeXO3XO4JTti9RkOKJZZfY39mMbq4qqn1sGQ3micKgz
	R0/n+3KEUurm/HdjhqT3sOg1t/rwwk1oITWiMKAavJR2r9wkgyuvBcXh7a4yNMLzedkEa4yCfs6gq
	mrtxDcoyMEYBTermWDHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEiq-0000Y0-UR; Wed, 09 Jan 2019 14:20:44 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEid-0000MA-LW
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:20:33 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E9EEC20A11; Wed,  9 Jan 2019 15:20:28 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 4BA65209C2;
 Wed,  9 Jan 2019 15:20:18 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH 2/2] media: cedrus: Allow using the current dst buffer as
 reference
Date: Wed,  9 Jan 2019 15:19:20 +0100
Message-Id: <20190109141920.12677-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109141920.12677-1-paul.kocialkowski@bootlin.com>
References: <20190109141920.12677-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_062032_017771_1FC83993 
X-CRM114-Status: GOOD (  12.55  )
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Courbot <acourbot@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Li <ayaka@soulik.info>,
 Tomasz Figa <tfiga@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It was reported that some cases of interleaved video decoding require
using the current destination buffer as a reference. However, this is
no longer possible after the move to vb2_find_timestamp because only
dequeued and done buffers are considered.

Add a helper in our driver that also considers the current destination
buffer before resorting to vb2_find_timestamp and use it in MPEG-2.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c   | 13 +++++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus_dec.h   |  2 ++
 drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c | 10 ++++++----
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
index 443fb037e1cf..2c295286766c 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
@@ -22,6 +22,19 @@
 #include "cedrus_dec.h"
 #include "cedrus_hw.h"
 
+int cedrus_reference_index_find(struct vb2_queue *queue,
+				struct vb2_buffer *vb2_buf, u64 timestamp)
+{
+	/*
+	 * Allow using the current capture buffer as reference, which can occur
+	 * for field-coded pictures.
+	 */
+	if (vb2_buf->timestamp == timestamp)
+		return vb2_buf->index;
+	else
+		return vb2_find_timestamp(queue, timestamp, 0);
+}
+
 void cedrus_device_run(void *priv)
 {
 	struct cedrus_ctx *ctx = priv;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.h b/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
index d1ae7903677b..8d0fc248220f 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.h
@@ -16,6 +16,8 @@
 #ifndef _CEDRUS_DEC_H_
 #define _CEDRUS_DEC_H_
 
+int cedrus_reference_index_find(struct vb2_queue *queue,
+				struct vb2_buffer *vb2_buf, u64 timestamp);
 void cedrus_device_run(void *priv);
 
 #endif
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
index cb45fda9aaeb..81c66a8aa1ac 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
@@ -10,6 +10,7 @@
 #include <media/videobuf2-dma-contig.h>
 
 #include "cedrus.h"
+#include "cedrus_dec.h"
 #include "cedrus_hw.h"
 #include "cedrus_regs.h"
 
@@ -159,8 +160,8 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
 
 	/* Forward and backward prediction reference buffers. */
-	forward_idx = vb2_find_timestamp(cap_q,
-					 slice_params->forward_ref_ts, 0);
+	forward_idx = cedrus_reference_index_find(cap_q, &run->dst->vb2_buf,
+						  slice_params->forward_ref_ts);
 
 	fwd_luma_addr = cedrus_dst_buf_addr(ctx, forward_idx, 0);
 	fwd_chroma_addr = cedrus_dst_buf_addr(ctx, forward_idx, 1);
@@ -168,8 +169,9 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_addr);
 	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR, fwd_chroma_addr);
 
-	backward_idx = vb2_find_timestamp(cap_q,
-					  slice_params->backward_ref_ts, 0);
+	backward_idx = cedrus_reference_index_find(cap_q, &run->dst->vb2_buf,
+						   slice_params->backward_ref_ts);
+
 	bwd_luma_addr = cedrus_dst_buf_addr(ctx, backward_idx, 0);
 	bwd_chroma_addr = cedrus_dst_buf_addr(ctx, backward_idx, 1);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
