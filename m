Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22526C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:42:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24E42082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="paEeb/m1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24E42082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=mb2cg/pOKvwxE1cChCaY9eP0USKa0iiz0+2hDCNgeAM=; b=paEeb/m1z4A0dXH+eVHNRwCAl4
	+UGaZ8yzCpWJPTiXpi9naKKqFsZI08KwfxUpF9T/v7BoURqJimnSZ30HUFVmclb6I8nSY7cg5IJ+X
	ZCSvbp7sEfsZ4OnL5SVBvVUFdOZSmQKF9OBteN139ECFimpqveBb4BKjBTHpJHLEQHf7IZHdjaXRR
	y+NRjCD1a3LObfXDQDFG6OTNQ14ygmarH4yLdyzbLdx9bRQ9Mm2+pBulk9ryyWPcPp70yxCPEhH35
	27IctLdUvN1B0Gztj9Z36t7lqjMGZdH6Af06dN/k50pTCR6FMsNv6bZTrpNnTJXsJWfNlYdBvYAXg
	0Qiq0XXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVL50-0006uh-Rf; Fri, 07 Dec 2018 18:42:26 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVL3C-0004uA-NS
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:40:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41BF31682;
 Fri,  7 Dec 2018 10:40:28 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28B483F5AF;
 Fri,  7 Dec 2018 10:40:25 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 07/13] arm64: add basic pointer authentication support
Date: Fri,  7 Dec 2018 18:39:25 +0000
Message-Id: <20181207183931.4285-8-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207183931.4285-1-kristina.martsenko@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_104034_994622_44D48E74 
X-CRM114-Status: GOOD (  20.08  )
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
 Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

This patch adds basic support for pointer authentication, allowing
userspace to make use of APIAKey, APIBKey, APDAKey, APDBKey, and
APGAKey. The kernel maintains key values for each process (shared by all
threads within), which are initialised to random values at exec() time.

The ID_AA64ISAR1_EL1.{APA,API,GPA,GPI} fields are exposed to userspace,
to describe that pointer authentication instructions are available and
that the kernel is managing the keys. Two new hwcaps are added for the
same reason: PACA (for address authentication) and PACG (for generic
authentication).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Tested-by: Adam Wallis <awallis@codeaurora.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pointer_auth.h | 75 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/thread_info.h  |  4 ++
 arch/arm64/include/uapi/asm/hwcap.h   |  2 +
 arch/arm64/kernel/cpufeature.c        | 13 ++++++
 arch/arm64/kernel/cpuinfo.c           |  2 +
 arch/arm64/kernel/process.c           |  4 ++
 6 files changed, 100 insertions(+)
 create mode 100644 arch/arm64/include/asm/pointer_auth.h

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
new file mode 100644
index 000000000000..fc7ffe8e326f
--- /dev/null
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __ASM_POINTER_AUTH_H
+#define __ASM_POINTER_AUTH_H
+
+#include <linux/random.h>
+
+#include <asm/cpufeature.h>
+#include <asm/sysreg.h>
+
+#ifdef CONFIG_ARM64_PTR_AUTH
+/*
+ * Each key is a 128-bit quantity which is split across a pair of 64-bit
+ * registers (Lo and Hi).
+ */
+struct ptrauth_key {
+	unsigned long lo, hi;
+};
+
+/*
+ * We give each process its own keys, which are shared by all threads. The keys
+ * are inherited upon fork(), and reinitialised upon exec*().
+ */
+struct ptrauth_keys {
+	struct ptrauth_key apia;
+	struct ptrauth_key apib;
+	struct ptrauth_key apda;
+	struct ptrauth_key apdb;
+	struct ptrauth_key apga;
+};
+
+static inline void ptrauth_keys_init(struct ptrauth_keys *keys)
+{
+	if (system_supports_address_auth())
+		get_random_bytes(keys, sizeof(struct ptrauth_key) * 4);
+
+	if (system_supports_generic_auth())
+		get_random_bytes(&keys->apga, sizeof(struct ptrauth_key));
+}
+
+#define __ptrauth_key_install(k, v)				\
+do {								\
+	struct ptrauth_key __pki_v = (v);			\
+	write_sysreg_s(__pki_v.lo, SYS_ ## k ## KEYLO_EL1);	\
+	write_sysreg_s(__pki_v.hi, SYS_ ## k ## KEYHI_EL1);	\
+} while (0)
+
+static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
+{
+	if (system_supports_address_auth()) {
+		__ptrauth_key_install(APIA, keys->apia);
+		__ptrauth_key_install(APIB, keys->apib);
+		__ptrauth_key_install(APDA, keys->apda);
+		__ptrauth_key_install(APDB, keys->apdb);
+	}
+
+	if (system_supports_generic_auth())
+		__ptrauth_key_install(APGA, keys->apga);
+}
+
+#define ptrauth_thread_init_user(tsk)					\
+do {									\
+	struct task_struct *__ptiu_tsk = (tsk);				\
+	ptrauth_keys_init(&__ptiu_tsk->thread_info.keys_user);		\
+	ptrauth_keys_switch(&__ptiu_tsk->thread_info.keys_user);	\
+} while (0)
+
+#define ptrauth_thread_switch(tsk)	\
+	ptrauth_keys_switch(&(tsk)->thread_info.keys_user)
+
+#else /* CONFIG_ARM64_PTR_AUTH */
+#define ptrauth_thread_init_user(tsk)
+#define ptrauth_thread_switch(tsk)
+#endif /* CONFIG_ARM64_PTR_AUTH */
+
+#endif /* __ASM_POINTER_AUTH_H */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index cb2c10a8f0a8..ea9272fb52d4 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -28,6 +28,7 @@
 struct task_struct;
 
 #include <asm/memory.h>
+#include <asm/pointer_auth.h>
 #include <asm/stack_pointer.h>
 #include <asm/types.h>
 
@@ -43,6 +44,9 @@ struct thread_info {
 	u64			ttbr0;		/* saved TTBR0_EL1 */
 #endif
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
+#ifdef CONFIG_ARM64_PTR_AUTH
+	struct ptrauth_keys	keys_user;
+#endif
 };
 
 #define thread_saved_pc(tsk)	\
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 2bcd6e4f3474..22efc70aa0a1 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -49,5 +49,7 @@
 #define HWCAP_ILRCPC		(1 << 26)
 #define HWCAP_FLAGM		(1 << 27)
 #define HWCAP_SSBS		(1 << 28)
+#define HWCAP_PACA		(1 << 29)
+#define HWCAP_PACG		(1 << 30)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f8e3c3568a79..6daa2f451eb9 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1154,6 +1154,12 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
 #endif /* CONFIG_ARM64_RAS_EXTN */
 
 #ifdef CONFIG_ARM64_PTR_AUTH
+static void cpu_enable_address_auth(struct arm64_cpu_capabilities const *cap)
+{
+	sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_ENIA | SCTLR_ELx_ENIB |
+				       SCTLR_ELx_ENDA | SCTLR_ELx_ENDB);
+}
+
 static bool has_address_auth(const struct arm64_cpu_capabilities *entry,
 			     int __unused)
 {
@@ -1431,6 +1437,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_ADDRESS_AUTH,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_address_auth,
+		.cpu_enable = cpu_enable_address_auth,
 	},
 	{
 		.desc = "Generic authentication (architected algorithm)",
@@ -1504,6 +1511,12 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, HWCAP_SVE),
 #endif
 	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_SSBS_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_SSBS_PSTATE_INSNS, CAP_HWCAP, HWCAP_SSBS),
+#ifdef CONFIG_ARM64_PTR_AUTH
+	{ .desc = "HWCAP_PACA", .type = ARM64_CPUCAP_SYSTEM_FEATURE, .matches = has_address_auth,
+		.hwcap_type = CAP_HWCAP, .hwcap = HWCAP_PACA },
+	{ .desc = "HWCAP_PACG", .type = ARM64_CPUCAP_SYSTEM_FEATURE, .matches = has_generic_auth,
+		.hwcap_type = CAP_HWCAP, .hwcap = HWCAP_PACG },
+#endif
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index bcc2831399cb..e7c7cad8dd85 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -82,6 +82,8 @@ static const char *const hwcap_str[] = {
 	"ilrcpc",
 	"flagm",
 	"ssbs",
+	"paca",
+	"pacg",
 	NULL
 };
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index d9a4c2d6dd8b..17a6b4dd6e46 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -57,6 +57,7 @@
 #include <asm/fpsimd.h>
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
+#include <asm/pointer_auth.h>
 #include <asm/stacktrace.h>
 
 #ifdef CONFIG_STACKPROTECTOR
@@ -429,6 +430,7 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	contextidr_thread_switch(next);
 	entry_task_switch(next);
 	uao_thread_switch(next);
+	ptrauth_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
@@ -496,4 +498,6 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 void arch_setup_new_exec(void)
 {
 	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
+
+	ptrauth_thread_init_user(current);
 }
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
