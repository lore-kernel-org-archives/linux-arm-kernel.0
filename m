Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09C2C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:43:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7013F222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d4ByVQQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7013F222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cGnW6qIGHi+/CybyyAAVWf6aM6fc4w/5H1nIyJtzhTo=; b=d4ByVQQAj+WSx2
	g/owLp/fkjBmt0H4NBEpec0EdQc5rDBHLdEdEFyx0gzvPi8ZI3JJqJ1ZT9rMMxmoJdXthARePkyl7
	o2/yNHRS7L2++n4DRJO5+CSv7AYDt5kBnlTbfUYE7JVAKAlNlvtXMGC4nLyWs5Qt1xgE3H/mebGVL
	xxe9wRzkl6F3F0mY6Hin8Kgatl4aJ0/+9ViRrqcXiz5eVs0uLFY/JMKWudUw//I881woTKs2L47Jr
	eCxl1+uxMMyDlMBKlTCLisdvOKGre9cB0kK5OSB6IkVDSKzJ/7YJ46zy0I+GG6q4izS2mmpvNpURi
	8sfYDarb/Ehbi6qw3UDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guDGx-0000vW-8F; Thu, 14 Feb 2019 09:25:35 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guDGt-0000v1-7I
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 09:25:33 +0000
Received: from localhost.localdomain
 (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
 (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id A305820000F;
 Thu, 14 Feb 2019 09:25:19 +0000 (UTC)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v2] media: cedrus: Forbid setting new formats on busy queues
Date: Thu, 14 Feb 2019 10:25:11 +0100
Message-Id: <20190214092511.672-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_012531_410704_A5098390 
X-CRM114-Status: GOOD (  10.33  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Check that our queues are not busy before setting the format or return
EBUSY if that's the case. This ensures that our format can't change
once buffers are allocated for the queue.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_video.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
index b5cc79389d67..b47854b3bce4 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -282,8 +282,13 @@ static int cedrus_s_fmt_vid_cap(struct file *file, void *priv,
 {
 	struct cedrus_ctx *ctx = cedrus_file2ctx(file);
 	struct cedrus_dev *dev = ctx->dev;
+	struct vb2_queue *vq;
 	int ret;
 
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
+	if (vb2_is_busy(vq))
+		return -EBUSY;
+
 	ret = cedrus_try_fmt_vid_cap(file, priv, f);
 	if (ret)
 		return ret;
@@ -299,8 +304,13 @@ static int cedrus_s_fmt_vid_out(struct file *file, void *priv,
 				struct v4l2_format *f)
 {
 	struct cedrus_ctx *ctx = cedrus_file2ctx(file);
+	struct vb2_queue *vq;
 	int ret;
 
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
+	if (vb2_is_busy(vq))
+		return -EBUSY;
+
 	ret = cedrus_try_fmt_vid_out(file, priv, f);
 	if (ret)
 		return ret;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
