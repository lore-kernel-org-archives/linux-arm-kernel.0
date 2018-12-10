Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F02CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:39:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300B72084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dN4z4wWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300B72084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5k7yBscsoOkYbf+CaJqHwBvmv+1iZOc8iOqH+IyjH9o=; b=dN4z4wWlRsw9VG
	WSK74BcVElMyQerJexBvnY3hHvKrr1gkywiUU+sgqK5EvmXTFkKnHRAaCYRXs/26VrJ/BInCRh02a
	1+OfZku5Foz3/xMR7umG+tALouoNm7GIGCkD/rL7NQoa72RbdIs1bzwYhBc2AXl66qWq0+6FjNnOa
	8w8khGPMqdwDIHXOGBVmtsJa6mM56iD+ySN5W2okLJ3SqTSa+xjWzmoDSDD/hwqZA+/QuQ278XcDF
	zF3osg6OY0dsoY5zF+1TwKCDuibdGxaB41F15iPOcF6yjl7hP1vuav7LSR+pAAkxRw89LHIw7/imK
	uklZPv/0q5qKgT+TEd6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWMig-0004F0-9E; Mon, 10 Dec 2018 14:39:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWMic-0004EF-Na
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 14:39:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 576DD15AD;
 Mon, 10 Dec 2018 06:39:24 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 6686D3F575; Mon, 10 Dec 2018 06:39:22 -0800 (PST)
Date: Mon, 10 Dec 2018 14:39:19 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 10/24] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20181210143919.GD4048@arrakis.emea.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-11-git-send-email-julien.thierry@arm.com>
 <20181204173610.GC19210@arrakis.emea.arm.com>
 <bc8d0621-8b6c-c678-49ec-ad1c96bac88a@arm.com>
 <20181205182616.GE27881@arrakis.emea.arm.com>
 <b8bcfa89-8c57-6e16-1861-9379f6762584@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b8bcfa89-8c57-6e16-1861-9379f6762584@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_063934_778804_2A0CBF06 
X-CRM114-Status: GOOD (  26.06  )
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
Cc: daniel.thompson@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 marc.zyngier@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>,
 joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 09:50:18AM +0000, Julien Thierry wrote:
> On 05/12/18 18:26, Catalin Marinas wrote:
> > On Wed, Dec 05, 2018 at 04:55:54PM +0000, Julien Thierry wrote:
> >> On 04/12/18 17:36, Catalin Marinas wrote:
> >>> On Mon, Nov 12, 2018 at 11:57:01AM +0000, Julien Thierry wrote:
> >>>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> >>>> index 24692ed..e0a32e4 100644
> >>>> --- a/arch/arm64/include/asm/irqflags.h
> >>>> +++ b/arch/arm64/include/asm/irqflags.h
> >>>> @@ -18,7 +18,27 @@
> >>>>  
> >>>>  #ifdef __KERNEL__
> >>>>  
> >>>> +#include <asm/alternative.h>
> >>>> +#include <asm/cpufeature.h>
> >>>>  #include <asm/ptrace.h>
> >>>> +#include <asm/sysreg.h>
> >>>> +
> >>>> +
> >>>> +/*
> >>>> + * When ICC_PMR_EL1 is used for interrupt masking, only the bit indicating
> >>>> + * whether the normal interrupts are masked is kept along with the daif
> >>>> + * flags.
> >>>> + */
> >>>> +#define ARCH_FLAG_PMR_EN 0x1
> >>>> +
> >>>> +#define MAKE_ARCH_FLAGS(daif, pmr)					\
> >>>> +	((daif) | (((pmr) >> GIC_PRIO_STATUS_SHIFT) & ARCH_FLAG_PMR_EN))
> >>>> +
> >>>> +#define ARCH_FLAGS_GET_PMR(flags)				 \
> >>>> +	((((flags) & ARCH_FLAG_PMR_EN) << GIC_PRIO_STATUS_SHIFT) \
> >>>> +		| GIC_PRIO_IRQOFF)
> >>>> +
> >>>> +#define ARCH_FLAGS_GET_DAIF(flags) ((flags) & ~ARCH_FLAG_PMR_EN)
> >>>
> >>> I wonder whether we could just use the PSR_I_BIT here to decide whether
> >>> to set the GIC_PRIO_IRQ{ON,OFF}. We could clear the PSR_I_BIT in
> >>> _restore_daif() with an alternative.
> >>
> >> So, the issue with it is that some contexts might be using PSR.I to
> >> disable interrupts (any contexts with async errors or debug exceptions
> >> disabled, kvm guest entry paths, pseudo-NMIs, ...).
> >>
> >> If any of these contexts calls local_irq_save()/local_irq_restore() or
> >> local_daif_save()/local_daif_restore(), by only relying on PSR_I_BIT to
> >> represent the PMR status, we might end up clearing PSR.I when we shouldn't.
> >>
> >> I'm not sure whether there are no callers of these functions in those
> >> context. But if that is the case, we could simplify things, yes.
> > 
> > There are callers of local_daif_save() (3) and local_daif_mask() (7) but
> > do they all need to disable the pseudo-NMIs?
> 
> Hmmm, I really think that both of those should be disabling NMIs.
> Otherwise, if we take an NMI, the first thing the el1_irq handler is
> going to do is "enable_da_f()" which could lead to potential issues.
> 
> One thing that could be done is:
> - local_daif_save() and local_daif_mask() both mask all daif bits
> (taking care to represent PMR value in the I bit of the saved flags)
> - local_daif_restore() restores da_f as expected and decides values to
> put for PMR and PSR.I as follows:
> 	* do the da_f restore
> 	* if PSR.A bit is cleared in the saved flags, then we also do a start_nmi()
> 
> However, this would not work with a local_daif_save()/restore() on the
> return path of an NMI because I think it is the only context with NMIs
> "stopped" that can take aborts. I can add a WARN_ON(in_nmi()) for
> local_daif_restore() if that doesn't affect performance too much.

FTR, as we discussed this in the office, the conclusion (IIUC) we got to
was: leave the *_daif_*() functions unchanged, touching all the
corresponding PSTATE bits, but change the arch_local_irq_*() macros to
only touch the PMR when the feature is enabled.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
