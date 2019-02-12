Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3313C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:46:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C342E2190B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aRTnxxIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C342E2190B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k1c51ZtuAqo4zZLUL71gXXNgZtuiCIvvI9/hy7oIiv4=; b=aRTnxxIMi9+Uy/emONOPNb61R
	+DTa74AZXjDgG0sQwyy0oePgv6103AB0V4pwK95UXwwz0D1c4lXMTk2BaJo+TP+8NZZJe5r5oONhI
	KSJn5icWA9r5Qg3ruwPF6ktq+N94/4DenIWE5n413rL06NzTWnf5cs2TMfeO2IRpdRd/RwFNdXeOX
	tDhwo1WfHi/nZ8Sfq9CguyuMBbWmpCfozGaoYHGVkSUXPfrof1ivBoeRYS7shu9RSYv2kH3eBprL6
	YNleeutBXf9xsOaEcnN66qovHSonm+jhAkHO8iBaaLcxm4+3zJSE5qDMhzd1icg7WruASq4kIvkTU
	tBhpYCqHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtd4z-0005cz-5w; Tue, 12 Feb 2019 18:46:49 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtd4v-0005bm-9R
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 18:46:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 625C1A78;
 Tue, 12 Feb 2019 10:46:44 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF2313F575;
 Tue, 12 Feb 2019 10:46:41 -0800 (PST)
Subject: Re: [PATCH v3 5/7] drm/sun4i: Rely on dma interconnect for our RAM
 offset
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Chen-Yu Tsai <wens@csie.org>
References: <cover.f2e5fbb4d21384168973fa32377a33d627768146.1549897336.git-series.maxime.ripard@bootlin.com>
 <dfbdedf89c6a36f6fe5564e7c518664fa9e828c0.1549897336.git-series.maxime.ripard@bootlin.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <16cb9f67-6b10-fbc3-6222-5364e718721b@arm.com>
Date: Tue, 12 Feb 2019 18:46:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dfbdedf89c6a36f6fe5564e7c518664fa9e828c0.1549897336.git-series.maxime.ripard@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_104645_341360_CA2ABB39 
X-CRM114-Status: GOOD (  28.14  )
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
Cc: devicetree@vger.kernel.org, Yong Deng <yong.deng@magewell.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Dave Martin <dave.martin@arm.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Georgi Djakov <georgi.djakov@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/02/2019 15:02, Maxime Ripard wrote:
> Now that we can express our DMA topology, rely on those property instead of
> hardcoding an offset from the dma_addr_t which wasn't really great.
> 
> We still need to add some code to deal with the old DT that would lack that
> property, but we move the offset to the DRM device dma_pfn_offset to be
> able to rely on just the dma_addr_t associated to the GEM object.
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>   drivers/gpu/drm/sun4i/sun4i_backend.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index 9e9255ee59cd..1846a1b30fea 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -383,13 +383,6 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
>   	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
>   	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
>   
> -	/*
> -	 * backend DMA accesses DRAM directly, bypassing the system
> -	 * bus. As such, the address range is different and the buffer
> -	 * address needs to be corrected.
> -	 */
> -	paddr -= PHYS_OFFSET;
> -
>   	if (fb->format->is_yuv)
>   		return sun4i_backend_update_yuv_buffer(backend, fb, paddr);
>   
> @@ -835,6 +828,27 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
>   	dev_set_drvdata(dev, backend);
>   	spin_lock_init(&backend->frontend_lock);
>   
> +	if (of_find_property(dev->of_node, "interconnects", NULL)) {
> +		/*
> +		 * This assume we have the same DMA constraints for all our the
> +		 * devices in our pipeline (all the backends, but also the
> +		 * frontends). This sounds bad, but it has always been the case
> +		 * for us, and DRM doesn't do per-device allocation either, so
> +		 * we would need to fix DRM first...
> +		 */
> +		ret = of_dma_configure(drm->dev, dev->of_node, true);

It would be even nicer if we could ensure that drm->dev originates from 
a DT node which has the appropriate interconnects property itself, such 
that we can assume it's already configured correctly.

Robin.

> +		if (ret)
> +			return ret;
> +	} else {
> +		/*
> +		 * If we don't have the interconnect property, most likely
> +		 * because of an old DT, we need to set the DMA offset by hand
> +		 * on our device since the RAM mapping is at 0 for the DMA bus,
> +		 * unlike the CPU.
> +		 */
> +		drm->dev->dma_pfn_offset = PHYS_PFN_OFFSET;
> +	}
> +
>   	backend->engine.node = dev->of_node;
>   	backend->engine.ops = &sun4i_backend_engine_ops;
>   	backend->engine.id = sun4i_backend_of_get_id(dev->of_node);
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
