Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F5CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:57:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F737206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N5Z7vtOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F737206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=twpVXofTowBjt90yl0f2dXkhAHKMJ+BYY3+SPKEzKqA=; b=N5Z7vtOcrenOutwesAms5bo//A
	Yord6jZl7g1aZLJageAMhOX3kpMC98ye3kmXxDRJG0WfIQ61oiUFeccO6fx4l8lKr/roWe/u0oGPv
	N8svd2hO5onoXuRztZdiEkywlkueEDpe6bWENCIsX0E5VcQh5R1e0zd8FoByfwFlt30PHrME4zYcG
	GvYfhjJ4y7UiLAyJoGmC1OteXAHoyWShWW8XJ6F+dq61MPw/tSeaKOUwwkGbtIB9MvlaRivnnn6+U
	2ynZm6dc6ro4spad31ehs835Q38IyPkYtnyEp/flE30sULtPB1k98f8KS26G9n1JtiobQPR++4lw/
	hi2kXu8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghNig-0007BJ-2k; Wed, 09 Jan 2019 23:57:10 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghNhU-00060B-N8
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 23:56:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F09BA78;
 Wed,  9 Jan 2019 15:55:56 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8795C3F5AF;
 Wed,  9 Jan 2019 15:55:55 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 5/7] arm64: add sysfs vulnerability show for spectre v2
Date: Wed,  9 Jan 2019 17:55:42 -0600
Message-Id: <20190109235544.2992426-6-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190109235544.2992426-1-jeremy.linton@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_155557_343846_D0B9D08C 
X-CRM114-Status: GOOD (  14.64  )
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

Add code to track whether all the cores in the machine are
vulnerable, and whether all the vulnerable cores have been
mitigated.

Once we have that information we can add the sysfs stub and
provide an accurate view of what is known about the machine.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 61 +++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 8dde8c616b7e..ee286d606d9b 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -111,6 +111,11 @@ atomic_t arm64_el2_vector_last_slot = ATOMIC_INIT(-1);
 
 uint arm64_requested_vuln_attrs = VULN_SPECTREV1;
 
+#if defined(CONFIG_HARDEN_BRANCH_PREDICTOR) || defined(CONFIG_GENERIC_CPU_VULNERABILITIES)
+/* Track overall mitigation state. We are only mitigated if all cores are ok */
+static bool __hardenbp_enab = true;
+#endif
+
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -233,15 +238,19 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
 	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
 		return;
 
-	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
+	if (psci_ops.smccc_version == SMCCC_VERSION_1_0) {
+		__hardenbp_enab = false;
 		return;
+	}
 
 	switch (psci_ops.conduit) {
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if ((int)res.a0 < 0)
+		if ((int)res.a0 < 0) {
+			__hardenbp_enab = false;
 			return;
+		}
 		cb = call_hvc_arch_workaround_1;
 		/* This is a guest, no need to patch KVM vectors */
 		smccc_start = NULL;
@@ -251,14 +260,17 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
 	case PSCI_CONDUIT_SMC:
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if ((int)res.a0 < 0)
+		if ((int)res.a0 < 0) {
+			__hardenbp_enab = false;
 			return;
+		}
 		cb = call_smc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_smc_start;
 		smccc_end = __smccc_workaround_1_smc_end;
 		break;
 
 	default:
+		__hardenbp_enab = false;
 		return;
 	}
 
@@ -509,7 +521,32 @@ cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
 	CAP_MIDR_RANGE_LIST(midr_list)
 
-#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+#if defined(CONFIG_HARDEN_BRANCH_PREDICTOR) || \
+	defined(CONFIG_GENERIC_CPU_VULNERABILITIES)
+
+
+static bool __spectrev2_safe = true;
+
+/*
+ * Track overall bp hardening for all heterogeneous cores in the machine.
+ * We are only considered "safe" if all booted cores are known safe.
+ */
+static bool __maybe_unused
+check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	bool is_vul;
+
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+
+	is_vul = is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list);
+
+	if (is_vul)
+		__spectrev2_safe = false;
+
+	arm64_requested_vuln_attrs |= VULN_SPECTREV2;
+
+	return is_vul;
+}
 
 /*
  * List of CPUs where we need to issue a psci call to
@@ -707,7 +744,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
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
@@ -758,4 +797,16 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	if (__spectrev2_safe)
+		return sprintf(buf, "Not affected\n");
+
+	if (__hardenbp_enab)
+		return sprintf(buf, "Mitigation: Branch predictor hardening\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
+
 #endif
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
