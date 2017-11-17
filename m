From: steve.capper@arm.com (Steve Capper)
Date: Fri, 17 Nov 2017 11:41:42 +0000
Subject: [PATCH 1/2] arm64: Re-order reserved_ttbr0 in linker script
In-Reply-To: <20171117114143.26577-1-steve.capper@arm.com>
References: <20171117114143.26577-1-steve.capper@arm.com>
Message-ID: <20171117114143.26577-2-steve.capper@arm.com>
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

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/include/asm/asm-uaccess.h | 6 +++---
 arch/arm64/include/asm/uaccess.h     | 2 +-
 arch/arm64/kernel/vmlinux.lds.S      | 5 ++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index ecd9788cd298..95ba9865826a 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -11,9 +11,9 @@
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
 	.endm
 
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index fc0f9eb66039..66170fd4b58f 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -108,7 +108,7 @@ static inline void __uaccess_ttbr0_disable(void)
 	unsigned long ttbr;
 
 	/* reserved_ttbr0 placed at the end of swapper_pg_dir */
-	ttbr = read_sysreg(ttbr1_el1) + SWAPPER_DIR_SIZE;
+	ttbr = read_sysreg(ttbr1_el1) - RESERVED_TTBR0_SIZE;
 	write_sysreg(ttbr, ttbr0_el1);
 	isb();
 }
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index fe56c268a7d9..6aa717582f6f 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -205,13 +205,12 @@ SECTIONS
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
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
-- 
2.11.0
