Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A80C2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:59:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A5C20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l348Xeab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A5C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BpkVKB9S9ww4VSKKZdfl5xMraFLlhgmP7+easfaO+EQ=; b=l348XeabmIKVcH
	K2DXcNPuTEoxWfQj00raPzssRBCIkDEOGNCfk/9Fru6P5h1QWtqAoWJrEe90YLcsTaC4PdUuDzKXM
	33moeF5vvi6aUF3jlxFvQTojvo/5vUzF51izL+7ieXnhjCT7i2yKjktRtQUkuI7g/Ij3ZBJThfhRD
	aqCeHo+Qu1qxQmm6u/RazKnmgaI546HyN0MiJQYE5vbXkAeyx6dcISrec+yqUbrW1KZptESlUnrzn
	3kEUQjZbR8mdw9M+IkvVxxGFR7YD4n0DP2X8Dn8y8Ne3ONNdrT6G25+cSQCh8tT7VzTcwG8zmOS1H
	II2B1g2Q4UZdXbCI6Y2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbyg-00031K-Vu; Mon, 21 Jan 2019 15:59:11 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1glbye-00030K-Hw; Mon, 21 Jan 2019 15:59:08 +0000
Date: Mon, 21 Jan 2019 07:59:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Message-ID: <20190121155908.GA8084@infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
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

On Mon, Jan 21, 2019 at 04:33:27PM +0100, Ard Biesheuvel wrote:
> On Mon, 21 Jan 2019 at 16:07, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > +#include <linux/dma-noncoherent.h>
> >
> > This header is not for usage in device drivers, but purely for
> > dma-mapping implementations!
> >
> 
> Is that documented anywhere?

I'll add big fat comments.  But the fact that nothing is exported
there should be a fairly big hint.

> > And even if something like this was valid to do, it would have to be
> > a core function with an arch hook, and not hidden in a random driver.
> 
> Why would it not be valid to do? Is it wrong for a driver to be aware
> of whether a device is cache coherent or not?
> 
> And in case it isn't, do you have an alternative suggestion on how to
> fix this mess?

For the write combine mappings we need a proper core API how instances
can advertise the support.  One thing I want to do fairly soon is
error checking of the attrs argument to dma_alloc_attrs - so if you
pass in something unsupported it will give you back an error.

It seems that isn't quite enough for the drm use case, so we might
also need a way to query these features, but that really has to go
through the usual dma layer abstraction as well and not hacked together
in a driver based on an eduacted guestimate.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
