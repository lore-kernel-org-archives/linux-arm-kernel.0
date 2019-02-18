Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B77AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:06:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1771420C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Acq2+/Q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1771420C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xoOYHszHccB9B9NTw8r29lS8I9FaMYL8XVYMzecxVF0=; b=Acq2+/Q4bS9gnw
	32xVnQUeOa58RcHHIdUVhzAqoeUpIPinLlPZPg5J4GmZagRYrEkFIZm/9qc6TIS8FTfrkL3BHaP4V
	9i5ZHkbfO3Zku7X4+aDHiIA6Cd6ePtjKOk4rhI0tN1AwoQ2EdlC1l/7epS2tUE7Ds/G2gFh0jpysZ
	cvvGjtVymKJZVma+5OngTa+2cgH7KNty7LP6qCEj4gGd0Jis6hScjkKv07cCwKC8V87DbEpkUtRjM
	6otWgx3dQi6WfbTUe/0eEDCJRBkWPaR+loj/0aEwTtbUxbJzmSGmmNly1G8t7cg1WnREZg9sf8d/W
	xo7EvUVT69hdEprfuk+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmNM-0007zv-Ij; Mon, 18 Feb 2019 17:06:40 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmLq-0004pY-Bs
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:05:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51FF0A78;
 Mon, 18 Feb 2019 09:04:12 -0800 (PST)
Received: from capper-debian.emea.arm.com (C02R32KKFVH8.manchester.arm.com
 [10.32.102.153])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 09A833FB75;
 Mon, 18 Feb 2019 09:04:10 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/9] arm64: kasan: Switch to using KASAN_SHADOW_OFFSET
Date: Mon, 18 Feb 2019 17:02:39 +0000
Message-Id: <20190218170245.14915-4-steve.capper@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218170245.14915-1-steve.capper@arm.com>
References: <20190218170245.14915-1-steve.capper@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_090506_596158_AC40FA70 
X-CRM114-Status: GOOD (  18.22  )
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

KASAN_SHADOW_OFFSET is a constant that is supplied to gcc as a command
line argument and affects the codegen of the inline address sanetiser.

Essentially, for an example memory access:
    *ptr1 = val;
The compiler will insert logic similar to the below:
    shadowValue = *(ptr1 >> KASAN_SHADOW_SCALE_SHIFT + KASAN_SHADOW_OFFSET)
    if (somethingWrong(shadowValue))
        flagAnError();

This code sequence is inserted into many places, thus
KASAN_SHADOW_OFFSET is essentially baked into many places in the kernel
text.

If we want to run a single kernel binary with multiple address spaces,
then we need to do this with KASAN_SHADOW_OFFSET fixed.

Thankfully, due to the way the KASAN_SHADOW_OFFSET is used to provide
shadow addresses we know that the end of the shadow region is constant
w.r.t. VA space size:
    KASAN_SHADOW_END = ~0 >> KASAN_SHADOW_SCALE_SHIFT + KASAN_SHADOW_OFFSET

This means that if we increase the size of the VA space, the start of
the KASAN region expands into lower addresses whilst the end of the
KASAN region is fixed.

Currently the arm64 code computes KASAN_SHADOW_OFFSET at build time via
build scripts with the VA size used as a parameter. (There are build
time checks in the C code too to ensure that expected values are being
derived). It is sufficient, and indeed is a simplification, to remove
the build scripts (and build time checks) entirely and instead provide
KASAN_SHADOW_OFFSET values.

This patch removes the logic to compute the KASAN_SHADOW_OFFSET in the
arm64 Makefile, and instead we adopt the approach used by x86 to supply
offset values in kConfig. To help debug/develop future VA space changes,
the Makefile logic has been preserved in a script file in the arm64
Documentation folder.

Signed-off-by: Steve Capper <steve.capper@arm.com>

---

Changed in V3, rebase to include KASAN_SHADOW_SCALE_SHIFT, wording
tidied up.
---
 Documentation/arm64/kasan-offsets.sh | 27 +++++++++++++++++++++++++++
 arch/arm64/Kconfig                   | 15 +++++++++++++++
 arch/arm64/Makefile                  |  8 --------
 arch/arm64/include/asm/kasan.h       | 11 ++++-------
 arch/arm64/include/asm/memory.h      |  8 +++++---
 arch/arm64/mm/kasan_init.c           |  2 --
 6 files changed, 51 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/arm64/kasan-offsets.sh

diff --git a/Documentation/arm64/kasan-offsets.sh b/Documentation/arm64/kasan-offsets.sh
new file mode 100644
index 000000000000..2b7a021db363
--- /dev/null
+++ b/Documentation/arm64/kasan-offsets.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+# Print out the KASAN_SHADOW_OFFSETS required to place the KASAN SHADOW
+# start address at the mid-point of the kernel VA space
+
+print_kasan_offset () {
+	printf "%02d\t" $1
+	printf "0x%08x00000000\n" $(( (0xffffffff & (-1 << ($1 - 1 - 32))) \
+			+ (1 << ($1 - 32 - $2)) \
+			- (1 << (64 - 32 - $2)) ))
+}
+
+echo KASAN_SHADOW_SCALE_SHIFT = 3
+printf "VABITS\tKASAN_SHADOW_OFFSET\n"
+print_kasan_offset 48 3
+print_kasan_offset 47 3
+print_kasan_offset 42 3
+print_kasan_offset 39 3
+print_kasan_offset 36 3
+echo
+echo KASAN_SHADOW_SCALE_SHIFT = 4
+printf "VABITS\tKASAN_SHADOW_OFFSET\n"
+print_kasan_offset 48 4
+print_kasan_offset 47 4
+print_kasan_offset 42 4
+print_kasan_offset 39 4
+print_kasan_offset 36 4
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..db155ae86fed 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -291,6 +291,21 @@ config ARCH_SUPPORTS_UPROBES
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
+config KASAN_SHADOW_OFFSET
+	hex
+	depends on KASAN
+	default 0xdfffa00000000000 if (ARM64_VA_BITS_48 || ARM64_USER_VA_BITS_52) && !KASAN_SW_TAGS
+	default 0xdfffd00000000000 if ARM64_VA_BITS_47 && !KASAN_SW_TAGS
+	default 0xdffffe8000000000 if ARM64_VA_BITS_42 && !KASAN_SW_TAGS
+	default 0xdfffffd000000000 if ARM64_VA_BITS_39 && !KASAN_SW_TAGS
+	default 0xdffffffa00000000 if ARM64_VA_BITS_36 && !KASAN_SW_TAGS
+	default 0xefff900000000000 if (ARM64_VA_BITS_48 || ARM64_USER_VA_BITS_52) && KASAN_SW_TAGS
+	default 0xefffc80000000000 if ARM64_VA_BITS_47 && KASAN_SW_TAGS
+	default 0xeffffe4000000000 if ARM64_VA_BITS_42 && KASAN_SW_TAGS
+	default 0xefffffc800000000 if ARM64_VA_BITS_39 && KASAN_SW_TAGS
+	default 0xeffffff900000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
+	default 0xffffffffffffffff
+
 source "arch/arm64/Kconfig.platforms"
 
 menu "Kernel Features"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2dad2ae6b181..764201c76d77 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -111,14 +111,6 @@ KBUILD_CFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
 KBUILD_CPPFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
 KBUILD_AFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
 
-# KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
-#				 - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
-# in 32-bit arithmetic
-KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
-	(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 1 - 32))) \
-	+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) \
-	- (1 << (64 - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) )) )
-
 export	TEXT_OFFSET GZFLAGS
 
 core-y		+= arch/arm64/kernel/ arch/arm64/mm/
diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index b52aacd2c526..10d2add842da 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -18,11 +18,8 @@
  * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
  * KASAN_SHADOW_END: KASAN_SHADOW_START + 1/N of kernel virtual addresses,
  * where N = (1 << KASAN_SHADOW_SCALE_SHIFT).
- */
-#define KASAN_SHADOW_START      (VA_START)
-#define KASAN_SHADOW_END        (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
-
-/*
+ *
+ * KASAN_SHADOW_OFFSET:
  * This value is used to map an address to the corresponding shadow
  * address by the following formula:
  *     shadow_addr = (address >> KASAN_SHADOW_SCALE_SHIFT) + KASAN_SHADOW_OFFSET
@@ -33,8 +30,8 @@
  *      KASAN_SHADOW_OFFSET = KASAN_SHADOW_END -
  *				(1ULL << (64 - KASAN_SHADOW_SCALE_SHIFT))
  */
-#define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << \
-					(64 - KASAN_SHADOW_SCALE_SHIFT)))
+#define _KASAN_SHADOW_START(va)	(KASAN_SHADOW_END - (1UL << ((va) - KASAN_SHADOW_SCALE_SHIFT)))
+#define KASAN_SHADOW_START      _KASAN_SHADOW_START(VA_BITS)
 
 void kasan_init(void);
 void kasan_copy_shadow(pgd_t *pgdir);
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 46a7aba44e9b..dde0b9b75b22 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -54,7 +54,7 @@
 	(UL(1) << VA_BITS) + 1)
 #define PAGE_OFFSET_END		(VA_START)
 #define KIMAGE_VADDR		(MODULES_END)
-#define BPF_JIT_REGION_START	(VA_START + KASAN_SHADOW_SIZE)
+#define BPF_JIT_REGION_START	(KASAN_SHADOW_END)
 #define BPF_JIT_REGION_SIZE	(SZ_128M)
 #define BPF_JIT_REGION_END	(BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
 #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
@@ -80,15 +80,17 @@
  * significantly, so double the (minimum) stack size when they are in use.
  */
 #ifdef CONFIG_KASAN
-#define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
+#define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
+#define KASAN_SHADOW_END	((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT)) \
+					+ KASAN_SHADOW_OFFSET)
 #ifdef CONFIG_KASAN_EXTRA
 #define KASAN_THREAD_SHIFT	2
 #else
 #define KASAN_THREAD_SHIFT	1
 #endif /* CONFIG_KASAN_EXTRA */
 #else
-#define KASAN_SHADOW_SIZE	(0)
 #define KASAN_THREAD_SHIFT	0
+#define KASAN_SHADOW_END	(VA_START)
 #endif
 
 #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index ee5ec343d009..66ea44568aa5 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -148,8 +148,6 @@ static void __init kasan_pgd_populate(unsigned long addr, unsigned long end,
 /* The early shadow maps everything to a single page of zeroes */
 asmlinkage void __init kasan_early_init(void)
 {
-	BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
-		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_START, PGDIR_SIZE));
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
 	kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
