Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85B6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6A1214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ATfRTzK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6A1214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G4jSZ6LWYSdgJqG6Va0mgC5whshV+VKgJ/dNjfNttlU=; b=ATfRTzK1/OmGYC
	MXvyiAJ8THmqWeJQIuSlazExh34UskWHiizivCqRZ+KQiKQOEsZbe0LVZUCeQj55taoeu+BvtWU9v
	EplSLp5aqOyJrgtfFmdYzjk0ddmQ+EdZX8pqwVqwz431aH7VsLRxUXgjhIG5ZBzJJ2RSiE8oE+OIV
	jKK7qodFMdq1G4pHTdXTTERcQ0PwAnVvG5FdUdCdQj8kdCTmeNwn2KLWQau7RjGe8FjSWM5erSEL2
	A2E9CehqkuYPLSPhE/Mp2mdxcw3mMsylf21SwBkdh6r01J0akvjuBw3Ek1Mz++4vHagDXDYtZHH46
	lA7ErX/aLdH10VGG0XZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUzAj-0004Ol-F3; Thu, 06 Dec 2018 19:18:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUzAS-00049X-3a
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 19:18:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C699DA78;
 Thu,  6 Dec 2018 11:18:25 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 96B863F59C;
 Thu,  6 Dec 2018 11:18:25 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id B9BB81AE0BAD; Thu,  6 Dec 2018 19:18:46 +0000 (GMT)
Date: Thu, 6 Dec 2018 19:18:46 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/2] arm64: Only call into preempt_schedule() if
 need_resched()
Message-ID: <20181206191846.GB20796@arm.com>
References: <1543599271-14339-1-git-send-email-will.deacon@arm.com>
 <20181206150850.GI13538@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206150850.GI13538@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_111836_173693_ED9CCBDE 
X-CRM114-Status: GOOD (  18.32  )
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
Cc: ard.biesheuvel@linaro.org, catalin.marinas@arm.com, rml@tech9.net,
 linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Peter,

On Thu, Dec 06, 2018 at 04:08:50PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 30, 2018 at 05:34:29PM +0000, Will Deacon wrote:
> > This is version two of the patches I originally posted here:
> > 
> >   http://lkml.kernel.org/r/1543347902-21170-1-git-send-email-will.deacon@arm.com
> > 
> > The only change since v1 is that  __preempt_count_dec_and_test() now
> > reloads the need_resched flag if it initially saw that it was set. This
> > resolves the issue spotted by Peter, where an IRQ coming in during the
> > decrement can cause a reschedule to be missed.
> 
> Yes, I think this one will work, so:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

> However, this leaves me wondering if the sequence is actually much
> better than what you had?
> 
> I suppose there's a win due to cache locality -- you only have to load a
> single line -- but I'm thinking that on pure instruction count, you're
> not actually winning much.

The fast path is still slightly shorter in terms of executed instructions,
but you're right that the win is likely to be because everything hits in the
cache or the store buffer when we're not preempting, so we should run
through the code reasonably quickly and avoid the unconditional call to
preempt_schedule().

Will

--->8

// Before
  20:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
  24:   910003fd        mov     x29, sp
  28:   d5384101        mrs     x1, sp_el0
  2c:   b9401020        ldr     w0, [x1, #16]
  30:   51000400        sub     w0, w0, #0x1
  34:   b9001020        str     w0, [x1, #16]
  38:   350000a0        cbnz    w0, 4c <preempt_enable+0x2c>
  3c:   f9400020        ldr     x0, [x1]
  40:   721f001f        tst     w0, #0x2
  44:   54000040        b.eq    4c <preempt_enable+0x2c>  // b.none
  48:   94000000        bl      0 <preempt_schedule>
  4c:   a8c17bfd        ldp     x29, x30, [sp], #16
  50:   d65f03c0        ret

// After
  20:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
  24:   910003fd        mov     x29, sp
  28:   d5384101        mrs     x1, sp_el0
  2c:   f9400820        ldr     x0, [x1, #16]
  30:   d1000400        sub     x0, x0, #0x1
  34:   b9001020        str     w0, [x1, #16]
  38:   b5000080        cbnz    x0, 48 <preempt_enable+0x28>
  3c:   94000000        bl      0 <preempt_schedule>
  40:   a8c17bfd        ldp     x29, x30, [sp], #16
  44:   d65f03c0        ret
  48:   f9400820        ldr     x0, [x1, #16]
  4c:   b5ffffa0        cbnz    x0, 40 <preempt_enable+0x20>
  50:   94000000        bl      0 <preempt_schedule>
  54:   17fffffb        b       40 <will_preempt_enable+0x20>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
