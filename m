Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EACFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:59:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D788218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DudO2akq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D788218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DMKcEdb8nv5aCVhGidSn+WxKFqg1pEC6MygrUwZ7Pbo=; b=DudO2akq54L6piXsXE2Z9ddpf2
	JuYbQ8kRO+FHTTOkXXehwcMHTWO05VZ2y6SUNlTYanhUOZpjzb0ZP3xiHfGv1iiB/u+6n7UUf9x07
	KOruWGzZmMu3qwsYOi6h/HcQrAi/ZmUz6HdTfh/HiJ8wagAiMEu+zAc5w1We0q4K6U2TtyNUz6tkJ
	ndhXi/k6SQPuErIaPIo/VYhU1/KizasnoPUYJfrI/HEJfv55aihDA0JuvOagep93Gz1ZlrhoqxR0l
	StRHwYSTn99MgrBl2/avyyXU4l9Mecx4Kup8hNGK/ejHo1qn8sd8AOrljeudVdZ9b+p7wYGlp0MzC
	v0DZC49g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpDoK-00068W-86; Thu, 31 Jan 2019 14:59:24 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpDoH-000677-4U
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 14:59:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA16DEBD;
 Thu, 31 Jan 2019 06:59:18 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 46A6E3F59C;
 Thu, 31 Jan 2019 06:59:16 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 01/25] arm64: Fix HCR.TGE status for NMI contexts
Date: Thu, 31 Jan 2019 14:58:39 +0000
Message-Id: <1548946743-38979-2-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_065921_185744_77FD064C 
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
Cc: mark.rutland@arm.com, linux-arch@vger.kernel.org,
 daniel.thompson@linaro.org, Arnd Bergmann <arnd@arndb.de>,
 Julien Thierry <julien.thierry@arm.com>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 joel@joelfernandes.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When using VHE, the host needs to clear HCR_EL2.TGE bit in order
to interact with guest TLBs, switching from EL2&0 translation regime
to EL1&0.

However, some non-maskable asynchronous event could happen while TGE is
cleared like SDEI. Because of this address translation operations
relying on EL2&0 translation regime could fail (tlb invalidation,
userspace access, ...).

Fix this by properly setting HCR_EL2.TGE when entering NMI context and
clear it if necessary when returning to the interrupted context.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/hardirq.h | 31 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/irq.c          |  3 +++
 include/linux/hardirq.h          |  7 +++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 1473fc2..89691c8 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -17,8 +17,12 @@
 #define __ASM_HARDIRQ_H
 
 #include <linux/cache.h>
+#include <linux/percpu.h>
 #include <linux/threads.h>
+#include <asm/barrier.h>
 #include <asm/irq.h>
+#include <asm/kvm_arm.h>
+#include <asm/sysreg.h>
 
 #define NR_IPI	7
 
@@ -37,6 +41,33 @@
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
+struct nmi_ctx {
+	u64 hcr;
+};
+
+DECLARE_PER_CPU(struct nmi_ctx, nmi_contexts);
+
+#define arch_nmi_enter()							\
+	do {									\
+		if (is_kernel_in_hyp_mode()) {					\
+			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
+			nmi_ctx->hcr = read_sysreg(hcr_el2);			\
+			if (!(nmi_ctx->hcr & HCR_TGE)) {			\
+				write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);	\
+				isb();						\
+			}							\
+		}								\
+	} while (0)
+
+#define arch_nmi_exit()								\
+	do {									\
+		if (is_kernel_in_hyp_mode()) {					\
+			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
+			if (!(nmi_ctx->hcr & HCR_TGE))				\
+				write_sysreg(nmi_ctx->hcr, hcr_el2);		\
+		}								\
+	} while (0)
+
 static inline void ack_bad_irq(unsigned int irq)
 {
 	extern unsigned long irq_err_count;
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 780a12f..92fa817 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -33,6 +33,9 @@
 
 unsigned long irq_err_count;
 
+/* Only access this in an NMI enter/exit */
+DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
+
 DEFINE_PER_CPU(unsigned long *, irq_stack_ptr);
 
 int arch_show_interrupts(struct seq_file *p, int prec)
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 0fbbcdf..da0af63 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -60,8 +60,14 @@ static inline void rcu_nmi_exit(void)
  */
 extern void irq_exit(void);
 
+#ifndef arch_nmi_enter
+#define arch_nmi_enter()	do { } while (0)
+#define arch_nmi_exit()		do { } while (0)
+#endif
+
 #define nmi_enter()						\
 	do {							\
+		arch_nmi_enter();				\
 		printk_nmi_enter();				\
 		lockdep_off();					\
 		ftrace_nmi_enter();				\
@@ -80,6 +86,7 @@ static inline void rcu_nmi_exit(void)
 		ftrace_nmi_exit();				\
 		lockdep_on();					\
 		printk_nmi_exit();				\
+		arch_nmi_exit();				\
 	} while (0)
 
 #endif /* LINUX_HARDIRQ_H */
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
