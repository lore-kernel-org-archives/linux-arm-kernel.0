Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B9C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:53:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE832085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CT4+Mvu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE832085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=J/VMuZLwv5YQzcM+5DntO9q9xT10jghHxX39IOUbISU=; b=CT4+Mvu0vBli4c
	GDb+aKfvR+RmTE8zoYz1z7YwE9AWTfpqfOUkfVsBvhymxrX10WUnbN7Zb8J+ZrBZrcBNPQn1ej2wz
	nMjST7eXAYT3Uq3ktLXF1CpgQmmaK5LJMEnqr/orY6x+V6ADbtzxs95ZAEUeUlcLiG5L53yFWwoic
	d5WJk6L+Lc1LFIbgZGgJdViJoaj71s59AiVaREt6wtOy5KBjukSsf1Nx6eo33ansbwm8w/QeNH4is
	rU81uep1h7IyOxI6sSekBtmmLfqxb0L8LD2wM9qoeSjqJa9I+EBISEW172QUdmoINe4jAGYYQ41WK
	DR3uz4LAhTURmF/IW2ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbhA-0001KK-2Z; Thu, 24 Jan 2019 09:53:12 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbgw-0001Az-HA
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:53:00 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id CD6DC2084E; Thu, 24 Jan 2019 10:52:54 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 5C68520654;
 Thu, 24 Jan 2019 10:52:44 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH 1/2] media: vb2: Keep dma-buf buffers mapped until they are
 freed
Date: Thu, 24 Jan 2019 10:51:55 +0100
Message-Id: <20190124095156.21898-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_015258_702972_E78032C8 
X-CRM114-Status: GOOD (  14.48  )
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
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pawel Osciak <pawel@osciak.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Tomasz Figa <tfiga@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>, Pawel Osciak <posciak@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Pawel Osciak <posciak@chromium.org>

When using vb2 for video decoding, dequeued capture buffers may still
be accessed by the hardware: this is the case when they are used as
reference frames for decoding subsequent frames.

When the buffer is imported with dma-buf, it needs to be mapped before
access. Until now, it was mapped when queuing and unmapped when
dequeuing, which doesn't work for access as a reference frames.

One way to solve this would be to map the buffer again when it is
needed as a reference, but the mapping/unmapping operations can
seriously impact performance. As a result, map the buffer once (when it
is first needed when queued) and keep it mapped until it is freed.

Signed-off-by: Pawel Osciak <posciak@chromium.org>
Reviewed-on: https://chromium-review.googlesource.com/334103
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
[Paul: Updated for mainline and changed commit message]
---
 drivers/media/common/videobuf2/videobuf2-core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 70e8c3366f9c..ce9294a635cc 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1196,6 +1196,9 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
 	 * userspace knows sooner rather than later if the dma-buf map fails.
 	 */
 	for (plane = 0; plane < vb->num_planes; ++plane) {
+		if (vb->planes[plane].dbuf_mapped)
+			continue;
+
 		ret = call_memop(vb, map_dmabuf, vb->planes[plane].mem_priv);
 		if (ret) {
 			dprintk(1, "failed to map dmabuf for plane %d\n",
@@ -1758,14 +1761,6 @@ static void __vb2_dqbuf(struct vb2_buffer *vb)
 
 	vb->state = VB2_BUF_STATE_DEQUEUED;
 
-	/* unmap DMABUF buffer */
-	if (q->memory == VB2_MEMORY_DMABUF)
-		for (i = 0; i < vb->num_planes; ++i) {
-			if (!vb->planes[i].dbuf_mapped)
-				continue;
-			call_void_memop(vb, unmap_dmabuf, vb->planes[i].mem_priv);
-			vb->planes[i].dbuf_mapped = 0;
-		}
 	call_void_bufop(q, init_buffer, vb);
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
