Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164CDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:07:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD784218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fTQkZ1xJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD784218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1GHCIkB5xaJj1RAZG7RCnNXYkdUSlfSObgO49aimNqc=; b=fTQkZ1xJeVaOq+GQr3zirv2T6f
	vxyuIXojjJf4lE7W9V2zqVB+XaE6+uf+KY4s+jCyERSuZ/oVLnFofsVdg+IgCCk0IUx8/pE2lCu3v
	3A3t75Du33PRMl4rWzSVJTBKxVZLVHqlc4NPyzz4ePxi8rGCdY0wDoY7pHCFwbcVSqB1Y4dhN0oUV
	SmhocyNbf1zYO+szcfZi61eUmu1sk3zKXjRazsZ4SbvscVdC5rKZaCNTphdXTuu/6AyHKWC6mtaHC
	S7bxS0tlWH5C/vZFkJSV1YfxDpTGXxGaV/ibvQVinoLNNbORmqPTzg5mePu4b9vxTU4xbBDfe4sBr
	jcfZvk+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyngT-00077R-4p; Wed, 27 Feb 2019 01:06:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gynfi-0006BX-Df
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 01:06:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 746BD1713;
 Tue, 26 Feb 2019 17:06:05 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5E093F5C1;
 Tue, 26 Feb 2019 17:06:04 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 04/10] arm64: Advertise mitigation of Spectre-v2,
 or lack thereof
Date: Tue, 26 Feb 2019 19:05:38 -0600
Message-Id: <20190227010544.597579-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190227010544.597579-1-jeremy.linton@arm.com>
References: <20190227010544.597579-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_170607_070516_CBE5D663 
X-CRM114-Status: GOOD (  20.40  )
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
Cc: mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, julien.thierry@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
 stefan.wahren@i2e.com, Andre.Przywara@arm.com, Dave.Martin@arm.com,
 shankerd@codeaurora.org
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
 arch/arm64/kernel/cpu_errata.c | 108 +++++++++++++++++----------------
 1 file changed, 56 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index ad58958becb6..c8972255b365 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -131,9 +131,9 @@ static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
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
@@ -177,23 +177,6 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 }
 #endif	/* CONFIG_KVM_INDIRECT_VECTORS */
 
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
@@ -228,31 +211,27 @@ static int __init parse_nospectre_v2(char *str)
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
-	if (__nospectre_v2) {
-		pr_info_once("spectrev2 mitigation disabled by command line option\n");
-		return;
-	}
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
@@ -263,23 +242,23 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
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
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
@@ -521,24 +500,49 @@ cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 	CAP_MIDR_RANGE_LIST(midr_list)
 
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
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
+	/* forced off */
+	if (__nospectre_v2) {
+		pr_info_once("spectrev2 mitigation disabled by command line option\n");
+		return false;
+	}
+
+	if (need_wa < 0)
+		pr_warn_once("ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware\n");
+
+	return (need_wa > 0);
+}
+
 #endif
 
 #ifdef CONFIG_HARDEN_EL2_VECTORS
@@ -717,8 +721,8 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		.cpu_enable = enable_smccc_arch_workaround_1,
-		ERRATA_MIDR_RANGE_LIST(arm64_bp_harden_smccc_cpus),
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.matches = check_branch_predictor,
 	},
 #endif
 #ifdef CONFIG_HARDEN_EL2_VECTORS
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
