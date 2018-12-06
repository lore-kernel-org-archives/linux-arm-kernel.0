Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2BEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:32:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BD820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DySyC5Jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BD820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YZr63s+KCUpYK04PhokSRovd4qFm61ZHQ9/Sh/Dw18w=; b=DySyC5JrLum/ha
	YNt43wln7JhR4NDndFP1OdBhSLypNTUv0AAfsXvB7ofT2ZX8/m1PP4k7ss9ve//qpFkKMve8RAKRn
	kpzSstSnibaMeE+dAwW63nmf1liaT/Qc30Qezc5pogCJGWiEDm5WF1utOfdF0XBaBhfOL/4EuDhWy
	SbhtLXh0hkS0E8ELQ7auAkIWjFCMWmVbhMEn9L+Esm7Nk2/AMcKehbb4azOiffmDBxfy/brbb1yT7
	IuvhDeudMLvQxV1cGfKr/juQxobWB7bZkG4l6gUajT82vfufkXJBbafias1/boN2jQpeyNH6jDYIc
	L0nHdBT5tkxdzGdPAPbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUxVH-0000KS-NH; Thu, 06 Dec 2018 17:31:59 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUxV4-00007v-00
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 17:31:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C4061596;
 Thu,  6 Dec 2018 09:31:39 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93C493F5AF;
 Thu,  6 Dec 2018 09:31:37 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v3 2/8] KVM: arm64: Rework detection of SVE, !VHE systems
Date: Thu,  6 Dec 2018 17:31:20 +0000
Message-Id: <20181206173126.139877-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206173126.139877-1-marc.zyngier@arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_093146_049124_3F2A7364 
X-CRM114-Status: GOOD (  14.67  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

An SVE system is so far the only case where we mandate VHE. As we're
starting to grow this requirements, let's slightly rework the way we
deal with that situation, allowing for easy extension of this check.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 2 +-
 arch/arm64/include/asm/kvm_host.h | 6 +++---
 virt/kvm/arm/arm.c                | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 5ca5d9af0c26..2184d9ddb418 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -285,7 +285,7 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-static inline bool kvm_arch_check_sve_has_vhe(void) { return true; }
+static inline bool kvm_arch_requires_vhe(void) { return false; }
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 52fbc823ff8c..d6d9aa76a943 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -422,7 +422,7 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 	}
 }
 
-static inline bool kvm_arch_check_sve_has_vhe(void)
+static inline bool kvm_arch_requires_vhe(void)
 {
 	/*
 	 * The Arm architecture specifies that implementation of SVE
@@ -430,9 +430,9 @@ static inline bool kvm_arch_check_sve_has_vhe(void)
 	 * relies on this when SVE is present:
 	 */
 	if (system_supports_sve())
-		return has_vhe();
-	else
 		return true;
+
+	return false;
 }
 
 static inline void kvm_arch_hardware_unsetup(void) {}
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 23774970c9df..1db4c15edcdd 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1640,8 +1640,10 @@ int kvm_arch_init(void *opaque)
 		return -ENODEV;
 	}
 
-	if (!kvm_arch_check_sve_has_vhe()) {
-		kvm_pr_unimpl("SVE system without VHE unsupported.  Broken cpu?");
+	in_hyp_mode = is_kernel_in_hyp_mode();
+
+	if (!in_hyp_mode && kvm_arch_requires_vhe()) {
+		kvm_pr_unimpl("CPU requiring VHE was booted in non-VHE mode");
 		return -ENODEV;
 	}
 
@@ -1657,8 +1659,6 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		return err;
 
-	in_hyp_mode = is_kernel_in_hyp_mode();
-
 	if (!in_hyp_mode) {
 		err = init_hyp_mode();
 		if (err)
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
