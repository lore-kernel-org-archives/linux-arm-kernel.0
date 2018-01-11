From: steve.capper@arm.com (Steve Capper)
Date: Thu, 11 Jan 2018 10:11:57 +0000
Subject: [PATCH V4 1/3] arm64: Re-order reserved_ttbr0 in linker script
In-Reply-To: <20180111101159.9748-1-steve.capper@arm.com>
References: <20180111101159.9748-1-steve.capper@arm.com>
Message-ID: <20180111101159.9748-2-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently one resolves the location of the reserved_ttbr0 for PAN by
taking a positive offset from swapper_pg_dir. In a future patch we wish
to extend the swapper s.t. its size is determined at link time rather
than comile time, rendering SWAPPER_DIR_SIZE unsuitable for such a low
level calculation.

In this patch we re-arrange the order of the linker script s.t. instead
one computes reserved_ttbr0 by subtracting RESERVED_TTBR0_SIZE from
swapper_pg_dir.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---

Changed in V4: added Ard's tags
---
 arch/arm64/include/asm/asm-uaccess.h | 8 ++++----
 arch/arm64/include/asm/uaccess.h     | 4 ++--
 arch/arm64/kernel/vmlinux.lds.S      | 5 ++---
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index f4f234b6155e..8719ce122a38 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -13,11 +13,11 @@
  */
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	.macro	__uaccess_ttbr0_disable, tmp1
-	mrs	\tmp1, ttbr1_el1		// swapper_pg_dir
-	add	\tmp1, \tmp1, #SWAPPER_DIR_SIZE	// reserved_ttbr0 at the end of swapper_pg_dir
-	msr	ttbr0_el1, \tmp1		// set reserved TTBR0_EL1
+	mrs	\tmp1, ttbr1_el1			// swapper_pg_dir
+	sub	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE	// reserved_ttbr0 just before swapper_pg_dir
+	msr	ttbr0_el1, \tmp1			// set reserved TTBR0_EL1
 	isb
-	sub	\tmp1, \tmp1, #SWAPPER_DIR_SIZE
+	add	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE
 	bic	\tmp1, \tmp1, #TTBR_ASID_MASK
 	msr	ttbr1_el1, \tmp1		// set reserved ASID
 	isb
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 6eadf55ebaf0..e269d35372cf 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -108,8 +108,8 @@ static inline void __uaccess_ttbr0_disable(void)
 	unsigned long ttbr;
 
 	ttbr = read_sysreg(ttbr1_el1);
-	/* reserved_ttbr0 placed at the end of swapper_pg_dir */
-	write_sysreg(ttbr + SWAPPER_DIR_SIZE, ttbr0_el1);
+	/* reserved_ttbr0 placed before swapper_pg_dir */
+	write_sysreg(ttbr - RESERVED_TTBR0_SIZE, ttbr0_el1);
 	isb();
 	/* Set reserved ASID */
 	ttbr &= ~TTBR_ASID_MASK;
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index ddfd3c0942f7..8e567de8f369 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -218,13 +218,12 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 	idmap_pg_dir = .;
 	. += IDMAP_DIR_SIZE;
-	swapper_pg_dir = .;
-	. += SWAPPER_DIR_SIZE;
-
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	reserved_ttbr0 = .;
 	. += RESERVED_TTBR0_SIZE;
 #endif
+	swapper_pg_dir = .;
+	. += SWAPPER_DIR_SIZE;
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	tramp_pg_dir = .;
-- 
2.11.0
