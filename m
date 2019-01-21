Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AFEC2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:22:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0545420870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QTiUwgVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0545420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iu5bXAAtd3VgLxgejJ9GW3IzhrhxwVxuUEtnDc42amM=; b=QTiUwgVfEXv5ms
	6agUnbZWwW+1nnnH9yRNUS+/9nCDd5oRnfTiK9pAJiqK5aCfzuI+xhbuPgBd1JVYCIobewS57IGDX
	/ny+1cXmoHjeE94IKDzap8ekU4zjiUDQTE1S8nuQ7dT17XtAH7W52w1TksOhIKS/gEc7dyPE1mewe
	5I4jVtmstzT61Z6rNzr50+oMx9BXVO94+C+n+A5Z+f7qK6lsh1PTqkJ00XLHpqwgYq1T2m96UajAC
	WC68nlQGv/ww4A2ehDVqoNw0GBjfkWP5srYufm6hRVIybOfSq26IzbJTS+A9WmCERWxbD474QsaEi
	PG0MScqrEMBZoUHuKJ6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcLQ-0007JQ-Io; Mon, 21 Jan 2019 16:22:40 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1glcLO-0007Io-TC; Mon, 21 Jan 2019 16:22:38 +0000
Date: Mon, 21 Jan 2019 08:22:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Message-ID: <20190121162238.GA17651@infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
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
Cc: Will Deacon <will.deacon@arm.com>, David Zhou <David1.Zhou@amd.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Michel Daenzer <michel.daenzer@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 Junwei Zhang <Jerry.Zhang@amd.com>, Huang Rui <ray.huang@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>,
 Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 05:14:37PM +0100, Ard Biesheuvel wrote:
> > I'll add big fat comments.  But the fact that nothing is exported
> > there should be a fairly big hint.
> >
> 
> I don't follow. How do other header files 'export' things in a way
> that this header doesn't?

Well, I'll add comments to make it more obvious..

> As far as I can tell, these drivers allocate DMA'able memory [in
> ttm_tt_populate()] and subsequently create their own CPU mappings for
> it, assuming that
> a) the default is cache coherent, so vmap()ing those pages with
> cacheable attributes works, and

Yikes.  vmaping with different attributes is generally prone to
create problems on a lot of architectures.

> b) telling the GPU to use NoSnoop attributes makes the accesses it
> performs coherent with non-cacheable CPU mappings of those physical
> pages
> 
> Since the latter is not true for many arm64 systems, I need this patch
> to get a working system.

Do we know that this actually works anywhere but x86?

In general I would call these above sequence rather bogus and would
prefer we could get rid of such antipatterns in the kernel and just use
dma_alloc_attrs with DMA_ATTR_WRITECOMBINE if we want writecombine
semantics.

Until that happens we should just change the driver ifdefs to default
the hacks to off and only enable them on setups where we 100%
positively know that they actually work.  And document that fact
in big fat comments.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
