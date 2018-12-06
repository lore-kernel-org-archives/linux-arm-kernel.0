Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B602C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:41:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D0820892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hvWZQv5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D0820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EkLJ3BpCF7btEW1UqCHtgC3RaHNZwAZW6J2jHXYAsbQ=; b=hvWZQv5vYeHwGt
	y8fNHy5rSXXRykOb3U1UyfVEHBhDgzFMpNfZXaiV0/ddU4ie6l85NGNstESy1XblXQFhxrx3ItNix
	ENRwg4e9lMP7GTWhsynAaqV1u6a36C5oX0KO8HDJDv1ls5uOhjLJjvu8PDmT8hGWfhVrTgQV6sNUB
	r/3D4yIYAqK6lxk43lHgkKC0yTCIYUe+j4uZb0B0ecpK1ZVuAPTLYI73wpQQhJYoxMNXjKLfmf4qZ
	vxbuWu+G0xQgLXaFB9Q7k1FhL28zok279ugunEr1qsyUgvbT5xPGaEz6yrucJSEWtI1UAjbsu9Q4Q
	IHXP2NhTHeAHuGsLMNtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUxe2-00058i-ME; Thu, 06 Dec 2018 17:41:02 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUxVF-0000AP-ME
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 17:32:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC9141682;
 Thu,  6 Dec 2018 09:31:46 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F5573F5AF;
 Thu,  6 Dec 2018 09:31:45 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v3 6/8] arm64: KVM: Add synchronization on translation regime
 change for erratum 1165522
Date: Thu,  6 Dec 2018 17:31:24 +0000
Message-Id: <20181206173126.139877-7-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206173126.139877-1-marc.zyngier@arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_093158_403583_F1C9A5B2 
X-CRM114-Status: GOOD (  15.04  )
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

In order to ensure that slipping HCR_EL2.TGE is done at the right
time when switching translation regime, let insert the required ISBs
that will be patched in when erratum 1165522 is detected.

Take this opportunity to add the missing include of asm/alternative.h
which was getting there by pure luck.

Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_hyp.h |  8 ++++++++
 arch/arm64/kvm/hyp/switch.c      | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 23aca66767f9..a80a7ef57325 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -20,6 +20,7 @@
 
 #include <linux/compiler.h>
 #include <linux/kvm_host.h>
+#include <asm/alternative.h>
 #include <asm/sysreg.h>
 
 #define __hyp_text __section(.hyp.text) notrace
@@ -163,6 +164,13 @@ static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
 {
 	write_sysreg(kvm->arch.vtcr, vtcr_el2);
 	write_sysreg(kvm->arch.vttbr, vttbr_el2);
+
+	/*
+	 * ARM erratum 1165522 requires the actual execution of the above
+	 * before we can switch to the EL1/EL0 translation regime used by
+	 * the guest.
+	 */
+	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
 }
 
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index a8fa61c68c32..31ee0bfc432f 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -143,6 +143,14 @@ static void deactivate_traps_vhe(void)
 {
 	extern char vectors[];	/* kernel exception vectors */
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
+
+	/*
+	 * ARM erratum 1165522 requires the actual execution of the above
+	 * before we can switch to the EL2/EL0 translation regime used by
+	 * the host.
+	 */
+	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
+
 	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
 	write_sysreg(vectors, vbar_el1);
 }
@@ -499,6 +507,17 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_save_host_state_vhe(host_ctxt);
 
+	/*
+	 * ARM erratum 1165522 requires us to configure both stage 1 and
+	 * stage 2 translation for the guest context before we clear
+	 * HCR_EL2.TGE.
+	 *
+	 * We have already configured the guest's stage 1 translation in
+	 * kvm_vcpu_load_sysregs above.  We must now call __activate_vm
+	 * before __activate_traps, because __activate_vm configures
+	 * stage 2 translation, and __activate_traps clear HCR_EL2.TGE
+	 * (among other things).
+	 */
 	__activate_vm(vcpu->kvm);
 	__activate_traps(vcpu);
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
