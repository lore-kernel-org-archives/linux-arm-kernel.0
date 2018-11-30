Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AEEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:37:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1856520863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZbfojlV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1856520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=izZnDisuEcGKuAyKWMXlJZV1yKQ8Idq08AZhvb8nm6c=; b=ZbfojlV8SjezEk
	nLbJkHAd2AnEwgwUfih0ajI2qSop6QCLhTSvDnzBlv272zMTwCx8AW9NoR/qu0XCtDZ1F+jGA+t2y
	t07aH3qhu9DhNQTK7+lRfw4z5dkk0m0li5K5wDzumLMVpjeuePmexEVS5Dp8ZtjPIFXG0uKizrqDC
	8gt4OR9aTIVnyhfKn7r2iQ4P4eRPyl3oP7chCbakKSJqyIJu0FFcC34i+ccWsEeqR4k+IG8CYEZ57
	AkgaBtXTAJdcdf1ddrfqH3LU1nHVwi5MgPT+c7uwQopi3/RWFHV77t0Kbuj6c0GVLqLhQvI9UtiYT
	bcEeYYvH0+BAEtGIGhtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSizH-0008MB-6h; Fri, 30 Nov 2018 13:37:43 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSizC-0008Ky-W1
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 13:37:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AE52A78;
 Fri, 30 Nov 2018 05:37:26 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D9563F5A0;
 Fri, 30 Nov 2018 05:37:24 -0800 (PST)
Date: Fri, 30 Nov 2018 13:37:19 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 08/24] arm64: Unmask PMR before going idle
Message-ID: <20181130133719.zw7wcklqayiebgap@lakrids.cambridge.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-9-git-send-email-julien.thierry@arm.com>
 <20181129174436.avqjydyzvv6ubnjd@lakrids.cambridge.arm.com>
 <9f157e6c-531f-8316-c326-27ff013a489e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9f157e6c-531f-8316-c326-27ff013a489e@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_053739_049426_07BA8EE4 
X-CRM114-Status: GOOD (  32.33  )
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
Cc: daniel.thompson@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 10:55:47AM +0000, Julien Thierry wrote:
> On 29/11/18 17:44, Mark Rutland wrote:
> > On Mon, Nov 12, 2018 at 11:56:59AM +0000, Julien Thierry wrote:

> >> +	mov	x2, #GIC_PRIO_IRQON
> >> +	msr_s	SYS_ICC_PMR_EL1, x2		// unmask PMR
> >>  	dsb	sy				// WFI may enter a low-power mode
> > 
> > Is the DSB SY sufficient and necessary to synchronise the update of
> > SYS_ICC_PMR_EL1? We don't need an ISB too?
> 
> DSB SY is necessary when we unmask interrupts to make sure that the
> redistributor sees the update to PMR before we do WFI. My understanding
> is that the resdistributor is free to stop forwarding interrupts to the
> CPU interface if from its point of view those interrupts don't have a
> high enough priority.
> 
> As for the ISB, I don't think we need one because writes to PMR are
> self-synchronizing, so the write to PMR should be seen before DSB SY and
> wfi.

Having looked at ARM IHI 0069D, 8.1.6 "Observability of the effects of
accesses to the GIC registers", I think I agree. 

My specific concern was that a CPU might complete the DSB before the
MSR, but I think it's clear per the GIC spec it's clear that an ISB is
not expected between the MSR and DSB, even if that's unusual.

> >>  	wfi
> >> +	msr_s	SYS_ICC_PMR_EL1, x1		// restore PMR
> > 
> > Likewise, we don't need any barriers here before we poke DAIF?
> 
> Here we don't need DSB SY because the value being restored is either:
> - GIC_PRIO_IRQON which is the same as the current value, the
> redistributor is already aware of it.
> - GIC_PRIO_IRQOFF and the self-synchronization of PMR ensures that no
> interrupts with priorities lower than the value of PMR can be taken
> (this does not require to be seen by the redistributor).
> 
> For the ISB, I have this small doubt about whether it is needed between
> WFI and MSR PMR. But there is this bit in the ARM ARM section D12.1.3
> "General behavior of accesses to the AArch64 System registers",
> subsection "Synchronization requirements for AArch64 System registers":
> 
> "Direct writes using the instructions in Table D11-2 on page D11-2660
> require synchronization before software can rely on the effects of
> changes to the System registers to affect instructions appearing in
> program order after the direct write to the System register. Direct
> writes to these registers are not allowed to affect any instructions
> appearing in program order before the direct write."
> 
> ICC_PMR_EL1 is part of the mentioned table.

I think that's a defect in the ARM ARM, given it disagrees with the GIC
spec.

> And reordering the direct write to PMR before the WFI would definitely
> affect the WFI instruction, so my interpretation is that this would
> not be allowed by the architecture. So I don't think we need the ISB
> either, but my understanding could be wrong.

We already assume that a DSB can't be re-ordered w.r.t. the WFI, so as
long as the DSB can't complete before the MSR, I think we're good.

> > 
> >> +	msr	daif, x0			// restore I bit
> >>  	ret
> >>  ENDPROC(cpu_do_idle)
> > 
> > If we build without CONFIG_ARM64_PSEUDO_NMI surely we don't want to emit
> > the alternative?
> > 
> > How about we move this to C, and have something like the below?
> > 
> > For the !CONFIG_ARM64_PSEUDO_NMI case it generates identical assembly to the
> > existing cpu_do_idle(). Note that I've assumed we don't need barriers, which
> > (as above) I'm not certain of.
> > 
> > Thanks,
> > Mark.
> > 
> > ---->8----
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 7f1628effe6d..ccd2ad8c5e2f 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -73,6 +73,40 @@ EXPORT_SYMBOL_GPL(pm_power_off);
> >  
> >  void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
> >  
> > +static inline void __cpu_do_idle(void)
> > +{
> > +       /* WFI may enter a low-power mode */
> > +       dsb(sy);
> > +       wfi();
> > +}
> > +
> > +/*
> > + * When using priority masking we need to take extra care, etc.
> > + */
> > +static inline void __cpu_do_idle_irqprio(void)
> > +{
> > +       unsigned long flags = arch_local_irq_save();
> 
> The issue with this is that in patch 10, arch_local_irq_* functions
> toggle PMR rather than PSR.I.
> 
> I could use local_daif_mask but I don't think disabling debug and async
> is good. Otherwise and can do a small bit of  inline assembly and have
> something like:

Can we factor out the existing arch_local_irq_save() somehow?

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
