Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0824DC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:09:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE81218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aAs/vmRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE81218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uLgbOu8QCrkItvRH7xfo7+y9dnuduOe/ASjNcKpXLnY=; b=aAs/vmRlSGF1PjX2/qkBg2qlWN
	YKxFtT06B778OMT2MZqu11i6VW8PCJT41TVI2gP7BUSUFuKZhPPzBgm9rOqSs5G2MPEloFKDiqXSO
	OB+Raiv5X+7FhPAAxCU0qY1VMOr+X7RRpI/g7FZNt9Rk4YYo4xND7HX7j3KBEKZyhyc/VuHfChd3W
	HEZd7b+W8TU1agVvbb9srFsWxhCkgkEkh+TUvJPrzQsc/mwJg2BMjtbWkuWzD75JTW2QZUs9BvGk7
	feZ1k2shlTHEmCEPza8NSHSvjzUVOwnjta+hraFEjw8zwxr4vUgVkrxJ+v6sCR7L5uNxckVfj9Wv8
	g7ZSm68g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn5vI-0007Xa-8p; Fri, 25 Jan 2019 18:09:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn5t4-0005Pw-EV
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 18:07:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37BC7169E;
 Fri, 25 Jan 2019 10:07:30 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90AF73F5AF;
 Fri, 25 Jan 2019 10:07:29 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 08/12] arm64: Advertise mitigation of Spectre-v2,
 or lack thereof
Date: Fri, 25 Jan 2019 12:07:07 -0600
Message-Id: <20190125180711.1970973-9-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190125180711.1970973-1-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_100731_101134_DA333EB8 
X-CRM114-Status: GOOD (  18.03  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, julien.thierry@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, steven.price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

We currently have a list of CPUs affected by Spectre-v2, for which
we check that the firmware implements ARCH_WORKAROUND_1. It turns
out that not all firmwares do implement the required mitigation,
and that we fail to let the user know about it.

Instead, let's slightly revamp our checks, and rely on a whitelist
of cores that are known to be non-vulnerable, and let the user know
the status of the mitigation in the kernel log.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[This makes more sense in front of the sysfs patch]
[Pick pieces of that patch into this and move it earlier]
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 104 +++++++++++++++++----------------
 1 file changed, 54 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index ef636acf5604..4d23b4d4cfa8 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -129,9 +129,9 @@ static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
 	__flush_icache_range((uintptr_t)dst, (uintptr_t)dst + SZ_2K);
 }
 
-static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
-				      const char *hyp_vecs_start,
-				      const char *hyp_vecs_end)
+static void install_bp_hardening_cb(bp_hardening_cb_t fn,
+				    const char *hyp_vecs_start,
+				    const char *hyp_vecs_end)
 {
 	static DEFINE_RAW_SPINLOCK(bp_lock);
 	int cpu, slot = -1;
@@ -164,23 +164,6 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 	raw_spin_unlock(&bp_lock);
 }
 
-static void  install_bp_hardening_cb(const struct arm64_cpu_capabilities *entry,
-				     bp_hardening_cb_t fn,
-				     const char *hyp_vecs_start,
-				     const char *hyp_vecs_end)
-{
-	u64 pfr0;
-
-	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
-		return;
-
-	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
-	if (cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_CSV2_SHIFT))
-		return;
-
-	__install_bp_hardening_cb(fn, hyp_vecs_start, hyp_vecs_end);
-}
-
 #include <uapi/linux/psci.h>
 #include <linux/arm-smccc.h>
 #include <linux/psci.h>
@@ -215,29 +198,27 @@ static int __init parse_nospectre_v2(char *str)
 }
 early_param("nospectre_v2", parse_nospectre_v2);
 
-static void
-enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
+/*
+ * -1: No workaround
+ *  0: No workaround required
+ *  1: Workaround installed
+ */
+static int detect_harden_bp_fw(void)
 {
 	bp_hardening_cb_t cb;
 	void *smccc_start, *smccc_end;
 	struct arm_smccc_res res;
 	u32 midr = read_cpuid_id();
 
-	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
-		return;
-
-	if (__nospectre_v2)
-		return;
-
 	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
-		return;
+		return -1;
 
 	switch (psci_ops.conduit) {
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 		if ((int)res.a0 < 0)
-			return;
+			return -1;
 		cb = call_hvc_arch_workaround_1;
 		/* This is a guest, no need to patch KVM vectors */
 		smccc_start = NULL;
@@ -248,23 +229,23 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 		if ((int)res.a0 < 0)
-			return;
+			return -1;
 		cb = call_smc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_smc_start;
 		smccc_end = __smccc_workaround_1_smc_end;
 		break;
 
 	default:
-		return;
+		return -1;
 	}
 
 	if (((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR) ||
 	    ((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR_V1))
 		cb = qcom_link_stack_sanitization;
 
-	install_bp_hardening_cb(entry, cb, smccc_start, smccc_end);
+	install_bp_hardening_cb(cb, smccc_start, smccc_end);
 
-	return;
+	return 1;
 }
 
 DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
@@ -502,24 +483,47 @@ cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
 	CAP_MIDR_RANGE_LIST(midr_list)
 
-
 /*
- * List of CPUs where we need to issue a psci call to
- * harden the branch predictor.
+ * List of CPUs that do not need any Spectre-v2 mitigation at all.
  */
-static const struct midr_range arm64_bp_harden_smccc_cpus[] = {
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
-	MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
-	MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
-	MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
-	MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
-	MIDR_ALL_VERSIONS(MIDR_NVIDIA_DENVER),
-	{},
+static const struct midr_range spectre_v2_safe_list[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+	{ /* sentinel */ }
 };
 
+static bool __maybe_unused
+check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	int need_wa;
+
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+
+	/* If the CPU has CSV2 set, we're safe */
+	if (cpuid_feature_extract_unsigned_field(read_cpuid(ID_AA64PFR0_EL1),
+						 ID_AA64PFR0_CSV2_SHIFT))
+		return false;
+
+	/* Alternatively, we have a list of unaffected CPUs */
+	if (is_midr_in_range_list(read_cpuid_id(), spectre_v2_safe_list))
+		return false;
+
+	/* Fallback to firmware detection */
+	need_wa = detect_harden_bp_fw();
+	if (!need_wa)
+		return false;
+
+	if (need_wa < 0)
+		pr_warn_once("ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware\n");
+
+	/* forced off */
+	if (__nospectre_v2)
+		return false;
+
+	return (need_wa > 0);
+}
+
 #ifdef CONFIG_HARDEN_EL2_VECTORS
 
 static const struct midr_range arm64_harden_el2_vectors[] = {
@@ -695,8 +699,8 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		.cpu_enable = enable_smccc_arch_workaround_1,
-		ERRATA_MIDR_RANGE_LIST(arm64_bp_harden_smccc_cpus),
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.matches = check_branch_predictor,
 	},
 #ifdef CONFIG_HARDEN_EL2_VECTORS
 	{
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
