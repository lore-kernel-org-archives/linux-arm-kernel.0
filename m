Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF5EC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:32:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618B820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZrIdMOEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618B820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3MkgSWhmZVTKVLc2BCIpl0eOzWdUI5TQWdBRD17yiZQ=; b=ZrIdMOEAfAIaoU
	b79n6NqgbO28d7F5F/Mbly1tjMvyrQnkaTY2XnaPRv2YcGTLuCnbugICuKnGTYy5/d/T5Ue8FS2hy
	Fa8S3x3d/1ooFd1CxfhNJ95p41sERsHOBLGsD0o2VluQ3GC3SGsu1zekJIhB20oCeVfdf+MwnPKAm
	V3z+9jtbho+5QYjUghdHCdggaLmz55wsIQJ9IkS//hMPCYp0nPhy5azOj4bOftdDiNXBBBtm1sOzr
	wB+9bpu8ZWg6yEcV/lGdQ/Lvw6zZ0JdDONEXG6omlvXGuFHreOXQFRPQrXjTBkVJKueca4yQoUgqw
	CJQh70ai/j/uOROEvskg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUxVa-0000gO-9U; Thu, 06 Dec 2018 17:32:18 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUxV4-00008Q-02
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 17:31:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2346115AB;
 Thu,  6 Dec 2018 09:31:41 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AA913F5AF;
 Thu,  6 Dec 2018 09:31:39 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v3 3/8] arm64: KVM: Install stage-2 translation before
 enabling traps
Date: Thu,  6 Dec 2018 17:31:21 +0000
Message-Id: <20181206173126.139877-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206173126.139877-1-marc.zyngier@arm.com>
References: <20181206173126.139877-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_093146_156416_13E15605 
X-CRM114-Status: GOOD (  12.81  )
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

It is a bit odd that we only install stage-2 translation after having
cleared HCR_EL2.TGE, which means that there is a window during which
AT requests could fail as stage-2 is not configured yet.

Let's move stage-2 configuration before we clear TGE, making the
guest entry sequence clearer: we first configure all the guest stuff,
then only switch to the guest translation regime.

While we're at it, do the same thing for !VHE. It doesn't hurt,
and keeps things symmetric.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/switch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 7cc175c88a37..a8fa61c68c32 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -499,8 +499,8 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_save_host_state_vhe(host_ctxt);
 
-	__activate_traps(vcpu);
 	__activate_vm(vcpu->kvm);
+	__activate_traps(vcpu);
 
 	sysreg_restore_guest_state_vhe(guest_ctxt);
 	__debug_switch_to_guest(vcpu);
@@ -545,8 +545,8 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
 
 	__sysreg_save_state_nvhe(host_ctxt);
 
-	__activate_traps(vcpu);
 	__activate_vm(kern_hyp_va(vcpu->kvm));
+	__activate_traps(vcpu);
 
 	__hyp_vgic_restore_state(vcpu);
 	__timer_enable_traps(vcpu);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
