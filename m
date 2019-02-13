Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03139C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:43:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0BB721902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qPE48wqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BB721902
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F1XjZPrvS0Yjcue4AZlNDYzBgm6uALAKlI7vqXBIeYg=; b=qPE48wqQxzBqqp
	3O6Uyo/Tg6dsldmIp7E+frRX/BIIvEupUZ35uXPME1LNWgibiKd9zomnPQWBGPp8niZ6eoHrPeDsM
	Z14b5R1x+Tia+fiQJbXXpt+6IKKKJb8vwhBKjfl898fDxRkR2GKSZOcpld8E94B95eHMC5zU6E6WA
	MEGzBdOGJR6yCyo4+iDqJGZL6AUO1WY+QHJl8QdE9GsouTynQKmaGnkKSvPCzTO/llgpxh3KlAhZ8
	75Zk+/9vbkmv8V/0VpQDbaZaHJ41z3R8HBgt7Zs8KmdkjXlGjC4F36WlgjzYJ9YXiIlxtl9o7fy8m
	mNQebeoyEufctaHezzkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwge-0006i3-EQ; Wed, 13 Feb 2019 15:43:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwgb-0006hA-Ku
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:42:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDC04A78;
 Wed, 13 Feb 2019 07:42:56 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72E6E3F575;
 Wed, 13 Feb 2019 07:42:55 -0800 (PST)
Date: Wed, 13 Feb 2019 15:42:53 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190213154252.GL3567@e103592.cambridge.arm.com>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
 <CAKv+Gu__0uy6Y-EJGSygSYH4RqpLDWMMNFE3yauF_x7-UNcgFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu__0uy6Y-EJGSygSYH4RqpLDWMMNFE3yauF_x7-UNcgFQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_074257_702913_EFD5AE83 
X-CRM114-Status: GOOD (  18.96  )
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
Cc: linux-rt-users@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Julien Grall <julien.grall@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 04:40:00PM +0100, Ard Biesheuvel wrote:
> On Wed, 13 Feb 2019 at 16:36, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Wed, Feb 13, 2019 at 03:30:29PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2019-02-08 16:55:13 [+0000], Julien Grall wrote:
> > > > When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
> > > > the kernel may be able to use FPSIMD/SVE. This is for instance the case
> > > > for crypto code.
> > > >
> > > > Any use of FPSIMD/SVE in the kernel are clearly marked by using the
> > > > function kernel_neon_{begin, end}. Furthermore, this can only be used
> > > > when may_use_simd() returns true.
> > >
> > > This is equal what x86 is currently doing. The naming is slightly
> > > different, there is irq_fpu_usable().
> >
> > Yes, I think it's basically the same idea.
> >
> > It's been evolving a bit on both sides, but is quite similar now.
> >
> 
> may_use_simd() only exists because we have a generic crypto SIMD
> helper, and so we needed something arch agnostic to wrap around
> irq_fpu_usable()

[...]

Sounds plausible.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
