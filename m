Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC74C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:15:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A222082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QyODIoAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A222082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NmV8bZ/fv5b3j+kym+BDqUgZu9d3lAVvSUqskM1wG8o=; b=QyODIoARWNsgs6
	p/SIz4OQNaTlhLKoJ1jeDBDVlVrLzNjx4SvnprM9i+2jEuoXkk4/0lYOR6cfpl4HkNejRJGm88sPV
	30O2aLyIPN4Njv9y5YdNjbnHAhWpHr6cxG7osJqxT5AIp32KUzfUsRrzoE4YT3dvHU0JdTXfdzu0I
	66W01XXGVACMKkWipkJr11AiRu/nvS8AzSpYOxdBGNNzQnqS9olN/OwgbuwCHvG7cx3WU04agJMNx
	kYHr8rdHQggOukpcwrSGcA1j8HH5jGQLG0/LEh6xzTq1d01RhNy092J02tt7W2gLvrvOChq4Pypj3
	pojGg25Xgv98yVRMzxgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJik-0002m7-Sg; Fri, 07 Dec 2018 17:15:22 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJih-0001lN-Sb
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:15:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5166815AB;
 Fri,  7 Dec 2018 09:15:09 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 21A7F3F5AF;
 Fri,  7 Dec 2018 09:15:09 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 7D8611AE077B; Fri,  7 Dec 2018 17:15:30 +0000 (GMT)
Date: Fri, 7 Dec 2018 17:15:30 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 2/4] arm64: Avoid masking "old" for LSE cmpxchg()
 implementation
Message-ID: <20181207171529.GA2044@edgewater-inn.cambridge.arm.com>
References: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
 <1543347887-21101-3-git-send-email-will.deacon@arm.com>
 <CAKv+Gu9jR3EgWDzyNB3YNRrvtD2L5Xo81VJ5+FpufDTNqSs8Kw@mail.gmail.com>
 <20181207154952.GA4000@edgewater-inn.cambridge.arm.com>
 <CAKv+Gu9deCArTiuGXSw3U0hzFTd27DJmr+m1vFy+VOWZa41QuA@mail.gmail.com>
 <20181207162224.GA4159@edgewater-inn.cambridge.arm.com>
 <CAKv+Gu_Pq8+JGZ9QCAj+U7JreqD3WzW68gJf5ZxY1tHjaS5ZUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_Pq8+JGZ9QCAj+U7JreqD3WzW68gJf5ZxY1tHjaS5ZUQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_091519_937257_C17A23B3 
X-CRM114-Status: GOOD (  22.84  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 06:03:35PM +0100, Ard Biesheuvel wrote:
> On Fri, 7 Dec 2018 at 17:22, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Dec 07, 2018 at 05:05:16PM +0100, Ard Biesheuvel wrote:
> > > On Fri, 7 Dec 2018 at 16:49, Will Deacon <will.deacon@arm.com> wrote:
> > > > On Tue, Dec 04, 2018 at 05:58:50PM +0100, Ard Biesheuvel wrote:
> > > > > On Tue, 27 Nov 2018 at 20:44, Will Deacon <will.deacon@arm.com> wrote:
> > > > > > diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> > > > > > index 4d6f917b654e..a424355240c5 100644
> > > > > > --- a/arch/arm64/include/asm/atomic_lse.h
> > > > > > +++ b/arch/arm64/include/asm/atomic_lse.h
> > > > > > @@ -448,11 +448,11 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
> > > > > >
> > > > > >  #define __CMPXCHG_CASE(w, sfx, name, sz, mb, cl...)                    \
> > > > > >  static inline u##sz __cmpxchg_case_##name##sz(volatile void *ptr,      \
> > > > > > -                                             unsigned long old,        \
> > > > > > +                                             u##sz old,                \
> > > > > >                                               u##sz new)                \
> > > > > >  {                                                                      \
> > > > > >         register unsigned long x0 asm ("x0") = (unsigned long)ptr;      \
> > > > > > -       register unsigned long x1 asm ("x1") = old;                     \
> > > > > > +       register u##sz x1 asm ("x1") = old;                             \
> > > > >
> > > > > This looks backwards to me, but perhaps I am missing something:
> > > > > changing from unsigned long to a narrower type makes it the compiler's
> > > > > job to perform the cast, no? Given that 'cas' ignores the upper bits
> > > > > anyway, what does this change buy us?
> > > >
> > > > A narrowing cast doesn't actually result in any additional instructions --
> > > > the masking occurs if you do a widening cast. In this case, the change I'm
> > > > proposing means we avoid the redundant widening casts for the LSE operations
> > > > because, as you point out, the underlying instruction only operates on the
> > > > relevant bits.
> > > >
> > >
> > > Playing around with some code, I found out that
> > >
> > > static inline void foo(unsigned char x)
> > > {
> > >     asm("" :: "r"(x));
> > > }
> > >
> > > void bar(unsigned long l)
> > > {
> > >     foo(l);
> > > }
> > >
> > > produces different code than
> > >
> > > static inline void foo(unsigned longr x)
> > > {
> > >     asm("" :: "r"(x));
> > > }
> > >
> > > void bar(unsigned long l)
> > > {
> > >     foo((unsigned char)l);
> > > }
> > >
> > > so what you are saying appears to be accurate. Whether it is correct,
> > > is another matter, though, since the 'unsigned char' argument passed
> > > into the asm() block may have higher bits set.
> >
> > Right, which is why I've kept the casting for sizes < 32 bits in the LL/SC
> > code.
> >
> 
> OK.
> 
> So if we are relying on the cast to occur implicitly by the cas
> instruction, does it really make sense to change the prototype?
> Shouldn't we keep it at unsigned long so that we explicitly pass the
> whole value in (but use an explicit cast in the LL/SC implementation
> as you did)

If we change the prototype of the __cmpxchg_case_* functions so that the
old and new parameters are unsigned long, then we'll get widening casts
(and explicit masking) for any caller of cmpxchg() that passes narrower
types such as u16.

Or are you suggesting something else?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
