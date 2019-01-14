Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58170C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:40:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D3320651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p7CWhPFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D3320651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HGbw6G8zme880r63SGdLLIxheXoWvpOdOCLtjLxV7o4=; b=p7CWhPFO8T1DqY
	LjNkuHN1ytGPw5+0f7IVZDdzfSdRFeoBkznyTP6NAtJ5GkReXqXwFNmAnEXIiKpu/hImV4Gi6EEpK
	gVkXZclxReYLpbZaBvgMgtUyr6S81oum0au8HHSnewWaNovibOgcY5rdUVvht7JFVh4o2qzS0+nnX
	zWI+dsxcZT5bXCvE0odIk2f64UJ8BKWR/3+D5AZ2v/8h4v9XwXNbC63EoWvWjYwn2iV+4t1shbIQG
	ejfVaxFjh4o8A+12nwsyKCHt3/LoqT6F18qwnidM0OB99DTsfLM9H+RtymFslwgRyWrmr+qV1mqHl
	FU9IXUYBy3KU0eTP1sbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2T7-0003s6-8V; Mon, 14 Jan 2019 13:39:57 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2SI-000368-FH
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:39:10 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 4C011209D7; Mon, 14 Jan 2019 14:39:01 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id CFB9F206F9;
 Mon, 14 Jan 2019 14:39:00 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH RFC 2/4] media: v4l2-mem2mem: Add an optional job_done
 operation
Date: Mon, 14 Jan 2019 14:38:37 +0100
Message-Id: <20190114133839.29967-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114133839.29967-1-paul.kocialkowski@bootlin.com>
References: <20190114133839.29967-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_053906_827249_08FB463E 
X-CRM114-Status: GOOD (  16.57  )
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

Introduce a new optional job_done operation, which allows calling back
to the driver when a job is done. Since the job might be completed
from interrupt context where some operations are not available, having
a callback from non-atomic context allows performing these operations
upon completion of a job. This is particularly useful for releasing
access to a reference buffer, which cannot be done in atomic context.

Use the already existing v4l2_m2m_device_run_work work queue for that
and clear the M2M device current context after calling job_done in the
worker thread, so that the private data can be passed to the operation.

Delaying the current context clearing should not be a problem since the
next call to v4l2_m2m_try_run happens right after that.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 8 ++++++--
 include/media/v4l2-mem2mem.h           | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 631f4e2aa942..d5bccb0192f9 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -376,6 +376,11 @@ static void v4l2_m2m_device_run_work(struct work_struct *work)
 	struct v4l2_m2m_dev *m2m_dev =
 		container_of(work, struct v4l2_m2m_dev, job_work);
 
+	if (m2m_dev->m2m_ops->job_done && m2m_dev->curr_ctx)
+		m2m_dev->m2m_ops->job_done(m2m_dev->curr_ctx->priv);
+
+	m2m_dev->curr_ctx = NULL;
+
 	v4l2_m2m_try_run(m2m_dev);
 }
 
@@ -431,8 +436,7 @@ void v4l2_m2m_job_finish(struct v4l2_m2m_dev *m2m_dev,
 	list_del(&m2m_dev->curr_ctx->queue);
 	m2m_dev->curr_ctx->job_flags &= ~(TRANS_QUEUED | TRANS_RUNNING);
 	wake_up(&m2m_dev->curr_ctx->finished);
-	m2m_dev->curr_ctx = NULL;
-
+	/* The current context pointer is cleared after the job_done step. */
 	spin_unlock_irqrestore(&m2m_dev->job_spinlock, flags);
 
 	/* This instance might have more buffers ready, but since we do not
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index 43e447dcf69d..261bcd661b2d 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -40,11 +40,15 @@
  *		v4l2_m2m_job_finish() (as if the transaction ended normally).
  *		This function does not have to (and will usually not) wait
  *		until the device enters a state when it can be stopped.
+ * @job_done:	optional. Informs the driver that the current job was completed.
+ *		This can be useful to release access to extra buffers that were
+ *		required for the job, such as reference buffers for decoding.
  */
 struct v4l2_m2m_ops {
 	void (*device_run)(void *priv);
 	int (*job_ready)(void *priv);
 	void (*job_abort)(void *priv);
+	void (*job_done)(void *priv);
 };
 
 struct video_device;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
