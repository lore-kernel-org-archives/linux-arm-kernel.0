Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7028EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:06:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26576217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IgLIOb7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26576217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LGFI9axv3DdDCVA0nuitRw2tsZI+Q85Jy4TU0VVso3E=; b=IgLIOb7TWWDFjC
	lp8iAQvn5gwuX4OexoWrFbL1N9+D8a+IYbe7cz5wPKHluwhM1myu994Xx2Z5mdj0LtFsr7djYXWII
	eqMdnRX1qMZzF8N85bSoufIX3Ge00xuMgsbNeTeACPj0tGvQwqTWqU39CsKx+lOduUsf0RhAoiijb
	IODIAgbsHFLiW5Zuexdc5FR1TRP1wACu41EqNlOSCKLJJ7gkN3SHg5wgtzn5KxN5ugI7E9gwYlHOd
	mg7l/bdQ1s9XIe6uDgNu+pPy34PnPDLmY51dISri9qU+N1UfhiYiG5s9tesJT9WcNa3HwnTlFmpJI
	cdurEdz7+1NGuXJ1wwaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmN3-0007cw-VA; Mon, 18 Feb 2019 17:06:21 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmLL-0004ax-5G
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:04:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B96B1993;
 Mon, 18 Feb 2019 09:04:19 -0800 (PST)
Received: from capper-debian.emea.arm.com (C02R32KKFVH8.manchester.arm.com
 [10.32.102.153])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F1B63F740;
 Mon, 18 Feb 2019 09:04:17 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/9] arm64: mm: Introduce VA_BITS_ACTUAL
Date: Mon, 18 Feb 2019 17:02:43 +0000
Message-Id: <20190218170245.14915-8-steve.capper@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218170245.14915-1-steve.capper@arm.com>
References: <20190218170245.14915-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_090435_219217_129B7A89 
X-CRM114-Status: GOOD (  17.62  )
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

In order to support 52-bit kernel addresses detectable at boot time, one
needs to know the actual VA_BITS detected. A new variable VA_BITS_ACTUAL
is introduced in this commit and employed for the KVM hypervisor layout,
KASAN, fault handling and phys-to/from-virt translation where there
would normally be compile time constants.

In order to maintain performance in phys_to_virt, another variable
physvirt_offset is introduced.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/include/asm/kasan.h       |  2 +-
 arch/arm64/include/asm/memory.h      | 17 ++++++++++-------
 arch/arm64/include/asm/mmu_context.h |  2 +-
 arch/arm64/kernel/head.S             |  5 +++++
 arch/arm64/kvm/va_layout.c           | 14 +++++++-------
 arch/arm64/mm/fault.c                |  4 ++--
 arch/arm64/mm/init.c                 |  7 ++++++-
 arch/arm64/mm/mmu.c                  |  3 +++
 8 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index 10d2add842da..ff991dc86ae1 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -31,7 +31,7 @@
  *				(1ULL << (64 - KASAN_SHADOW_SCALE_SHIFT))
  */
 #define _KASAN_SHADOW_START(va)	(KASAN_SHADOW_END - (1UL << ((va) - KASAN_SHADOW_SCALE_SHIFT)))
-#define KASAN_SHADOW_START      _KASAN_SHADOW_START(VA_BITS)
+#define KASAN_SHADOW_START      _KASAN_SHADOW_START(VA_BITS_ACTUAL)
 
 void kasan_init(void);
 void kasan_copy_shadow(pgd_t *pgdir);
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 03db258eb354..a51056a157dd 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -48,10 +48,6 @@
  * VA_START - the first kernel virtual address.
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
-#define VA_START		(UL(0xffffffffffffffff) - \
-	(UL(1) << (VA_BITS - 1)) + 1)
-#define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
-	(UL(1) << VA_BITS) + 1)
 #define PAGE_OFFSET_END		(VA_START)
 #define KIMAGE_VADDR		(MODULES_END)
 #define BPF_JIT_REGION_START	(KASAN_SHADOW_END)
@@ -178,10 +174,17 @@
 #endif
 
 #ifndef __ASSEMBLY__
+extern u64			vabits_actual;
+#define VA_BITS_ACTUAL		({vabits_actual;})
+#define VA_START		(_VA_START(VA_BITS_ACTUAL))
+#define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
+					(UL(1) << VA_BITS_ACTUAL) + 1)
+#define PAGE_OFFSET_END		(VA_START)
 
 #include <linux/bitops.h>
 #include <linux/mmdebug.h>
 
+extern s64			physvirt_offset;
 extern s64			memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
 #define PHYS_OFFSET		({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
@@ -248,9 +251,9 @@ extern u64			vabits_user;
  * space. Testing the top bit for the start of the region is a
  * sufficient check.
  */
-#define __is_lm_address(addr)	(!((addr) & BIT(VA_BITS - 1)))
+#define __is_lm_address(addr)	(!((addr) & BIT(VA_BITS_ACTUAL - 1)))
 
-#define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
+#define __lm_to_phys(addr)	(((addr) + physvirt_offset))
 #define __kimg_to_phys(addr)	((addr) - kimage_voffset)
 
 #define __virt_to_phys_nodebug(x) ({					\
@@ -269,7 +272,7 @@ extern phys_addr_t __phys_addr_symbol(unsigned long x);
 #define __phys_addr_symbol(x)	__pa_symbol_nodebug(x)
 #endif
 
-#define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
+#define __phys_to_virt(x)	((unsigned long)((x) - physvirt_offset))
 #define __phys_to_kimg(x)	((unsigned long)((x) + kimage_voffset))
 
 /*
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 2da3e478fd8f..133ecb65b602 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -106,7 +106,7 @@ static inline void __cpu_set_tcr_t0sz(unsigned long t0sz)
 	isb();
 }
 
-#define cpu_set_default_tcr_t0sz()	__cpu_set_tcr_t0sz(TCR_T0SZ(VA_BITS))
+#define cpu_set_default_tcr_t0sz()	__cpu_set_tcr_t0sz(TCR_T0SZ(VA_BITS_ACTUAL))
 #define cpu_set_idmap_tcr_t0sz()	__cpu_set_tcr_t0sz(idmap_t0sz)
 
 /*
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b6c15b97ec9d..68c391b26858 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -332,6 +332,11 @@ __create_page_tables:
 	dmb	sy
 	dc	ivac, x6		// Invalidate potentially stale cache line
 
+	adr_l	x6, vabits_actual
+	str	x5, [x6]
+	dmb	sy
+	dc	ivac, x6		// Invalidate potentially stale cache line
+
 	/*
 	 * VA_BITS may be too small to allow for an ID mapping to be created
 	 * that covers system RAM if that is located sufficiently high in the
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index c712a7376bc1..c9a1debb45bd 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -40,25 +40,25 @@ static void compute_layout(void)
 	int kva_msb;
 
 	/* Where is my RAM region? */
-	hyp_va_msb  = idmap_addr & BIT(VA_BITS - 1);
-	hyp_va_msb ^= BIT(VA_BITS - 1);
+	hyp_va_msb  = idmap_addr & BIT(VA_BITS_ACTUAL - 1);
+	hyp_va_msb ^= BIT(VA_BITS_ACTUAL - 1);
 
 	kva_msb = fls64((u64)phys_to_virt(memblock_start_of_DRAM()) ^
 			(u64)(high_memory - 1));
 
-	if (kva_msb == (VA_BITS - 1)) {
+	if (kva_msb == (VA_BITS_ACTUAL - 1)) {
 		/*
 		 * No space in the address, let's compute the mask so
-		 * that it covers (VA_BITS - 1) bits, and the region
+		 * that it covers (VA_BITS_ACTUAL - 1) bits, and the region
 		 * bit. The tag stays set to zero.
 		 */
-		va_mask  = BIT(VA_BITS - 1) - 1;
+		va_mask  = BIT(VA_BITS_ACTUAL - 1) - 1;
 		va_mask |= hyp_va_msb;
 	} else {
 		/*
 		 * We do have some free bits to insert a random tag.
 		 * Hyp VAs are now created from kernel linear map VAs
-		 * using the following formula (with V == VA_BITS):
+		 * using the following formula (with V == VA_BITS_ACTUAL):
 		 *
 		 *  63 ... V |     V-1    | V-2 .. tag_lsb | tag_lsb - 1 .. 0
 		 *  ---------------------------------------------------------
@@ -66,7 +66,7 @@ static void compute_layout(void)
 		 */
 		tag_lsb = kva_msb;
 		va_mask = GENMASK_ULL(tag_lsb - 1, 0);
-		tag_val = get_random_long() & GENMASK_ULL(VA_BITS - 2, tag_lsb);
+		tag_val = get_random_long() & GENMASK_ULL(VA_BITS_ACTUAL - 2, tag_lsb);
 		tag_val |= hyp_va_msb;
 		tag_val >>= tag_lsb;
 	}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index efb7b2cbead5..15eca262f6e6 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -171,9 +171,9 @@ void show_pte(unsigned long addr)
 		return;
 	}
 
-	pr_alert("%s pgtable: %luk pages, %u-bit VAs, pgdp = %p\n",
+	pr_alert("%s pgtable: %luk pages, %llu-bit VAs, pgdp = %p\n",
 		 mm == &init_mm ? "swapper" : "user", PAGE_SIZE / SZ_1K,
-		 mm == &init_mm ? VA_BITS : (int) vabits_user, mm->pgd);
+		 mm == &init_mm ? VA_BITS_ACTUAL : (int) vabits_user, mm->pgd);
 	pgdp = pgd_offset(mm, addr);
 	pgd = READ_ONCE(*pgdp);
 	pr_alert("[%016lx] pgd=%016llx", addr, pgd_val(pgd));
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 0574e17fd28d..25bdb71c6c5a 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -61,6 +61,9 @@
 s64 memstart_addr __ro_after_init = -1;
 EXPORT_SYMBOL(memstart_addr);
 
+s64 physvirt_offset __ro_after_init;
+EXPORT_SYMBOL(physvirt_offset);
+
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
 #ifdef CONFIG_KEXEC_CORE
@@ -354,7 +357,7 @@ static void __init fdt_enforce_memory_region(void)
 
 void __init arm64_memblock_init(void)
 {
-	const s64 linear_region_size = BIT(VA_BITS - 1);
+	const s64 linear_region_size = BIT(VA_BITS_ACTUAL - 1);
 
 	/* Handle linux,usable-memory-range property */
 	fdt_enforce_memory_region();
@@ -368,6 +371,8 @@ void __init arm64_memblock_init(void)
 	memstart_addr = round_down(memblock_start_of_DRAM(),
 				   ARM64_MEMSTART_ALIGN);
 
+	physvirt_offset = PHYS_OFFSET - PAGE_OFFSET;
+
 	/*
 	 * Remove the memory that we will not be able to cover with the
 	 * linear mapping. Take care not to clip the kernel which may be
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c24bc447ed9c..50fe776ccb37 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -55,6 +55,9 @@ u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 u64 vabits_user __ro_after_init;
 EXPORT_SYMBOL(vabits_user);
 
+u64 __section(".mmuoff.data.write") vabits_actual;
+EXPORT_SYMBOL(vabits_actual);
+
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
