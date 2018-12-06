Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F556C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:53:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C393020878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TbaxTh4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C393020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YJOWuTyBSpv+aQoPmfUt70eXyUNTkmXws81KD55hsz0=; b=TbaxTh4f5WQZXO
	7mc/tWyqpQc7qZ4hvFX6UTF34LPLNguHl2lsaOBOnTFna8OK7jRZg9LD66/zKhxlmIxKmF2OUhlk+
	c6rZMK3s43H4w6/xVg5Icgh3TirIdZ/qQ07sxq3/kC4otNB5xAGJ/NssougK4SIWdUlxfVx6bpFRP
	HwD96+QzNBD44i71ivfJcX3byPQSWTtuZnUs3zC4fntOzq7IohZCO4dpTkt43tq1zx0LZeS1UttwS
	Z1/xxjPlSS2nzw1+iNx5dyRl+LImf+e5r2SEqr37r5I4KruPe9Z6S7JKUXwIo+VExXaU8TuqD7R0/
	93TgJyZrZyg+F6uP0epw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV2Vw-0003Tl-AI; Thu, 06 Dec 2018 22:53:00 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV2UI-0001kS-E3
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:51:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B98115AB;
 Thu,  6 Dec 2018 14:51:13 -0800 (PST)
Received: from capper-debian.arm.com (unknown [10.37.12.92])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB7493F5AF;
 Thu,  6 Dec 2018 14:51:11 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V5 6/7] arm64: mm: introduce 52-bit userspace support
Date: Thu,  6 Dec 2018 22:50:41 +0000
Message-Id: <20181206225042.11548-7-steve.capper@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206225042.11548-1-steve.capper@arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_145118_968719_38193B1B 
X-CRM114-Status: GOOD (  17.70  )
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
Cc: ard.biesheuvel@linaro.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 Steve Capper <steve.capper@arm.com>, will.deacon@arm.com, jcm@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On arm64 there is optional support for a 52-bit virtual address space.
To exploit this one has to be running with a 64KB page size and be
running on hardware that supports this.

For an arm64 kernel supporting a 48 bit VA with a 64KB page size,
some changes are needed to support a 52-bit userspace:
 * TCR_EL1.T0SZ needs to be 12 instead of 16,
 * TASK_SIZE needs to reflect the new size.

This patch implements the above when the support for 52-bit VAs is
detected at early boot time.

On arm64 userspace addresses translation is controlled by TTBR0_EL1. As
well as userspace, TTBR0_EL1 controls:
 * The identity mapping,
 * EFI runtime code.

It is possible to run a kernel with an identity mapping that has a
larger VA size than userspace (and for this case __cpu_set_tcr_t0sz()
would set TCR_EL1.T0SZ as appropriate). However, when the conditions for
52-bit userspace are met; it is possible to keep TCR_EL1.T0SZ fixed at
12. Thus in this patch, the TCR_EL1.T0SZ size changing logic is
disabled.

Signed-off-by: Steve Capper <steve.capper@arm.com>

---
Changed in V5, extra dependency for 52-bit support:
ARM64_PAN || !ARM64_SW_TTBR0_PAN

Changed in V4, pgd_index logic removed as we offset ttbr1 instead
---
 arch/arm64/Kconfig                   |  4 ++++
 arch/arm64/include/asm/assembler.h   |  7 +++----
 arch/arm64/include/asm/mmu_context.h |  3 +++
 arch/arm64/include/asm/processor.h   | 14 +++++++++-----
 arch/arm64/kernel/head.S             | 13 +++++++++++++
 arch/arm64/mm/fault.c                |  2 +-
 arch/arm64/mm/mmu.c                  |  1 +
 arch/arm64/mm/proc.S                 | 10 +++++++++-
 8 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 787d7850e064..6a93d5bc7f76 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -709,6 +709,10 @@ config ARM64_PA_BITS_52
 
 endchoice
 
+config ARM64_52BIT_VA
+	def_bool y
+	depends on ARM64_VA_BITS_48 && ARM64_64K_PAGES && (ARM64_PAN || !ARM64_SW_TTBR0_PAN)
+
 config ARM64_PA_BITS
 	int
 	default 48 if ARM64_PA_BITS_48
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index e2fe378d2a63..243ec4f0c00f 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -342,11 +342,10 @@ alternative_endif
 	.endm
 
 /*
- * tcr_set_idmap_t0sz - update TCR.T0SZ so that we can load the ID map
+ * tcr_set_t0sz - update TCR.T0SZ so that we can load the ID map
  */
-	.macro	tcr_set_idmap_t0sz, valreg, tmpreg
-	ldr_l	\tmpreg, idmap_t0sz
-	bfi	\valreg, \tmpreg, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
+	.macro	tcr_set_t0sz, valreg, t0sz
+	bfi	\valreg, \t0sz, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
 	.endm
 
 /*
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 1e58bf58c22b..b125fafc611b 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -72,6 +72,9 @@ extern u64 idmap_ptrs_per_pgd;
 
 static inline bool __cpu_uses_extended_idmap(void)
 {
+	if (IS_ENABLED(CONFIG_ARM64_52BIT_VA))
+		return false;
+
 	return unlikely(idmap_t0sz != TCR_T0SZ(VA_BITS));
 }
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index fe95fd8b065e..b363fc705be4 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -19,11 +19,12 @@
 #ifndef __ASM_PROCESSOR_H
 #define __ASM_PROCESSOR_H
 
-#define TASK_SIZE_64		(UL(1) << VA_BITS)
-
-#define KERNEL_DS	UL(-1)
-#define USER_DS		(TASK_SIZE_64 - 1)
-
+#define KERNEL_DS		UL(-1)
+#ifdef CONFIG_ARM64_52BIT_VA
+#define USER_DS			((UL(1) << 52) - 1)
+#else
+#define USER_DS			((UL(1) << VA_BITS) - 1)
+#endif /* CONFIG_ARM64_52IT_VA */
 #ifndef __ASSEMBLY__
 #ifdef __KERNEL__
 
@@ -48,6 +49,9 @@
 
 #define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS)
 
+extern u64 vabits_user;
+#define TASK_SIZE_64		(UL(1) << vabits_user)
+
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32		UL(0x100000000)
 #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 58fcc1edd852..c229d9cfe9bf 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -318,6 +318,19 @@ __create_page_tables:
 	adrp	x0, idmap_pg_dir
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
 
+#ifdef CONFIG_ARM64_52BIT_VA
+	mrs_s	x6, SYS_ID_AA64MMFR2_EL1
+	and	x6, x6, #(0xf << ID_AA64MMFR2_LVA_SHIFT)
+	mov	x5, #52
+	cbnz	x6, 1f
+#endif
+	mov	x5, #VA_BITS
+1:
+	adr_l	x6, vabits_user
+	str	x5, [x6]
+	dmb	sy
+	dc	ivac, x6		// Invalidate potentially stale cache line
+
 	/*
 	 * VA_BITS may be too small to allow for an ID mapping to be created
 	 * that covers system RAM if that is located sufficiently high in the
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 7d9571f4ae3d..5fe6d2e40e9b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -160,7 +160,7 @@ void show_pte(unsigned long addr)
 
 	pr_alert("%s pgtable: %luk pages, %u-bit VAs, pgdp = %p\n",
 		 mm == &init_mm ? "swapper" : "user", PAGE_SIZE / SZ_1K,
-		 VA_BITS, mm->pgd);
+		 mm == &init_mm ? VA_BITS : (int) vabits_user, mm->pgd);
 	pgdp = pgd_offset(mm, addr);
 	pgd = READ_ONCE(*pgdp);
 	pr_alert("[%016lx] pgd=%016llx", addr, pgd_val(pgd));
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 394b8d554def..f8fc393143ea 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -52,6 +52,7 @@
 
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
+u64 vabits_user __ro_after_init;
 
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 2db1c491d45d..0cf86b17714c 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -450,7 +450,15 @@ ENTRY(__cpu_setup)
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 			TCR_TBI0 | TCR_A1
-	tcr_set_idmap_t0sz	x10, x9
+
+#ifdef CONFIG_ARM64_52BIT_VA
+	ldr_l 		x9, vabits_user
+	sub		x9, xzr, x9
+	add		x9, x9, #64
+#else
+	ldr_l		x9, idmap_t0sz
+#endif
+	tcr_set_t0sz	x10, x9
 
 	/*
 	 * Set the IPS bits in TCR_EL1.
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
