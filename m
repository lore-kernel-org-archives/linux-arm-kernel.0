Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F82C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:12:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214EB218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GUe11znk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214EB218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fOkNgT4hj7lByaIz6L+szXwbInsRKCsXkSTEbDJIdvc=; b=GUe11znkKN0+OlfuIlsJNyXmwO
	CtEWzrjEKRE8vNWYXm/621N9dFM7XS8m8KP39A9o4YHde+/KREYuIAomgk2A45H/1V3IyRB6CGqAG
	Jp3aoXF2oSD91+oUo+KZbvN+o/JhTNbDv1wAucGk7bFQC72c2rEi/gRL3ev5K2Q7O5t/SEedjcqzM
	16ZjS23jbbf9Kn6p1kpFrRscapUSwd8Ld+7MmuRBKCHPjXyBCUzWIzuUSywAiIErMxTJrGpLVFEGD
	BrE1KftzbZhlMgLU0ZfFk8ATYykKP9X2uCv9rebA9q86sDDr+w9uvUBsRnxYiShM6+ZOhtYyW0Dev
	tvHYXNRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gynls-0001uS-Bc; Wed, 27 Feb 2019 01:12:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gynfm-0006Il-R7
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 01:06:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38EE01A25;
 Tue, 26 Feb 2019 17:06:10 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A28D3F5C1;
 Tue, 26 Feb 2019 17:06:09 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 08/10] arm64: Always enable ssb vulnerability detection
Date: Tue, 26 Feb 2019 19:05:42 -0600
Message-Id: <20190227010544.597579-9-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190227010544.597579-1-jeremy.linton@arm.com>
References: <20190227010544.597579-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_170611_020312_7334EC69 
X-CRM114-Status: GOOD (  11.93  )
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

The ssb detection logic is necessary regardless of whether
the vulnerability mitigation code is built into the kernel.
Break it out so that the CONFIG option only controls the
mitigation logic and not the vulnerability detection.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  4 ----
 arch/arm64/kernel/cpu_errata.c      | 11 +++++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index dfcfba725d72..c2b60a021437 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -628,11 +628,7 @@ static inline int arm64_get_ssbd_state(void)
 #endif
 }
 
-#ifdef CONFIG_ARM64_SSBD
 void arm64_set_ssbd_mitigation(bool state);
-#else
-static inline void arm64_set_ssbd_mitigation(bool state) {}
-#endif
 
 extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 0f6e8f5d67bc..5f5611d17dc1 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -276,7 +276,6 @@ static int detect_harden_bp_fw(void)
 	return 1;
 }
 
-#ifdef CONFIG_ARM64_SSBD
 DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 
 int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
@@ -347,6 +346,7 @@ void __init arm64_enable_wa2_handling(struct alt_instr *alt,
 		*updptr = cpu_to_le32(aarch64_insn_gen_nop());
 }
 
+#ifdef CONFIG_ARM64_SSBD
 void arm64_set_ssbd_mitigation(bool state)
 {
 	if (this_cpu_has_cap(ARM64_SSBS)) {
@@ -371,6 +371,12 @@ void arm64_set_ssbd_mitigation(bool state)
 		break;
 	}
 }
+#else
+void arm64_set_ssbd_mitigation(bool state)
+{
+	pr_info_once("SSBD, disabled by kernel configuration\n");
+}
+#endif	/* CONFIG_ARM64_SSBD */
 
 static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 				    int scope)
@@ -468,7 +474,6 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 
 	return required;
 }
-#endif	/* CONFIG_ARM64_SSBD */
 
 static void __maybe_unused
 cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
@@ -760,14 +765,12 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_RANGE_LIST(arm64_harden_el2_vectors),
 	},
 #endif
-#ifdef CONFIG_ARM64_SSBD
 	{
 		.desc = "Speculative Store Bypass Disable",
 		.capability = ARM64_SSBD,
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.matches = has_ssbd_mitigation,
 	},
-#endif
 #ifdef CONFIG_ARM64_ERRATUM_1188873
 	{
 		/* Cortex-A76 r0p0 to r2p0 */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
