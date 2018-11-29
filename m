Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E599DC43610
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:13:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4868213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X2Pdo7WM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4868213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xo01f/Pw717r3gzjkcMrA5KiB7vhfDocPCtZ52zACfg=; b=X2Pdo7WM68H1FJ
	g3ChneSW0W+XsyhkzJqpGJh9mzhA6hWtcRN1bdzE36eDIiXQjk9medttSBW0tM/SGQPbdY2BQmeRZ
	L/UY3D+ssiY9w3uPjXUxNXbtOa/PmJNyMXqGVGmNDw8B3J4yylzyGpan2rOp/h9x7kFHM2/ubqP4U
	c6MdlR99+ga9qoVowU0q2RpZNuekrwDJjm9S9YOObCqLJf2lnJ6fMH026bH2ppj8FP0D+tq+v2HoI
	scdeQT/AEU1skXG0DZPsbikpE0m2dNV6hlRpUHz01l9WV2uVhiNLa87FPBcx191YdpJx1u+eikxpY
	FGBur43HALCJKAQPoJtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQoP-0002s7-L6; Thu, 29 Nov 2018 18:13:17 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQoM-0002rI-6o
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 18:13:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96B2E80D;
 Thu, 29 Nov 2018 10:13:03 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 814393F575;
 Thu, 29 Nov 2018 10:13:01 -0800 (PST)
Date: Thu, 29 Nov 2018 18:12:59 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 05/24] irqchip/gic-v3: Switch to PMR masking before
 calling IRQ handler
Message-ID: <20181129181258.jo6s4e7s3zwkp4sk@lakrids.cambridge.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-6-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542023835-21446-6-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_101314_262885_760E0156 
X-CRM114-Status: GOOD (  21.11  )
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
Cc: daniel.thompson@linaro.org, Jason Cooper <jason@lakedaemon.net>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 joel@joelfernandes.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 12, 2018 at 11:56:56AM +0000, Julien Thierry wrote:
> Mask the IRQ priority through PMR and re-enable IRQs at CPU level,
> allowing only higher priority interrupts to be received during interrupt
> handling.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/arch_gicv3.h   | 17 +++++++++++++++++
>  arch/arm64/include/asm/arch_gicv3.h | 17 +++++++++++++++++
>  drivers/irqchip/irq-gic-v3.c        | 10 ++++++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
> index bef0b5d..f6f485f 100644
> --- a/arch/arm/include/asm/arch_gicv3.h
> +++ b/arch/arm/include/asm/arch_gicv3.h
> @@ -363,5 +363,22 @@ static inline void gits_write_vpendbaser(u64 val, void * __iomem addr)
>  
>  #define gits_read_vpendbaser(c)		__gic_readq_nonatomic(c)
>  
> +static inline bool gic_prio_masking_enabled(void)
> +{
> +	return false;
> +}
> +
> +static inline void gic_pmr_mask_irqs(void)
> +{
> +	/* Should not get called. */
> +	WARN_ON_ONCE(true);
> +}
> +
> +static inline void gic_arch_enable_irqs(void)
> +{
> +	/* Should not get called. */
> +	WARN_ON_ONCE(true);
> +}
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* !__ASM_ARCH_GICV3_H */
> diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
> index 37193e2..3f8d5f4 100644
> --- a/arch/arm64/include/asm/arch_gicv3.h
> +++ b/arch/arm64/include/asm/arch_gicv3.h
> @@ -155,5 +155,22 @@ static inline u32 gic_read_rpr(void)
>  #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
>  #define gits_read_vpendbaser(c)		readq_relaxed(c)
>  
> +static inline bool gic_prio_masking_enabled(void)
> +{
> +	return system_supports_irq_prio_masking();
> +}
> +
> +static inline void gic_pmr_mask_irqs(void)
> +{
> +	/* Should not get called yet. */
> +	WARN_ON_ONCE(true);
> +}
> +
> +static inline void gic_arch_enable_irqs(void)
> +{
> +	/* Should not get called yet. */
> +	WARN_ON_ONCE(true);
> +}
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_ARCH_GICV3_H */
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 8f87f40..e5d8c14 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -353,6 +353,11 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>  	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
>  		int err;
>  
> +		if (gic_prio_masking_enabled()) {
> +			gic_pmr_mask_irqs();
> +			gic_arch_enable_irqs();
> +		}

IIUC, if we have two pNMIs, this will allow one to preempt another, e.g.

	< pNMI#1 asserted >

	< CPU takes IRQ exception for pNMI #1>

	irqnr = gic_read_iar(); // pNMI #1

	< pNMI#2 asserted >

	// masks IRQs at GIC, leaves other pNMIs unmasked
	gic_pmr_mask_irqs()
	gic_arch_enable_irqs();

	...

	< CPU takes IRQ exception for pNMI #2 >

... or is that not a problem? Is the NMI code re-entrant?

> +
>  		if (static_branch_likely(&supports_deactivate_key))
>  			gic_write_eoir(irqnr);
>  		else
> @@ -371,6 +376,11 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>  		return;
>  	}
>  	if (irqnr < 16) {
> +		if (gic_prio_masking_enabled()) {
> +			gic_pmr_mask_irqs();
> +			gic_arch_enable_irqs();
> +		}

Can we pull this above the two cases, or is there a problem with doing
this for spurious IRQs?

Where is the corresponding unmask of the PMR, and disable of IRQs? It's
difficult to follow the logic if that's in another patch.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
