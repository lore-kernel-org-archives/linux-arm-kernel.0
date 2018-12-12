Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1036AC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:50:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D346B2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ma+zXExS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D346B2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tSIhrsp9pOLKXzWppnTxRpeXEDH6U+Y+esXwpMiISWE=; b=ma+zXExS1NY971kxKQZde/B+Mj
	8VC6eQQNsR+Zo1A+G7vGSo7uX2iEN5TbLWZrrAqeg89+k2IJ13y6ZZTwlOhlybkARv951g6dGLF1Z
	BNX7vtVvAJJE6UOtfo/wEADXn6UL27/jlJIIFk/x8B56q+fcMTGYgwVL4BDepY8TQOVhIiAW+qkD5
	7HdTT03XRgdL3M7qqVnMB6vlE4i3Phf/pVixUT3LNWlrWrZpdPntY/ZTOzJolMnp6/l3qejyurrpw
	qqC8rVtGu6Aul5M1MjqKcztMAp0NkbUGBzq2UUQPiREmY3xj/o53xRfoEY53QQRS4iZrlUtzbex6h
	QqjtSQJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX7if-00064A-Jz; Wed, 12 Dec 2018 16:50:45 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX7gF-0002JE-O3
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 16:48:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F38C15BF;
 Wed, 12 Dec 2018 08:48:15 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2F903F575;
 Wed, 12 Dec 2018 08:48:13 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 12/25] arm64: daifflags: Include PMR in daifflags restore
 operations
Date: Wed, 12 Dec 2018 16:47:12 +0000
Message-Id: <1544633245-6036-13-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_084816_354839_66A30F16 
X-CRM114-Status: GOOD (  14.20  )
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
