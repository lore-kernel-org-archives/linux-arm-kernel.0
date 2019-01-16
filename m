Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2A8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:02:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46400206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GnOz4ZCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46400206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n8bhIkm0+0y8LHQJWYWurr0bTs20M7YPVomGqZ5eAY4=; b=GnOz4ZCGhO1P8B
	bXF9y5gs/Rn/Ri6KnScEuo22wgIsKLLUNMVJKVpCMvnhwzK3YwI+qak9rotIFHNVt0+vt1N+M6+BD
	ac8iMpUb+XCR/OHm8+VxoJbEc1lfi/ZKt2i/S0uQcvLy4dHZQg/Jwxgx1S9HWVY2K7gBGBfTK2NYz
	EDyPDMkzph8lfF92qnp4Rx+2XY6zdbwiZbAfodKrzK+VWBRKSEk8MnLSlVlTwvE2pRbolJ2xhzmS1
	QAgCp3aUWmwhygouUYbbZrSdyHDL322s67xcJg4EIxhyO/w5hsA2fMxnp6ELJ+xts7ysulg3R/RNg
	PEK3zqUCUXlp6ysWaXnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjjuG-0000d8-Tt; Wed, 16 Jan 2019 12:02:52 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjjuD-0000cj-D2
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 12:02:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCCC1A78;
 Wed, 16 Jan 2019 04:02:46 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E044B3F5AF;
 Wed, 16 Jan 2019 04:02:45 -0800 (PST)
Date: Wed, 16 Jan 2019 12:02:43 +0000
From: Will Deacon <will.deacon@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: kaslr: ensure randomized quantities are clean to
 the PoC
Message-ID: <20190116120243.GD11240@fuggles.cambridge.arm.com>
References: <20190115194707.11614-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu_BZZVNj9scfwfuEmbPD93oyBGjs08raLgD7dQ9+3B7Fw@mail.gmail.com>
 <20190116113227.GB11240@fuggles.cambridge.arm.com>
 <20190116115805.jarm4op4ydbkofbr@mbp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116115805.jarm4op4ydbkofbr@mbp>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_040249_447551_C17A0308 
X-CRM114-Status: GOOD (  28.35  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 11:58:05AM +0000, Catalin Marinas wrote:
> On Wed, Jan 16, 2019 at 11:32:27AM +0000, Will Deacon wrote:
> > On Tue, Jan 15, 2019 at 09:12:41PM +0100, Ard Biesheuvel wrote:
> > > On Tue, 15 Jan 2019 at 20:47, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > > kaslr_early_init() is called with the kernel mapped at its
> > > > link time offset, and if it returns with a non-zero offset,
> > > > the kernel is unmapped and remapped again at the randomized
> > > > offset.
> > > >
> > > > During its execution, kaslr_early_init() also randomizes the
> > > > base of the module region and of the linear mapping of DRAM,
> > > > and sets two variables accordingly. However, since these
> > > > variables are assigned with the caches on, they may get lost
> > > > during the cache maintenance that occurs when unmapping and
> > > > remapping the kernel, so ensure that these values are cleaned
> > > > to the PoC.
> > > >
> > > > Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
> > > > Cc: <stable@vger.kernel.org> # v4.6+
> > > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > 
> > > On an affected kernel build, I see the following variables sharing the
> > > same 64-byte cacheline
> > > 
> > > ffff00001100bd18 R module_alloc_base
> > > ffff00001100bd20 R memstart_addr
> > > ffff00001100bd28 R arm64_dma_phys_limit
> > > ffff00001100bd30 R kimage_voffset
> > > ffff00001100bd38 R vabits_user
> > > 
> > > and we now have the following code in head.S (line 330)
> > > 
> > > adr_l x6, vabits_user
> > > str x5, [x6]
> > > dmb sy
> > > dc ivac, x6 // Invalidate potentially stale cache line
> > > 
> > > which is invoked after kaslr_early_init() returns.
> > 
> > Urgh, this is hideous. Well done for debugging it! It would be nice to make
> > this less fragile in future, perhaps by annotating the variable declarations
> > and ensuring they're padded to the CWG etc so that we avoid any false
> > sharing and make it very obvious what's going to be invalidated. We already
> > have .mmuoff.data.write for data written with the MMU off.
> > 
> > I'm happy to take your patch to plug the regression, but I think we should
> > aim to remove the false sharing rather than handling it. Another alternative
> > might be to use clean+invalidate instead of invalidate in head.S, along the
> > lines of:
> > 
> > 	DC CIVAC,	X0
> > 	DMB		SY
> > 	STR		X1, [X0]
> > 	DMB		SY
> > 	DC CIVAC,	X0
> > 
> > Can you foresee any issues with that?
> 
> The assumptions we've made in head.S were that any meaningful data has
> already been written back by whoever wrote it (we don't care about clean
> entries in the D-cache). Ard's patch fixes the code for this assumption.
> 
> I don't think changing head.S to CIVAC breaks anything since dirty lines
> can be randomly evicted anyway. I'm more worried about no longer
> detecting potential issues in things running prior to the kernel
> (whether it's boot-loader, qemu).

Well, this code was never about detecting broken bootloaders :) The reason
I proposed using CIVAC explicitly is because it unifies the host and guest
behaviour. I failed to reproduce the module-loading crash which was
triggered by the issue because I was testing inside a guest.

> FWIW, on Ard's patch:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Cheers, I'll pick it up as a fix.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
