Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF81C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:53:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4B820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NS3kKNnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4B820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uRw11srDJYAbWylQ8ndisRxpVpV5fQbQabqdSNZ269U=; b=NS3kKNnQOA+aA5
	GCqE4QrKbSaXOVYxYZYRc7jo5vg4oAMvmEjq2nAOTPwMvXDJiHaG7JdJxGhMUY+V4mh0AEc/mIPRS
	7vNpvyezyy9lHBmAsPEVrJCWZ06aDxouvpVfieSRnhTZWmfpkrn9y2Z+dkRFkMgJug1McCOZDzxKi
	Ja/EzfUAc89wWNFWLApf9dQq118oU+FHa7UJVeCa7uxatt6zcY3m3nQ5cFo5intK+dUF8/TDqJ5XO
	PmtuVnHpczrT2JgOaF5tzTO8fwno8xi1Z3AlWQFp734ve0fTbyD3iaeGq5bk0RlRMbBsOtHVZBjbT
	ICG8KPgxeOOHXd7K566g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gooQW-0005oY-0k; Wed, 30 Jan 2019 11:53:08 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gooQS-0005np-4v
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 11:53:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC9061596;
 Wed, 30 Jan 2019 03:53:01 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99223F59C;
 Wed, 30 Jan 2019 03:52:59 -0800 (PST)
Subject: Re: [PATCH v9 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
From: Julien Thierry <julien.thierry@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-13-git-send-email-julien.thierry@arm.com>
 <20190122152149.GD187049@arrakis.emea.arm.com>
 <2eabb029-4efe-6829-7fb1-6174a2edb154@arm.com>
Message-ID: <8873213c-a667-567b-9df2-de11cdd3671a@arm.com>
Date: Wed, 30 Jan 2019 11:52:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2eabb029-4efe-6829-7fb1-6174a2edb154@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_035304_198546_DB2EC579 
X-CRM114-Status: GOOD (  23.53  )
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



On 23/01/2019 10:44, Julien Thierry wrote:
> 
> 
> On 22/01/2019 15:21, Catalin Marinas wrote:
>> On Mon, Jan 21, 2019 at 03:33:31PM +0000, Julien Thierry wrote:
>>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
>>> index 24692ed..7e82a92 100644
>>> --- a/arch/arm64/include/asm/irqflags.h
>>> +++ b/arch/arm64/include/asm/irqflags.h
>>> @@ -18,7 +18,9 @@
>>>  
>>>  #ifdef __KERNEL__
>>>  
>>> +#include <asm/alternative.h>
>>>  #include <asm/ptrace.h>
>>> +#include <asm/sysreg.h>
>>>  
>>>  /*
>>>   * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
>>> @@ -36,33 +38,31 @@
>>>  /*
>>>   * CPU interrupt mask handling.
>>>   */
>>> -static inline unsigned long arch_local_irq_save(void)
>>> -{
>>> -	unsigned long flags;
>>> -	asm volatile(
>>> -		"mrs	%0, daif		// arch_local_irq_save\n"
>>> -		"msr	daifset, #2"
>>> -		: "=r" (flags)
>>> -		:
>>> -		: "memory");
>>> -	return flags;
>>> -}
>>> -
>>>  static inline void arch_local_irq_enable(void)
>>>  {
>>> -	asm volatile(
>>> -		"msr	daifclr, #2		// arch_local_irq_enable"
>>> -		:
>>> +	unsigned long unmasked = GIC_PRIO_IRQON;
>>> +
>>> +	asm volatile(ALTERNATIVE(
>>> +		"msr	daifclr, #2		// arch_local_irq_enable\n"
>>> +		"nop",
>>> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
>>> +		"dsb	sy",
>>> +		ARM64_HAS_IRQ_PRIO_MASKING)
>>>  		:
>>> +		: "r" (unmasked)
>>>  		: "memory");
>>>  }
>>>  
>>>  static inline void arch_local_irq_disable(void)
>>>  {
>>> -	asm volatile(
>>> -		"msr	daifset, #2		// arch_local_irq_disable"
>>> -		:
>>> +	unsigned long masked = GIC_PRIO_IRQOFF;
>>> +
>>> +	asm volatile(ALTERNATIVE(
>>> +		"msr	daifset, #2		// arch_local_irq_disable",
>>> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
>>> +		ARM64_HAS_IRQ_PRIO_MASKING)
>>>  		:
>>> +		: "r" (masked)
>>>  		: "memory");
>>>  }
>>
>> Nitpicks: you could drop masked/unmasked variables here (it's up to you,
>> it wouldn't make any difference on the generated asm).
>>
> 
> Good point, I'll do that.
> 
>>> @@ -71,12 +71,44 @@ static inline void arch_local_irq_disable(void)
>>>   */
>>>  static inline unsigned long arch_local_save_flags(void)
>>>  {
>>> +	unsigned long daif_bits;
>>>  	unsigned long flags;
>>> -	asm volatile(
>>> -		"mrs	%0, daif		// arch_local_save_flags"
>>> -		: "=r" (flags)
>>> -		:
>>> +
>>> +	daif_bits = read_sysreg(daif);
>>> +
>>> +	/*
>>> +	 * The asm is logically equivalent to:
>>> +	 *
>>> +	 * if (system_uses_irq_prio_masking())
>>> +	 *	flags = (daif_bits & PSR_I_BIT) ?
>>> +	 *			GIC_PRIO_IRQOFF :
>>> +	 *			read_sysreg_s(SYS_ICC_PMR_EL1);
>>> +	 * else
>>> +	 *	flags = daif_bits;
>>> +	 */
>>> +	asm volatile(ALTERNATIVE(
>>> +			"mov	%0, %1\n"
>>> +			"nop\n"
>>> +			"nop",
>>> +			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1) "\n"
>>> +			"ands	%1, %1, " __stringify(PSR_I_BIT) "\n"
>>> +			"csel	%0, %0, %2, eq",
>>> +			ARM64_HAS_IRQ_PRIO_MASKING)
>>> +		: "=&r" (flags), "+r" (daif_bits)
>>> +		: "r" (GIC_PRIO_IRQOFF)
>>>  		: "memory");
>>> +
>>> +	return flags;
>>> +}
>>
>> BTW, how's the code generated from the C version? It will have a branch
>> but may not be too bad. Either way is fine by me.
>>
> 
> It's a bit hard to talk about the code generated from the C version as
> it can lie within several layers of inline, so the instructions for that
> section are a bit more scattered.
> 
> However, it seems like the compiler is more clever (maybe the asm
> volatile prevents some optimizations regarding register allocation or
> instruction ordering) and the C version seems to perform slightly better
> (although it could be within the noise) despite the branch.
> 
> So, I'll just switch up to the C version.
> 

I remember a reason to stick to the asm version. There is a time
interval between the (early) CPU feature being enabled and the (early)
alternatives being applied.

For the early ones, interrupts remain disabled between CPU feature
enabling and alternative application. However, if you enable lockdep, it
will do some interrupts_disabled() checks which become
local_irqs_disabled_flags(local_save_flags()). If one is using the
alternative and the other the static branch, lockdep will emit a warning
about it.

So, I tried moving all irqflags functions but using the static branch
for arch_local_irq_restore() slows things down a bit, and I'm not sure
having arch_local_irq_save() use static branch while
arch_local_irq_restore() uses alternative makes much sense.

In the end, I'll stick to the ASM + alternative version to avoid the
lockdep issue and have consistant manipulation of the irqflags.

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
