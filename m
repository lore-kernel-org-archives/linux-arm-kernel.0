Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04929C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:18:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5C820673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T00EbaY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5C820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DiiXviIoEsyn9kn6cVudfCuNxB+SJ5dOHgXDgVMIZxI=; b=T00EbaY1Q7Z2Ly
	gN50qDjPm/i07It/CJ6fUEFDiEnWAdBM3VZHn4fr537+K3LzY7v9s7Vm78t5sIv7inRgnAI/kVLCt
	PoT5OCezeuVNc586l+3qOv6GFIvh88+1IAyK/EsCRkfo/OgsOEvk4OOFCMM36EGcaHc/hbDg8kRk5
	WQfcXoxdsuUfw8646bCRdirUMT1VBAs2g9z9dE6bRccn5NxQrZCxj4aIo2aAR/LxCwsTgn5XdCv+V
	4+NkXM5wB7xZIMbsYHOlMagHILPfqrbxmfd+gD5R6GjJYvja2Pz9N2O0a0lpAfyXM1gP17G0Vue/f
	evD+6TBxQnfWS0URtlvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSewG-0000hS-FQ; Fri, 30 Nov 2018 09:18:20 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSewD-0000gP-3w
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 09:18:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98E9115AB;
 Fri, 30 Nov 2018 01:18:06 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9946C3F59C;
 Fri, 30 Nov 2018 01:18:04 -0800 (PST)
Subject: Re: [PATCH v6 05/24] irqchip/gic-v3: Switch to PMR masking before
 calling IRQ handler
To: Mark Rutland <mark.rutland@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-6-git-send-email-julien.thierry@arm.com>
 <20181129181258.jo6s4e7s3zwkp4sk@lakrids.cambridge.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <c135f7a3-ec3e-4ca2-3ef0-0d2eb845a615@arm.com>
Date: Fri, 30 Nov 2018 09:18:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181129181258.jo6s4e7s3zwkp4sk@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_011817_170309_A4B1EB07 
X-CRM114-Status: GOOD (  26.51  )
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



On 29/11/18 18:12, Mark Rutland wrote:
> On Mon, Nov 12, 2018 at 11:56:56AM +0000, Julien Thierry wrote:
>> Mask the IRQ priority through PMR and re-enable IRQs at CPU level,
>> allowing only higher priority interrupts to be received during interrupt
>> handling.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/include/asm/arch_gicv3.h   | 17 +++++++++++++++++
>>  arch/arm64/include/asm/arch_gicv3.h | 17 +++++++++++++++++
>>  drivers/irqchip/irq-gic-v3.c        | 10 ++++++++++
>>  3 files changed, 44 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
>> index bef0b5d..f6f485f 100644
>> --- a/arch/arm/include/asm/arch_gicv3.h
>> +++ b/arch/arm/include/asm/arch_gicv3.h
>> @@ -363,5 +363,22 @@ static inline void gits_write_vpendbaser(u64 val, void * __iomem addr)
>>  
>>  #define gits_read_vpendbaser(c)		__gic_readq_nonatomic(c)
>>  
>> +static inline bool gic_prio_masking_enabled(void)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline void gic_pmr_mask_irqs(void)
>> +{
>> +	/* Should not get called. */
>> +	WARN_ON_ONCE(true);
>> +}
>> +
>> +static inline void gic_arch_enable_irqs(void)
>> +{
>> +	/* Should not get called. */
>> +	WARN_ON_ONCE(true);
>> +}
>> +
>>  #endif /* !__ASSEMBLY__ */
>>  #endif /* !__ASM_ARCH_GICV3_H */
>> diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
>> index 37193e2..3f8d5f4 100644
>> --- a/arch/arm64/include/asm/arch_gicv3.h
>> +++ b/arch/arm64/include/asm/arch_gicv3.h
>> @@ -155,5 +155,22 @@ static inline u32 gic_read_rpr(void)
>>  #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
>>  #define gits_read_vpendbaser(c)		readq_relaxed(c)
>>  
>> +static inline bool gic_prio_masking_enabled(void)
>> +{
>> +	return system_supports_irq_prio_masking();
>> +}
>> +
>> +static inline void gic_pmr_mask_irqs(void)
>> +{
>> +	/* Should not get called yet. */
>> +	WARN_ON_ONCE(true);
>> +}
>> +
>> +static inline void gic_arch_enable_irqs(void)
>> +{
>> +	/* Should not get called yet. */
>> +	WARN_ON_ONCE(true);
>> +}
>> +
>>  #endif /* __ASSEMBLY__ */
>>  #endif /* __ASM_ARCH_GICV3_H */
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 8f87f40..e5d8c14 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -353,6 +353,11 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>>  	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
>>  		int err;
>>  
>> +		if (gic_prio_masking_enabled()) {
>> +			gic_pmr_mask_irqs();
>> +			gic_arch_enable_irqs();
>> +		}
> 
> IIUC, if we have two pNMIs, this will allow one to preempt another, e.g.
> 
> 	< pNMI#1 asserted >
> 
> 	< CPU takes IRQ exception for pNMI #1>
> 
> 	irqnr = gic_read_iar(); // pNMI #1
> 
> 	< pNMI#2 asserted >
> 
> 	// masks IRQs at GIC, leaves other pNMIs unmasked
> 	gic_pmr_mask_irqs()
> 	gic_arch_enable_irqs();
> 
> 	...
> 
> 	< CPU takes IRQ exception for pNMI #2 >
> 
> ... or is that not a problem? Is the NMI code re-entrant?

At this patch stage, the GICv3 handling code is not supporting
pseudo-NMIs yet, only using interrupt priorities.

I introduce this in patch 18: irqchip/gic-v3: Handle pseudo-NMIs.

And yes, this would be an issue but only after gic_write_eoir. Once an
interrupt is running, its priority becomes the running priority and only
an interrupt with higher priority can preempt it. When we do the eoir,
the running priority is dropped meaning any interrupt can preempt (if
PSR.I is cleared and its priority is not masked by PMR).

What is done in the later patch for pseudo-NMIs is that we don't switch
to PMR masking and leave the I bit set since we don't want anything to
preempt it.

> 
>> +
>>  		if (static_branch_likely(&supports_deactivate_key))
>>  			gic_write_eoir(irqnr);
>>  		else
>> @@ -371,6 +376,11 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>>  		return;
>>  	}
>>  	if (irqnr < 16) {
>> +		if (gic_prio_masking_enabled()) {
>> +			gic_pmr_mask_irqs();
>> +			gic_arch_enable_irqs();
>> +		}
> 
> Can we pull this above the two cases, or is there a problem with doing
> this for spurious IRQs?
> 

So the reason I split this is to avoid doing it for NMIs. Otherwise we
would mask PMR, clear PSR.I and once we know we have an NMI set PSR.I again.

An alternative to it would be to check whether we have an NMI before we
know the type of interrupt we have, which would be unnecessary for IPIs
and of course spurious interrupts.

Maybe I can always mask PMR and clear PSR.I (after the interrupt ack) at
this stage and then do the necessary modifications once pseudo-NMI
handling code is added?

> Where is the corresponding unmask of the PMR, and disable of IRQs? It's
> difficult to follow the logic if that's in another patch.
> 
In patch 7: arm64: Make PMR part of task context

The arch/arm64 code becomes responsible for saving/restoring the value
of PMR upon exception entry/return.

I'm not really sure whether it makes sense to merge both patches though.
Would explaining that PMR will get restored on irq return in the commit
message be sufficient?

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
