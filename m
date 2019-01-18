Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D308AC07EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:30:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52E220823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o9Sg0WwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52E220823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HQeIO7k4Q7la6RbGWj0D5Ud12Kj398z12mW9T6o0Ic4=; b=o9Sg0WwON+dtWu
	EbHcrmauSmNVVKYXZsZvQ9zBF0RI1pnbVf4OsdzWZW0OoFk5TvlzoNPL9g3OMgSwEnbokrKJkc8Hu
	c1wctq0XPccsdVUxX1bGPlVrNmSiw2bvnT5mIkzp3FOC84pzI+vfFSEcYWmc02nEhf/23UPC20vLD
	Yn5zTa9EqfYsl8//D1Q6wY5OXOFTd09UyfEwq8baWafnHLSBB2UAvMKJn8m1ojbjJd+fns7VoD0uJ
	/AgdFf3FAyDu9++WeHb/tTm4sFjKk5H8FV9k59voBlfkLwOHf5tFkeDBhT13/ul44KzvznKqWDuYj
	TMxSQTtucg+XrlmVQOnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXy8-0001Ae-9w; Fri, 18 Jan 2019 17:30:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXy4-0000fh-KK
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:30:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8321780D;
 Fri, 18 Jan 2019 09:30:07 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 7005A3F7BE; Fri, 18 Jan 2019 09:30:05 -0800 (PST)
Date: Fri, 18 Jan 2019 17:30:02 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190118173002.GA247921@arrakis.emea.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
 <20190118160920.GF118707@arrakis.emea.arm.com>
 <0af2d75e-9a61-e53b-b2df-3d08d3f63d9c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0af2d75e-9a61-e53b-b2df-3d08d3f63d9c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_093008_690991_79DE6046 
X-CRM114-Status: GOOD (  17.86  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, marc.zyngier@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 04:57:32PM +0000, Julien Thierry wrote:
> On 18/01/2019 16:09, Catalin Marinas wrote:
> > On Tue, Jan 08, 2019 at 02:07:30PM +0000, Julien Thierry wrote:
> >> +	asm volatile(ALTERNATIVE(
> >> +			"nop",
> >> +			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1),
> >> +			ARM64_HAS_IRQ_PRIO_MASKING)
> >> +		: "=&r" (pmr)
> >>  		:
> >>  		: "memory");
> >> +
> >> +	return _get_irqflags(daif_bits, pmr);
> >> +}
> > 
> > I find this confusing spread over two inline asm statements. IIUC, you
> > want something like below (it could be written as inline asm but I need
> > to understand it first):
> > 
> > 	daif_bits = read_sysreg(daif);
> > 
> > 	if (system_uses_irq_prio_masking()) {
> > 		pmr = read_gicreg(ICC_PMR_EL1);
> > 		flags = pmr & ~(daif_bits & PSR_I_BIT);
> > 	} else {
> > 		flags = daif_bits;
> > 	}
> > 
> > 	return flags;
> > 
> > In the case where the interrupts are disabled at the PSR level, is the
> > PMR value still relevant? Could we just return the GIC_PRIO_IRQOFF?
> > Something like:
> > 
> > 	flags = read_sysreg(daif);
> > 
> > 	if (system_uses_irq_prio_masking())
> > 		flags = flags & PSR_I_BIT ?
> > 			GIC_PRIO_IRQOFF : read_gicreg(ICC_PMR_EL1);
> > 
> 
> You're right, returning GIC_PRIO_IRQOFF should be good enough (it is
> actually what happens in this version because GIC_PRIO_IRQOFF ==
> GIC_PRIO_IRQON & ~PSR_I_BIT happens to be true).

This wasn't entirely clear to me, I got confused by:

+       BUILD_BUG_ON(GIC_PRIO_IRQOFF < (GIC_PRIO_IRQON & ~PSR_I_BIT));  \

and I thought there isn't necessarily an equality between the two.

> Your suggestion would
> make things easier to reason about. Maybe something like:
> 
> 
> static inline unsigned long arch_local_save_flags(void)
> {
> 	unsigned long daif_bits;
> 	unsigned long prio_off = GIC_PRIO_IRQOFF;
> 
> 	daif_bits = read_sysreg(daif);
> 
> 	asm volatile(ALTERNATIVE(
> 		"mov	%0, %1\n"
> 		"nop\n"
> 		"nop",
> 		"mrs	%0, SYS_ICC_PMR_EL1\n"
> 		"ands	%1, %1, PSR_I_BIT\n"
> 		"csel	%0, %0, %2, eq")
> 	: "=&r" (flags)
> 	: "r" (daif_bits), "r" (prio_off)
> 	: "memory");
> 
> 	return flags;
> }

It looks fine. If you turn the BUILD_BUG_ON into a !=, you could
probably simplify the asm a bit (though the number of instructions
generated would probably be the same). Untested:

static inline unsigned long arch_local_save_flags(void)
{
	unsigned long flags;

	flags = read_sysreg(daif);

	asm volatile(ALTERNATIVE(
		"nop",
		"bic	%0, %1, %2")
	: "=&r" (flags)
	: "r" (flags & PSR_I_BIT), "r" (GIC_PRIO_IRQOFF)
	: "memory");

	return flags;
}

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
