Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169E4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:39:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB76120842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XByhBJAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB76120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KCyLim2lxGIhaQPnSfFBrJhQC8h1ESlxhdJeGW7cDqg=; b=XByhBJAuLpvQfJ
	XjEREeacU/5lsGhV6PpIs7aNgCK0yE8cVG0o/ZnNl6PiUm4O5sMxBf+mtSf62HEztPV99Ipt2omoT
	GOgRfYDUYzmtWosDOJXx0L+Bx2e246/7YbG/tOOmBbyUAbVGrYqZRgbVmJNDG/o+F04dHGdPDwjzh
	G9laRsaU+cDOFFLqWkEtC3bgALhYhEaNQlPoCrw0L1f3sIJxtv2n8WWFm8OfyFvNe7Ze8+5ptsgJe
	UnksV6UeGJ6stu66ylP8MgneRQdAWY9aMLoAhATyN2PGOYzM3Sm+3rlWUhVF1VHLyXPrZAJYv3brz
	B4gVacMDnk5IsXFUz1zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyHPd-0006sz-2c; Mon, 25 Feb 2019 14:39:21 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyHPa-0006sG-6a
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 14:39:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 787BE80D;
 Mon, 25 Feb 2019 06:39:17 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF1213F575;
 Mon, 25 Feb 2019 06:39:16 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: liviu.dudau@arm.com
Subject: [PATCH] drm: hdlcd: Stop failing atomic disable check
Date: Mon, 25 Feb 2019 14:39:13 +0000
Message-Id: <57a68c52732f1b463b036168d2d53737821d1087.1550862776.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_063918_245536_12B60BCB 
X-CRM114-Status: GOOD (  17.47  )
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
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When __drm_atomic_helper_disable_all() tries to commit the disabled
state, we end up in hdlcd_crtc_atomic_check() with a mode clock rate
of 0. If the input clock has a nonzero minimum rate, this fails the
clk_round_rate() check and prevents the CRTC being torn down cleanly.

If we're disabling the output, though, then the clock rate should be
pretty much irrelevant, so skip it in that case. The kerneldoc seems
to imply that we probably shouldn't be looking at the rest of the
state anyway if enable=false.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

I'm still occasionally trying to get to the bottom of why the HDLCD on
Juno doesn't work properly with recent upstream EDK2 (the Linux driver
thinks it's initialised and taken over, but the hardware stays stuck
displaying the last contents of the EFI framebuffer). I was hoping that
just unbinding and reprobing the HDLCD/TDA998x drivers might help reset
things hard enough to start working again, but sadly no...

Robin.

 drivers/gpu/drm/arm/hdlcd_crtc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index e4d67b70244d..30a0d9570b57 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -193,6 +193,9 @@ static int hdlcd_crtc_atomic_check(struct drm_crtc *crtc,
 	struct drm_display_mode *mode = &state->adjusted_mode;
 	long rate, clk_rate = mode->clock * 1000;
 
+	if (!state->enable)
+		return 0;
+
 	rate = clk_round_rate(hdlcd->clk, clk_rate);
 	if (rate != clk_rate) {
 		/* clock required by mode not supported by hardware */
-- 
2.20.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
