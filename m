Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60252C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:17:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2527E217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eAbaYbcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2527E217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7xQoS6E2iDYqqJR4uI4jytJQtv5kkTFeyzhufLgLRwI=; b=eAbaYbcFMHW0+z
	CgMV7v17GQbS8+F6UQmuAXwhhIh1VdWfSxN0EZuqRuV/XQ9+r8xzgDAKyFAwRPzskGR+ZMzKw4PYc
	gyvjJ1bqtPYJbZjC+996950PUbQsdZmiITsoRrJE3mK5GqljI57/FPH65NXvgOaLiLjnL6/2PdQ8x
	e8ATUGody/InU1Bpzwp2/FCpEao1OXXcyt+nH9U1FkTz/rZqS33CBS7+vH5bSuvBZg3pBovUDtnAe
	Ey4JZKYc0q09L+aw1ObWNMZm8vgaEXLjloqJERdQQUPnWe1u1Cy21PD8OCWTCYI8YQnwxwnD0KlL9
	X7soy6iuD4leDYotoBlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmXw-0003wA-Ey; Mon, 18 Feb 2019 17:17:36 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmXo-0003vK-1E
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:17:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F08291713;
 Mon, 18 Feb 2019 09:04:16 -0800 (PST)
Received: from capper-debian.emea.arm.com (C02R32KKFVH8.manchester.arm.com
 [10.32.102.153])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB8863F740;
 Mon, 18 Feb 2019 09:04:15 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/9] arm64: mm: Introduce VA_BITS_MIN
Date: Mon, 18 Feb 2019 17:02:42 +0000
Message-Id: <20190218170245.14915-7-steve.capper@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218170245.14915-1-steve.capper@arm.com>
References: <20190218170245.14915-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_091733_076801_4019931E 
X-CRM114-Status: GOOD (  19.32  )
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

In order to support 52-bit kernel addresses detectable at boot time, the
kernel needs to know the most conservative VA_BITS possible should it
need to fall back to this quantity due to lack of hardware support.

A new compile time constant VA_BITS_MIN is introduced in this patch and
it is employed in the KASAN end address, KASLR, and EFI stub.

For Arm, if 52-bit VA support is unavailable the fallback is to 48-bits.

In other words: VA_BITS_MIN = min (48, VA_BITS)

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/Kconfig                 | 4 ++++
 arch/arm64/include/asm/efi.h       | 4 ++--
 arch/arm64/include/asm/memory.h    | 5 ++++-
 arch/arm64/include/asm/processor.h | 2 +-
 arch/arm64/kernel/head.S           | 2 +-
 arch/arm64/kernel/kaslr.c          | 6 +++---
 arch/arm64/mm/kasan_init.c         | 3 ++-
 7 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index db155ae86fed..0f933d3a1614 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -756,6 +756,10 @@ config ARM64_VA_BITS
 	default 47 if ARM64_VA_BITS_47
 	default 48 if ARM64_VA_BITS_48 || ARM64_USER_VA_BITS_52
 
+config ARM64_VA_BITS_MIN
+	int
+	default ARM64_VA_BITS
+
 choice
 	prompt "Physical address space size"
 	default ARM64_PA_BITS_48
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 7ed320895d1f..4a84353bc9f7 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -68,7 +68,7 @@ static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
 
 /*
  * On arm64, we have to ensure that the initrd ends up in the linear region,
- * which is a 1 GB aligned region of size '1UL << (VA_BITS - 1)' that is
+ * which is a 1 GB aligned region of size '1UL << (VA_BITS_MIN - 1)' that is
  * guaranteed to cover the kernel Image.
  *
  * Since the EFI stub is part of the kernel Image, we can relax the
@@ -79,7 +79,7 @@ static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
 static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 						    unsigned long image_addr)
 {
-	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS - 1));
+	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS_MIN - 1));
 }
 
 #define efi_call_early(f, ...)		sys_table_arg->boottime->f(__VA_ARGS__)
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index dde0b9b75b22..03db258eb354 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -64,6 +64,9 @@
 #define PCI_IO_END		(VMEMMAP_START - SZ_2M)
 #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
 #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
+#define VA_BITS_MIN		(CONFIG_ARM64_VA_BITS_MIN)
+#define _VA_START(va)		(UL(0xffffffffffffffff) - \
+				(UL(1) << ((va) - 1)) + 1)
 
 #define KERNEL_START      _text
 #define KERNEL_END        _end
@@ -90,7 +93,7 @@
 #endif /* CONFIG_KASAN_EXTRA */
 #else
 #define KASAN_THREAD_SHIFT	0
-#define KASAN_SHADOW_END	(VA_START)
+#define KASAN_SHADOW_END	(_VA_START(VA_BITS_MIN))
 #endif
 
 #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f1a7ab18faf3..48e94a671234 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -53,7 +53,7 @@
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
  */
 
-#define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS)
+#define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS_MIN)
 #define TASK_SIZE_64		(UL(1) << vabits_user)
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 15d79a8e5e5e..b6c15b97ec9d 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -325,7 +325,7 @@ __create_page_tables:
 	mov	x5, #52
 	cbnz	x6, 1f
 #endif
-	mov	x5, #VA_BITS
+	mov	x5, #VA_BITS_MIN
 1:
 	adr_l	x6, vabits_user
 	str	x5, [x6]
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index b09b6f75f759..6f0075f983c7 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -119,15 +119,15 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	/*
 	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
 	 * kernel image offset from the seed. Let's place the kernel in the
-	 * middle half of the VMALLOC area (VA_BITS - 2), and stay clear of
+	 * middle half of the VMALLOC area (VA_BITS_MIN - 2), and stay clear of
 	 * the lower and upper quarters to avoid colliding with other
 	 * allocations.
 	 * Even if we could randomize at page granularity for 16k and 64k pages,
 	 * let's always round to 2 MB so we don't interfere with the ability to
 	 * map using contiguous PTEs
 	 */
-	mask = ((1UL << (VA_BITS - 2)) - 1) & ~(SZ_2M - 1);
-	offset = BIT(VA_BITS - 3) + (seed & mask);
+	mask = ((1UL << (VA_BITS_MIN - 2)) - 1) & ~(SZ_2M - 1);
+	offset = BIT(VA_BITS_MIN - 3) + (seed & mask);
 
 	/* use the top 16 bits to randomize the linear region */
 	memstart_offset_seed = seed >> 48;
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 66ea44568aa5..3996d46b5d0e 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -148,7 +148,8 @@ static void __init kasan_pgd_populate(unsigned long addr, unsigned long end,
 /* The early shadow maps everything to a single page of zeroes */
 asmlinkage void __init kasan_early_init(void)
 {
-	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_START, PGDIR_SIZE));
+	BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS), PGDIR_SIZE));
+	BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS_MIN), PGDIR_SIZE));
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
 	kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE,
 			   true);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
