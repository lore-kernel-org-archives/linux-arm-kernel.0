From: mka@chromium.org (Matthias Kaehlcke)
Date: Mon,  1 May 2017 14:26:22 -0700
Subject: [PATCH] arm64: Fix multiple 'asm-operand-widths' warnings
Message-ID: <20170501212622.153720-1-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clang raises 'asm-operand-widths' warnings in inline assembly code when
the size of an operand is < 64 bits and the operand width is unspecified.
Most warnings are raised in macros, i.e. the datatype of the operand may
vary. Forcing the use of an x register through the 'x' operand modifier
would silence the warning however it involves the risk that for operands
< 64 bits 'unused' bits may be assigned to 64-bit values (more details at
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/503816.html).
Instead we cast the operand to 64 bits, which also forces the use of a
x register, but without the unexpected behavior.

In gic_write_bpr1() use write_sysreg_s() to write the register. This
aligns the functions with others in this header and fixes an
'asm-operand-widths' warning.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/include/asm/arch_gicv3.h  | 2 +-
 arch/arm64/include/asm/barrier.h     | 2 +-
 arch/arm64/include/asm/uaccess.h     | 2 +-
 arch/arm64/kernel/armv8_deprecated.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index f37e3a21f6e7..9092d612d8c2 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -166,7 +166,7 @@ static inline void gic_write_sre(u32 val)
 
 static inline void gic_write_bpr1(u32 val)
 {
-	asm volatile("msr_s " __stringify(ICC_BPR1_EL1) ", %0" : : "r" (val));
+	write_sysreg_s(val, ICC_BPR1_EL1);
 }
 
 #define gic_read_typer(c)		readq_relaxed(c)
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 4e0497f581a0..1248401b07ab 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -60,7 +60,7 @@ do {									\
 		break;							\
 	case 8:								\
 		asm volatile ("stlr %1, %0"				\
-				: "=Q" (*p) : "r" (v) : "memory");	\
+			      : "=Q" (*p) : "r" ((__u64)v) : "memory");	\
 		break;							\
 	}								\
 } while (0)
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 5308d696311b..7db143689694 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -302,7 +302,7 @@ do {									\
 	"	.previous\n"						\
 	_ASM_EXTABLE(1b, 3b)						\
 	: "+r" (err)							\
-	: "r" (x), "r" (addr), "i" (-EFAULT))
+	: "r" ((__u64)x), "r" (addr), "i" (-EFAULT))
 
 #define __put_user_err(x, ptr, err)					\
 do {									\
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 657977e77ec8..79b9fef48b14 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -306,7 +306,7 @@ do {								\
 	_ASM_EXTABLE(0b, 4b)					\
 	_ASM_EXTABLE(1b, 4b)					\
 	: "=&r" (res), "+r" (data), "=&r" (temp), "=&r" (temp2)	\
-	: "r" (addr), "i" (-EAGAIN), "i" (-EFAULT),		\
+	: "r" ((__u64)addr), "i" (-EAGAIN), "i" (-EFAULT),	\
 	  "i" (__SWP_LL_SC_LOOPS)				\
 	: "memory");						\
 	uaccess_disable();					\
-- 
2.13.0.rc0.306.g87b477812d-goog
