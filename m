Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D6EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8242A222B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IBg6GmQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8242A222B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iLYx/nUtWUIw9ySWuOWB5Z7H3kqVGn5qc5KK7u2KUac=; b=IBg6GmQU/UGOqR
	Kpm9dQ4aCVsQnQFrCZpQApkzS9mpZ835qCFuqLe94qGkjiWEApB1/BmXjx0oiSEBLibp98UpQBtwC
	I2X/bNtXnV+MJeRaGrc+prYvRpcXCv7o0lLjX7fUKfD1L5x8oz/Se/Sdg6+r5FwT6mHL8+u4JjLfl
	8N9bieIqgpT5GCbWfUJaH+1aerTg+CfEW8uMTKMtcYpKUb0FUBjW9V8R7ZK+BI58UsmZlf+fC70V4
	MTF4ufD55+LQ5sroAGixWnDGdORUjsMs4WIQVVQXHoFAN3oA0cKKl0SbsXSEkbcGhka6OgRrdA+Jn
	y4XtckH/N563EPkkvBuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtD8G-0001Xx-63; Mon, 11 Feb 2019 15:04:28 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtD7I-0000WW-7p
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 15:03:41 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EFE21240031;
 Mon, 11 Feb 2019 15:03:23 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 5/7] drm/sun4i: Rely on dma interconnect for our RAM offset
Date: Mon, 11 Feb 2019 16:02:53 +0100
Message-Id: <dfbdedf89c6a36f6fe5564e7c518664fa9e828c0.1549897336.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.f2e5fbb4d21384168973fa32377a33d627768146.1549897336.git-series.maxime.ripard@bootlin.com>
References: <cover.f2e5fbb4d21384168973fa32377a33d627768146.1549897336.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_070328_846243_5B6A45F0 
X-CRM114-Status: GOOD (  18.66  )
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
Cc: devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Georgi Djakov <georgi.djakov@linaro.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Yong Deng <yong.deng@magewell.com>, Robin Murphy <robin.murphy@arm.com>,
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Now that we can express our DMA topology, rely on those property instead of
hardcoding an offset from the dma_addr_t which wasn't really great.

We still need to add some code to deal with the old DT that would lack that
property, but we move the offset to the DRM device dma_pfn_offset to be
able to rely on just the dma_addr_t associated to the GEM object.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 9e9255ee59cd..1846a1b30fea 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -383,13 +383,6 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
 
-	/*
-	 * backend DMA accesses DRAM directly, bypassing the system
-	 * bus. As such, the address range is different and the buffer
-	 * address needs to be corrected.
-	 */
-	paddr -= PHYS_OFFSET;
-
 	if (fb->format->is_yuv)
 		return sun4i_backend_update_yuv_buffer(backend, fb, paddr);
 
@@ -835,6 +828,27 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 	dev_set_drvdata(dev, backend);
 	spin_lock_init(&backend->frontend_lock);
 
+	if (of_find_property(dev->of_node, "interconnects", NULL)) {
+		/*
+		 * This assume we have the same DMA constraints for all our the
+		 * devices in our pipeline (all the backends, but also the
+		 * frontends). This sounds bad, but it has always been the case
+		 * for us, and DRM doesn't do per-device allocation either, so
+		 * we would need to fix DRM first...
+		 */
+		ret = of_dma_configure(drm->dev, dev->of_node, true);
+		if (ret)
+			return ret;
+	} else {
+		/*
+		 * If we don't have the interconnect property, most likely
+		 * because of an old DT, we need to set the DMA offset by hand
+		 * on our device since the RAM mapping is at 0 for the DMA bus,
+		 * unlike the CPU.
+		 */
+		drm->dev->dma_pfn_offset = PHYS_PFN_OFFSET;
+	}
+
 	backend->engine.node = dev->of_node;
 	backend->engine.ops = &sun4i_backend_engine_ops;
 	backend->engine.id = sun4i_backend_of_get_id(dev->of_node);
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
