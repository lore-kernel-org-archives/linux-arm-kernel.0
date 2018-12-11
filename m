Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2374BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:15:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FF320811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iQ3pOpZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FF320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Y4XUtbTOiuvBDowp++6juZZyccIlVQaRaWxVDLfg/SE=; b=iQ3pOpZ1SIYC/C55PHf75WtQaK
	ae24Cz/HzTu08W4cZJ4J/FoP1xAFHve8Yj4WlZzQonr4YBuWnxfO9ZQxCDI0loYqYDgovTyacIW9G
	tXubs1UQNALTHXjSlp1u40CHbnEOYJBJB+viDLgBlri329Ay6F5E+etJMNNN+RbM9OE5lM6T2iDDT
	apCzmPwlyulRn7IpDHF9yvb+lEPN3x/5SqZDPfimbaxF/d4xxBbUhE5lDfJpPbLNeRUegiR5B6JTG
	HWzqtkHQ3m6TTNcgCW1QeaTDXf6mdDvLu7/yKc2/qXJAU4leOEVeepp2wAtQW7rELvT6Y0e15RIZe
	K3o1Eusg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWgwG-0004LA-J5; Tue, 11 Dec 2018 12:15:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWgva-0003d9-6V
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 12:14:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E7BA165C;
 Tue, 11 Dec 2018 04:14:09 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4009E3F6A8;
 Tue, 11 Dec 2018 04:14:07 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 2/5] arm64: KVM: encapsulate kvm_cpu_context in
 kvm_host_data
Date: Tue, 11 Dec 2018 12:13:37 +0000
Message-Id: <1544530420-1477-3-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544530420-1477-1-git-send-email-andrew.murray@arm.com>
References: <1544530420-1477-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_041418_339293_3ADF86AE 
X-CRM114-Status: GOOD (  11.89  )
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
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Julien Thierry <julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The virt/arm core allocates a percpu structure as per the kvm_cpu_context_t
type, at present this is typedef'd to kvm_cpu_context and used to store
host cpu context. The kvm_cpu_context structure is also used elsewhere to
hold vcpu context. In order to use the percpu to hold additional future
host information we encapsulate kvm_cpu_context in a new structure.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 8 ++++++--
 arch/arm64/kernel/asm-offsets.c   | 3 ++-
 virt/kvm/arm/arm.c                | 4 +++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 1550192..bcf9d60 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -205,7 +205,11 @@ struct kvm_cpu_context {
 	struct kvm_vcpu *__hyp_running_vcpu;
 };
 
-typedef struct kvm_cpu_context kvm_cpu_context_t;
+struct kvm_host_data {
+	struct kvm_cpu_context __kvm_cpu_state;
+};
+
+typedef struct kvm_host_data kvm_cpu_context_t;
 
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
@@ -241,7 +245,7 @@ struct kvm_vcpu_arch {
 	struct kvm_guest_debug_arch external_debug_state;
 
 	/* Pointer to host CPU context */
-	kvm_cpu_context_t *host_cpu_context;
+	struct kvm_cpu_context *host_cpu_context;
 
 	struct thread_info *host_thread_info;	/* hyp VA */
 	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 323aeb5..da34022 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -142,7 +142,8 @@ int main(void)
   DEFINE(CPU_FP_REGS,		offsetof(struct kvm_regs, fp_regs));
   DEFINE(VCPU_FPEXC32_EL2,	offsetof(struct kvm_vcpu, arch.ctxt.sys_regs[FPEXC32_EL2]));
   DEFINE(VCPU_HOST_CONTEXT,	offsetof(struct kvm_vcpu, arch.host_cpu_context));
-  DEFINE(HOST_CONTEXT_VCPU,	offsetof(struct kvm_cpu_context, __hyp_running_vcpu));
+  DEFINE(HOST_CONTEXT_VCPU,	offsetof(struct kvm_cpu_context, __hyp_running_vcpu)
+				+ offsetof(struct kvm_host_data, __kvm_cpu_state));
 #endif
 #ifdef CONFIG_CPU_PM
   DEFINE(CPU_SUSPEND_SZ,	sizeof(struct cpu_suspend_ctx));
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 150c8a6..4f2e534 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -361,8 +361,10 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	int *last_ran;
+	kvm_cpu_context_t *cpu_ctxt;
 
 	last_ran = this_cpu_ptr(vcpu->kvm->arch.last_vcpu_ran);
+	cpu_ctxt = this_cpu_ptr(&kvm_host_cpu_state);
 
 	/*
 	 * We might get preempted before the vCPU actually runs, but
@@ -374,7 +376,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	}
 
 	vcpu->cpu = cpu;
-	vcpu->arch.host_cpu_context = this_cpu_ptr(&kvm_host_cpu_state);
+	vcpu->arch.host_cpu_context = &cpu_ctxt->__kvm_cpu_state;
 
 	kvm_arm_set_running_vcpu(vcpu);
 	kvm_vgic_load(vcpu);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
