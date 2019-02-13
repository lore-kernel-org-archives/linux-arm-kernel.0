Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E20C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:36:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D18206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WF9R72ng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D18206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2isNvQ2VotC4na4AWIYgc+XhNXbOyAM4M+FNM9NLZGA=; b=WF9R72nguBKEid
	vCeWXoXl/XEsAYVvZhZqMg77zxbeJWhwB9phnEwD1kfK0j8d+1zyRl68P/jlFrY6mJENa9Nq+ORGH
	f5y69obUTBA1cmxsTtnOtklTO4oNFTMiARI6aHRSHF/eq+wbIuj0XwlLpxMxmK0H8+B+dapRgdpU8
	2kFzKQ91vuyl3OhVrMEN8rWnguSef/RUdd/w4Frg7hmNKt6pnjIZ7XvKRwp1COMHH6af0y8VbQzoK
	BRPdJ4dMT6U04R5gtRm5xlD0fRoklUJN2JyzbZh70ozBJYcGQ9T03IWiK3OwgMXsIW+JgfevMzzru
	lj8M5AclhevZ1OZwDLjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwaU-0003bl-Kx; Wed, 13 Feb 2019 15:36:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwaR-0003bN-D9
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:36:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 605C6A78;
 Wed, 13 Feb 2019 07:36:34 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D979D3F575;
 Wed, 13 Feb 2019 07:36:32 -0800 (PST)
Date: Wed, 13 Feb 2019 15:36:30 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190213153630.GK3567@e103592.cambridge.arm.com>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_073635_466650_E0B6B04E 
X-CRM114-Status: GOOD (  35.14  )
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
Cc: linux-rt-users@vger.kernel.org, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Julien Grall <julien.grall@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 03:30:29PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-02-08 16:55:13 [+0000], Julien Grall wrote:
> > When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
> > the kernel may be able to use FPSIMD/SVE. This is for instance the case
> > for crypto code.
> > 
> > Any use of FPSIMD/SVE in the kernel are clearly marked by using the
> > function kernel_neon_{begin, end}. Furthermore, this can only be used
> > when may_use_simd() returns true.
> 
> This is equal what x86 is currently doing. The naming is slightly
> different, there is irq_fpu_usable().

Yes, I think it's basically the same idea.

It's been evolving a bit on both sides, but is quite similar now.

> > The current implementation of may_use_simd() allows softirq to use
> > FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
> > When in used, softirqs usually fallback to a software method.
> > 
> > At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
> > when touching the FPSIMD/SVE context. This has the drawback to disable
> > all softirqs even if they are not using FPSIMD/SVE.
> 
> Is this bad? This means also that your crypto code will not be
> interrupted by a softirq. Also if you would get rid of it, you could
> avoid the software fallback in case may_use_simd() says false.

Masking softirqs during kernel_neon_begin()..._end() is unlikely to be a
huge problem, but currently we block softirq during all context switch
operations that act on the CPU vector registers.

The reasons for this are somewhat historical, and IIRC predated the
requirement for softirq users of kernel-mode NEON to include the
may_use_simd() check and implement a fallback path on arm64.

Now that softirq code is required to work around kernel-mode NEON being
temporarily unusable, masking softirqs completely during context switch
etc. should no longer be necessary.

> > As a softirq should not rely on been able to use simd at a given time,
> > there are limited reason to keep softirq disabled when touching the
> > FPSIMD/SVE context. Instead, we can only disable preemption and tell
> > the NEON unit is currently in use.
> > 
> > This patch introduces two new helpers kernel_neon_{disable, enable} to
> > mark the area using FPSIMD/SVE context and use them in replacement of
> > local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
> > also re-implemented to use the new helpers.
> > 
> > Signed-off-by: Julien Grall <julien.grall@arm.com>
> > 
> > ---
> > 
> > I have been exploring this solution as an alternative approach to the RT
> > patch "arm64: fpsimd: use preemp_disable in addition to local_bh_disable()".
> > 
> > So far, the patch has only been lightly tested.
> > 
> > For RT-linux, it might be possible to use migrate_{enable, disable}. I
> > am quite new with RT and have some trouble to understand the semantics
> > of migrate_{enable, disable}. So far, I am still unsure if it is possible
> > to run another userspace task on the same CPU while getting preempted
> > when the migration is disabled.
> 
> In RT:
> - preemt_disable() is the same as !RT. A thread can not be suspend. An
>   interrupt may interrupt. However on RT we have threaded interrupts so
>   the interrupt is limited to the first-level handler (not the threaded
>   handler).
> 
> - migrate_disable() means that the thread can not be moved to another
>   CPU. It can be suspended.
> 
> - local_bh_disable() disables the BH: No softirq can run. In RT
>   local_bh_disable() does not inherit preempt_disable(). Two different
>   softirqs can be executed in parallel.
>   The BH is usually invoked at the end of the threaded interrupt
>   (because the threaded interrupt handler raises the softirq). It can
>   also run in the ksoftirqd.
> 
> Usually you should not get preempted in a migrate_disable() section. A
> SCHED_OTHER task should not interrupt another SCHED_OTHER task in a
> migrate_disable() section. A task with a higher priority (a RT/DL task)
> will. Since threaded interrupts run with a RT priority of 50, they will
> interrupt your task in a migrate_disable() section.

"Usually" is probably not good enough if another task can run: if the
preempting task enters userspace then the vector registers are needed
for its use, which is tricky to arrange if the registers are currently
in use by context switch logic running in the first task.

My current feeling is that we probably have to stick with
preempt_disable() here, but hopefully we can get rid of
local_bh_disable() (as proposed) with no ill effects...

Does that sound sensible?

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
