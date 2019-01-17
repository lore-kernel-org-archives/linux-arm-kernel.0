Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71363C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:00:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A01320854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pq+ejmuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A01320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rh5CXnbaZPoNgZDsR6uKvpa5+kE7l2m1OO2uCZQPwHs=; b=pq+ejmuGN6Ef1V
	kxwTC4siSH374thb7wt4cgQI8kirltE9HWkbw2I7KlJd2+EyFKDBtw7ClF7+VEAATtQCJKu3r5rK4
	XdTbxItKluDk9/oow/JVsFWC4soxurD7LKd7saAIjrPob8pgEP7bztMiv1WZrVOfvtXLn+HgxjjBS
	g96bxmXV8sewiThwOnMhTJdvMbLf5ImP1jYS9LqhmV38JsU4kZpPbi5RzMUUkmzPrMKmK/5rjQeIE
	H00sxmwi/+Fn+ycWbITdVKaVeuuk2hfOqHFqj27Fd7Rm/rZJeOXJtAyv9g/UPh8TVbRFypcSjasHH
	l6FXuxcTbQilySxgsSsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk0jG-0006C9-Rp; Thu, 17 Jan 2019 06:00:38 +0000
Received: from gate.crashing.org ([63.228.1.57])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk0jD-0006Bd-To
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:00:37 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0H5xrlO023594;
 Wed, 16 Jan 2019 23:59:54 -0600
Message-ID: <db8cd68b82cda0ee0d352fdb709a76151798f9f5.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>
Date: Thu, 17 Jan 2019 16:59:53 +1100
In-Reply-To: <9dc27cbf-e109-0c32-fc92-6fce1b224cda@amd.com>
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
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_220036_179698_71505B35 
X-CRM114-Status: GOOD (  13.04  )
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
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Airlie <airlied@linux.ie>,
 Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Zhang, Jerry" <Jerry.Zhang@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Bernhard =?ISO-8859-1?Q?Rosenkr=E4nzer?= <Bernhard.Rosenkranzer@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-16 at 07:35 +0000, Koenig, Christian wrote:
> No, but you answer the wrong question.
> 
> See we don't want to have different mappings of cached and non-cached on 
> the CPU, but rather want to know if a snooped DMA from the PCIe counts 
> as cached access as well.
> 
> As far as I know on x86 it doesn't, so when you have an un-cached page 
> you can still access it with a snooping DMA read/write operation and 
> don't cause trouble.

Hrm... well, if you map it uncached on the CPU on powerpc, a snoop DMA
will work fine too, it won't hit any cache. The only problem I'm aware
of is a core (or CAPI device) emiting non-cached load/stores colliding
with a cache snooper.

> > The old hack of using non-cached mapping to avoid snoop cost in AGP and
> > others is just that ... an ugly and horrible hacks that should have
> > never eventuated, when the search for performance pushes HW people into
> > utter insanity :)
> 
> Well I agree that un-cached system memory makes things much more 
> complicated for a questionable gain.
> 
> But fact is we now have to deal with the mess, so no point in 
> complaining about it to much :)

I wish we could just sent the HW designers home and tell them we won't
support that crap... oh well.

Ben.

> Cheers,
> Christian.
> 
> > Cheers,
> > Ben.
> > 
> > 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
