Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB790C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:25:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECC320863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="THDM0f3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECC320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iK33tisnzd2hB5EzQQVecirp0Jzl/3Kxc0tr+vOkSO4=; b=THDM0f3jrvI5kh
	/Pxg9Jsf2GJNEVB99zxeMO/9vF8epU8sYgPmvgc9zuiLsiJm36EcoGB2QxnK2zylHRm+Xfr06c3+W
	GUx0dVT6+eVN6uTegTUzUPNmwT2/xtKtCTXmjLwUzLk4eM0Ymi3rEOp7aDiq9LZFld58W+w2uijpI
	xXP6MFNXyn0pMdPMiNmoTBYdXlwmOpKh9JQWPoggAgtkjFNrdCtBXHsYi8MDzR8hXIsFGuNHlMyAO
	up2MYOGeJBgkgmySHghYYBbl5rklOyerSXvdkPBYWkex5vWBt6pHHZTmotMvKrbwVyClThHFdQMNI
	1ZH01Y4+6J2EDzPkF1yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSf3G-0004Zs-Ho; Fri, 30 Nov 2018 09:25:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSf35-00049g-6D
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 09:25:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC17115AB;
 Fri, 30 Nov 2018 01:25:12 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBCAA3F73F;
 Fri, 30 Nov 2018 01:25:10 -0800 (PST)
Subject: Re: [PATCH v6 07/24] arm64: Make PMR part of task context
To: Mark Rutland <mark.rutland@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-8-git-send-email-julien.thierry@arm.com>
 <20181129164600.ddr2ja5p7vc3qikb@lakrids.cambridge.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <92b85c6c-029d-d1d6-f299-32129c81009e@arm.com>
Date: Fri, 30 Nov 2018 09:25:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181129164600.ddr2ja5p7vc3qikb@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_012523_385074_1246F40A 
X-CRM114-Status: GOOD (  23.71  )
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
 james.morse@arm.com, joel@joelfernandes.org, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 29/11/18 16:46, Mark Rutland wrote:
> On Mon, Nov 12, 2018 at 11:56:58AM +0000, Julien Thierry wrote:
>> If ICC_PMR_EL1 is used to mask interrupts, its value should be
>> saved/restored whenever a task is context switched out/in or
>> gets an exception.
>>
>> Add PMR to the registers to save in the pt_regs struct upon kernel entry,
>> and restore it before ERET. Also, initialize it to a sane value when
>> creating new tasks.
> 
> Could you please elaborate on when this matters?
> 
> Does this actually matter for context-switch? Can we do that in a
> pseudo-NMI handler?
> 
> Or does this only matter for exception entry/return, and not
> context-switch?
> 

Yes, PMR becomes an equivalent of PSR.I and in the same way it will need
to be saved/restored on exception entry/return (except this is not done
by the architecture for PMR).

It is also necessary when context switching to a task that was preempted
in exception context (el1_preempt, return from syscall, ...). In the
same way as spsr_el1.

I'll update the commit message.

Thanks,

Julien

> 
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Dave Martin <Dave.Martin@arm.com>
>> ---
>>  arch/arm64/include/asm/processor.h |  3 +++
>>  arch/arm64/include/asm/ptrace.h    | 14 +++++++++++---
>>  arch/arm64/kernel/asm-offsets.c    |  1 +
>>  arch/arm64/kernel/entry.S          | 13 +++++++++++++
>>  arch/arm64/kernel/process.c        |  6 ++++++
>>  5 files changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
>> index 6b0d4df..b2315ef 100644
>> --- a/arch/arm64/include/asm/processor.h
>> +++ b/arch/arm64/include/asm/processor.h
>> @@ -168,6 +168,9 @@ static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
>>  	memset(regs, 0, sizeof(*regs));
>>  	forget_syscall(regs);
>>  	regs->pc = pc;
>> +
>> +	if (system_supports_irq_prio_masking())
>> +		regs->pmr_save = GIC_PRIO_IRQON;
>>  }
>>  
>>  static inline void start_thread(struct pt_regs *regs, unsigned long pc,
>> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
>> index ce6998c..0ad46f5 100644
>> --- a/arch/arm64/include/asm/ptrace.h
>> +++ b/arch/arm64/include/asm/ptrace.h
>> @@ -19,6 +19,8 @@
>>  #ifndef __ASM_PTRACE_H
>>  #define __ASM_PTRACE_H
>>  
>> +#include <asm/cpufeature.h>
>> +
>>  #include <uapi/asm/ptrace.h>
>>  
>>  /* Current Exception Level values, as contained in CurrentEL */
>> @@ -173,7 +175,8 @@ struct pt_regs {
>>  #endif
>>  
>>  	u64 orig_addr_limit;
>> -	u64 unused;	// maintain 16 byte alignment
>> +	/* Only valid when ARM64_HAS_IRQ_PRIO_MASKING is enabled. */
>> +	u64 pmr_save;
>>  	u64 stackframe[2];
>>  };
>>  
>> @@ -208,8 +211,13 @@ static inline void forget_syscall(struct pt_regs *regs)
>>  #define processor_mode(regs) \
>>  	((regs)->pstate & PSR_MODE_MASK)
>>  
>> -#define interrupts_enabled(regs) \
>> -	(!((regs)->pstate & PSR_I_BIT))
>> +#define irqs_priority_unmasked(regs)					\
>> +	(system_supports_irq_prio_masking() ?				\
>> +		(regs)->pmr_save & GIC_PRIO_STATUS_BIT :		\
>> +		true)
>> +
>> +#define interrupts_enabled(regs)			\
>> +	(!((regs)->pstate & PSR_I_BIT) && irqs_priority_unmasked(regs))
>>  
>>  #define fast_interrupts_enabled(regs) \
>>  	(!((regs)->pstate & PSR_F_BIT))
>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>> index 323aeb5..bab4122 100644
>> --- a/arch/arm64/kernel/asm-offsets.c
>> +++ b/arch/arm64/kernel/asm-offsets.c
>> @@ -78,6 +78,7 @@ int main(void)
>>    DEFINE(S_ORIG_X0,		offsetof(struct pt_regs, orig_x0));
>>    DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
>>    DEFINE(S_ORIG_ADDR_LIMIT,	offsetof(struct pt_regs, orig_addr_limit));
>> +  DEFINE(S_PMR_SAVE,		offsetof(struct pt_regs, pmr_save));
>>    DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
>>    DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
>>    BLANK();
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 039144e..eb8120e 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -249,6 +249,12 @@ alternative_else_nop_endif
>>  	msr	sp_el0, tsk
>>  	.endif
>>  
>> +	/* Save pmr */
>> +alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>> +	mrs_s	x20, SYS_ICC_PMR_EL1
>> +	str	x20, [sp, #S_PMR_SAVE]
>> +alternative_else_nop_endif
>> +
>>  	/*
>>  	 * Registers that may be useful after this macro is invoked:
>>  	 *
>> @@ -269,6 +275,13 @@ alternative_else_nop_endif
>>  	/* No need to restore UAO, it will be restored from SPSR_EL1 */
>>  	.endif
>>  
>> +	/* Restore pmr */
>> +alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>> +	ldr	x20, [sp, #S_PMR_SAVE]
>> +	msr_s	SYS_ICC_PMR_EL1, x20
>> +	dsb	sy
>> +alternative_else_nop_endif
>> +
>>  	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
>>  	.if	\el == 0
>>  	ct_user_enter
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index d9a4c2d..71e8850 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -231,6 +231,9 @@ void __show_regs(struct pt_regs *regs)
>>  
>>  	printk("sp : %016llx\n", sp);
>>  
>> +	if (system_supports_irq_prio_masking())
>> +		printk("pmr_save: %08llx\n", regs->pmr_save);
>> +
>>  	i = top_reg;
>>  
>>  	while (i >= 0) {
>> @@ -362,6 +365,9 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>>  		if (arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE)
>>  			childregs->pstate |= PSR_SSBS_BIT;
>>  
>> +		if (system_supports_irq_prio_masking())
>> +			childregs->pmr_save = GIC_PRIO_IRQON;
>> +
>>  		p->thread.cpu_context.x19 = stack_start;
>>  		p->thread.cpu_context.x20 = stk_sz;
>>  	}
>> -- 
>> 1.9.1
>>

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
