From: steve.capper@arm.com (Steve Capper)
Date: Thu, 10 May 2018 17:23:47 +0100
Subject: [PATCH v3 8/8] arm64: mm: Add 48/52-bit kernel VA support
In-Reply-To: <20180510162347.3858-1-steve.capper@arm.com>
References: <20180510162347.3858-1-steve.capper@arm.com>
Message-ID: <20180510162347.3858-9-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the option to use 52-bit VA support upon availability at boot. We
use the same KASAN_SHADOW_OFFSET for both 48 and 52 bit VA spaces as in
both cases the start and end of the KASAN shadow region are PGD aligned.

>From ID_AA64MMFR2, we check the LVA field on very early boot and set the
VA size, PGDIR_SHIFT and TCR.T[01]SZ values which then influence how the
rest of the memory system behaves.

Note that userspace addresses will still be capped out at 48-bit. More
patches are needed to deal with scenarios where the user provides
MMAP_FIXED hint and a high address to mmap.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/Kconfig   | 10 +++++++++-
 arch/arm64/mm/proc.S | 13 +++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f68eeab08904..6fe0c2976f0d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -266,6 +266,7 @@ config PGTABLE_LEVELS
 	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
 	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
 	default 3 if ARM64_64K_PAGES && ARM64_VA_BITS_48
+	default 3 if ARM64_64K_PAGES && ARM64_VA_BITS_52
 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
 	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
 	default 4 if !ARM64_64K_PAGES && ARM64_VA_BITS_48
@@ -282,6 +283,7 @@ config MULTI_IRQ_HANDLER
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN
+	default 0xdfffa00000000000 if ARM64_VA_BITS_52
 	default 0xdfffa00000000000 if ARM64_VA_BITS_48
 	default 0xdfffd00000000000 if ARM64_VA_BITS_47
 	default 0xdffffe8000000000 if ARM64_VA_BITS_42
@@ -670,6 +672,10 @@ config ARM64_VA_BITS_47
 config ARM64_VA_BITS_48
 	bool "48-bit"
 
+config ARM64_VA_BITS_52
+	bool "52-bit (ARMv8.2) (48 if not in hardware)"
+	depends on ARM64_64K_PAGES
+
 endchoice
 
 config ARM64_VA_BITS
@@ -679,10 +685,12 @@ config ARM64_VA_BITS
 	default 42 if ARM64_VA_BITS_42
 	default 47 if ARM64_VA_BITS_47
 	default 48 if ARM64_VA_BITS_48
+	default 52 if ARM64_VA_BITS_52
 
 config ARM64_VA_BITS_MIN
 	int
-	default ARM64_VA_BITS
+	default ARM64_VA_BITS if !ARM64_VA_BITS_52
+	default 48 if ARM64_VA_BITS_52
 
 choice
 	prompt "Physical address space size"
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5f8d9e452190..031604502776 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -472,9 +472,22 @@ ENTRY(__cpu_setup)
 ENDPROC(__cpu_setup)
 
 ENTRY(__setup_va_constants)
+#ifdef CONFIG_ARM64_VA_BITS_52
+	mrs_s	x5, SYS_ID_AA64MMFR2_EL1
+	and	x5, x5, #0xf << ID_AA64MMFR2_LVA_SHIFT
+	cmp	x5, #1 << ID_AA64MMFR2_LVA_SHIFT
+	b.ne	1f
+	mov	x0, #VA_BITS
+	mov	x1, TCR_T0SZ(VA_BITS)
+	mov	x2, #1 << (VA_BITS - PGDIR_SHIFT)
+	b	2f
+#endif
+
+1:
 	mov	x0, #VA_BITS_MIN
 	mov	x1, TCR_T0SZ(VA_BITS_MIN)
 	mov	x2, #1 << (VA_BITS_MIN - PGDIR_SHIFT)
+2:
 	str_l	x0, vabits_actual, x5
 	str_l	x1, idmap_t0sz, x5
 	str_l	x2, ptrs_per_pgd, x5
-- 
2.11.0
