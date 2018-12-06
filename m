Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E71C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:52:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF78720878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gxdNNryi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF78720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dqq9NN8ZOgmRf300qx/wwz+loHVERgTbDNmvDiF3Tn8=; b=gxdNNryiZmvN7v
	cHA5tjbHx8fU4tFqKxFJIXSVcJBDeHD8/6FlidPwKaHwxM1Go96TZaDqKdxV2A4pgGyM5tsTQfjWM
	XcBi6+0DYmhaf/nu/zU4LZL9ElyIBMFrY6ocRntMg27LrJ8erSgSzM1ENbq7H7z8+yk4PKTmKEdpi
	0rUwPSWGXQaipyDf4VhTOEkIej3Dc+xmCCuCvr60dKEKX3fM22r290R6SIyW7M6Uia/d5kq9w6vwL
	yrbt9t0Vgulo0DLNnfPiCN6C5G1Q7Spx3rYUpzo/1tWSQ8CbFM22/ZsAzUQRcxb/8y9JtBD+5KYCG
	HUQHXhissb5Fkb/7Cisw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV2VS-0002zj-Mx; Thu, 06 Dec 2018 22:52:30 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV2UI-0001he-Dz
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:51:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0621A1682;
 Thu,  6 Dec 2018 14:51:08 -0800 (PST)
Received: from capper-debian.arm.com (unknown [10.37.12.92])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7593F3F5AF;
 Thu,  6 Dec 2018 14:51:06 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V5 4/7] arm64: mm: Offset TTBR1 to allow 52-bit PTRS_PER_PGD
Date: Thu,  6 Dec 2018 22:50:39 +0000
Message-Id: <20181206225042.11548-5-steve.capper@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206225042.11548-1-steve.capper@arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_145119_050665_AF8FA53A 
X-CRM114-Status: GOOD (  15.38  )
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

Changed in V5, removed ttbr1 save/restore logic for software PAN as
hardware PAN is a mandatory ARMv8.1 feature anyway. The logic to enable
52-bit VAs has also been changed to depend on
ARM64_PAN || !ARM64_SW_TTBR0_PAN
(in a later patch)

This patch is new in V4 of the series
---
 arch/arm64/include/asm/assembler.h     | 23 +++++++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |  9 +++++++++
 arch/arm64/kernel/head.S               |  1 +
 arch/arm64/kernel/hibernate-asm.S      |  1 +
 arch/arm64/mm/proc.S                   |  4 ++++
 5 files changed, 38 insertions(+)

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
