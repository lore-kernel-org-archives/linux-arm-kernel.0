Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D365AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:05:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A484C20C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mmNVSWT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A484C20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jvnjUDDHxcG7deeB6tix9aU3VuTMqW3339BXa7Qfzl4=; b=mmNVSWT8b7PeRM
	teC3BIF+Posgw1ClaAjYNq6yGmb9OH4Tv66mWEmuHeoz3p/nzGfNVJYgJfUFAD7IZgEkYX8RcaZQ0
	qi9DbHKA+xz5kwQuwT1WdWXCQXIQ1RYMfGoi4VdYaM+k9loGj2ss+i8XZ017WcZYjSMviJP33ZcjI
	wS0UAf5lpmALf1Q+ikRkK9SMFOpmDBOByPM3QZjuoMiVX3bH1ZA22VtIN6B2XKxjMCg+9a3a/40zv
	nydqUYR00leHgGGmmUiwSafd/1xt6dDfGoew0YX/rvNQscxfNIvkBoBtrrMBS7l0XFoPZ51c0V7MM
	MyDwnJgEh3rnBj+e4keA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmME-0006ml-P6; Mon, 18 Feb 2019 17:05:30 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmLM-0004eq-B0
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:04:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAFD31A25;
 Mon, 18 Feb 2019 09:04:21 -0800 (PST)
Received: from capper-debian.emea.arm.com (C02R32KKFVH8.manchester.arm.com
 [10.32.102.153])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5FA7A3F740;
 Mon, 18 Feb 2019 09:04:20 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 9/9] arm64: mm: Introduce 52-bit Kernel VAs
Date: Mon, 18 Feb 2019 17:02:45 +0000
Message-Id: <20190218170245.14915-10-steve.capper@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218170245.14915-1-steve.capper@arm.com>
References: <20190218170245.14915-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_090436_523245_C75A85BE 
X-CRM114-Status: GOOD (  18.13  )
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
Cc: crecklin@redhat.com, Steve Capper <steve.capper@arm.com>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
 will.deacon@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Most of the machinery is now in place to enable 52-bit kernel VAs that
are detectable at boot time.

This patch adds a Kconfig option for 52-bit user and kernel addresses
and plumbs in the requisite CONFIG_ macros as well as sets TCR.T1SZ at
early boot.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/Kconfig                     | 31 ++++++++++++++++++++++----
 arch/arm64/include/asm/assembler.h     |  9 +++++++-
 arch/arm64/include/asm/memory.h        |  2 +-
 arch/arm64/include/asm/mmu_context.h   |  2 +-
 arch/arm64/include/asm/pgtable-hwdef.h |  2 +-
 arch/arm64/kernel/head.S               |  4 ++--
 arch/arm64/mm/proc.S                   |  6 ++++-
 7 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0f933d3a1614..1a673a7d0a9b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -276,11 +276,14 @@ config KERNEL_MODE_NEON
 config FIX_EARLYCON_MEM
 	def_bool y
 
+config HAS_VA_BITS_52
+	def_bool n
+
 config PGTABLE_LEVELS
 	int
 	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
 	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
-	default 3 if ARM64_64K_PAGES && (ARM64_VA_BITS_48 || ARM64_USER_VA_BITS_52)
+	default 3 if ARM64_64K_PAGES && (ARM64_VA_BITS_48 || HAS_VA_BITS_52)
 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
 	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
 	default 4 if !ARM64_64K_PAGES && ARM64_VA_BITS_48
@@ -294,12 +297,12 @@ config ARCH_PROC_KCORE_TEXT
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN
-	default 0xdfffa00000000000 if (ARM64_VA_BITS_48 || ARM64_USER_VA_BITS_52) && !KASAN_SW_TAGS
+	default 0xdfffa00000000000 if (ARM64_VA_BITS_48 || HAS_VA_BITS_52) && !KASAN_SW_TAGS
 	default 0xdfffd00000000000 if ARM64_VA_BITS_47 && !KASAN_SW_TAGS
 	default 0xdffffe8000000000 if ARM64_VA_BITS_42 && !KASAN_SW_TAGS
 	default 0xdfffffd000000000 if ARM64_VA_BITS_39 && !KASAN_SW_TAGS
 	default 0xdffffffa00000000 if ARM64_VA_BITS_36 && !KASAN_SW_TAGS
-	default 0xefff900000000000 if (ARM64_VA_BITS_48 || ARM64_USER_VA_BITS_52) && KASAN_SW_TAGS
+	default 0xefff900000000000 if (ARM64_VA_BITS_48 || HAS_VA_BITS_52) && KASAN_SW_TAGS
 	default 0xefffc80000000000 if ARM64_VA_BITS_47 && KASAN_SW_TAGS
 	default 0xeffffe4000000000 if ARM64_VA_BITS_42 && KASAN_SW_TAGS
 	default 0xefffffc800000000 if ARM64_VA_BITS_39 && KASAN_SW_TAGS
@@ -721,6 +724,7 @@ config ARM64_VA_BITS_48
 config ARM64_USER_VA_BITS_52
 	bool "52-bit (user)"
 	depends on ARM64_64K_PAGES && (ARM64_PAN || !ARM64_SW_TTBR0_PAN)
+	select HAS_VA_BITS_52
 	help
 	  Enable 52-bit virtual addressing for userspace when explicitly
 	  requested via a hint to mmap(). The kernel will continue to
@@ -733,11 +737,28 @@ config ARM64_USER_VA_BITS_52
 
 	  If unsure, select 48-bit virtual addressing instead.
 
+config ARM64_USER_KERNEL_VA_BITS_52
+	bool "52-bit (user & kernel)"
+	depends on ARM64_64K_PAGES && (ARM64_PAN || !ARM64_SW_TTBR0_PAN)
+	select HAS_VA_BITS_52
+	help
+	  Enable 52-bit virtual addressing for userspace when explicitly
+	  requested via a hint to mmap(). The kernel will also use 52-bit
+	  virtual addresses for its own mappings (provided HW support for
+	  this feature is available, otherwise it reverts to 48-bit).
+
+	  NOTE: Enabling 52-bit virtual addressing in conjunction with
+	  ARMv8.3 Pointer Authentication will result in the PAC being
+	  reduced from 7 bits to 3 bits, which may have a significant
+	  impact on its susceptibility to brute-force attacks.
+
+	  If unsure, select 48-bit virtual addressing instead.
+
 endchoice
 
 config ARM64_FORCE_52BIT
 	bool "Force 52-bit virtual addresses for userspace"
-	depends on ARM64_USER_VA_BITS_52 && EXPERT
+	depends on HAS_VA_BITS_52 && EXPERT
 	help
 	  For systems with 52-bit userspace VAs enabled, the kernel will attempt
 	  to maintain compatibility with older software by providing 48-bit VAs
@@ -755,9 +776,11 @@ config ARM64_VA_BITS
 	default 42 if ARM64_VA_BITS_42
 	default 47 if ARM64_VA_BITS_47
 	default 48 if ARM64_VA_BITS_48 || ARM64_USER_VA_BITS_52
+	default 52 if ARM64_USER_KERNEL_VA_BITS_52
 
 config ARM64_VA_BITS_MIN
 	int
+	default 48 if ARM64_USER_KERNEL_VA_BITS_52
 	default ARM64_VA_BITS
 
 choice
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 58ed5d086e1e..c7c3ca2d70f8 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -363,6 +363,13 @@ alternative_endif
 	bfi	\valreg, \t0sz, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
 	.endm
 
+/*
+ * tcr_set_t1sz - update TCR.T1SZ
+ */
+	.macro	tcr_set_t1sz, valreg, t1sz
+	bfi	\valreg, \t1sz, #TCR_T1SZ_OFFSET, #TCR_TxSZ_WIDTH
+	.endm
+
 /*
  * tcr_compute_pa_size - set TCR.(I)PS to the highest supported
  * ID_AA64MMFR0_EL1.PARange value
@@ -568,7 +575,7 @@ alternative_endif
  * to be nop'ed out when dealing with 52-bit kernel VAs.
  */
 	.macro	restore_ttbr1, ttbr
-#if defined(CONFIG_ARM64_USER_VA_BITS_52) || defined(CONFIG_ARM64_KERNEL_VA_BITS_52)
+#ifdef CONFIG_HAS_VA_BITS_52
 	bic	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
 #endif
 	.endm
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index a51056a157dd..f17777f4272c 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -67,7 +67,7 @@
 #define KERNEL_START      _text
 #define KERNEL_END        _end
 
-#ifdef CONFIG_ARM64_USER_VA_BITS_52
+#ifdef CONFIG_HAS_VA_BITS_52
 #define MAX_USER_VA_BITS	52
 #else
 #define MAX_USER_VA_BITS	VA_BITS
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 133ecb65b602..1ae26b357e1e 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -74,7 +74,7 @@ extern u64 idmap_ptrs_per_pgd;
 
 static inline bool __cpu_uses_extended_idmap(void)
 {
-	if (IS_ENABLED(CONFIG_ARM64_USER_VA_BITS_52))
+	if (IS_ENABLED(CONFIG_HAS_VA_BITS_52))
 		return false;
 
 	return unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS));
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index e9b0a7d75184..15379996ffe2 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -315,7 +315,7 @@
 #define TTBR_BADDR_MASK_52	(((UL(1) << 46) - 1) << 2)
 #endif
 
-#ifdef CONFIG_ARM64_USER_VA_BITS_52
+#ifdef CONFIG_HAS_VA_BITS_52
 /* Must be at least 64-byte aligned to prevent corruption of the TTBR */
 #define TTBR1_BADDR_4852_OFFSET	(((UL(1) << (52 - PGDIR_SHIFT)) - \
 				 (UL(1) << (48 - PGDIR_SHIFT))) * 8)
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4877b82d2091..c486e66a9ba6 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -319,7 +319,7 @@ __create_page_tables:
 	adrp	x0, idmap_pg_dir
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
 
-#ifdef CONFIG_ARM64_USER_VA_BITS_52
+#ifdef CONFIG_HAS_VA_BITS_52
 	mrs_s	x6, SYS_ID_AA64MMFR2_EL1
 	and	x6, x6, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
 	mov	x5, #52
@@ -818,7 +818,7 @@ ENTRY(__enable_mmu)
 ENDPROC(__enable_mmu)
 
 ENTRY(__cpu_secondary_check52bitva)
-#ifdef CONFIG_ARM64_USER_VA_BITS_52
+#ifdef CONFIG_HAS_VA_BITS_52
 	ldr_l	x0, vabits_user
 	cmp	x0, #52
 	b.ne	2f
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 73886a5f1f30..e85500dfe89a 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -457,7 +457,7 @@ ENTRY(__cpu_setup)
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
 
-#ifdef CONFIG_ARM64_USER_VA_BITS_52
+#ifdef CONFIG_HAS_VA_BITS_52
 	ldr_l		x9, vabits_user
 	sub		x9, xzr, x9
 	add		x9, x9, #64
@@ -466,6 +466,10 @@ ENTRY(__cpu_setup)
 #endif
 	tcr_set_t0sz	x10, x9
 
+#ifdef CONFIG_ARM64_USER_KERNEL_VA_BITS_52
+	tcr_set_t1sz	x10, x9
+#endif
+
 	/*
 	 * Set the IPS bits in TCR_EL1.
 	 */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
