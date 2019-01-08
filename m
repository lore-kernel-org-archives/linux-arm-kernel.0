Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BA6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:12:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A020120827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kx4WlljR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A020120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bd0kVqswMs+DqCpUKbn64iKi2sy7Ff1PimU2E6Ue6D8=; b=kx4WlljR1dE/zWS+X4JUw3TUrH
	AvFmY9m8gPQLOdG8KuhoXtvgHIhfCtroN8P3gzBuEzVIAc4fXFaEDoE5k7Z/NwDOlFmoaDWzGpdxP
	LWHoNXGgUvLHYvqeSgQfG2g8DXVeluizZC/jykMs/Ei37h0GOPAFrKFlNYPjumr0UcZWLu3FQMMSF
	zTzmE5TsB+4ToVZHvpps45FCxZ7VXn5yuNujCqLNa+joak87NUbfXlPKw9bzo8poIx16EM4bZQYcT
	iShOhE7Hmqsgstje0qp7gW5RaMbY4MbkJx+4BqsyRAwRmH9rIO9zADgFjKHyPbFB5rED8YwFS/t8Y
	xlIMBsAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggs7h-00059T-Pj; Tue, 08 Jan 2019 14:12:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3W-0007V2-RI
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:09:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA8DB19BF;
 Tue,  8 Jan 2019 06:08:25 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3C133F70D;
 Tue,  8 Jan 2019 06:08:23 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Date: Tue,  8 Jan 2019 14:07:30 +0000
Message-Id: <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_060835_508156_1B328A71 
X-CRM114-Status: GOOD (  16.32  )
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
 arch/arm64/include/asm/efi.h      |  11 ++++
 arch/arm64/include/asm/irqflags.h | 123 +++++++++++++++++++++++++++++---------
 2 files changed, 106 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 7ed3208..134ff6e 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -44,6 +44,17 @@
 
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
 
+#define arch_efi_save_flags(state_flags)		\
+	do {						\
+		(state_flags) =	read_sysreg(daif);	\
+	} while (0)
+
+#define arch_efi_restore_flags(state_flags)		\
+	do {						\
+		write_sysreg(state_flags, daif);	\
+	} while (0)
+
+
 /* arch specific definitions used by the stub code */
 
 /*
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 24692ed..fa3b06f 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -18,7 +18,9 @@
 
 #ifdef __KERNEL__
 
+#include <asm/alternative.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
 
 /*
  * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
@@ -36,47 +38,96 @@
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
 
 /*
+ * Having two ways to control interrupt status is a bit complicated. Some
+ * locations like exception entries will have PSR.I bit set by the architecture
+ * while PMR is unmasked.
+ * We need the irqflags to represent that interrupts are disabled in such cases.
+ *
+ * For this, we lower the value read from PMR when the I bit is set so it is
+ * considered as an irq masking priority. (With PMR, lower value means masking
+ * more interrupts).
+ */
+#define _get_irqflags(daif_bits, pmr)					\
+({									\
+	unsigned long flags;						\
+									\
+	BUILD_BUG_ON(GIC_PRIO_IRQOFF < (GIC_PRIO_IRQON & ~PSR_I_BIT));	\
+	asm volatile(ALTERNATIVE(					\
+		"mov	%0, %1\n"					\
+		"nop\n"							\
+		"nop",							\
+		"and	%0, %1, #" __stringify(PSR_I_BIT) "\n"		\
+		"mvn	%0, %0\n"					\
+		"and	%0, %0, %2",					\
+		ARM64_HAS_IRQ_PRIO_MASKING)				\
+		: "=&r" (flags)						\
+		: "r" (daif_bits), "r" (pmr)				\
+		: "memory");						\
+									\
+	flags;								\
+})
+
+/*
  * Save the current interrupt enable state.
  */
 static inline unsigned long arch_local_save_flags(void)
 {
-	unsigned long flags;
-	asm volatile(
-		"mrs	%0, daif		// arch_local_save_flags"
-		: "=r" (flags)
+	unsigned long daif_bits;
+	unsigned long pmr; // Only used if alternative is on
+
+	daif_bits = read_sysreg(daif);
+
+	// Get PMR
+	asm volatile(ALTERNATIVE(
+			"nop",
+			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1),
+			ARM64_HAS_IRQ_PRIO_MASKING)
+		: "=&r" (pmr)
 		:
 		: "memory");
+
+	return _get_irqflags(daif_bits, pmr);
+}
+
+#undef _get_irqflags
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
 
@@ -85,16 +136,32 @@ static inline unsigned long arch_local_save_flags(void)
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
