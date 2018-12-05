Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308B1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:43:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB26B20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WqOnXpYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB26B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NzAWwzXQJsbjBc7SXwhdYGDVJVfykzYtwDqmVY7MxWs=; b=WqOnXpYIC80HQd
	fbTorS2whOW4ZjacDSvg70wnn8Lj4N3ybk41FaWcYsO7PkVj3jJr2DaGS1UmxZH9VXeW7i3KE/943
	sH0V9YZwjxhTZIm0iehTgK7sxzabzE3DHIzNSl/lXMqG2DWBENTfSzuGMoR9BUfRO49K1uPKYrznl
	i1Fb9UyVtS5waXcFLp+9ycAxmUVvq8PfypFSqNmvG5aUkHvHX4wgBZhvqtW9nY+zpIMul52VEM/5U
	8FR1eqQ/miZpo+37atlv/Qp4k5JcoMlL5APGkinc3d/UwkmUfQQOEcGXpPO3saioe9e/P3dCvPhjE
	MXYReLQNkDh4VJ+g0QjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUaGT-0001KB-Mk; Wed, 05 Dec 2018 16:43:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUaFU-0000Kr-QH
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:42:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DECAC168F;
 Wed,  5 Dec 2018 08:42:06 -0800 (PST)
Received: from capper-debian.emea.arm.com (C02R32KKFVH8.manchester.arm.com
 [10.32.102.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 95B283F5AF;
 Wed,  5 Dec 2018 08:42:05 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V4 4/6] arm64: mm: Offset TTBR1 to allow 52-bit PTRS_PER_PGD
Date: Wed,  5 Dec 2018 16:41:43 +0000
Message-Id: <20181205164145.24568-5-steve.capper@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205164145.24568-1-steve.capper@arm.com>
References: <20181205164145.24568-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_084208_859733_422C50BA 
X-CRM114-Status: GOOD (  15.73  )
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
Cc: catalin.marinas@arm.com, Steve Capper <steve.capper@arm.com>,
 will.deacon@arm.com, jcm@redhat.com, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enabling 52-bit VAs on arm64 requires that the PGD table expands from 64
entries (for the 48-bit case) to 1024 entries. This quantity,
PTRS_PER_PGD is used as follows to compute which PGD entry corresponds
to a given virtual address, addr:

pgd_index(addr) -> (addr >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)

Userspace addresses are prefixed by 0's, so for a 48-bit userspace
address, uva, the following is true:
(uva >> PGDIR_SHIFT) & (1024 - 1) == (uva >> PGDIR_SHIFT) & (64 - 1)

In other words, a 48-bit userspace address will have the same pgd_index
when using PTRS_PER_PGD = 64 and 1024.

Kernel addresses are prefixed by 1's so, given a 48-bit kernel address,
kva, we have the following inequality:
(kva >> PGDIR_SHIFT) & (1024 - 1) != (kva >> PGDIR_SHIFT) & (64 - 1)

In other words a 48-bit kernel virtual address will have a different
pgd_index when using PTRS_PER_PGD = 64 and 1024.

If, however, we note that:
kva = 0xFFFF << 48 + lower (where lower[63:48] == 0b)
and, PGDIR_SHIFT = 42 (as we are dealing with 64KB PAGE_SIZE)

We can consider:
(kva >> PGDIR_SHIFT) & (1024 - 1) - (kva >> PGDIR_SHIFT) & (64 - 1)
 = (0xFFFF << 6) & 0x3FF - (0xFFFF << 6) & 0x3F	// "lower" cancels out
 = 0x3C0

In other words, one can switch PTRS_PER_PGD to the 52-bit value globally
provided that they increment ttbr1_el1 by 0x3C0 * 8 = 0x1E00 bytes when
running with 48-bit kernel VAs (TCR_EL1.T1SZ = 16).

For kernel configuration where 52-bit userspace VAs are possible, this
patch offsets ttbr1_el1 and sets PTRS_PER_PGD corresponding to the
52-bit value.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>

---

This patch is new in V4 of the series
---
 arch/arm64/include/asm/asm-uaccess.h   |  4 ++++
 arch/arm64/include/asm/assembler.h     | 23 +++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  9 +++++++++
 arch/arm64/include/asm/uaccess.h       |  4 ++++
 arch/arm64/kernel/head.S               |  1 +
 arch/arm64/kernel/hibernate-asm.S      |  1 +
 arch/arm64/mm/proc.S                   |  4 ++++
 7 files changed, 46 insertions(+)

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index 4128bec033f6..cd361dd16b12 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -14,11 +14,13 @@
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	.macro	__uaccess_ttbr0_disable, tmp1
 	mrs	\tmp1, ttbr1_el1			// swapper_pg_dir
+	restore_ttbr1 \tmp1
 	bic	\tmp1, \tmp1, #TTBR_ASID_MASK
 	sub	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE	// reserved_ttbr0 just before swapper_pg_dir
 	msr	ttbr0_el1, \tmp1			// set reserved TTBR0_EL1
 	isb
 	add	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE
+	offset_ttbr1 \tmp1
 	msr	ttbr1_el1, \tmp1		// set reserved ASID
 	isb
 	.endm
@@ -27,8 +29,10 @@
 	get_thread_info \tmp1
 	ldr	\tmp1, [\tmp1, #TSK_TI_TTBR0]	// load saved TTBR0_EL1
 	mrs	\tmp2, ttbr1_el1
+	restore_ttbr1 \tmp2
 	extr    \tmp2, \tmp2, \tmp1, #48
 	ror     \tmp2, \tmp2, #16
+	offset_ttbr1 \tmp2
 	msr	ttbr1_el1, \tmp2		// set the active ASID
 	isb
 	msr	ttbr0_el1, \tmp1		// set the non-PAN TTBR0_EL1
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 6142402c2eb4..e2fe378d2a63 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -515,6 +515,29 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	mrs	\rd, sp_el0
 	.endm
 
+/*
+ * Offset ttbr1 to allow for 48-bit kernel VAs set with 52-bit PTRS_PER_PGD.
+ * orr is used as it can cover the immediate value (and is idempotent).
+ * In future this may be nop'ed out when dealing with 52-bit kernel VAs.
+ * 	ttbr: Value of ttbr to set, modified.
+ */
+	.macro	offset_ttbr1, ttbr
+#ifdef CONFIG_ARM64_52BIT_VA
+	orr	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
+#endif
+	.endm
+
+/*
+ * Perform the reverse of offset_ttbr1.
+ * bic is used as it can cover the immediate value and, in future, won't need
+ * to be nop'ed out when dealing with 52-bit kernel VAs.
+ */
+	.macro	restore_ttbr1, ttbr
+#ifdef CONFIG_ARM64_52BIT_VA
+	bic	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
+#endif
+	.endm
+
 /*
  * Arrange a physical address in a TTBR register, taking care of 52-bit
  * addresses.
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 1d7d8da2ef9b..4a29c7e03ae4 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -80,7 +80,11 @@
 #define PGDIR_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - CONFIG_PGTABLE_LEVELS)
 #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
+#ifdef CONFIG_ARM64_52BIT_VA
+#define PTRS_PER_PGD		(1 << (52 - PGDIR_SHIFT))
+#else
 #define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
+#endif
 
 /*
  * Section address mask and size definitions.
@@ -306,4 +310,9 @@
 #define TTBR_BADDR_MASK_52	(((UL(1) << 46) - 1) << 2)
 #endif
 
+#ifdef CONFIG_ARM64_52BIT_VA
+#define TTBR1_BADDR_4852_OFFSET	(((UL(1) << (52 - PGDIR_SHIFT)) - \
+				 (UL(1) << (48 - PGDIR_SHIFT))) * 8)
+#endif
+
 #endif
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 07c34087bd5e..df60b3978568 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -124,7 +124,11 @@ static inline void __uaccess_ttbr0_disable(void)
 	ttbr = read_sysreg(ttbr1_el1);
 	ttbr &= ~TTBR_ASID_MASK;
 	/* reserved_ttbr0 placed before swapper_pg_dir */
+#ifdef CONFIG_ARM64_52BIT_VA
+	write_sysreg((ttbr & ~TTBR1_BADDR_4852_OFFSET) - RESERVED_TTBR0_SIZE, ttbr0_el1);
+#else
 	write_sysreg(ttbr - RESERVED_TTBR0_SIZE, ttbr0_el1);
+#endif
 	isb();
 	/* Set reserved ASID */
 	write_sysreg(ttbr, ttbr1_el1);
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4471f570a295..f60081be9a1b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -769,6 +769,7 @@ ENTRY(__enable_mmu)
 	phys_to_ttbr x1, x1
 	phys_to_ttbr x2, x2
 	msr	ttbr0_el1, x2			// load TTBR0
+	offset_ttbr1 x1
 	msr	ttbr1_el1, x1			// load TTBR1
 	isb
 	msr	sctlr_el1, x0
diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
index dd14ab8c9f72..fe36d85c60bd 100644
--- a/arch/arm64/kernel/hibernate-asm.S
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -40,6 +40,7 @@
 	tlbi	vmalle1
 	dsb	nsh
 	phys_to_ttbr \tmp, \page_table
+	offset_ttbr1 \tmp
 	msr	ttbr1_el1, \tmp
 	isb
 .endm
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 2c75b0b903ae..2db1c491d45d 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -182,6 +182,7 @@ ENDPROC(cpu_do_switch_mm)
 .macro	__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
 	adrp	\tmp1, empty_zero_page
 	phys_to_ttbr \tmp2, \tmp1
+	offset_ttbr1 \tmp2
 	msr	ttbr1_el1, \tmp2
 	isb
 	tlbi	vmalle1
@@ -200,6 +201,7 @@ ENTRY(idmap_cpu_replace_ttbr1)
 
 	__idmap_cpu_set_reserved_ttbr1 x1, x3
 
+	offset_ttbr1 x0
 	msr	ttbr1_el1, x0
 	isb
 
@@ -254,6 +256,7 @@ ENTRY(idmap_kpti_install_ng_mappings)
 	pte		.req	x16
 
 	mrs	swapper_ttb, ttbr1_el1
+	restore_ttbr1	swapper_ttb
 	adr	flag_ptr, __idmap_kpti_flag
 
 	cbnz	cpu, __idmap_kpti_secondary
@@ -373,6 +376,7 @@ __idmap_kpti_secondary:
 	cbnz	w18, 1b
 
 	/* All done, act like nothing happened */
+	offset_ttbr1 swapper_ttb
 	msr	ttbr1_el1, swapper_ttb
 	isb
 	ret
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
