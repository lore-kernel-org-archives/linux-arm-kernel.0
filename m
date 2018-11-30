Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB122C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:56:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBA72146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u1T1rVjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBA72146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ICj6881eXd0DBC0dXQWqzvalkvMm9r9U1/IL2r4q8FM=; b=u1T1rVjRqcgAud
	ByFf+TCbG8OkquDsR2wjQfvk2X6PxElZgKYE8gxHkIxu4M2nGlbC6mYYMEcOMoe8ZfNHBx8aXDvfw
	ny+AByC5t7iEGiYZsY65iMe1Q6r3eaUfVwKjfD/ALXw7mMZKbQD4VM/w/A4KIu5FT3R7AVFzoliG1
	FlLYNC0w2pV/pnNx5MwTUPJWra0PkV+Vjn1iDOooJmZsiwd6qgXhuwfqHo5kpSsY5BT69Ezw3LMxW
	FIpn5YZcp/G8HlZUShr37T27R7b12iO3AqiditsbxKCTbo7jeOht5QiCVE8MjNDqHlJWZZxzlHh+3
	8KYw3NZ+CUbNDhaUHXFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSgSw-0006Dq-9t; Fri, 30 Nov 2018 10:56:10 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSgSn-0006A3-SF
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 10:56:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5493B80D;
 Fri, 30 Nov 2018 02:55:51 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 922F63F59C;
 Fri, 30 Nov 2018 02:55:49 -0800 (PST)
Subject: Re: [PATCH v6 08/24] arm64: Unmask PMR before going idle
To: Mark Rutland <mark.rutland@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-9-git-send-email-julien.thierry@arm.com>
 <20181129174436.avqjydyzvv6ubnjd@lakrids.cambridge.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <9f157e6c-531f-8316-c326-27ff013a489e@arm.com>
Date: Fri, 30 Nov 2018 10:55:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181129174436.avqjydyzvv6ubnjd@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_025602_058866_83748666 
X-CRM114-Status: GOOD (  34.59  )
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



On 29/11/18 17:44, Mark Rutland wrote:
> On Mon, Nov 12, 2018 at 11:56:59AM +0000, Julien Thierry wrote:
>> CPU does not received signals for interrupts with a priority masked by
>> ICC_PMR_EL1. This means the CPU might not come back from a WFI
>> instruction.
>>
>> Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  arch/arm64/mm/proc.S | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 2c75b0b..3c7064c 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -20,6 +20,7 @@
>>  
>>  #include <linux/init.h>
>>  #include <linux/linkage.h>
>> +#include <linux/irqchip/arm-gic-v3.h>
>>  #include <asm/assembler.h>
>>  #include <asm/asm-offsets.h>
>>  #include <asm/hwcap.h>
>> @@ -53,10 +54,27 @@
>>   *	cpu_do_idle()
>>   *
>>   *	Idle the processor (wait for interrupt).
>> + *
>> + *	If the CPU supports priority masking we must do additional work to
>> + *	ensure that interrupts are not masked at the PMR (because the core will
>> + *	not wake up if we block the wake up signal in the interrupt controller).
>>   */
>>  ENTRY(cpu_do_idle)
>> +alternative_if_not ARM64_HAS_IRQ_PRIO_MASKING
>> +	dsb	sy				// WFI may enter a low-power mode
>> +	wfi
>> +	ret
>> +alternative_else
>> +	mrs	x0, daif			// save I bit
>> +	msr	daifset, #2			// set I bit
>> +	mrs_s	x1, SYS_ICC_PMR_EL1		// save PMR
>> +alternative_endif
>> +	mov	x2, #GIC_PRIO_IRQON
>> +	msr_s	SYS_ICC_PMR_EL1, x2		// unmask PMR
>>  	dsb	sy				// WFI may enter a low-power mode
> 
> Is the DSB SY sufficient and necessary to synchronise the update of
> SYS_ICC_PMR_EL1? We don't need an ISB too?
> 

DSB SY is necessary when we unmask interrupts to make sure that the
redistributor sees the update to PMR before we do WFI. My understanding
is that the resdistributor is free to stop forwarding interrupts to the
CPU interface if from its point of view those interrupts don't have a
high enough priority.

As for the ISB, I don't think we need one because writes to PMR are
self-synchronizing, so the write to PMR should be seen before DSB SY and
wfi.


>>  	wfi
>> +	msr_s	SYS_ICC_PMR_EL1, x1		// restore PMR
> 
> Likewise, we don't need any barriers here before we poke DAIF?

Here we don't need DSB SY because the value being restored is either:
- GIC_PRIO_IRQON which is the same as the current value, the
redistributor is already aware of it.
- GIC_PRIO_IRQOFF and the self-synchronization of PMR ensures that no
interrupts with priorities lower than the value of PMR can be taken
(this does not require to be seen by the redistributor).


For the ISB, I have this small doubt about whether it is needed between
WFI and MSR PMR. But there is this bit in the ARM ARM section D12.1.3
"General behavior of accesses to the AArch64 System registers",
subsection "Synchronization requirements for AArch64 System registers":

"Direct writes using the instructions in Table D11-2 on page D11-2660
require synchronization before software can rely on the effects of
changes to the System registers to affect instructions appearing in
program order after the direct write to the System register. Direct
writes to these registers are not allowed to affect any instructions
appearing in program order before the direct write."

ICC_PMR_EL1 is part of the mentioned table. And reordering the direct
write to PMR before the WFI would definitely affect the WFI instruction,
so my interpretation is that this would not be allowed by the
architecture. So I don't think we need the ISB either, but my
understanding could be wrong.

> 
>> +	msr	daif, x0			// restore I bit
>>  	ret
>>  ENDPROC(cpu_do_idle)
> 
> If we build without CONFIG_ARM64_PSEUDO_NMI surely we don't want to emit
> the alternative?
> 
> How about we move this to C, and have something like the below?
> 
> For the !CONFIG_ARM64_PSEUDO_NMI case it generates identical assembly to the
> existing cpu_do_idle(). Note that I've assumed we don't need barriers, which
> (as above) I'm not certain of.
> 
> Thanks,
> Mark.
> 
> ---->8----
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 7f1628effe6d..ccd2ad8c5e2f 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -73,6 +73,40 @@ EXPORT_SYMBOL_GPL(pm_power_off);
>  
>  void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
>  
> +static inline void __cpu_do_idle(void)
> +{
> +       /* WFI may enter a low-power mode */
> +       dsb(sy);
> +       wfi();
> +}
> +
> +/*
> + * When using priority masking we need to take extra care, etc.
> + */
> +static inline void __cpu_do_idle_irqprio(void)
> +{
> +       unsigned long flags = arch_local_irq_save();

The issue with this is that in patch 10, arch_local_irq_* functions
toggle PMR rather than PSR.I.

I could use local_daif_mask but I don't think disabling debug and async
is good. Otherwise and can do a small bit of  inline assembly and have
something like:

static inline void __cpu_do_idle_irqprio(void)
{
	unsigned long flags = arch_local_irq_save();

	// set PSR.I

	gic_write_pmr(GIC_PRIO_IRQON);

	__cpu_do_idle();

	arch_local_irq_restore(flags); // restores PMR and PSR.I
}


Otherwise I agree, moving it to C makes it more readable and avoid
generating code that will never get called.

I'll do it for the next version.

Thanks,

> +       unsigned long pmr = gic_read_pmr();
> +
> +       gic_write_pmr(GIC_PRIO_IRQON);
> +
> +       __cpu_do_idle();
> +
> +       gic_write_pmr(pmr);
> +       arch_local_irq_enable();
> +}
> +
> +/*
> + * Idle the processor (wait for interrupt).
> + */
> +void cpu_do_idle(void)
> +{
> +       if (system_uses_irq_prio_masking())
> +               __cpu_do_idle_irqprio();
> +       else
> +               __cpu_do_idle();
> +}
> +
>  /*
>   * This is our default idle handler.
>   */
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 03646e6a2ef4..38c0171e52e2 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -49,17 +49,6 @@
>  
>  #define MAIR(attr, mt) ((attr) << ((mt) * 8))
>  
> -/*
> - *     cpu_do_idle()
> - *
> - *     Idle the processor (wait for interrupt).
> - */
> -ENTRY(cpu_do_idle)
> -       dsb     sy                              // WFI may enter a low-power mode
> -       wfi
> -       ret
> -ENDPROC(cpu_do_idle)
> -
>  #ifdef CONFIG_CPU_PM
>  /**
>   * cpu_do_suspend - save CPU registers context
>  
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
