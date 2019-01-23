Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2A9C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:15:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7C821019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="szPxU/Q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7C821019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qJePkH4zWSE5m2PMB7c3bwCfIFOhe22s7g557mfLcAI=; b=szPxU/Q63WpkMt
	tFiRwax4NFu0GHp2Z6SWWT+gTwS+2bnzr7t3gPLn8sbFPZHSJLaGs3bANov/LKSNOo+jBlhmkv23c
	GOJdY0pkIB1vV2znZOk7H1ZptNNvBX95w5uhMIfg3NAwzwnl1F1NDeNyslP54gv1XRknQv6dYwxF+
	nKGkQ5SYB64qm6xqwYrgNMa/y2FfLVCVxa8i1IeMNiIQ2I/89RNFW3lPtW6n0Iz7EJBGaikFNK6vT
	X/hw645ZPzNkIhzgBveoOPvx6lRs9IJ1XaLZnHpcmAl0RP2upa4m+CX163N2lC02JJkaDXUHiVltp
	HdPNCmYHf5IFA5SGGVhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmCkw-0006hz-O1; Wed, 23 Jan 2019 07:15:26 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gmCks-0006hg-0j; Wed, 23 Jan 2019 07:15:22 +0000
Date: Tue, 22 Jan 2019 23:15:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Message-ID: <20190123071521.GB20526@infradead.org>
References: <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
 <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
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

On Tue, Jan 22, 2019 at 10:07:07PM +0100, Ard Biesheuvel wrote:
> Yes, so much was clear. And the reason this breaks on some arm64
> systems is because
> a) non-snooped PCIe TLP attributes may be ignored, and
> b) non-x86 CPUs do not snoop the caches when accessing uncached mappings.
> 
> I don't think there is actually any disagreement on this part. And I
> think my patch is reasonable, only Christoph is objecting to it on the
> grounds that drivers should not go around the DMA API and create
> vmap()s of DMA pages with self chosen attributes.

I object to it on various grounds.  While the above is correct it really
is a mid to long-term fix.

But even in the short term your patch just maintains a random list of
idefs in a random driver, pokes into the dma-mapping internals and lacks
any comments in the code explaining on what is going on, leading to
futher cargo culting.  So it very clearly is not acceptable.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
