Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE60C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:49:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BF72084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NpCJJMiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BF72084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZyR2FU6Bndr5upAKymIQOHmUgTiO5GgeCwApc72/QQY=; b=NpCJJMiJI/OCs1UYQb3ZwBitpR
	d+pj7/qgC00aMKLT6Zx9HHTRbu+6xi/wN3BD4RhHoy+1VG/aYzze7QN6ot3tarbZNTFgi9K8EK6mn
	Jvj7BNyI/4WU8I5uGoBbLbvYvLtsqre1u5ZUaBBSnLJ/pNdTou/Ld/aWgN8JBWmrumWhEWvP1s/nl
	9qbO1edPnIVzUcMJhOasr/cag7VJ5//iOMDpd7D7xJ9y5KuJKAzGDFCMQRgtlh0VX3z+lxYOEuVf4
	mPLSZOFwXeFt3+I9hMqkIZ9YnyVKsF3HnmMcAILfZgpLxgl6h/MFLStqiuutCTi91NACzs7YjuH3J
	X2VBYikA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX7hX-00047t-TE; Wed, 12 Dec 2018 16:49:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX7gB-0002TX-Nf
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 16:48:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB4F31650;
 Wed, 12 Dec 2018 08:48:08 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1C753F575;
 Wed, 12 Dec 2018 08:48:06 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 09/25] arm64: Unmask PMR before going idle
Date: Wed, 12 Dec 2018 16:47:09 +0000
Message-Id: <1544633245-6036-10-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_084812_693728_9E9D2750 
X-CRM114-Status: GOOD (  16.30  )
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
index 34f495b..28b7423 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -51,6 +51,7 @@
 #include <linux/thread_info.h>
 
 #include <asm/alternative.h>
+#include <asm/arch_gicv3.h>
 #include <asm/compat.h>
 #include <asm/cacheflush.h>
 #include <asm/exec.h>
@@ -73,6 +74,50 @@
 
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
index 2c75b0b..2fb822b 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -49,17 +49,6 @@
 
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
