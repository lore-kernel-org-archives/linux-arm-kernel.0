Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2913C2F42E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:38:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6806520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WSWaeIzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6806520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=dvcQeg3z7MubGskfXcFQOxsXBMSZPqlKtj7SeG0zD1g=; b=WSWaeIzUp8QoviVxd4s1yCrqIr
	5IiKXCBiP9YHyxgmHhmcM5CoJE2402O8rJMsVX2RwP5gYBiuw9fmgFnarHNzvsWmGDT6/Du9eorQO
	yP3WnQ7cOT8+wXLIjHjDYSkN76lDZyzWjfN5OJn4LNZILHJ8TezLVy5pmHQ7N3pbMJ5BUFHKKyjkR
	nx1H8K6ifMo91NXPdQLSyluOQHI7rdXvVwS9TRbk737Ubx23VNOdKiU/UEU7GO0UYs+rvCWbv2GH9
	t2Dsg47j67ZLWVKdxZN9Xz1oveAvAmNFXHIe7CHaTY+ZxCXp7xthpo5uLSRMDXPzc73Kq/SrrQK73
	rQzQZ8fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbeF-0001Xd-R0; Mon, 21 Jan 2019 15:38:03 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glban-0005Mn-Iu
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:34:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D26315BE;
 Mon, 21 Jan 2019 07:34:29 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49A373F5C1;
 Mon, 21 Jan 2019 07:34:27 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Date: Mon, 21 Jan 2019 15:33:31 +0000
Message-Id: <1548084825-8803-13-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_073429_885475_63946BCB 
X-CRM114-Status: GOOD (  15.79  )
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
 catalin.marinas@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Instead disabling interrupts by setting the PSR.I bit, use a priority
higher than the one used for interrupts to mask them via PMR.

When using PMR to disable interrupts, the value of PMR will be used
instead of PSR.[DAIF] for the irqflags.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 arch/arm64/include/asm/efi.h      |   6 +++
 arch/arm64/include/asm/irqflags.h | 104 ++++++++++++++++++++++++++++----------
 2 files changed, 82 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 7ed3208..3db6772 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -44,6 +44,12 @@
 
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
 
+#define arch_efi_save_flags(state_flags)		\
+	((void)((state_flags) = read_sysreg(daif)))
+
+#define arch_efi_restore_flags(state_flags)	write_sysreg(state_flags, daif)
+
+
 /* arch specific definitions used by the stub code */
 
 /*
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 24692ed..7e82a92 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -18,7 +18,9 @@
 
 #ifdef __KERNEL__
 
+#include <asm/alternative.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
 
 /*
  * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
@@ -36,33 +38,31 @@
 /*
  * CPU interrupt mask handling.
  */
-static inline unsigned long arch_local_irq_save(void)
-{
-	unsigned long flags;
-	asm volatile(
-		"mrs	%0, daif		// arch_local_irq_save\n"
-		"msr	daifset, #2"
-		: "=r" (flags)
-		:
-		: "memory");
-	return flags;
-}
-
 static inline void arch_local_irq_enable(void)
 {
-	asm volatile(
-		"msr	daifclr, #2		// arch_local_irq_enable"
-		:
+	unsigned long unmasked = GIC_PRIO_IRQON;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifclr, #2		// arch_local_irq_enable\n"
+		"nop",
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
+		"dsb	sy",
+		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
+		: "r" (unmasked)
 		: "memory");
 }
 
 static inline void arch_local_irq_disable(void)
 {
-	asm volatile(
-		"msr	daifset, #2		// arch_local_irq_disable"
-		:
+	unsigned long masked = GIC_PRIO_IRQOFF;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifset, #2		// arch_local_irq_disable",
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
+		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
+		: "r" (masked)
 		: "memory");
 }
 
@@ -71,12 +71,44 @@ static inline void arch_local_irq_disable(void)
  */
 static inline unsigned long arch_local_save_flags(void)
 {
+	unsigned long daif_bits;
 	unsigned long flags;
-	asm volatile(
-		"mrs	%0, daif		// arch_local_save_flags"
-		: "=r" (flags)
-		:
+
+	daif_bits = read_sysreg(daif);
+
+	/*
+	 * The asm is logically equivalent to:
+	 *
+	 * if (system_uses_irq_prio_masking())
+	 *	flags = (daif_bits & PSR_I_BIT) ?
+	 *			GIC_PRIO_IRQOFF :
+	 *			read_sysreg_s(SYS_ICC_PMR_EL1);
+	 * else
+	 *	flags = daif_bits;
+	 */
+	asm volatile(ALTERNATIVE(
+			"mov	%0, %1\n"
+			"nop\n"
+			"nop",
+			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1) "\n"
+			"ands	%1, %1, " __stringify(PSR_I_BIT) "\n"
+			"csel	%0, %0, %2, eq",
+			ARM64_HAS_IRQ_PRIO_MASKING)
+		: "=&r" (flags), "+r" (daif_bits)
+		: "r" (GIC_PRIO_IRQOFF)
 		: "memory");
+
+	return flags;
+}
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+
+	flags = arch_local_save_flags();
+
+	arch_local_irq_disable();
+
 	return flags;
 }
 
@@ -85,16 +117,32 @@ static inline unsigned long arch_local_save_flags(void)
  */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
-	asm volatile(
-		"msr	daif, %0		// arch_local_irq_restore"
-	:
-	: "r" (flags)
-	: "memory");
+	asm volatile(ALTERNATIVE(
+			"msr	daif, %0\n"
+			"nop",
+			"msr_s	" __stringify(SYS_ICC_PMR_EL1) ", %0\n"
+			"dsb	sy",
+			ARM64_HAS_IRQ_PRIO_MASKING)
+		: "+r" (flags)
+		:
+		: "memory");
 }
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags & PSR_I_BIT;
+	int res;
+
+	asm volatile(ALTERNATIVE(
+			"and	%w0, %w1, #" __stringify(PSR_I_BIT) "\n"
+			"nop",
+			"cmp	%w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
+			"cset	%w0, ls",
+			ARM64_HAS_IRQ_PRIO_MASKING)
+		: "=&r" (res)
+		: "r" ((int) flags)
+		: "memory");
+
+	return res;
 }
 #endif
 #endif
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
