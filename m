Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06FEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:10:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8137F206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cwY2gEMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8137F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7BOVigV4r9QuM+yopAE+XQNzRcNmt84EKju6f7uAoFM=; b=cwY2gEMwOlelZmg+jAdYMVCFS/
	W2XS/9Hv6XI8YQ2BhaEHizENVvRcJisQsnTUpoYNIW0HVkRSnqoXzBvwwEhsW0NajHlU31slI1O/c
	iEiFAjwXxTrTYbUGFTpJ6rmHihKm8cGDNC8NEO50sziSxmBRs9yhzoXvFsnhH0s/4qbG72T5X/qby
	tkbLD7E7/6osjbgH4h2csFun1lV3+PB/goOQRWP8FTDy2bmr7fa64NdB149fNulee29jvcnJdeakZ
	aAJgSSR7zTarxn8Ot9Km+rTbMHZKQzdUW4qnXMJaJVtb22g1ecVmregyRtvk8TT3izzA6ythXkZbT
	Dsld281g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggs56-0000uI-Cb; Tue, 08 Jan 2019 14:10:12 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3F-0007Dy-3b
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:08:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B082780D;
 Tue,  8 Jan 2019 06:08:16 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9AEB13F70D;
 Tue,  8 Jan 2019 06:08:14 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 08/26] arm64: Make PMR part of task context
Date: Tue,  8 Jan 2019 14:07:26 +0000
Message-Id: <1546956464-48825-9-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_060817_528530_83B96BE0 
X-CRM114-Status: GOOD (  13.08  )
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
 Julien Thierry <julien.thierry@arm.com>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>,
 joel@joelfernandes.org, Dave Martin <Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to replace PSR.I interrupt disabling/enabling with ICC_PMR_EL1
interrupt masking, ICC_PMR_EL1 needs to be saved/restored when
taking/returning from an exception. This mimics the way hardware saves
and restores PSR.I bit in spsr_el1 for exceptions and ERET.

Add PMR to the registers to save in the pt_regs struct upon kernel entry,
and restore it before ERET. Also, initialize it to a sane value when
creating new tasks.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/processor.h |  3 +++
 arch/arm64/include/asm/ptrace.h    | 14 +++++++++++---
 arch/arm64/kernel/asm-offsets.c    |  1 +
 arch/arm64/kernel/entry.S          | 14 ++++++++++++++
 arch/arm64/kernel/process.c        |  6 ++++++
 5 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f1a7ab1..5d9ce62 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -191,6 +191,9 @@ static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
 	memset(regs, 0, sizeof(*regs));
 	forget_syscall(regs);
 	regs->pc = pc;
+
+	if (system_uses_irq_prio_masking())
+		regs->pmr_save = GIC_PRIO_IRQON;
 }
 
 static inline void start_thread(struct pt_regs *regs, unsigned long pc,
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 05cf913..43e5df5 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -19,6 +19,8 @@
 #ifndef __ASM_PTRACE_H
 #define __ASM_PTRACE_H
 
+#include <asm/cpufeature.h>
+
 #include <uapi/asm/ptrace.h>
 
 /* Current Exception Level values, as contained in CurrentEL */
@@ -179,7 +181,8 @@ struct pt_regs {
 #endif
 
 	u64 orig_addr_limit;
-	u64 unused;	// maintain 16 byte alignment
+	/* Only valid when ARM64_HAS_IRQ_PRIO_MASKING is enabled. */
+	u64 pmr_save;
 	u64 stackframe[2];
 };
 
@@ -214,8 +217,13 @@ static inline void forget_syscall(struct pt_regs *regs)
 #define processor_mode(regs) \
 	((regs)->pstate & PSR_MODE_MASK)
 
-#define interrupts_enabled(regs) \
-	(!((regs)->pstate & PSR_I_BIT))
+#define irqs_priority_unmasked(regs)					\
+	(system_uses_irq_prio_masking() ?				\
+		(regs)->pmr_save == GIC_PRIO_IRQON :			\
+		true)
+
+#define interrupts_enabled(regs)			\
+	(!((regs)->pstate & PSR_I_BIT) && irqs_priority_unmasked(regs))
 
 #define fast_interrupts_enabled(regs) \
 	(!((regs)->pstate & PSR_F_BIT))
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 65b8afc..90ab2cf 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -81,6 +81,7 @@ int main(void)
   DEFINE(S_ORIG_X0,		offsetof(struct pt_regs, orig_x0));
   DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
   DEFINE(S_ORIG_ADDR_LIMIT,	offsetof(struct pt_regs, orig_addr_limit));
+  DEFINE(S_PMR_SAVE,		offsetof(struct pt_regs, pmr_save));
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 0ec0c46..35a47f6 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -249,6 +249,12 @@ alternative_else_nop_endif
 	msr	sp_el0, tsk
 	.endif
 
+	/* Save pmr */
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	mrs_s	x20, SYS_ICC_PMR_EL1
+	str	x20, [sp, #S_PMR_SAVE]
+alternative_else_nop_endif
+
 	/*
 	 * Registers that may be useful after this macro is invoked:
 	 *
@@ -269,6 +275,14 @@ alternative_else_nop_endif
 	/* No need to restore UAO, it will be restored from SPSR_EL1 */
 	.endif
 
+	/* Restore pmr */
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	ldr	x20, [sp, #S_PMR_SAVE]
+	msr_s	SYS_ICC_PMR_EL1, x20
+	/* Ensure priority change is seen by redistributor */
+	dsb	sy
+alternative_else_nop_endif
+
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
 	.if	\el == 0
 	ct_user_enter
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a0f985a..6d410fc 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -232,6 +232,9 @@ void __show_regs(struct pt_regs *regs)
 
 	printk("sp : %016llx\n", sp);
 
+	if (system_uses_irq_prio_masking())
+		printk("pmr_save: %08llx\n", regs->pmr_save);
+
 	i = top_reg;
 
 	while (i >= 0) {
@@ -363,6 +366,9 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		if (arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE)
 			childregs->pstate |= PSR_SSBS_BIT;
 
+		if (system_uses_irq_prio_masking())
+			childregs->pmr_save = GIC_PRIO_IRQON;
+
 		p->thread.cpu_context.x19 = stack_start;
 		p->thread.cpu_context.x20 = stk_sz;
 	}
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
