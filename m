Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5783DC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:01:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0895721855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XknT1log"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0895721855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0z5LZq3kOBrjAAmTwsqKmgPwUw22JDCKm4tdjR+XrJ4=; b=XknT1logyB53MQ406/ARnLxVC8
	epk2U34cJbUx+eoaVflT0pN88ahJqiZ8uCEMXA/VYajBdtiJq9WcVFaUWvicZdR16CaCh4HnodjdF
	espfZmjQKFVCrcGulI3LwOxsKejPtImurDboU7EnDRi2BYJG7LQkOQSIZ4LoHvDhXuxmQnrmS66P7
	gxOjgceGwUeFP1j27lft3eozwp7/Vfvkbe8p6do9vS70Lq9gS9gGnPhYEjx9PzsJyvfdDVtbz3aTm
	M0OJhlzV0sxatOr6haYw4DpqoL28oJ0ulVOAy8q1eZiJP/1RqJa2bJ9rIu3TbZt5k+yMhfIKZy9k0
	glPmyn1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmfZN-0003a8-Pt; Thu, 24 Jan 2019 14:01:25 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmfYk-0002sX-CB
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 14:00:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00B461596;
 Thu, 24 Jan 2019 06:00:46 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E7EF3F5C1;
 Thu, 24 Jan 2019 06:00:45 -0800 (PST)
From: Christoffer Dall <christoffer.dall@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/14] ARM: KVM: Teach some form of type-safety to kvm_call_hyp
Date: Thu, 24 Jan 2019 15:00:22 +0100
Message-Id: <20190124140032.8588-5-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190124140032.8588-1-christoffer.dall@arm.com>
References: <20190124140032.8588-1-christoffer.dall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_060046_860373_759D8C7D 
X-CRM114-Status: GOOD (  13.68  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvm@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Just like on arm64, and for the same reasons, kvm_call_hyp removes
any form of type safety when calling into HYP. But we can still
try to tell the compiler what we're trying to achieve.

Here, we can add code that would do the function call if it wasn't
guarded by an always-false predicate. Hopefully, the compiler is
dumb enough to do the type checking and clever enough to not emit
the corresponding code...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
---
 arch/arm/include/asm/kvm_host.h | 31 ++++++++++++++++++++++++++++---
 arch/arm/kvm/hyp/hyp-entry.S    |  2 +-
 arch/arm/kvm/interrupts.S       |  4 ++--
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 023c9f2b1eea..4b6193f2f0f6 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -215,8 +215,33 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 
-unsigned long kvm_call_hyp(void *hypfn, ...);
-#define kvm_call_hyp_ret(f, ...) kvm_call_hyp(f, ##__VA_ARGS__)
+unsigned long __kvm_call_hyp(void *hypfn, ...);
+
+/*
+ * The has_vhe() part doesn't get emitted, but is used for type-checking.
+ */
+#define kvm_call_hyp(f, ...)						\
+	do {								\
+		if (has_vhe()) {					\
+			f(__VA_ARGS__);					\
+		} else {						\
+			__kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__); \
+		}							\
+	} while(0)
+
+#define kvm_call_hyp_ret(f, ...)					\
+	({								\
+		typeof(f(__VA_ARGS__)) ret;				\
+									\
+		if (has_vhe()) {					\
+			ret = f(__VA_ARGS__);				\
+		} else {						\
+			ret = __kvm_call_hyp(kvm_ksym_ref(f),		\
+					     ##__VA_ARGS__);		\
+		}							\
+									\
+		ret;							\
+	})
 
 void force_vm_exit(const cpumask_t *mask);
 int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
@@ -268,7 +293,7 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 	 * compliant with the PCS!).
 	 */
 
-	kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
+	__kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
 }
 
 static inline void __cpu_init_stage2(void)
diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
index aa3f9a9837ac..6ed3cf23fe89 100644
--- a/arch/arm/kvm/hyp/hyp-entry.S
+++ b/arch/arm/kvm/hyp/hyp-entry.S
@@ -176,7 +176,7 @@ THUMB(	orr	lr, lr, #PSR_T_BIT	)
 	msr	spsr_cxsf, lr
 	ldr	lr, =panic
 	msr	ELR_hyp, lr
-	ldr	lr, =kvm_call_hyp
+	ldr	lr, =__kvm_call_hyp
 	clrex
 	eret
 ENDPROC(__hyp_do_panic)
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 80a1d6cd261c..a08e6419ebe9 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -42,7 +42,7 @@
  *   r12:     caller save
  *   rest:    callee save
  */
-ENTRY(kvm_call_hyp)
+ENTRY(__kvm_call_hyp)
 	hvc	#0
 	bx	lr
-ENDPROC(kvm_call_hyp)
+ENDPROC(__kvm_call_hyp)
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
