Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94774C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:22:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560C921908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WZI8XNhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560C921908
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9DHN/wzadzZ5TLgSFuElrE0Hgs7AmJ3MkbR+m3SzOTE=; b=WZI8XNhBCAPtBB
	W1vQ1eYSKUehvAu6CxFwFl45oQGTZombURSMQpNV3ABLKI7tyBs/ROkcSMorrGBlQVp94QaPx4p9e
	bs1mZ0DGqW/Hge+X8ExGSY9uFKTpceIq59CCJpccrip1N12hrXc2V9sIggM+3KX9J4UobAjczQE1K
	Brukg0C0dYqROLKyU8/jRRQDuevjjpyYhQ0Tub1C6V9blkIZ0fVMwQY5eOrmsTIBLPFlCADH2xXwk
	ymeOnb8ai3DFYpt/+sHbFurqpUFRsIJtlnLU7rl/OTUzD27QG4ZaF+FseGIYPS17Z2m+pWikF5own
	/SpAKAK2vt+zkvQhHrhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grjdC-0006FV-8J; Thu, 07 Feb 2019 13:22:18 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grja8-00027x-Cr
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:19:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3024EA78;
 Thu,  7 Feb 2019 05:19:08 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE8A63F675;
 Thu,  7 Feb 2019 05:19:05 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 04/11] arm64: KVM: Don't generate UNDEF when LORegion feature
 is present
Date: Thu,  7 Feb 2019 13:18:36 +0000
Message-Id: <20190207131843.157210-5-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207131843.157210-1-marc.zyngier@arm.com>
References: <20190207131843.157210-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_051909_117851_DE683814 
X-CRM114-Status: GOOD (  14.04  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 kvm@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We currently hide the LORegion feature, and generate an UNDEF
if the guest dares using the corresponding registers. This is
a bit extreme, as ARMv8.1 guarantees the feature to be present.

The guest should check the feature register before doing anything,
but we could also give the guest some slack (read "allow the
guest to be a bit stupid").

So instead of unconditionnaly deliver an exception, let's
only do it when the host doesn't support LORegion at all (or
when the feature has been sanitized out), and treat the registers
as RAZ/WI otherwise (with the exception of LORID_EL1 being RO).

Fixes: cc33c4e20185 ("arm64/kvm: Prohibit guest LOR accesses")
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e3e37228ae4e..86096774abcd 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -314,12 +314,29 @@ static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 		return read_zero(vcpu, p);
 }
 
-static bool trap_undef(struct kvm_vcpu *vcpu,
-		       struct sys_reg_params *p,
-		       const struct sys_reg_desc *r)
+/*
+ * ARMv8.1 mandates at least a trivial LORegion implementation, where all the
+ * RW registers are RES0 (which we can implement as RAZ/WI). On an ARMv8.0
+ * system, these registers should UNDEF. LORID_EL1 being a RO register, we
+ * treat it separately.
+ */
+static bool trap_loregion(struct kvm_vcpu *vcpu,
+			  struct sys_reg_params *p,
+			  const struct sys_reg_desc *r)
 {
-	kvm_inject_undefined(vcpu);
-	return false;
+	u64 val = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
+	u32 sr = sys_reg((u32)r->Op0, (u32)r->Op1,
+			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
+
+	if (!(val & (0xfUL << ID_AA64MMFR1_LOR_SHIFT))) {
+		kvm_inject_undefined(vcpu);
+		return false;
+	}
+
+	if (p->is_write && sr == SYS_LORID_EL1)
+		return write_to_read_only(vcpu, p, r);
+
+	return trap_raz_wi(vcpu, p, r);
 }
 
 static bool trap_oslsr_el1(struct kvm_vcpu *vcpu,
@@ -1048,11 +1065,6 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
 		if (val & ptrauth_mask)
 			kvm_debug("ptrauth unsupported for guests, suppressing\n");
 		val &= ~ptrauth_mask;
-	} else if (id == SYS_ID_AA64MMFR1_EL1) {
-		if (val & (0xfUL << ID_AA64MMFR1_LOR_SHIFT))
-			kvm_debug("LORegions unsupported for guests, suppressing\n");
-
-		val &= ~(0xfUL << ID_AA64MMFR1_LOR_SHIFT);
 	}
 
 	return val;
@@ -1338,11 +1350,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
 	{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
 
-	{ SYS_DESC(SYS_LORSA_EL1), trap_undef },
-	{ SYS_DESC(SYS_LOREA_EL1), trap_undef },
-	{ SYS_DESC(SYS_LORN_EL1), trap_undef },
-	{ SYS_DESC(SYS_LORC_EL1), trap_undef },
-	{ SYS_DESC(SYS_LORID_EL1), trap_undef },
+	{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LOREA_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LORN_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LORC_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LORID_EL1), trap_loregion },
 
 	{ SYS_DESC(SYS_VBAR_EL1), NULL, reset_val, VBAR_EL1, 0 },
 	{ SYS_DESC(SYS_DISR_EL1), NULL, reset_val, DISR_EL1, 0 },
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
