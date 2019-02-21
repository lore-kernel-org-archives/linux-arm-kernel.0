Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AFEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:36:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3449920818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZtktrgfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3449920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j+USVK83XMoZb2l+lgZc6nRkWQBODOnwVeV7V1vyTgE=; b=ZtktrgfWXwVPZ+
	dXEQY7pJVHaawiu6UBWEwEyI5vF+NGz0UMODZ7nEIOGsMcFT12QECNrSMgVMcH788MrLwYpY06vNK
	sJAz0A5+fU8RYGMz6bQk3I66+CUuuFhJ2drAT/Yg6AR1+Hrj+BuBYs+jLH6uBdWvOvpH3hywspyOP
	Vgk+BEAL/1QVMsj6sukhYC4hTCF8qVptskAoo5e4XEB7+Rymg8UnevT+ZNEUbv0D81AQ/I+5Ok2Ly
	DOx+HZ/DSsUqrmh/NVPU8t8evmslN8ROxLEOIhcNftRKV7qPIBeQ/IWR0P0EvNbcpU4vhLYNLZ39X
	NDcH4YrnDFknctBzDunA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gww0g-0005Uj-7s; Thu, 21 Feb 2019 21:36:02 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gww0d-0005U1-9J
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 21:36:00 +0000
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gww0R-0004wr-4M; Thu, 21 Feb 2019 22:35:47 +0100
Date: Thu, 21 Feb 2019 22:35:45 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
In-Reply-To: <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
Message-ID: <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_133559_471675_C53C9481 
X-CRM114-Status: GOOD (  13.36  )
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
Cc: jpoimboe@redhat.com, dvlasenk@redhat.com, brgerst@gmail.com,
 Peter Zijlstra <peterz@infradead.org>, catalin.marinas@arm.com,
 valentin.schneider@arm.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 mingo@redhat.com, james.morse@arm.com, luto@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, bp@alien8.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 21 Feb 2019, Julien Thierry wrote:
> On 20/02/2019 22:55, H. Peter Anvin wrote:
> > Now, __fentry__ is kind of a special beast; in some ways it is an "exception
> > implemented as a function call"; on x86 one could even consider using an INT
> > instruction in order to reduce the NOP footprint in the unarmed case.  Nor is
> > __fentry__ a C function; it has far more of an exception-like ABI.
> > *Regardless* of what else we do, I believe __fentry__ ought to
> > save/disable/restore AC, just like an exception does.
> > 
> 
> That does make sense to me. However it doesn't solve the issue of
> calling (or preventing to call) some function that rescheds.

IMNSHO any call inside a AC region is a bug lurking round the corner. The
only thing which is tolerable is an exception of some sort.

Enforce that with objtool. End of story.

Thanks,

	tglx



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
