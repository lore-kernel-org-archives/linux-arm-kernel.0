Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE5BC2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:35:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D15520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gdEjJUaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D15520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c/XyBtaUM4zTCQHQMwv3nMqBxjIWqktDQfbNRklLimE=; b=gdEjJUaL+mPQV/
	UVXd/nsAhoOV2qRBmPXKNhs+ssHkHR0woSQRVD8yyg3bO/AluNrZ0f0/06cb0V+WAuVbLfH7HfRWn
	C5NE+RrGZMqOWtLhiioeMy5TvHR3OZOrhwd9r+q0Vd00DgwVoEQ6VlNqDg3k7l+isyzgzvZrWu9/x
	GcS7G2afYdtqQiVQUwPXZYqROW2aaBeXKrrXzXlMeYrBMSIb6dg0JCcuJoKzduuTsBA/Dvrg+vYwO
	WHCEQaWny9UYXeGpORnOzpCC18EnSeLZ+RQ+s2Ia41QJFtkS+oKZo4OEniV7LMbJFi991vktdH7+m
	95HQ/STyZTfKK7E33cYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcY2-0007Ga-7D; Mon, 21 Jan 2019 16:35:42 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1glcXz-0007Ee-RH; Mon, 21 Jan 2019 16:35:39 +0000
Date: Mon, 21 Jan 2019 08:35:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Message-ID: <20190121163539.GA18070@infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
 <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
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

On Mon, Jan 21, 2019 at 05:30:00PM +0100, Ard Biesheuvel wrote:
> > Until that happens we should just change the driver ifdefs to default
> > the hacks to off and only enable them on setups where we 100%
> > positively know that they actually work.  And document that fact
> > in big fat comments.
> 
> Well, as I mentioned in my commit log as well, if we default to off
> unless CONFIG_X86, we may break working setups on MIPS and Power where
> the device is in fact non-cache coherent, and relies on this
> 'optimization' to get things working. The same could be true for
> non-coherent ARM systems, hence my approach to disable this hack for
> cache coherent devices on non-X86 only.

Do we break existing setups or just reduce performance due to the lack
of WC mappings?  I thought it was the latter.  The point is that
even your check won't do what you actually said.  At lot of non-loongson
mips platforms are not cache coherent.  As are a lot of arm setups
and all sparc64 ones for example.  And chances that someone will
hacks this file out in a random subsystem when adding news ports also
is rather slim, so we'll remaing broken by default.

That is why I want at very least:  a whitelist instead of a blacklist
and some very big comments explaining what is going on here.  And in
the mid to long term even drm really needs to learn to use the
proper APIs :(

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
