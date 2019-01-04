Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61A9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:48:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D0B2070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M+IGzTeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D0B2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eVKziKGawHX5Pn9r8Kqfk8bMel7o5epFv0+5YRz/AaY=; b=M+IGzTeLKhn9WS
	DBbcGNGIenJiKcld3J4+NgUMAY5qRwaUcN3vwYqe81Ujwh3CRBCVMUHC8om16/Al3CVFJwSOnL8AH
	1XFQEvODT7VVEqMRV1kVxwujgGTVvA5DKes9irpqIDM1EXNSV1sVUgHqjjAtvC9BraUVXmn6w7GIf
	Q8kN8Q+MMpwxPvE0HC42KSfuEcA+p+p+c68Ev53QoZ1xrnLkbTNf41DH94q0Ip/dFIotIAA0E0uJR
	dDKEp94z1OLs7dvkz+PAY+v0TkikiYOEHhXH/alVJfSv59N3j3QxgRRZD6+XHdRxGLNqr26kJIMF4
	a3ZZKUfmuau2yw6NPgmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfPpZ-0004yF-8U; Fri, 04 Jan 2019 13:48:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfPpG-0004cf-SX
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 13:47:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7282AEBD;
 Fri,  4 Jan 2019 05:47:49 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 403993F706;
 Fri,  4 Jan 2019 05:47:49 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id C66041AE0C63; Fri,  4 Jan 2019 13:47:49 +0000 (GMT)
Date: Fri, 4 Jan 2019 13:47:49 +0000
From: Will Deacon <will.deacon@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 1/3] arm64: compat: Avoid sending SIGILL for unallocated
 syscall numbers
Message-ID: <20190104134749.GA28158@edgewater-inn.cambridge.arm.com>
References: <1546539240-20647-1-git-send-email-will.deacon@arm.com>
 <1546539240-20647-2-git-send-email-will.deacon@arm.com>
 <20190104125425.GB3571@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104125425.GB3571@e103592.cambridge.arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_054751_290889_F6676F99 
X-CRM114-Status: GOOD (  26.22  )
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
Cc: pihsun@chromium.org, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 04, 2019 at 12:54:26PM +0000, Dave Martin wrote:
> On Thu, Jan 03, 2019 at 06:13:58PM +0000, Will Deacon wrote:
> > The ARM Linux kernel handles the EABI syscall numbers as follows:
> > 
> >   0           - NR_SYSCALLS-1	: Invoke syscall via syscall table
> >   NR_SYSCALLS - 0xeffff		: -ENOSYS (to be allocated in future)
> >   0xf0000     - 0xf07ff		: Private syscall or -ENOSYS if not allocated
> >   > 0xf07ff			: SIGILL
> > 
> > Our compat code gets this wrong and ends up sending SIGILL in response
> > to all syscalls greater than NR_SYSCALLS which have a value greater
> > than 0x7ff in the bottom 16 bits.
> > 
> > Fix this by defining the end of the ARM private syscall region and
> > checking the syscall number against that directly. Update the comment
> > while we're at it.
> > 
> > Cc: <stable@vger.kernel.org>
> > Cc: Dave Martin <Dave.Martin@arm.com>
> > Reported-by: Pi-Hsun Shih <pihsun@chromium.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/unistd.h | 5 +++--
> >  arch/arm64/kernel/sys_compat.c  | 4 ++--
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> > index b13ca091f833..be66a54ee3a1 100644
> > --- a/arch/arm64/include/asm/unistd.h
> > +++ b/arch/arm64/include/asm/unistd.h
> > @@ -40,8 +40,9 @@
> >   * The following SVCs are ARM private.
> >   */
> >  #define __ARM_NR_COMPAT_BASE		0x0f0000
> > -#define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE+2)
> > -#define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE+5)
> > +#define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE + 2)
> > +#define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
> > +#define __ARM_NR_compat_syscall_end	(__ARM_NR_COMPAT_BASE + 0x800)
> 
> Nit: there is no compat_syscall_end().  Can we make this #define upper
> case, like __ARM_NR_COMPAT_BASE, since a symbolic bound, not a syscall
> number?

That's fair; I'll rename it to __ARM_NR_COMPAT_END.

> >  #define __NR_compat_syscalls		399
> >  #endif
> > diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
> > index 32653d156747..5972b7533fa0 100644
> > --- a/arch/arm64/kernel/sys_compat.c
> > +++ b/arch/arm64/kernel/sys_compat.c
> > @@ -102,12 +102,12 @@ long compat_arm_syscall(struct pt_regs *regs)
> >  
> >  	default:
> >  		/*
> > -		 * Calls 9f00xx..9f07ff are defined to return -ENOSYS
> > +		 * Calls 0xf0xxx..0xf07ff are defined to return -ENOSYS
> >  		 * if not implemented, rather than raising SIGILL. This
> >  		 * way the calling program can gracefully determine whether
> >  		 * a feature is supported.
> >  		 */
> > -		if ((no & 0xffff) <= 0x7ff)
> > +		if (no < __ARM_NR_compat_syscall_end)
> 
> arm_syscall() in arch/arm is not responsible for handling syscalls less
> __ARM_NR_BASE; the code in entry-common.S redirects those directly to
> sys_ni_syscall() instead.
> 
> Given how fiddly this is I think it's preferable if we keep to the
> arch/arm code structure as much as possible, and call this function only
> when no >= __ARM_NR_COMPAT_BASE?

I don't think we should be using the arm code structure as a template here.
Although we're providing the same interface, we don't have to worry about
things like OABI or ARM vs THUMB entry code. We're also in the process of
moving more of this out of assembly and into C, so I'd rather keep the
compat code as self-contained as possible.

Even if we did modify the caller so that we only call compat_arm_syscall()
for numbers >= __ARM_NR_COMPAT_BASE, we'd still need the check above to
handle numbers >= __ARM_NR_COMPAT_END, so I don't think we gain anything.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
