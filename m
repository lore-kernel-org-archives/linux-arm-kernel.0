Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E50FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:33:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D092D20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cjf1ktXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D092D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gz1KhR4ouHc5nmPBbcuOX1tuC7rhRV+mZA1Tgfk0dS0=; b=Cjf1ktXk/NKAc6
	QV4cpHvy0IrtkweSOwvX+k3fVrZPH1fwrG3htsKq51gnvLM9GJo2Elb77FIy/rkYyva+JNyU+cBz6
	U7blYF2IKjP1C83pE4tcR+a/tLoGwBghBBclFOasm0h0Xc2HQv0HjP16xHj01V0iLWoqzHCImqWJK
	TmitMGl7+tHdVAS2Rbbk/yrt0WwBlcuNLniKGAU80URk8aSoroxy8TkJF2g59jykvTGX30vdrcWFN
	9jkIA5FhyrllvLCmKPLdHrbskbwlkVkFmd1RS89koik8hZ/KPvtd8Vnzk0z1rPj7IIhN9TzaWOmWI
	9Bi3t/dCjYTm/RPKreYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjZ9Q-0001XD-UU; Wed, 16 Jan 2019 00:33:48 +0000
Received: from gate.crashing.org ([63.228.1.57])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjZ9N-0001WS-Vs
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 00:33:47 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0G0X6xW011333;
 Tue, 15 Jan 2019 18:33:08 -0600
Message-ID: <ed2dd9042d1afede4843d7fd3728a4d701a19fdd.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Date: Wed, 16 Jan 2019 11:33:06 +1100
In-Reply-To: <87a7k2yx66.fsf@concordia.ellerman.id.au>
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
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_163346_237542_54B1D027 
X-CRM114-Status: GOOD (  11.38  )
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

On Tue, 2019-01-15 at 22:31 +1100, Michael Ellerman wrote:
> > > As far as I know Power doesn't really supports un-cached memory at all, 
> > > except for a very very old and odd configuration with AGP.
> > 
> > Hopefully Michael/Ben can elaborate here, but I was under the (possibly
> > mistaken) impression that mismatched attributes could cause a machine-check
> > on Power.
> 
> That's what I've always been told, but I can't actually find where it's
> documented, I'll keep searching.
> 
> But you're right that mixing cached / uncached is not really supported,
> and probably results in a machine check or worse.

 .. or worse :) It could checkstop.

It's also my understanding that on ARM v7 and above, it's technically
forbidden to map the same physical page with both cached and non-cached 
mappings, since the cached one could prefetch (or speculatively load),
thus creating collisions and inconsistencies. Am I wrong here ?

The old hack of using non-cached mapping to avoid snoop cost in AGP and
others is just that ... an ugly and horrible hacks that should have
never eventuated, when the search for performance pushes HW people into
utter insanity :)

Cheers,
Ben.




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
