Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE69CC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:21:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B737D21104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G6z7EKJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B737D21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ijMdUCuLThFuC1/xLHJIaabkq4ax8qnH4t7wBoEGjtY=; b=G6z7EKJ0pHjkmB
	Nf+UTvxuESRXNHnD0SS1HZLTAk+9GVhd1cFGVzcjNjKD37LGCk28ArplusWzNVdS4RHWQejgCbGXf
	c9IhajJ4Obty9IqYMBmqqZrdg/+5P2H4KfWbtgcs1oAtxDUIOySDoyTvKP4EMJx5WW34YCBNqaBg8
	p2Ah6qYfjWnQZO5amTVbaOSus+Jfjlb7h4MEDOnBfU1m+SojyPZsEsEj+4h1TYemj0YOwIfxtRjMx
	0sM2XEVE9UPmApJNonUrx1KqeK6kW44i+py3D0UphJ6W7VxJtTXFw21XECMGLKZjdq+CNChn385qF
	isCg509mRssmuK98YNGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQvq-0007CA-FY; Thu, 29 Nov 2018 18:20:58 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQvm-0006oc-UR
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 18:20:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8307980D;
 Thu, 29 Nov 2018 10:20:44 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95BEB3F575;
 Thu, 29 Nov 2018 10:20:43 -0800 (PST)
Date: Thu, 29 Nov 2018 18:20:41 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3 2/2] arm64: crypto: add NEON accelerated XOR
 implementation
Message-ID: <20181129182040.GR3505@e103592.cambridge.arm.com>
References: <20181127100858.6995-1-liuyun01@kylinos.cn>
 <20181127100858.6995-2-liuyun01@kylinos.cn>
 <20181129170048.GQ3505@e103592.cambridge.arm.com>
 <CAKv+Gu-rm6uygi7+_=ssJ7UK-RgYgGNVyiTQ4O9zkN3JoYEB7g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-rm6uygi7+_=ssJ7UK-RgYgGNVyiTQ4O9zkN3JoYEB7g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_102054_984020_DAE420A3 
X-CRM114-Status: GOOD (  19.08  )
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
Cc: linux-block@vger.kernel.org, liuyun01 <liuyun01@kylinos.cn>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 07:09:10PM +0100, Ard Biesheuvel wrote:
> On Thu, 29 Nov 2018 at 18:00, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Tue, Nov 27, 2018 at 06:08:58PM +0800, Jackie Liu wrote:

[...]

> > > +static struct xor_block_template xor_block_arm64 = {
> > > +     .name   = "arm64_neon",
> > > +     .do_2   = xor_neon_2,
> > > +     .do_3   = xor_neon_3,
> > > +     .do_4   = xor_neon_4,
> > > +     .do_5   = xor_neon_5
> > > +};
> > > +#undef XOR_TRY_TEMPLATES
> > > +#define XOR_TRY_TEMPLATES           \
> > > +     do {        \
> > > +             xor_speed(&xor_block_8regs);    \
> > > +             xor_speed(&xor_block_32regs);    \
> > > +             if (cpu_has_neon()) { \
> > > +                     xor_speed(&xor_block_arm64);\
> > > +             } \
> > > +     } while (0)
> >
> > Should there be a may_use_simd() check somewhere?
> >
> > If we invoke this in a softirq I don't see what prevents us from
> > corrupting the task's NEON state.
> >
> > (The check might be in some surrounding glue code that I missed...)
> >
> 
> There is no check. This code should simply not be called from
> non-process context, same as the RAID56 code.
> 
> This is not terribly robust, obviously, but appears to be common
> practice in this realm of the kernel.

Fair enough -- I was just curious.

If this goes wrong, we should get a clear splat in kernel_neon_begin()
anyway.  I'd be more concerned if we could just end up scribbling over
the NEON state silently.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
