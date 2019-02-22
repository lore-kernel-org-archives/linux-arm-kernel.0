Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C57EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:28:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6052070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eTv8V9Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6052070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xb1K1tLe4wdXuQ+B78KvPVBmLVHOKhC+hTY3FAPdm58=; b=eTv8V9XqBqY1xn
	h/QXjgQniUZQ9UIJG33V/IAbmTmI0Z4iSH9mfwmxl0ivCaI6RpH8PlIaNIeUwHM8h3G/8uqdpBa6P
	MIhO3h2aS1lbSxrLZuip7VW/QiGXVybuj3Yf7tCtGV59HWZa6b9hWeq9WuYaWNOazbiY6thVsksAM
	PbQty1hf28ca0R7OfO5TbSeI96O08T+DM29c8r7PiUYfOs/XETJYVpeiaBY6lauDvCc7RkyyL4y8V
	vVGESMBJ+gFgSBmiBOCe9ZTABpZgyLpU0vdcfv6NS7EVzUq3/wBkv4jle4c/WWXp0hhii+2ZE/exk
	sAEQZh88xiZw7Gj9ySlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxDgC-00086D-Fx; Fri, 22 Feb 2019 16:28:04 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDfT-0007FI-J8
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:27:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 430ED80D;
 Fri, 22 Feb 2019 08:27:19 -0800 (PST)
Received: from big-swifty.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 71F9C3F5C1; Fri, 22 Feb 2019 08:27:14 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 05/27] ARM: KVM: Teach some form of type-safety to kvm_call_hyp
Date: Fri, 22 Feb 2019 16:25:43 +0000
Message-Id: <20190222162605.5054-6-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222162605.5054-1-marc.zyngier@arm.com>
References: <20190222162605.5054-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_082720_250421_A0C2136F 
X-CRM114-Status: GOOD (  13.36  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, kvm@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 Zenghui Yu <yuzenghui@huawei.com>, Colin Ian King <colin.king@canonical.com>,
 Dave Martin <Dave.Martin@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Just like on arm64, and for the same reasons, kvm_call_hyp removes
any form of type safety when calling into HYP. But we can still
try to tell the compiler what we're trying to achieve.

Here, we can add code that would do the function call if it wasn't
guarded by an always-false predicate. Hopefully, the compiler is
dumb enough to do the type checking and clever enough to not emit
the corresponding code...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
