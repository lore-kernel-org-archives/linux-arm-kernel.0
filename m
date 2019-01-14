Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43572C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:39:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EDC206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BzLGsBQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EDC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xJUqO1uqF5U42UeEr1+2EPvKBWTL/7IOyoVa6MpL+D8=; b=BzLGsBQsakS9z9
	71krW8xj9bIQvvaBtPIpuw6lj/oubuUO2PXO99yBaKRQ/0l6ZLNYWEeqHVM0K6QHia1ekTHxkLvno
	B/dAr8FjfFhD8vXjUHGSJ+hiJqI1mlO3cfLVThxJjsCzpUKo8p2JZUf9oIhvu6DATPQP/VeoY3H+H
	5CinuHak6KTmcAorEXMICaaaWhPzIxVwG+qTDQV9HpOl3IbqBYS24jUXlZSiec6QTU3KD3tCPS7v0
	Sim3c047y86jMlSQ1X1lAVlqKVp1eJYtg+zxf6crQm7Q0P53l5xhbI4/4MQtAjV+6euVd/LGKonLm
	opGjoEnEx3N0uO8IVPIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2Su-0003fC-JY; Mon, 14 Jan 2019 13:39:44 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2SI-000369-FJ
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:39:09 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E27AA20955; Mon, 14 Jan 2019 14:39:00 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6D91620728;
 Mon, 14 Jan 2019 14:39:00 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH RFC 1/4] media: vb2: Add helpers to access unselected buffers
Date: Mon, 14 Jan 2019 14:38:36 +0100
Message-Id: <20190114133839.29967-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114133839.29967-1-paul.kocialkowski@bootlin.com>
References: <20190114133839.29967-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_053906_817052_819F5CF5 
X-CRM114-Status: GOOD (  12.74  )
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

Introduce helpers to request and release access to buffers that are
not currently selected as current output or capture buffers.

This is useful to ensure proper access to buffers imported via dma-buf
that are used as reference and thus require associated map/unmap calls
before access.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 46 +++++++++++++++++++
 include/media/videobuf2-core.h                | 15 ++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 70e8c3366f9c..2a0c5de4d683 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -986,6 +986,52 @@ void vb2_discard_done(struct vb2_queue *q)
 }
 EXPORT_SYMBOL_GPL(vb2_discard_done);
 
+int vb2_buffer_access_request(struct vb2_buffer *vb)
+{
+	struct vb2_queue *q = vb->vb2_queue;
+	unsigned int plane;
+	int ret;
+
+	/* Only dmabuf-imported buffers need to be mapped before access. */
+	if (q->memory != VB2_MEMORY_DMABUF)
+		return -EINVAL;
+
+	for (plane = 0; plane < vb->num_planes; ++plane) {
+		if (vb->planes[plane].dbuf_mapped)
+			continue;
+
+		ret = call_memop(vb, map_dmabuf, vb->planes[plane].mem_priv);
+		if (ret) {
+			dprintk(1, "failed to map dmabuf for plane %d\n",
+				plane);
+			return ret;
+		}
+		vb->planes[plane].dbuf_mapped = 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vb2_buffer_access_request);
+
+void vb2_buffer_access_release(struct vb2_buffer *vb)
+{
+	struct vb2_queue *q = vb->vb2_queue;
+	unsigned int plane;
+
+	/* Only dmabuf-imported buffers need to be unmapped after access. */
+	if (q->memory != VB2_MEMORY_DMABUF)
+		return;
+
+	for (plane = 0; plane < vb->num_planes; ++plane) {
+		if (!vb->planes[plane].dbuf_mapped)
+			continue;
+
+		call_void_memop(vb, unmap_dmabuf, vb->planes[plane].mem_priv);
+		vb->planes[plane].dbuf_mapped = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(vb2_buffer_access_release);
+
 /*
  * __prepare_mmap() - prepare an MMAP buffer
  */
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 4a737b2c610b..bf378c1e718b 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -1199,4 +1199,19 @@ bool vb2_request_object_is_buffer(struct media_request_object *obj);
  */
 unsigned int vb2_request_buffer_cnt(struct media_request *req);
 
+/**
+ * vb2_buffer_access_request() - request out-of-band data access to a buffer
+ *
+ * @vb:		buffer to request data access for
+ */
+int vb2_buffer_access_request(struct vb2_buffer *vb);
+
+
+/**
+ * vb2_buffer_access_release() - release out-of-band data access to a buffer
+ *
+ * @vb:		buffer to release data access for
+ */
+void vb2_buffer_access_release(struct vb2_buffer *vb);
+
 #endif /* _MEDIA_VIDEOBUF2_CORE_H */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
