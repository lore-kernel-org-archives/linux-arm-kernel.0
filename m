Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FB6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:12:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A1620827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nJcnhpjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A1620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tSIhrsp9pOLKXzWppnTxRpeXEDH6U+Y+esXwpMiISWE=; b=nJcnhpjUtEi68k79ioIOxk4FFr
	9JcORbg25VrmB2s3IEIJQmrMHQEfnHS7u02XBWI1nR1548oIPyHMt0MN+0VpYIC1KwIJvuaJdiNsD
	hoe1b6Ljs5kv1N/mDfPmSkLC15in2Yhus9Cb9EbdNdv+M+p4nlZG1yCZfk8ZyCp+KreWjf+OtEpVR
	xgir7FfqgEKMx6Nu2Hv3rptNOQ8CfeXlo1kd7lIbxyc2EQd2uVrZ5prVZ/vgM4l2s34QyNumVT1RH
	/zg8/+6guic05LynyxGxlZNnTDCnP8ys10NIBFX1qGlLbbLNrjH2/R1wJlhSDf9G2Wy/GmXtCsiXs
	J/81NTtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggs7S-0004vg-Sz; Tue, 08 Jan 2019 14:12:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3W-0007V0-K1
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:09:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E62591A25;
 Tue,  8 Jan 2019 06:08:27 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 22BA13F70D;
 Tue,  8 Jan 2019 06:08:25 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 13/26] arm64: daifflags: Include PMR in daifflags restore
 operations
Date: Tue,  8 Jan 2019 14:07:31 +0000
Message-Id: <1546956464-48825-14-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_060835_082016_263817CF 
X-CRM114-Status: GOOD (  13.71  )
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

The addition of PMR should not bypass the semantics of daifflags.

When DA_F are set, I bit is also set as no interrupts (even of higher
priority) is allowed.

When DA_F are cleared, I bit is cleared and interrupt enabling/disabling
goes through ICC_PMR_EL1.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/daifflags.h | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 546bc39..1fd390e 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -18,6 +18,8 @@
 
 #include <linux/irqflags.h>
 
+#include <asm/cpufeature.h>
+
 #define DAIF_PROCCTX		0
 #define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
 
@@ -36,7 +38,13 @@ static inline unsigned long local_daif_save(void)
 {
 	unsigned long flags;
 
-	flags = arch_local_save_flags();
+	flags = read_sysreg(daif);
+
+	if (system_uses_irq_prio_masking()) {
+		/* If IRQs are masked with PMR, reflect it in the flags */
+		if (read_sysreg_s(SYS_ICC_PMR_EL1) <= GIC_PRIO_IRQOFF)
+			flags |= PSR_I_BIT;
+	}
 
 	local_daif_mask();
 
@@ -45,12 +53,27 @@ static inline unsigned long local_daif_save(void)
 
 static inline void local_daif_restore(unsigned long flags)
 {
-	if (!arch_irqs_disabled_flags(flags))
+	bool irq_disabled = flags & PSR_I_BIT;
+
+	if (!irq_disabled) {
 		trace_hardirqs_on();
 
-	arch_local_irq_restore(flags);
+		if (system_uses_irq_prio_masking())
+			arch_local_irq_enable();
+	} else if (!(flags & PSR_A_BIT)) {
+		/*
+		 * If interrupts are disabled but we can take
+		 * asynchronous errors, we can take NMIs
+		 */
+		if (system_uses_irq_prio_masking()) {
+			flags &= ~PSR_I_BIT;
+			arch_local_irq_disable();
+		}
+	}
+
+	write_sysreg(flags, daif);
 
-	if (arch_irqs_disabled_flags(flags))
+	if (irq_disabled)
 		trace_hardirqs_off();
 }
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
