Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E76AC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:01:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FF220881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KYfkjO7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FF220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=N6I9foHwh/FLGU3aeb4J+CDvYfCZW/SzeC9KLUFMHk4=; b=KYfkjO7deXFKN/Bhu4RCbCYWXK
	S3E3nil6Hto4IofKBt5GaKTK0WhqjKpu5UCFShwezLkFvCKuliqxgKRyUekI4AziIulJS6XJM5ghA
	4PQbstBPbfaz1h+7SLTvgtGTUf3qgXzdb3UjgP947hkS7HqB80z1+g/JQbT29bwpm/KQf1cwViivn
	tqdik2Xh1DStBUVTllm0DQWnQcQCbqUkees2wCqv1yVQ+tqEOcGWalwdiXexsdEC5ykucULlUz4MJ
	52mPZTOj9+3fVGqi9peo3mW7/kGYBIQuILwS/4ngrzmd6XnFBEvQBxO/Sn5iZQ2o9FUFXUDg7Prfe
	pDLjiFIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go0uo-0005SY-ID; Mon, 28 Jan 2019 07:01:06 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go0tL-00030T-Hz
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 06:59:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D94FC15AB;
 Sun, 27 Jan 2019 22:59:34 -0800 (PST)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.0.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 256903F5AF; Sun, 27 Jan 2019 22:59:30 -0800 (PST)
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 5/5] arm64/kvm: control accessibility of ptrauth key
 registers
Date: Mon, 28 Jan 2019 12:28:46 +0530
Message-Id: <1548658727-14271-6-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_225935_858677_C62936C3 
X-CRM114-Status: GOOD (  16.35  )
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
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to userspace settings, ptrauth key registers are conditionally
present in guest system register list based on user specified flag
KVM_ARM_VCPU_PTRAUTH.

Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/arm64/pointer-authentication.txt |  3 ++
 arch/arm64/kvm/sys_regs.c                      | 42 +++++++++++++++++++-------
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
index 0529a7d..3be4ee1 100644
--- a/Documentation/arm64/pointer-authentication.txt
+++ b/Documentation/arm64/pointer-authentication.txt
@@ -87,3 +87,6 @@ created by passing a flag (KVM_ARM_VCPU_PTRAUTH) requesting this feature
 to be enabled. Without this flag, pointer authentication is not enabled
 in KVM guests and attempted use of the feature will result in an UNDEFINED
 exception being injected into the guest.
+
+Additionally, when KVM_ARM_VCPU_PTRAUTH is not set then KVM will filter
+out the authentication key registers from userspace.
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2546a65..b46a78e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1334,12 +1334,6 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
 	{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
 
-	PTRAUTH_KEY(APIA),
-	PTRAUTH_KEY(APIB),
-	PTRAUTH_KEY(APDA),
-	PTRAUTH_KEY(APDB),
-	PTRAUTH_KEY(APGA),
-
 	{ SYS_DESC(SYS_AFSR0_EL1), access_vm_reg, reset_unknown, AFSR0_EL1 },
 	{ SYS_DESC(SYS_AFSR1_EL1), access_vm_reg, reset_unknown, AFSR1_EL1 },
 	{ SYS_DESC(SYS_ESR_EL1), access_vm_reg, reset_unknown, ESR_EL1 },
@@ -1491,6 +1485,14 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_FPEXC32_EL2), NULL, reset_val, FPEXC32_EL2, 0x70 },
 };
 
+static const struct sys_reg_desc ptrauth_reg_descs[] = {
+	PTRAUTH_KEY(APIA),
+	PTRAUTH_KEY(APIB),
+	PTRAUTH_KEY(APDA),
+	PTRAUTH_KEY(APDB),
+	PTRAUTH_KEY(APGA),
+};
+
 static bool trap_dbgidr(struct kvm_vcpu *vcpu,
 			struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
@@ -2093,6 +2095,8 @@ static int emulate_sys_reg(struct kvm_vcpu *vcpu,
 	r = find_reg(params, table, num);
 	if (!r)
 		r = find_reg(params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	if (!r && kvm_arm_vcpu_ptrauth_allowed(vcpu))
+		r = find_reg(params, ptrauth_reg_descs, ARRAY_SIZE(ptrauth_reg_descs));
 
 	if (likely(r)) {
 		perform_access(vcpu, params, r);
@@ -2206,6 +2210,8 @@ static const struct sys_reg_desc *index_to_sys_reg_desc(struct kvm_vcpu *vcpu,
 	r = find_reg_by_id(id, &params, table, num);
 	if (!r)
 		r = find_reg(&params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	if (!r && kvm_arm_vcpu_ptrauth_allowed(vcpu))
+		r = find_reg(&params, ptrauth_reg_descs, ARRAY_SIZE(ptrauth_reg_descs));
 
 	/* Not saved in the sys_reg array and not otherwise accessible? */
 	if (r && !(r->reg || r->get_user))
@@ -2487,18 +2493,22 @@ static int walk_one_sys_reg(const struct sys_reg_desc *rd,
 }
 
 /* Assumed ordered tables, see kvm_sys_reg_table_init. */
-static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind)
+static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind,
+			const struct sys_reg_desc *desc, unsigned int len)
 {
 	const struct sys_reg_desc *i1, *i2, *end1, *end2;
 	unsigned int total = 0;
 	size_t num;
 	int err;
 
+	if (desc == ptrauth_reg_descs && !kvm_arm_vcpu_ptrauth_allowed(vcpu))
+		return total;
+
 	/* We check for duplicates here, to allow arch-specific overrides. */
 	i1 = get_target_table(vcpu->arch.target, true, &num);
 	end1 = i1 + num;
-	i2 = sys_reg_descs;
-	end2 = sys_reg_descs + ARRAY_SIZE(sys_reg_descs);
+	i2 = desc;
+	end2 = desc + len;
 
 	BUG_ON(i1 == end1 || i2 == end2);
 
@@ -2526,7 +2536,10 @@ unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu)
 {
 	return ARRAY_SIZE(invariant_sys_regs)
 		+ num_demux_regs()
-		+ walk_sys_regs(vcpu, (u64 __user *)NULL);
+		+ walk_sys_regs(vcpu, (u64 __user *)NULL, sys_reg_descs,
+				ARRAY_SIZE(sys_reg_descs))
+		+ walk_sys_regs(vcpu, (u64 __user *)NULL, ptrauth_reg_descs,
+				ARRAY_SIZE(ptrauth_reg_descs));
 }
 
 int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
@@ -2541,7 +2554,12 @@ int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 		uindices++;
 	}
 
-	err = walk_sys_regs(vcpu, uindices);
+	err = walk_sys_regs(vcpu, uindices, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	if (err < 0)
+		return err;
+	uindices += err;
+
+	err = walk_sys_regs(vcpu, uindices, ptrauth_reg_descs, ARRAY_SIZE(ptrauth_reg_descs));
 	if (err < 0)
 		return err;
 	uindices += err;
@@ -2575,6 +2593,7 @@ void kvm_sys_reg_table_init(void)
 	BUG_ON(check_sysreg_table(cp15_regs, ARRAY_SIZE(cp15_regs)));
 	BUG_ON(check_sysreg_table(cp15_64_regs, ARRAY_SIZE(cp15_64_regs)));
 	BUG_ON(check_sysreg_table(invariant_sys_regs, ARRAY_SIZE(invariant_sys_regs)));
+	BUG_ON(check_sysreg_table(ptrauth_reg_descs, ARRAY_SIZE(ptrauth_reg_descs)));
 
 	/* We abuse the reset function to overwrite the table itself. */
 	for (i = 0; i < ARRAY_SIZE(invariant_sys_regs); i++)
@@ -2616,6 +2635,7 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
 
 	/* Generic chip reset first (so target could override). */
 	reset_sys_reg_descs(vcpu, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	reset_sys_reg_descs(vcpu, ptrauth_reg_descs, ARRAY_SIZE(ptrauth_reg_descs));
 
 	table = get_target_table(vcpu->arch.target, true, &num);
 	reset_sys_reg_descs(vcpu, table, num);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
