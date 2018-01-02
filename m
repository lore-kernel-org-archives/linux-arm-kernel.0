From: steve.capper@arm.com (Steve Capper)
Date: Tue,  2 Jan 2018 15:12:53 +0000
Subject: [PATCH V3 2/3] arm64: entry: Move the trampoline to be before PAN
In-Reply-To: <20180102151254.4063-1-steve.capper@arm.com>
References: <20180102151254.4063-1-steve.capper@arm.com>
Message-ID: <20180102151254.4063-3-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The trampline page tables are positioned after the early page tables in
the kernel linker script.

As we are about to change the early page table logic to resolve the
swapper size at link time as opposed to compile time, the
SWAPPER_DIR_SIZE variable (currently used to locate the trampline)
will be rendered unsuitable for low level assembler.

This patch solves this issue by moving the trampoline before the PAN
page tables. The offset to the trampoline from ttbr1 can then be
expressed by: PAGE_SIZE + RESERVED_TTBR0_SIZE, which is available to the
entry assembler.

Signed-off-by: Steve Capper <steve.capper@arm.com>

---

Patch added in V3 of the series to allow it to work with kpti.
---
 arch/arm64/kernel/entry.S       |  4 ++--
 arch/arm64/kernel/vmlinux.lds.S | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 031392ee5f47..7902d8145b9a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -987,7 +987,7 @@ __ni_sys_trace:
 
 	.macro tramp_map_kernel, tmp
 	mrs	\tmp, ttbr1_el1
-	sub	\tmp, \tmp, #(SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
+	add	\tmp, \tmp, #(PAGE_SIZE + RESERVED_TTBR0_SIZE)
 	bic	\tmp, \tmp, #USER_ASID_FLAG
 	msr	ttbr1_el1, \tmp
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
@@ -1006,7 +1006,7 @@ alternative_else_nop_endif
 
 	.macro tramp_unmap_kernel, tmp
 	mrs	\tmp, ttbr1_el1
-	add	\tmp, \tmp, #(SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
+	sub	\tmp, \tmp, #(PAGE_SIZE + RESERVED_TTBR0_SIZE)
 	orr	\tmp, \tmp, #USER_ASID_FLAG
 	msr	ttbr1_el1, \tmp
 	/*
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 8e567de8f369..4c7112a47469 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -218,6 +218,12 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 	idmap_pg_dir = .;
 	. += IDMAP_DIR_SIZE;
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	tramp_pg_dir = .;
+	. += PAGE_SIZE;
+#endif
+
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	reserved_ttbr0 = .;
 	. += RESERVED_TTBR0_SIZE;
@@ -225,11 +231,6 @@ SECTIONS
 	swapper_pg_dir = .;
 	. += SWAPPER_DIR_SIZE;
 
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_pg_dir = .;
-	. += PAGE_SIZE;
-#endif
-
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
 
-- 
2.11.0
