Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7E3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:31:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368CF2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sU/EKFpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368CF2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6tMp9vL0UGgYF5qqIkmTD/18GQ83zDcVYuwq6NyySjM=; b=sU/EKFpkViyRRc
	Ozh3/H8IDvZYobactqdNRhYmaRCEvgWljFLzazYzsWJ8IEJ7lFrygvXHDDOOlBOSLEuxc7ru+JMK9
	n0xUR1uzRCP7VUdW9XYZu2fhQIeXR9TO1Zem+4A9N6Fd6Oetu16xP25X7QusocawcxwSuTvMDvoXw
	XdAzj7EXJCBDnZJhG+k3LWZTR6VZ+5CTIRkc3pmyvM4WvRzkqXuqdAvYEmIBNv+zTF3F1Iqt0qQkh
	RLN5fNcRwOzt2lLugUzZWo74tYwFLQuBN69ikSSVVfQqzrS+1tbDD1lQT3vbyOsARoUeW70sBtFIX
	PuTYQ8k5tw3tsINiMC6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjMwY-00067j-TA; Tue, 15 Jan 2019 11:31:42 +0000
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjMwT-00066n-QI
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 11:31:40 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43f7TG5sg3z9sCh;
 Tue, 15 Jan 2019 22:31:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Will Deacon <will.deacon@arm.com>, "Koenig\,
 Christian" <Christian.Koenig@amd.com>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
In-Reply-To: <20190114193548.GB29600@fuggles.cambridge.arm.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
 <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
 <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
 <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com>
 <20190114191350.GA29600@fuggles.cambridge.arm.com>
 <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com>
 <20190114193548.GB29600@fuggles.cambridge.arm.com>
Date: Tue, 15 Jan 2019 22:31:29 +1100
Message-ID: <87a7k2yx66.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_033138_090458_1FA695F3 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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
 benh@kernel.crashing.org,
 Michel =?utf-8?Q?D=C3=A4nz?= =?utf-8?Q?er?= <michel@daenzer.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Zhang, Jerry" <Jerry.Zhang@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Bernhard =?utf-8?Q?Rosenkr=C3=A4n?= =?utf-8?Q?zer?=
 <Bernhard.Rosenkranzer@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

Will Deacon <will.deacon@arm.com> writes:
> [+ BenH and MPE]
>
> On Mon, Jan 14, 2019 at 07:21:08PM +0000, Koenig, Christian wrote:
>> Am 14.01.19 um 20:13 schrieb Will Deacon:
...
>
>> > The Arm architecture (and others including Power afaiu) doesn't
>> > guarantee coherency when memory is accessed using mismatched cacheability
>> > attributes.
...
>
>> As far as I know Power doesn't really supports un-cached memory at all, 
>> except for a very very old and odd configuration with AGP.
>
> Hopefully Michael/Ben can elaborate here, but I was under the (possibly
> mistaken) impression that mismatched attributes could cause a machine-check
> on Power.

That's what I've always been told, but I can't actually find where it's
documented, I'll keep searching.

But you're right that mixing cached / uncached is not really supported,
and probably results in a machine check or worse.

cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
