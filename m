Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8815C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99069217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TtkviSe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99069217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mHMkOUdtRGEsiLR2rFLkmIFgdg58Xcr3xt/1i21t/a8=; b=TtkviSe1ByJIT2
	/3V0RQh+GRnBbhi4xe4EYTvJcEjli4UnIOfeOFYVm9o1/64BfBfy22sNqSJxYajWDCgrE17Vp5Edu
	8GF1H95XGgTfIHZYbBaOE2PrzhR47bBdms5/c7nV6FK/EzB+yvv+euFO8wgkTtfxoqxsK0x6ab7cI
	bpZtYvRMavqzXmw/ysIm8twxxNjlCuu+NekbLH0kMGu+nDBxBYJBDTpE1qmCCX5ScOHdx31MpMwuY
	xnNQgc/cTGpqZ91rU6aqrn/REDpJTTcs05/tiwyJsjmDcRdx2fRxWvGbcIvRDYVdhO6jjlOuUdiNs
	zh5kfaL9nvAEhPBTVaPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxu0-0004rj-5O; Tue, 22 Jan 2019 15:23:48 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxtw-0004qa-Dk
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 15:23:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 461B6A78;
 Tue, 22 Jan 2019 07:23:43 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35FB83F589;
 Tue, 22 Jan 2019 07:23:42 -0800 (PST)
Date: Tue, 22 Jan 2019 15:23:39 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Subject: Re: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Message-ID: <20190122152339.GD52887@lakrids.cambridge.arm.com>
References: <8898674D84E3B24BA3A2D289B872026A6A29FA8F@G01JPEXMBKW03>
 <20190118141758.GC12256@lakrids.cambridge.arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A2A2F44@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A2A2F44@G01JPEXMBKW03>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_072344_473244_DBDA7DAA 
X-CRM114-Status: GOOD (  29.02  )
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
Cc: "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
 "'will.deacon@arm.com'" <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 02:05:26AM +0000, Zhang, Lei wrote:
> Hi, Mark
> 
> Thanks for your comments, and sorry for late.
> 
> > -----Original Message-----
> > * Under what conditions can the fault occur? e.g. is this in place of
> >   some other fault, or completely spurious?

> This fault can occur completely spurious under a specific hardware
> condition and instructions order.

Ok.

Can you be more specific regarding the conditions under which this
occurs? e.g. can this only occur with certain instruction sequences?

> > * Does this only occur for data abort? i.e. not instruction aborts?

> Yes. This fault only occurs for data abort.
> 
> > * How often does this fault occur?

> In my test, this fault occurs once every several times in the OS boot
> sequence, and after the completion of OS boot, this fault have never
> occurred.
> In my opinion, this fault rarely occurs after the completion of OS
> boot.

I'm very concerned that this could occur during boot (even if rarely),
as that implies this is being taken EL1->EL1 or EL2->EL2.

Which exception levels can the fault be taken from?

e.g. is it possible for this fault to be taken from EL2 to EL2, or from
EL3 to EL3?

> > * Does this only apply to Stage-1, or can the same faults be taken at
> >   Stage-2?
> This fault can be taken only at Stage-1.
> 
> > I'm a bit surprised by the single retry. Is there any guarantee that a
> > thread will eventually stop delivering this fault code?

> I guarantee that a thread will stop delivering this fault code by the
> this patch.
> The hardware condition which cause this fault is reset at exception
> entry, therefore execution of at least one instruction is guaranteed
> by this single retry.

Ok, so we can guarantee forward progress, but in the worst case that's
down to single-step performance levels.

> > Note that all CPUs and threads share the do_bad_ignore_first variable,
> > so this is going to behave non-deterministically and kill threads in
> > some cases.

I see now that I'd misread the code, and we'll always retry the fault
(on A64FX), so this is not true.

> > This code is also preemptible, so checking the MIDR here doesn't make
> > much sense. Either this is always uniform (and we can check once in the
> > errata framework), or it's variable (e.g. on a big.LITTLE system)
> > and we need to avoid preemption up until this point.

... though this may be a problem if A64FX is integrated into a
non-uniform system (and we could unwittingly kill threads).

> > Rather than dynamically checking the MIDR, this should use the errata
> > framework, and if any A64FX CPU is discovered, set an erratum cap like
> > ARM64_WORKAROUND_CONFIG_FUJITSU_ERRATUM_010001, so we can do something
> > like:

> I try to provide a new patch to reflect your comments in today.
> Unfortunately this bug may occurs before init_cpu_hwcaps_indirect_list
> called.

As above, I'm very concerned that this could be taken from kernel
context. There are a number of cases where we cannot handle such faults:

* During boot, when we hand-over between agents (e.g. UEFI->kernel).

* Before VBAR_EL1 is initialized.

* During exception entry/return sequences (including when the KPTI
  trampoline vectors are installed).

* While the KVM vectors are installed (for VHE).

Are there any constraints on when the fault can be raised? Under which
conditions does this happen?

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
