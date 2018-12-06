Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B3DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:45:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4EAE20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VcVpcP2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EAE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=V7vioYwH6iFgVaYJ9MrYTZ1Nu3bhpUI57CTq0HIrDgQ=; b=VcVpcP2btQRg+cVCqD3KmpDKOG
	/O/c5kmabNRM8skFXPO8L2CUGoK19WWh3rOJoHc3WERLRW3Z0PsfnoP8fCtMupQ02sT18irX9ErMe
	/9LnzsQVLAnLqBxNg/7uywaqTg8U7pd6o5efrcCp0SiU7s2VWR3sFtFt3Y6BtHGILhDHJLZGW6iWY
	H5I1Ft8Le8i9/h8/Y1ayV+55zBzOpBNC+dncTTLZ7Eo5PLfHRIYr237QJKrUCQ87ZBeIH1QyA45Th
	9dyTOjSiiBvX1uavtFnsuPohdQ1Dpvv9lckmAh+PUVZeJNJJixO7yXs1w1sNUMAtgVaJ1xZDKFomn
	H41COJFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV3L4-0004Kr-Mp; Thu, 06 Dec 2018 23:45:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV3K0-0001qm-M7
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 23:44:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D8481682;
 Thu,  6 Dec 2018 15:44:34 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C09853F5AF;
 Thu,  6 Dec 2018 15:44:33 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/6] arm64: add sysfs vulnerability show for spectre v2
Date: Thu,  6 Dec 2018 17:44:06 -0600
Message-Id: <20181206234408.1287689-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181206234408.1287689-1-jeremy.linton@arm.com>
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_154445_466811_31AB5646 
X-CRM114-Status: GOOD (  15.62  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, ykaukab@suse.de, dave.martin@arm.com,
 shankerd@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add code to track whether all the cores in the machine are
vulnerable, and whether all the vulnerable cores have been
mitigated.

Once we have that information we can add the sysfs stub and
provide an accurate view of what is known about the machine.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 72 +++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 559ecdee6fd2..6505c93d507e 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -109,6 +109,11 @@ cpu_enable_trap_ctr_access(const struct arm64_cpu_capabilities *__unused)
 
 atomic_t arm64_el2_vector_last_slot = ATOMIC_INIT(-1);
 
+#if defined(CONFIG_HARDEN_BRANCH_PREDICTOR) || defined(CONFIG_GENERIC_CPU_VULNERABILITIES)
+/* Track overall mitigation state. We are only mitigated if all cores are ok */
+static enum { A64_HBP_UNSET, A64_HBP_MIT, A64_HBP_NOTMIT } __hardenbp_enab = A64_HBP_UNSET;
+#endif
+
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -231,15 +236,19 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
 	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
 		return;
 
-	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
+	if (psci_ops.smccc_version == SMCCC_VERSION_1_0) {
+		__hardenbp_enab = A64_HBP_NOTMIT;
 		return;
+	}
 
 	switch (psci_ops.conduit) {
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if ((int)res.a0 < 0)
+		if ((int)res.a0 < 0) {
+			__hardenbp_enab = A64_HBP_NOTMIT;
 			return;
+		}
 		cb = call_hvc_arch_workaround_1;
 		/* This is a guest, no need to patch KVM vectors */
 		smccc_start = NULL;
@@ -249,14 +258,17 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
 	case PSCI_CONDUIT_SMC:
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if ((int)res.a0 < 0)
+		if ((int)res.a0 < 0) {
+			__hardenbp_enab = A64_HBP_NOTMIT;
 			return;
+		}
 		cb = call_smc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_smc_start;
 		smccc_end = __smccc_workaround_1_smc_end;
 		break;
 
 	default:
+		__hardenbp_enab = A64_HBP_NOTMIT;
 		return;
 	}
 
@@ -266,6 +278,9 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
 
 	install_bp_hardening_cb(entry, cb, smccc_start, smccc_end);
 
+	if (__hardenbp_enab == A64_HBP_UNSET)
+		__hardenbp_enab = A64_HBP_MIT;
+
 	return;
 }
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
@@ -539,7 +554,36 @@ multi_entry_cap_cpu_enable(const struct arm64_cpu_capabilities *entry)
 			caps->cpu_enable(caps);
 }
 
-#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+#if defined(CONFIG_HARDEN_BRANCH_PREDICTOR) || \
+	defined(CONFIG_GENERIC_CPU_VULNERABILITIES)
+
+static enum { A64_SV2_UNSET, A64_SV2_SAFE, A64_SV2_UNSAFE } __spectrev2_safe = A64_SV2_UNSET;
+
+/*
+ * Track overall bp hardening for all heterogeneous cores in the machine.
+ * We are only considered "safe" if all booted cores are known safe.
+ */
+static bool __maybe_unused
+check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	bool is_vul;
+	bool has_csv2;
+	u64 pfr0;
+
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+
+	is_vul = is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list);
+
+	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
+	has_csv2 = cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_CSV2_SHIFT);
+
+	if (is_vul)
+		__spectrev2_safe = A64_SV2_UNSAFE;
+	else if (__spectrev2_safe == A64_SV2_UNSET && has_csv2)
+		__spectrev2_safe = A64_SV2_SAFE;
+
+	return is_vul;
+}
 
 /*
  * List of CPUs where we need to issue a psci call to
@@ -728,7 +772,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		.cpu_enable = enable_smccc_arch_workaround_1,
-		ERRATA_MIDR_RANGE_LIST(arm64_bp_harden_smccc_cpus),
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.matches = check_branch_predictor,
+		.midr_range_list = arm64_bp_harden_smccc_cpus,
 	},
 #endif
 #ifdef CONFIG_HARDEN_EL2_VECTORS
@@ -766,4 +812,20 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	switch (__spectrev2_safe) {
+	case A64_SV2_SAFE:
+		return sprintf(buf, "Not affected\n");
+	case A64_SV2_UNSAFE:
+		if (__hardenbp_enab == A64_HBP_MIT)
+			return sprintf(buf,
+				"Mitigation: Branch predictor hardening\n");
+		return sprintf(buf, "Vulnerable\n");
+	default:
+		return sprintf(buf, "Unknown\n");
+	}
+}
+
 #endif
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
