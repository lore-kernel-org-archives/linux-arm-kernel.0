Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04899C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:12:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A38120827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H9uRCE+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A38120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uinbAFEMOi3o0AcmNeNhFyboBuQiW6ZSNpNq2gdqrLA=; b=H9uRCE+jklkTuvYsQzWVCvrUyV
	N2/+imGb5PLhqrrL0ebjMPSbAT3k1Qtrjbp4jnypA2FIXNLg5uB/1JO5zCrSn62Upyee7nMEqYNuc
	qPXlin7LfXy2UJOr4Ou2vVDLFo9sTKbR7kaHbT2t3jKHkOfMYftq5oj1lLD+LM3BhEdbu3TIJ4piw
	LMpwsXYFjYKMQ7cCXiKatItnH/QS0PhoLZogKZ/LcI2SBYvn4ZTcDNxPGq+tzsEMOYbyxGUOiFUOi
	u8dI2GmWNpR/psMBjsdStFVzQmoCQl4pHW6lGDeOjoaXB+qZAWpsvLcysZD+oNjKaYM6RIP4e06Ue
	jdkUhnzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggs70-0004Qj-78; Tue, 08 Jan 2019 14:12:10 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3H-0007GO-Ei
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:08:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8421165C;
 Tue,  8 Jan 2019 06:08:18 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC9AA3F70D;
 Tue,  8 Jan 2019 06:08:16 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 09/26] arm64: Unmask PMR before going idle
Date: Tue,  8 Jan 2019 14:07:27 +0000
Message-Id: <1546956464-48825-10-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_060820_372048_1DAC9167 
X-CRM114-Status: GOOD (  15.70  )
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
 christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CPU does not received signals for interrupts with a priority masked by
ICC_PMR_EL1. This means the CPU might not come back from a WFI
instruction.

Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.

Since the logic of cpu_do_idle is becoming a bit more complex than just
two instructions, lets turn it from ASM to C.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/process.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/proc.S        | 11 -----------
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6d410fc..f05b63f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -51,6 +51,7 @@
 #include <linux/thread_info.h>
 
 #include <asm/alternative.h>
+#include <asm/arch_gicv3.h>
 #include <asm/compat.h>
 #include <asm/cacheflush.h>
 #include <asm/exec.h>
@@ -74,6 +75,50 @@
 
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
+static inline void __cpu_do_idle(void)
+{
+	dsb(sy);
+	wfi();
+}
+
+static inline void __cpu_do_idle_irqprio(void)
+{
+	unsigned long pmr;
+	unsigned long daif_bits;
+
+	daif_bits = read_sysreg(daif);
+	write_sysreg(daif_bits | PSR_I_BIT, daif);
+
+	/*
+	 * Unmask PMR before going idle to make sure interrupts can
+	 * be raised.
+	 */
+	pmr = gic_read_pmr();
+	gic_write_pmr(GIC_PRIO_IRQON);
+
+	__cpu_do_idle();
+
+	gic_write_pmr(pmr);
+	write_sysreg(daif_bits, daif);
+}
+
+/*
+ *	cpu_do_idle()
+ *
+ *	Idle the processor (wait for interrupt).
+ *
+ *	If the CPU supports priority masking we must do additional work to
+ *	ensure that interrupts are not masked at the PMR (because the core will
+ *	not wake up if we block the wake up signal in the interrupt controller).
+ */
+void cpu_do_idle(void)
+{
+	if (system_uses_irq_prio_masking())
+		__cpu_do_idle_irqprio();
+	else
+		__cpu_do_idle();
+}
+
 /*
  * This is our default idle handler.
  */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 73886a5..3ea4f3b 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -55,17 +55,6 @@
 
 #define MAIR(attr, mt)	((attr) << ((mt) * 8))
 
-/*
- *	cpu_do_idle()
- *
- *	Idle the processor (wait for interrupt).
- */
-ENTRY(cpu_do_idle)
-	dsb	sy				// WFI may enter a low-power mode
-	wfi
-	ret
-ENDPROC(cpu_do_idle)
-
 #ifdef CONFIG_CPU_PM
 /**
  * cpu_do_suspend - save CPU registers context
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
