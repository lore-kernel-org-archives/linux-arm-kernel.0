From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 08:53:16 +0100
Subject: [PATCH 06/10] ARM: io: RiscPC: eliminate private inb() et.al.
	definitions
In-Reply-To: <20110817075104.GC1006@n2100.arm.linux.org.uk>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
Message-ID: <E1Qtaw8-0007N1-Of@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we've got rid of the bit-31 set IO addresses, we can now use the
standard inb() definitions and reduce the IO space limit to 64K.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-rpc/include/mach/io.h |  190 ++---------------------------------
 1 files changed, 8 insertions(+), 182 deletions(-)

diff --git a/arch/arm/mach-rpc/include/mach/io.h b/arch/arm/mach-rpc/include/mach/io.h
index dd706ff..695f4ed 100644
--- a/arch/arm/mach-rpc/include/mach/io.h
+++ b/arch/arm/mach-rpc/include/mach/io.h
@@ -15,192 +15,18 @@
 
 #include <mach/hardware.h>
 
-#define IO_SPACE_LIMIT 0xffffffff
+#define IO_SPACE_LIMIT 0xffff
 
 /*
- * We use two different types of addressing - PC style addresses, and ARM
- * addresses.  PC style accesses the PC hardware with the normal PC IO
- * addresses, eg 0x3f8 for serial#1.  ARM addresses are 0x80000000+
- * and are translated to the start of IO.  Note that all addresses are
- * shifted left!
- */
-#define __PORT_PCIO(x)	(!((x) & 0x80000000))
-
-/*
- * Dynamic IO functions.
- */
-static inline void __outb (unsigned int value, unsigned int port)
-{
-	unsigned long temp;
-	__asm__ __volatile__(
-	"tst	%2, #0x80000000\n\t"
-	"mov	%0, %4\n\t"
-	"addeq	%0, %0, %3\n\t"
-	"strb	%1, [%0, %2, lsl #2]	@ outb"
-	: "=&r" (temp)
-	: "r" (value), "r" (port), "Ir" (PCIO_BASE - IO_BASE), "Ir" (IO_BASE)
-	: "cc");
-}
-
-static inline void __outw (unsigned int value, unsigned int port)
-{
-	unsigned long temp;
-	__asm__ __volatile__(
-	"tst	%2, #0x80000000\n\t"
-	"mov	%0, %4\n\t"
-	"addeq	%0, %0, %3\n\t"
-	"str	%1, [%0, %2, lsl #2]	@ outw"
-	: "=&r" (temp)
-	: "r" (value|value<<16), "r" (port), "Ir" (PCIO_BASE - IO_BASE), "Ir" (IO_BASE)
-	: "cc");
-}
-
-static inline void __outl (unsigned int value, unsigned int port)
-{
-	unsigned long temp;
-	__asm__ __volatile__(
-	"tst	%2, #0x80000000\n\t"
-	"mov	%0, %4\n\t"
-	"addeq	%0, %0, %3\n\t"
-	"str	%1, [%0, %2, lsl #2]	@ outl"
-	: "=&r" (temp)
-	: "r" (value), "r" (port), "Ir" (PCIO_BASE - IO_BASE), "Ir" (IO_BASE)
-	: "cc");
-}
-
-#define DECLARE_DYN_IN(sz,fnsuffix,instr)					\
-static inline unsigned sz __in##fnsuffix (unsigned int port)		\
-{										\
-	unsigned long temp, value;						\
-	__asm__ __volatile__(							\
-	"tst	%2, #0x80000000\n\t"						\
-	"mov	%0, %4\n\t"							\
-	"addeq	%0, %0, %3\n\t"							\
-	"ldr" instr "	%1, [%0, %2, lsl #2]	@ in" #fnsuffix			\
-	: "=&r" (temp), "=r" (value)						\
-	: "r" (port), "Ir" (PCIO_BASE - IO_BASE), "Ir" (IO_BASE)		\
-	: "cc");								\
-	return (unsigned sz)value;						\
-}
-
-static inline void __iomem *__deprecated __ioaddr(unsigned int port)
-{
-	void __iomem *ret;
-	if (__PORT_PCIO(port))
-		ret = PCIO_BASE;
-	else
-		ret = IO_BASE;
-	return ret + (port << 2);
-}
-
-#define DECLARE_IO(sz,fnsuffix,instr)	\
-	DECLARE_DYN_IN(sz,fnsuffix,instr)
-
-DECLARE_IO(char,b,"b")
-DECLARE_IO(short,w,"")
-DECLARE_IO(int,l,"")
-
-#undef DECLARE_IO
-#undef DECLARE_DYN_IN
-
-/*
- * Constant address IO functions
+ * We need PC style IO addressing for:
+ *  - floppy (at 0x3f2,0x3f4,0x3f5,0x3f7)
+ *  - parport (at 0x278-0x27a, 0x27b-0x27f, 0x778-0x77a)
+ *  - 8250 serial (only for compile)
  *
- * These have to be macros for the 'J' constraint to work -
- * +/-4096 immediate operand.
+ * These peripherals are found in an area of MMIO which looks very much
+ * like an ISA bus, but with registers@the low byte of each word.
  */
-#define __outbc(value,port)							\
-({										\
-	if (__PORT_PCIO((port)))						\
-		__asm__ __volatile__(						\
-		"strb	%0, [%1, %2]	@ outbc"				\
-		: : "r" (value), "r" (PCIO_BASE), "Jr" ((port) << 2));		\
-	else									\
-		__asm__ __volatile__(						\
-		"strb	%0, [%1, %2]	@ outbc"				\
-		: : "r" (value), "r" (IO_BASE), "r" ((port) << 2));		\
-})
-
-#define __inbc(port)								\
-({										\
-	unsigned char result;							\
-	if (__PORT_PCIO((port)))						\
-		__asm__ __volatile__(						\
-		"ldrb	%0, [%1, %2]	@ inbc"					\
-		: "=r" (result) : "r" (PCIO_BASE), "Jr" ((port) << 2));		\
-	else									\
-		__asm__ __volatile__(						\
-		"ldrb	%0, [%1, %2]	@ inbc"					\
-		: "=r" (result) : "r" (IO_BASE), "r" ((port) << 2));		\
-	result;									\
-})
-
-#define __outwc(value,port)							\
-({										\
-	unsigned long __v = value;						\
-	if (__PORT_PCIO((port)))						\
-		__asm__ __volatile__(						\
-		"str	%0, [%1, %2]	@ outwc"				\
-		: : "r" (__v|__v<<16), "r" (PCIO_BASE), "Jr" ((port) << 2));	\
-	else									\
-		__asm__ __volatile__(						\
-		"str	%0, [%1, %2]	@ outwc"				\
-		: : "r" (__v|__v<<16), "r" (IO_BASE), "r" ((port) << 2));		\
-})
-
-#define __inwc(port)								\
-({										\
-	unsigned short result;							\
-	if (__PORT_PCIO((port)))						\
-		__asm__ __volatile__(						\
-		"ldr	%0, [%1, %2]	@ inwc"					\
-		: "=r" (result) : "r" (PCIO_BASE), "Jr" ((port) << 2));		\
-	else									\
-		__asm__ __volatile__(						\
-		"ldr	%0, [%1, %2]	@ inwc"					\
-		: "=r" (result) : "r" (IO_BASE), "r" ((port) << 2));		\
-	result & 0xffff;							\
-})
-
-#define __outlc(value,port)							\
-({										\
-	unsigned long __v = value;						\
-	if (__PORT_PCIO((port)))						\
-		__asm__ __volatile__(						\
-		"str	%0, [%1, %2]	@ outlc"				\
-		: : "r" (__v), "r" (PCIO_BASE), "Jr" ((port) << 2));		\
-	else									\
-		__asm__ __volatile__(						\
-		"str	%0, [%1, %2]	@ outlc"				\
-		: : "r" (__v), "r" (IO_BASE), "r" ((port) << 2));		\
-})
-
-#define __inlc(port)								\
-({										\
-	unsigned long result;							\
-	if (__PORT_PCIO((port)))						\
-		__asm__ __volatile__(						\
-		"ldr	%0, [%1, %2]	@ inlc"					\
-		: "=r" (result) : "r" (PCIO_BASE), "Jr" ((port) << 2));		\
-	else									\
-		__asm__ __volatile__(						\
-		"ldr	%0, [%1, %2]	@ inlc"					\
-		: "=r" (result) : "r" (IO_BASE), "r" ((port) << 2));		\
-	result;									\
-})
-
-#define inb(p)	 	(__builtin_constant_p((p)) ? __inbc(p)    : __inb(p))
-#define inw(p)	 	(__builtin_constant_p((p)) ? __inwc(p)    : __inw(p))
-#define inl(p)	 	(__builtin_constant_p((p)) ? __inlc(p)    : __inl(p))
-#define outb(v,p)	(__builtin_constant_p((p)) ? __outbc(v,p) : __outb(v,p))
-#define outw(v,p)	(__builtin_constant_p((p)) ? __outwc(v,p) : __outw(v,p))
-#define outl(v,p)	(__builtin_constant_p((p)) ? __outlc(v,p) : __outl(v,p))
-
-#define insb(p,d,l)	__raw_readsb(__ioaddr(p),d,l)
-#define insw(p,d,l)	__raw_readsw(__ioaddr(p),d,l)
-
-#define outsb(p,d,l)	__raw_writesb(__ioaddr(p),d,l)
-#define outsw(p,d,l)	__raw_writesw(__ioaddr(p),d,l)
+#define __io(a)		(PCIO_BASE + ((a) << 2))
 
 /*
  * 1:1 mapping for ioremapped regions.
-- 
1.7.4.4
