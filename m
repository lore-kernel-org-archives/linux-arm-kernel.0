Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9956C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:46:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8D220989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mKS7fDSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8D220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fLfeoRC+vSqRGEgJCIpXiAI78ST3AClB1j5RWAcEFKI=; b=mKS7fDStS3Q8x/
	aTWvPpk59m3dUHKT7I4Afi098FuCL3D24f2kTeaHxXKl0jju3sVyxI5aeyEqaRb43BUmnJfuyyC80
	TNtq3y51+CglgZ/ePKvoNxeBULaUXAfSagroE3TAqUq5zZR7aR9nPSD0R4MT5TF8CxRH5T5oYnvrZ
	7RYUWsHOed019Uknt/vNscEjGwWBdcyf/8yXKI03xe0oSCB28EMeRc2rpqgeeLn8g7CHnf7ojQbPl
	V7wgaKBTc4PugKwCM0D1HKloxYs4GywHIkPgOQRlOsFI/lk25PCQ7WXzfANcvxGTw1CjExnyWqFKL
	kGmGGudsCXljmpH/vm1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPSF-0007x1-0h; Thu, 29 Nov 2018 16:46:19 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPSB-0007vx-95
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:46:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6434A78;
 Thu, 29 Nov 2018 08:46:04 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0168C3F59C;
 Thu, 29 Nov 2018 08:46:02 -0800 (PST)
Date: Thu, 29 Nov 2018 16:46:00 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 07/24] arm64: Make PMR part of task context
Message-ID: <20181129164600.ddr2ja5p7vc3qikb@lakrids.cambridge.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-8-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542023835-21446-8-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_084615_325597_C68FC0E4 
X-CRM114-Status: GOOD (  21.74  )
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

On Mon, Nov 12, 2018 at 11:56:58AM +0000, Julien Thierry wrote:
> If ICC_PMR_EL1 is used to mask interrupts, its value should be
> saved/restored whenever a task is context switched out/in or
> gets an exception.
> 
> Add PMR to the registers to save in the pt_regs struct upon kernel entry,
> and restore it before ERET. Also, initialize it to a sane value when
> creating new tasks.

Could you please elaborate on when this matters?

Does this actually matter for context-switch? Can we do that in a
pseudo-NMI handler?

Or does this only matter for exception entry/return, and not
context-switch?

Thanks,
Mark.

> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/include/asm/processor.h |  3 +++
>  arch/arm64/include/asm/ptrace.h    | 14 +++++++++++---
>  arch/arm64/kernel/asm-offsets.c    |  1 +
>  arch/arm64/kernel/entry.S          | 13 +++++++++++++
>  arch/arm64/kernel/process.c        |  6 ++++++
>  5 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 6b0d4df..b2315ef 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -168,6 +168,9 @@ static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
>  	memset(regs, 0, sizeof(*regs));
>  	forget_syscall(regs);
>  	regs->pc = pc;
> +
> +	if (system_supports_irq_prio_masking())
> +		regs->pmr_save = GIC_PRIO_IRQON;
>  }
>  
>  static inline void start_thread(struct pt_regs *regs, unsigned long pc,
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index ce6998c..0ad46f5 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -19,6 +19,8 @@
>  #ifndef __ASM_PTRACE_H
>  #define __ASM_PTRACE_H
>  
> +#include <asm/cpufeature.h>
> +
>  #include <uapi/asm/ptrace.h>
>  
>  /* Current Exception Level values, as contained in CurrentEL */
> @@ -173,7 +175,8 @@ struct pt_regs {
>  #endif
>  
>  	u64 orig_addr_limit;
> -	u64 unused;	// maintain 16 byte alignment
> +	/* Only valid when ARM64_HAS_IRQ_PRIO_MASKING is enabled. */
> +	u64 pmr_save;
>  	u64 stackframe[2];
>  };
>  
> @@ -208,8 +211,13 @@ static inline void forget_syscall(struct pt_regs *regs)
>  #define processor_mode(regs) \
>  	((regs)->pstate & PSR_MODE_MASK)
>  
> -#define interrupts_enabled(regs) \
> -	(!((regs)->pstate & PSR_I_BIT))
> +#define irqs_priority_unmasked(regs)					\
> +	(system_supports_irq_prio_masking() ?				\
> +		(regs)->pmr_save & GIC_PRIO_STATUS_BIT :		\
> +		true)
> +
> +#define interrupts_enabled(regs)			\
> +	(!((regs)->pstate & PSR_I_BIT) && irqs_priority_unmasked(regs))
>  
>  #define fast_interrupts_enabled(regs) \
>  	(!((regs)->pstate & PSR_F_BIT))
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 323aeb5..bab4122 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -78,6 +78,7 @@ int main(void)
>    DEFINE(S_ORIG_X0,		offsetof(struct pt_regs, orig_x0));
>    DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
>    DEFINE(S_ORIG_ADDR_LIMIT,	offsetof(struct pt_regs, orig_addr_limit));
> +  DEFINE(S_PMR_SAVE,		offsetof(struct pt_regs, pmr_save));
>    DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
>    DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
>    BLANK();
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 039144e..eb8120e 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -249,6 +249,12 @@ alternative_else_nop_endif
>  	msr	sp_el0, tsk
>  	.endif
>  
> +	/* Save pmr */
> +alternative_if ARM64_HAS_IRQ_PRIO_MASKING
> +	mrs_s	x20, SYS_ICC_PMR_EL1
> +	str	x20, [sp, #S_PMR_SAVE]
> +alternative_else_nop_endif
> +
>  	/*
>  	 * Registers that may be useful after this macro is invoked:
>  	 *
> @@ -269,6 +275,13 @@ alternative_else_nop_endif
>  	/* No need to restore UAO, it will be restored from SPSR_EL1 */
>  	.endif
>  
> +	/* Restore pmr */
> +alternative_if ARM64_HAS_IRQ_PRIO_MASKING
> +	ldr	x20, [sp, #S_PMR_SAVE]
> +	msr_s	SYS_ICC_PMR_EL1, x20
> +	dsb	sy
> +alternative_else_nop_endif
> +
>  	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
>  	.if	\el == 0
>  	ct_user_enter
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index d9a4c2d..71e8850 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -231,6 +231,9 @@ void __show_regs(struct pt_regs *regs)
>  
>  	printk("sp : %016llx\n", sp);
>  
> +	if (system_supports_irq_prio_masking())
> +		printk("pmr_save: %08llx\n", regs->pmr_save);
> +
>  	i = top_reg;
>  
>  	while (i >= 0) {
> @@ -362,6 +365,9 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  		if (arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE)
>  			childregs->pstate |= PSR_SSBS_BIT;
>  
> +		if (system_supports_irq_prio_masking())
> +			childregs->pmr_save = GIC_PRIO_IRQON;
> +
>  		p->thread.cpu_context.x19 = stack_start;
>  		p->thread.cpu_context.x20 = stk_sz;
>  	}
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
