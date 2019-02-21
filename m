Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF53C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:21:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA3B2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JK6SDkW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA3B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Zh5UkHy5ilU31LEHqGUpfb21egaGTX6fpdV/GecK6tM=; b=JK6SDkW7dny5IJKF2BvVTaEkdZ
	mufvbK39eaAWj0S+I4Zqg7kM/psPjPL9Oo9iruDDqswg0nExDNqQIsGE7ZclostVFIMqVsuxjTwVD
	8CX8oRxrrqH81vDPHDVk/IWO1iAxZi3gdOhEGsXXOpzu0idzFhjNJkT0iR8CmOrdG0LTYXQDFEM7j
	XHu+sIuR/jzsblvpEgET7Bj8fPVxuua7lIhSe2Cf8TPtzlbvR4U99ohc9u6VKIgpKduX7lesVdubQ
	/lE2D6dncqQ4UqJT/IpHmEW90Eo8f+BxTQtI7dMhyJkeuJkXWl/6aMGZqwPhPX0l1IzWb6MptdiyA
	jR5aBF5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnMC-0004gx-8h; Thu, 21 Feb 2019 12:21:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnLf-0003wo-Fi
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 12:21:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52C6C80D;
 Thu, 21 Feb 2019 04:21:07 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E21773F575;
 Thu, 21 Feb 2019 04:21:05 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 2/6] arm64: HWCAP: add support for AT_HWCAP2
Date: Thu, 21 Feb 2019 12:20:53 +0000
Message-Id: <1550751657-30252-3-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550751657-30252-1-git-send-email-andrew.murray@arm.com>
References: <1550751657-30252-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_042107_533492_ED479E55 
X-CRM114-Status: GOOD (  21.24  )
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
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

As we will exhaust the first 32 bits of AT_HWCAP let's start
exposing AT_HWCAP2 to userspace to give us up to 64 caps.

Whilst it's possible to use the remaining 32 bits of AT_HWCAP, we
prefer to expand into AT_HWCAP2 in order to provide a consistent
view to userspace between ILP32 and LP64. However internal to the
kernel we prefer to continue to use the full space of elf_hwcap.

To reduce complexity and allow for future expansion, we now
represent hwcaps in the kernel as ordinals and use a
KERNEL_HWCAP_ prefix. This allows us to support automatic feature
based module loading for all our hwcaps.

We introduce cpu_set_feature to set hwcaps which compliments the
existing cpu_have_feature helper. These helpers allow us to clean
up existing direct uses of elf_hwcap and reduce any future effort
required to move beyond 64 caps.

For convenience we also introduce cpu_{have,set}_feature_name which
makes use of the cpu_feature macro to allow providing a hwcap name
without a {KERNEL_}HWCAP_ prefix.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/crypto/aes-ce-ccm-glue.c      |  2 +-
 arch/arm64/crypto/aes-neonbs-glue.c      |  2 +-
 arch/arm64/crypto/chacha-neon-glue.c     |  2 +-
 arch/arm64/crypto/crct10dif-ce-glue.c    |  2 +-
 arch/arm64/crypto/ghash-ce-glue.c        |  6 +--
 arch/arm64/crypto/nhpoly1305-neon-glue.c |  2 +-
 arch/arm64/crypto/sha256-glue.c          |  4 +-
 arch/arm64/include/asm/cpufeature.h      | 19 ++++++---
 arch/arm64/include/asm/hwcap.h           | 40 ++++++++++++++++++-
 arch/arm64/include/uapi/asm/hwcap.h      |  2 +-
 arch/arm64/kernel/cpufeature.c           | 66 ++++++++++++++++----------------
 arch/arm64/kernel/cpuinfo.c              |  2 +-
 arch/arm64/kernel/fpsimd.c               |  4 +-
 drivers/clocksource/arm_arch_timer.c     |  8 ++++
 14 files changed, 108 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/crypto/aes-ce-ccm-glue.c b/arch/arm64/crypto/aes-ce-ccm-glue.c
index 68b11aa..c77f015 100644
--- a/arch/arm64/crypto/aes-ce-ccm-glue.c
+++ b/arch/arm64/crypto/aes-ce-ccm-glue.c
@@ -374,7 +374,7 @@ static struct aead_alg ccm_aes_alg = {
 
 static int __init aes_mod_init(void)
 {
-	if (!(elf_hwcap & HWCAP_AES))
+	if (!cpu_have_feature_name(AES))
 		return -ENODEV;
 	return crypto_register_aead(&ccm_aes_alg);
 }
diff --git a/arch/arm64/crypto/aes-neonbs-glue.c b/arch/arm64/crypto/aes-neonbs-glue.c
index e7a95a5..7a133cd1 100644
--- a/arch/arm64/crypto/aes-neonbs-glue.c
+++ b/arch/arm64/crypto/aes-neonbs-glue.c
@@ -440,7 +440,7 @@ static int __init aes_init(void)
 	int err;
 	int i;
 
-	if (!(elf_hwcap & HWCAP_ASIMD))
+	if (!cpu_have_feature_name(ASIMD))
 		return -ENODEV;
 
 	err = crypto_register_skciphers(aes_algs, ARRAY_SIZE(aes_algs));
diff --git a/arch/arm64/crypto/chacha-neon-glue.c b/arch/arm64/crypto/chacha-neon-glue.c
index bece1d8..71f12cd 100644
--- a/arch/arm64/crypto/chacha-neon-glue.c
+++ b/arch/arm64/crypto/chacha-neon-glue.c
@@ -173,7 +173,7 @@ static struct skcipher_alg algs[] = {
 
 static int __init chacha_simd_mod_init(void)
 {
-	if (!(elf_hwcap & HWCAP_ASIMD))
+	if (!cpu_have_feature_name(ASIMD))
 		return -ENODEV;
 
 	return crypto_register_skciphers(algs, ARRAY_SIZE(algs));
diff --git a/arch/arm64/crypto/crct10dif-ce-glue.c b/arch/arm64/crypto/crct10dif-ce-glue.c
index b461d62..56f1a7b 100644
--- a/arch/arm64/crypto/crct10dif-ce-glue.c
+++ b/arch/arm64/crypto/crct10dif-ce-glue.c
@@ -88,7 +88,7 @@ static struct shash_alg crc_t10dif_alg = {
 
 static int __init crc_t10dif_mod_init(void)
 {
-	if (elf_hwcap & HWCAP_PMULL)
+	if (cpu_have_feature_name(PMULL))
 		crc_t10dif_pmull = crc_t10dif_pmull_p64;
 	else
 		crc_t10dif_pmull = crc_t10dif_pmull_p8;
diff --git a/arch/arm64/crypto/ghash-ce-glue.c b/arch/arm64/crypto/ghash-ce-glue.c
index 067d893..8426f8a 100644
--- a/arch/arm64/crypto/ghash-ce-glue.c
+++ b/arch/arm64/crypto/ghash-ce-glue.c
@@ -646,10 +646,10 @@ static int __init ghash_ce_mod_init(void)
 {
 	int ret;
 
-	if (!(elf_hwcap & HWCAP_ASIMD))
+	if (!cpu_have_feature_name(ASIMD))
 		return -ENODEV;
 
-	if (elf_hwcap & HWCAP_PMULL)
+	if (cpu_have_feature_name(PMULL))
 		pmull_ghash_update = pmull_ghash_update_p64;
 
 	else
@@ -659,7 +659,7 @@ static int __init ghash_ce_mod_init(void)
 	if (ret)
 		return ret;
 
-	if (elf_hwcap & HWCAP_PMULL) {
+	if (cpu_have_feature_name(PMULL)) {
 		ret = crypto_register_aead(&gcm_aes_alg);
 		if (ret)
 			crypto_unregister_shash(&ghash_alg);
diff --git a/arch/arm64/crypto/nhpoly1305-neon-glue.c b/arch/arm64/crypto/nhpoly1305-neon-glue.c
index 22cc32a..9ce3368 100644
--- a/arch/arm64/crypto/nhpoly1305-neon-glue.c
+++ b/arch/arm64/crypto/nhpoly1305-neon-glue.c
@@ -56,7 +56,7 @@ static struct shash_alg nhpoly1305_alg = {
 
 static int __init nhpoly1305_mod_init(void)
 {
-	if (!(elf_hwcap & HWCAP_ASIMD))
+	if (!cpu_have_feature_name(ASIMD))
 		return -ENODEV;
 
 	return crypto_register_shash(&nhpoly1305_alg);
diff --git a/arch/arm64/crypto/sha256-glue.c b/arch/arm64/crypto/sha256-glue.c
index 4aedeae..20e28d0 100644
--- a/arch/arm64/crypto/sha256-glue.c
+++ b/arch/arm64/crypto/sha256-glue.c
@@ -173,7 +173,7 @@ static int __init sha256_mod_init(void)
 	if (ret)
 		return ret;
 
-	if (elf_hwcap & HWCAP_ASIMD) {
+	if (cpu_have_feature_name(ASIMD)) {
 		ret = crypto_register_shashes(neon_algs, ARRAY_SIZE(neon_algs));
 		if (ret)
 			crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
@@ -183,7 +183,7 @@ static int __init sha256_mod_init(void)
 
 static void __exit sha256_mod_fini(void)
 {
-	if (elf_hwcap & HWCAP_ASIMD)
+	if (cpu_have_feature_name(ASIMD))
 		crypto_unregister_shashes(neon_algs, ARRAY_SIZE(neon_algs));
 	crypto_unregister_shashes(algs, ARRAY_SIZE(algs));
 }
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index dfcfba7..dd21a32 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -17,12 +17,12 @@
 /*
  * In the arm64 world (as in the ARM world), elf_hwcap is used both internally
  * in the kernel and for user space to keep track of which optional features
- * are supported by the current system. So let's map feature 'x' to HWCAP_x.
- * Note that HWCAP_x constants are bit fields so we need to take the log.
+ * are supported by the current system. So let's map feature 'x' to
+ * KERNEL_HWCAP_x.
  */
 
-#define MAX_CPU_FEATURES	(8 * sizeof(elf_hwcap))
-#define cpu_feature(x)		ilog2(HWCAP_ ## x)
+#define MAX_CPU_FEATURES	64
+#define cpu_feature(x)		(KERNEL_HWCAP_ ## x)
 
 #ifndef __ASSEMBLY__
 
@@ -396,10 +396,19 @@ extern struct static_key_false arm64_const_caps_ready;
 
 bool this_cpu_has_cap(unsigned int cap);
 
+static inline void cpu_set_feature(unsigned int num)
+{
+	WARN_ON(num >= MAX_CPU_FEATURES);
+	elf_hwcap |= BIT(num);
+}
+#define cpu_set_feature_name(name) cpu_set_feature(cpu_feature(name))
+
 static inline bool cpu_have_feature(unsigned int num)
 {
-	return elf_hwcap & (1UL << num);
+	WARN_ON(num >= MAX_CPU_FEATURES);
+	return elf_hwcap & BIT(num);
 }
+#define cpu_have_feature_name(name) cpu_have_feature(cpu_feature(name))
 
 /* System capability check for constant caps */
 static inline bool __cpus_have_const_cap(int num)
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 400b80b..7549c72 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -39,12 +39,50 @@
 #define COMPAT_HWCAP2_SHA2	(1 << 3)
 #define COMPAT_HWCAP2_CRC32	(1 << 4)
 
+/*
+ * KERNEL_HWCAP flags - for elf_hwcap (in kernel)
+ */
+#define KERNEL_HWCAP_FP			ilog2(HWCAP_FP)
+#define KERNEL_HWCAP_ASIMD		ilog2(HWCAP_ASIMD)
+#define KERNEL_HWCAP_EVTSTRM		ilog2(HWCAP_EVTSTRM)
+#define KERNEL_HWCAP_AES		ilog2(HWCAP_AES)
+#define KERNEL_HWCAP_PMULL		ilog2(HWCAP_PMULL)
+#define KERNEL_HWCAP_SHA1		ilog2(HWCAP_SHA1)
+#define KERNEL_HWCAP_SHA2		ilog2(HWCAP_SHA2)
+#define KERNEL_HWCAP_CRC32		ilog2(HWCAP_CRC32)
+#define KERNEL_HWCAP_ATOMICS		ilog2(HWCAP_ATOMICS)
+#define KERNEL_HWCAP_FPHP		ilog2(HWCAP_FPHP)
+#define KERNEL_HWCAP_ASIMDHP		ilog2(HWCAP_ASIMDHP)
+#define KERNEL_HWCAP_CPUID		ilog2(HWCAP_CPUID)
+#define KERNEL_HWCAP_ASIMDRDM		ilog2(HWCAP_ASIMDRDM)
+#define KERNEL_HWCAP_JSCVT		ilog2(HWCAP_JSCVT)
+#define KERNEL_HWCAP_FCMA		ilog2(HWCAP_FCMA)
+#define KERNEL_HWCAP_LRCPC		ilog2(HWCAP_LRCPC)
+#define KERNEL_HWCAP_DCPOP		ilog2(HWCAP_DCPOP)
+#define KERNEL_HWCAP_SHA3		ilog2(HWCAP_SHA3)
+#define KERNEL_HWCAP_SM3		ilog2(HWCAP_SM3)
+#define KERNEL_HWCAP_SM4		ilog2(HWCAP_SM4)
+#define KERNEL_HWCAP_ASIMDDP		ilog2(HWCAP_ASIMDDP)
+#define KERNEL_HWCAP_SHA512		ilog2(HWCAP_SHA512)
+#define KERNEL_HWCAP_SVE		ilog2(HWCAP_SVE)
+#define KERNEL_HWCAP_ASIMDFHM		ilog2(HWCAP_ASIMDFHM)
+#define KERNEL_HWCAP_DIT		ilog2(HWCAP_DIT)
+#define KERNEL_HWCAP_USCAT		ilog2(HWCAP_USCAT)
+#define KERNEL_HWCAP_ILRCPC		ilog2(HWCAP_ILRCPC)
+#define KERNEL_HWCAP_FLAGM		ilog2(HWCAP_FLAGM)
+#define KERNEL_HWCAP_SSBS		ilog2(HWCAP_SSBS)
+#define KERNEL_HWCAP_SB			ilog2(HWCAP_SB)
+#define KERNEL_HWCAP_PACA		ilog2(HWCAP_PACA)
+#define KERNEL_HWCAP_PACG		ilog2(HWCAP_PACG)
+#define KERNEL_HWCAP_DCPODP		(ilog2(HWCAP2_DCPODP) + 32)
+
 #ifndef __ASSEMBLY__
 /*
  * This yields a mask that user programs can use to figure out what
  * instruction set this cpu supports.
  */
-#define ELF_HWCAP		(elf_hwcap)
+#define ELF_HWCAP		lower_32_bits(elf_hwcap)
+#define ELF_HWCAP2		upper_32_bits(elf_hwcap)
 
 #ifdef CONFIG_COMPAT
 #define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 5f0750c..453b45a 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -18,7 +18,7 @@
 #define _UAPI__ASM_HWCAP_H
 
 /*
- * HWCAP flags - for elf_hwcap (in kernel) and AT_HWCAP
+ * HWCAP flags - for AT_HWCAP
  */
 #define HWCAP_FP		(1 << 0)
 #define HWCAP_ASIMD		(1 << 1)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f6d84e2..6a477a3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1536,39 +1536,39 @@ static const struct arm64_cpu_capabilities ptr_auth_hwcap_gen_matches[] = {
 #endif
 
 static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_AES_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, HWCAP_PMULL),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_AES_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_AES),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA1_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SHA1),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA2_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SHA2),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA2_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, HWCAP_SHA512),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_CRC32_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_CRC32),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_ATOMICS_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, HWCAP_ATOMICS),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_RDM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_ASIMDRDM),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA3_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SHA3),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SM3_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SM3),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SM4_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SM4),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_DP_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_ASIMDDP),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_FHM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_ASIMDFHM),
-	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_TS_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_FLAGM),
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_FP),
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_FPHP),
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_ASIMDHP),
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_DIT_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_DIT),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DPB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_DCPOP),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_JSCVT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_JSCVT),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FCMA_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_FCMA),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_LRCPC),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, HWCAP_ILRCPC),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SB),
-	HWCAP_CAP(SYS_ID_AA64MMFR2_EL1, ID_AA64MMFR2_AT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_USCAT),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_AES_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_PMULL),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_AES_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_AES),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA1_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SHA1),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA2_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SHA2),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA2_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_SHA512),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_CRC32_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_CRC32),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_ATOMICS_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_ATOMICS),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_RDM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDRDM),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA3_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SHA3),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SM3_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SM3),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SM4_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SM4),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_DP_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDDP),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_FHM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDFHM),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_TS_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FLAGM),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, KERNEL_HWCAP_FP),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FPHP),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, KERNEL_HWCAP_ASIMD),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_ASIMDHP),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_DIT_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_DIT),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DPB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_DCPOP),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_JSCVT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_JSCVT),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FCMA_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FCMA),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_LRCPC),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_ILRCPC),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SB),
+	HWCAP_CAP(SYS_ID_AA64MMFR2_EL1, ID_AA64MMFR2_AT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, HWCAP_SVE),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, KERNEL_HWCAP_SVE),
 #endif
-	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_SSBS_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_SSBS_PSTATE_INSNS, CAP_HWCAP, HWCAP_SSBS),
+	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_SSBS_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_SSBS_PSTATE_INSNS, CAP_HWCAP, KERNEL_HWCAP_SSBS),
 #ifdef CONFIG_ARM64_PTR_AUTH
-	HWCAP_MULTI_CAP(ptr_auth_hwcap_addr_matches, CAP_HWCAP, HWCAP_PACA),
-	HWCAP_MULTI_CAP(ptr_auth_hwcap_gen_matches, CAP_HWCAP, HWCAP_PACG),
+	HWCAP_MULTI_CAP(ptr_auth_hwcap_addr_matches, CAP_HWCAP, KERNEL_HWCAP_PACA),
+	HWCAP_MULTI_CAP(ptr_auth_hwcap_gen_matches, CAP_HWCAP, KERNEL_HWCAP_PACG),
 #endif
 	{},
 };
@@ -1588,7 +1588,7 @@ static void __init cap_set_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 {
 	switch (cap->hwcap_type) {
 	case CAP_HWCAP:
-		elf_hwcap |= cap->hwcap;
+		cpu_set_feature(cap->hwcap);
 		break;
 #ifdef CONFIG_COMPAT
 	case CAP_COMPAT_HWCAP:
@@ -1611,7 +1611,7 @@ static bool cpus_have_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 
 	switch (cap->hwcap_type) {
 	case CAP_HWCAP:
-		rc = (elf_hwcap & cap->hwcap) != 0;
+		rc = cpu_have_feature(cap->hwcap);
 		break;
 #ifdef CONFIG_COMPAT
 	case CAP_COMPAT_HWCAP:
@@ -1632,7 +1632,7 @@ static bool cpus_have_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 {
 	/* We support emulation of accesses to CPU ID feature registers */
-	elf_hwcap |= HWCAP_CPUID;
+	cpu_set_feature_name(CPUID);
 	for (; hwcaps->matches; hwcaps++)
 		if (hwcaps->matches(hwcaps, cpucap_default_scope(hwcaps)))
 			cap_set_elf_hwcap(hwcaps);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index ca0685f..810db95 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -167,7 +167,7 @@ static int c_show(struct seq_file *m, void *v)
 #endif /* CONFIG_COMPAT */
 		} else {
 			for (j = 0; hwcap_str[j]; j++)
-				if (elf_hwcap & (1 << j))
+				if (cpu_have_feature(j))
 					seq_printf(m, " %s", hwcap_str[j]);
 		}
 		seq_puts(m, "\n");
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5ebe73b..940b547 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1258,14 +1258,14 @@ static inline void fpsimd_hotplug_init(void) { }
  */
 static int __init fpsimd_init(void)
 {
-	if (elf_hwcap & HWCAP_FP) {
+	if (cpu_have_feature_name(FP)) {
 		fpsimd_pm_init();
 		fpsimd_hotplug_init();
 	} else {
 		pr_notice("Floating-point is not implemented\n");
 	}
 
-	if (!(elf_hwcap & HWCAP_ASIMD))
+	if (!cpu_have_feature_name(ASIMD))
 		pr_notice("Advanced SIMD is not implemented\n");
 
 	return sve_sysctl_init();
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc..4e8d3b4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -778,7 +778,11 @@ static void arch_timer_evtstrm_enable(int divider)
 	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
 			| ARCH_TIMER_VIRT_EVT_EN;
 	arch_timer_set_cntkctl(cntkctl);
+#ifdef CONFIG_ARM64
+	cpu_set_feature_name(EVTSTRM);
+#else
 	elf_hwcap |= HWCAP_EVTSTRM;
+#endif
 #ifdef CONFIG_COMPAT
 	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
 #endif
@@ -1000,7 +1004,11 @@ static int arch_timer_cpu_pm_notify(struct notifier_block *self,
 	} else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT) {
 		arch_timer_set_cntkctl(__this_cpu_read(saved_cntkctl));
 
+#ifdef CONFIG_ARM64
+		if (cpu_have_feature_name(EVTSTRM))
+#else
 		if (elf_hwcap & HWCAP_EVTSTRM)
+#endif
 			cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
 	}
 	return NOTIFY_OK;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
