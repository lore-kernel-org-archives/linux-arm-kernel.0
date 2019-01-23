Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F226BC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:44:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D382184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p0MwlLii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D382184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8GfkZ5CKIF3ps5HdxCb6gFflrdxaqDC1UBDaOAUMkhY=; b=p0MwlLiihFD6Mq
	X7H1zwRy6NgbaL3iy8d3XtG3PMyF8i0+ReqiI5vJUkRpIofYgnFT3m2mm1bPwlcdkOk3jFl+8kz+F
	h57iT2TzoBOAEvvHY5wkkHTljEKD3pwMkP5mpKuxP55vfAkUdBp8iJwcGiATeLqKTGsZAHHiUEbOH
	RZy9nno+escCrVnUsuSAjL3il/BY2o9NN+so3kzZRSikE6T7aOc7nFHsh6cNJv4WsefUVNhx6WaBd
	wc5Q/pBUsSWmcG0BnsjrxVwK+Yokd+AJuKQw+ZYduGhsPoUA0AIYVfZBq/bZpo2HdQlNMvpSfcMJN
	WZyUy6QDKwUFew2T0zrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLdf-0002P5-Uw; Wed, 23 Jan 2019 16:44:31 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gmLdc-0002OQ-9E; Wed, 23 Jan 2019 16:44:28 +0000
Date: Wed, 23 Jan 2019 08:44:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Message-ID: <20190123164428.GA9367@infradead.org>
References: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
 Michael Ellerman <mpe@ellerman.id.au>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Junwei Zhang <Jerry.Zhang@amd.com>, Christoph Hellwig <hch@infradead.org>,
 David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

I think we just want a driver-local check for those combinations
where we know this hack actually works, which really just seems
to be x86-64 with PAT. Something like the patch below, but maybe with
even more strong warnings to not do something like this elsewhere:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 728e15e5d68a..5fe657f20232 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -456,33 +456,16 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 
 	bo->flags = bp->flags;
 
-#ifdef CONFIG_X86_32
-	/* XXX: Write-combined CPU mappings of GTT seem broken on 32-bit
-	 * See https://bugs.freedesktop.org/show_bug.cgi?id=84627
-	 */
-	bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-#elif defined(CONFIG_X86) && !defined(CONFIG_X86_PAT)
-	/* Don't try to enable write-combining when it can't work, or things
-	 * may be slow
-	 * See https://bugs.freedesktop.org/show_bug.cgi?id=88758
-	 */
-
-#ifndef CONFIG_COMPILE_TEST
-#warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
-	 thanks to write-combining
-#endif
-
-	if (bo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
-		DRM_INFO_ONCE("Please enable CONFIG_MTRR and CONFIG_X86_PAT for "
-			      "better performance thanks to write-combining\n");
-	bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-#else
-	/* For architectures that don't support WC memory,
-	 * mask out the WC flag from the BO
+	/*
+	 * Don't try to enable write-combined CPU mappings unless we 100%
+	 * positively know it works, otherwise there may be dragons.
+	 *
+	 * See:
+	 *  - https://bugs.freedesktop.org/show_bug.cgi?id=88758
+	 *  - https://bugs.freedesktop.org/show_bug.cgi?id=84627
 	 */
-	if (!drm_arch_can_wc_memory())
+	if (!(IS_ENABLED(CONFIG_X86_64) && IS_ENABLED(CONFIG_X86_PAT)))
 		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-#endif
 
 	bo->tbo.bdev = &adev->mman.bdev;
 	amdgpu_bo_placement_from_domain(bo, bp->domain);
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 833e909706a9..c1fb5ad4ab9a 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -226,32 +226,17 @@ int radeon_bo_create(struct radeon_device *rdev,
 	if (rdev->family >= CHIP_RV610 && rdev->family <= CHIP_RV635)
 		bo->flags &= ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
 
-#ifdef CONFIG_X86_32
-	/* XXX: Write-combined CPU mappings of GTT seem broken on 32-bit
-	 * See https://bugs.freedesktop.org/show_bug.cgi?id=84627
-	 */
-	bo->flags &= ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
-#elif defined(CONFIG_X86) && !defined(CONFIG_X86_PAT)
-	/* Don't try to enable write-combining when it can't work, or things
-	 * may be slow
-	 * See https://bugs.freedesktop.org/show_bug.cgi?id=88758
-	 */
-#ifndef CONFIG_COMPILE_TEST
-#warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
-	 thanks to write-combining
-#endif
 
-	if (bo->flags & RADEON_GEM_GTT_WC)
-		DRM_INFO_ONCE("Please enable CONFIG_MTRR and CONFIG_X86_PAT for "
-			      "better performance thanks to write-combining\n");
-	bo->flags &= ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
-#else
-	/* For architectures that don't support WC memory,
-	 * mask out the WC flag from the BO
+	/*
+	 * Don't try to enable write-combined CPU mappings unless we 100%
+	 * positively know it works, otherwise there may be dragons.
+	 *
+	 * See:
+	 *  - https://bugs.freedesktop.org/show_bug.cgi?id=88758
+	 *  - https://bugs.freedesktop.org/show_bug.cgi?id=84627
 	 */
-	if (!drm_arch_can_wc_memory())
-		bo->flags &= ~RADEON_GEM_GTT_WC;
-#endif
+	if (!(IS_ENABLED(CONFIG_X86_64) && IS_ENABLED(CONFIG_X86_PAT)))
+		bo->flags &= ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
 
 	radeon_ttm_placement_from_domain(bo, domain);
 	/* Kernel allocation are uninterruptible */
diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
index bfe1639df02d..6c3960f4c477 100644
--- a/include/drm/drm_cache.h
+++ b/include/drm/drm_cache.h
@@ -40,16 +40,4 @@ void drm_clflush_sg(struct sg_table *st);
 void drm_clflush_virt_range(void *addr, unsigned long length);
 u64 drm_get_max_iomem(void);
 
-
-static inline bool drm_arch_can_wc_memory(void)
-{
-#if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
-	return false;
-#elif defined(CONFIG_MIPS) && defined(CONFIG_CPU_LOONGSON3)
-	return false;
-#else
-	return true;
-#endif
-}
-
 #endif


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
