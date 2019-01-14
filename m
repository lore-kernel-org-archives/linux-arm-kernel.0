Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8E7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:39:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F2920651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BFv2ISEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F2920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hY7lmBB2ANnif9DtMBwz4Rd7+3rwdokpLl7nJyriiy4=; b=BFv2ISEbeqhHgy
	pGtHOZww4X7x+z2somxQHPh4qCsKA+RyRdu4ZaPJpWKF0ZButzNC+EvZSHgm1g92/TvH6PzekKZQ3
	Vz7LPVCzMd1cKxYyORe0tlI0lS3uksnAMaY7KiDnb0+Vdtls0KV2pk8U719g1ikhytcy6K/e1Xs/1
	fT96JCysb+Y7cqTz9luKEURthUw4I/KPzB8FjK8WGa74ty+AGJZ+5Mvv/FKOAmMw3Trk87beF8lJV
	gpzvmqv6Hk33sNeSYsfhcnB7O2Oj8zUgo0O5JJlUzD22g2+w6b9ogRf5DY8J0sj79bCBChjoLLt2n
	QOqZQtixgUckj8zneBuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2SV-0003Hd-IL; Mon, 14 Jan 2019 13:39:19 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2SI-000367-FG
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:39:08 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 7934F20742; Mon, 14 Jan 2019 14:39:00 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 08D0B206F9;
 Mon, 14 Jan 2019 14:39:00 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH RFC 0/3] media: Ensure access to dma-buf-imported reference
 buffers
Date: Mon, 14 Jan 2019 14:38:35 +0100
Message-Id: <20190114133839.29967-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_053906_640881_70796905 
X-CRM114-Status: GOOD (  14.20  )
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

This is a first attempt at implementing proper access to buffers
imported with dma-buf and used as reference frames for decoding
subsequent frames.

The main concern associated with this scenario was that memory could be
liberated while the buffer is not in a queued state. After careful
checking, it appears that this is not the case as the refcount is
always increased when importing the buffer. It is only decreased when
the same buffer is queued with a different dma-buf fd or when all
buffers are liberated. In the meantime (when decoding using the frame as
a reference happens), the buffer is thus guaranteed to stay alive.

However, buffers imported with dma-buf require calls to dma-buf-specific
map/unmap memops before they are accessed. This introduces the plumbing
for allowing that.

One major issue is that it cannot be done in atomic context, where
the job is marked as completed. To solve this, a new m2m operation
(job_done) is introduced which allows releasing access to the
reference buffers from the m2m worker thread.

Since this series touches the core of vb2 and m2m and may not be the
best way to implement this, it is marked as RFC.

This series is based on the series starting with:
  media: cedrus: Cleanup duplicate declarations from cedrus_dec header

Paul Kocialkowski (4):
  media: vb2: Add helpers to access unselected buffers
  media: v4l2-mem2mem: Add an optional job_done operation
  media: cedrus: Request access to reference buffers when decoding
  media: cedrus: Remove completed item from TODO list (dma-buf
    references)

 .../media/common/videobuf2/videobuf2-core.c   | 46 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  8 +++-
 drivers/staging/media/sunxi/cedrus/TODO       |  5 --
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  1 +
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  1 +
 .../staging/media/sunxi/cedrus/cedrus_dec.c   | 18 ++++++++
 .../staging/media/sunxi/cedrus/cedrus_dec.h   |  1 +
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c |  8 ++++
 include/media/v4l2-mem2mem.h                  |  4 ++
 include/media/videobuf2-core.h                | 15 ++++++
 10 files changed, 100 insertions(+), 7 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
