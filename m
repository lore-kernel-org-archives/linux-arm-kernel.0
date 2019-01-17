Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF33C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:07:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535802054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZEPF/jY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535802054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Po2LtlBXhxOpb+j0q82Dz/PZKQxg2n6LuuJi4B6we7E=; b=ZEPF/jY0izVlke
	BCwfCuXpl6ACAKXjMy0nsD/owKKz+IyiVxuFzZA5DHixLCsPGCi+epY51S374A4rkAmK2088eKC2g
	6yOo5WrpFUgN1D4ig7LR3t5bWv1hV7Oq9oIjCGEWRBmgDfgOsY5cAorS31avti2ndjFG/kdQQXpBO
	IqSI1B44GblIcS0jTO11WDIwaCmhqmAgB/87Mw1k3u8GIufS6OiZp/Vxqei7PrIj490040CPAKZMh
	qe/dAjVEGahzAvVkEmQjiQMAq4tjWoJ+zHKdb3tuA3q2UWImxbPgEc7uzoQaesh8FLwCMf6/ySQD1
	uqY99WUALrpAkJYWK/CQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk0qK-0007we-Aq; Thu, 17 Jan 2019 06:07:56 +0000
Received: from gate.crashing.org ([63.228.1.57])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk0qH-0007wH-0L
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:07:54 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0H67KwY024177;
 Thu, 17 Jan 2019 00:07:22 -0600
Message-ID: <9d706807c93f88bc850153ae20ea28e6502e0aac.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Date: Thu, 17 Jan 2019 17:07:20 +1100
In-Reply-To: <CAKv+Gu8_0HjPsT2ne-uCtxRt=2CE_tLGY6wo9xafC5SmJOGRKA@mail.gmail.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
 <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
 <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
 <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com>
 <20190114191350.GA29600@fuggles.cambridge.arm.com>
 <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com>
 <20190114193548.GB29600@fuggles.cambridge.arm.com>
 <87a7k2yx66.fsf@concordia.ellerman.id.au>
 <ed2dd9042d1afede4843d7fd3728a4d701a19fdd.camel@kernel.crashing.org>
 <9dc27cbf-e109-0c32-fc92-6fce1b224cda@amd.com>
 <CAKv+Gu8_0HjPsT2ne-uCtxRt=2CE_tLGY6wo9xafC5SmJOGRKA@mail.gmail.com>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_220753_269145_BD130D97 
X-CRM114-Status: GOOD (  19.98  )
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
Cc: Carsten Haitzler <Carsten.Haitzler@arm.com>,
 David Airlie <airlied@linux.ie>, Michael Ellerman <mpe@ellerman.id.au>,
 Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Zhang, Jerry" <Jerry.Zhang@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Bernhard =?ISO-8859-1?Q?Rosenkr=E4nzer?= <Bernhard.Rosenkranzer@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-16 at 08:47 +0100, Ard Biesheuvel wrote:
> > As far as I know on x86 it doesn't, so when you have an un-cached page
> > you can still access it with a snooping DMA read/write operation and
> > don't cause trouble.
> > 
> 
> I think it is the other way around. The question is, on an otherwise
> cache coherent device, whether the NoSnoop attribute set by the GPU
> propagates all the way to the bus so that it bypasses the caches.

On powerpc it's ignored, all DMA accesses will be snooped. But that's
fine regardless of whether the memory was mapped cachable or not, the
snooper will simply not find anything if not. I *think* we only do
cache inject if the line already exists in one of the caches.

> On x86, we can tolerate if this is not the case, since uncached memory
> accesses by the CPU snoop the caches as well.
> 
> On other architectures, uncached accesses go straight to main memory,
> so if the device wrote anything to the caches we won't see it.

Well, on all powerpc implementations that I am aware of at least (dunno
about ARM), they do, but we don't have a problem because I don't think
the devices can/will write to the caches directly unless a
corresponding line already exists (but I might be wrong, we need to
double check all implementations which is tricky).

I am not aware of any powerpc chip implementing NoSnoop.

> So to use this optimization, you have to either be 100% sure that
> NoSnoop is implemented correctly, or have a x86 CPU.
> 
> > > The old hack of using non-cached mapping to avoid snoop cost in AGP and
> > > others is just that ... an ugly and horrible hacks that should have
> > > never eventuated, when the search for performance pushes HW people into
> > > utter insanity :)
> > 
> > Well I agree that un-cached system memory makes things much more
> > complicated for a questionable gain.
> > 
> > But fact is we now have to deal with the mess, so no point in
> > complaining about it to much :)
> > 
> 
> Indeed. I wonder if we should just disable it altogether unless CONFIG_X86=y

The question is whether DMA from a device can instanciate cache lines
in your system. This a system specific rather than architecture
specific question I suspect...
 
Cheers,
Ben.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
