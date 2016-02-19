From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 17:39:35 +0100
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <HK2PR06MB056181A22F655E6D4A11DEED8AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
 <64215923.Y25jP5YYZ2@wuerfel>
 <HK2PR06MB056181A22F655E6D4A11DEED8AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <4255249.Z5tzmoAfvg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 February 2016 16:28:06 Chris Brandt wrote:
> On 19 Feb 2016, Arnd Bergmann wrote:
> > 
> > > But, now I see that PHYS_OFFSET is used all over the place as a hard
> > > coded #define, hence your comment "which cannot patch the kernel image
> > > at boot time"
> > > 
> > > So, I retract my thought...it has to be configured at build-time
> > > (unless of course you turn it into a global variable everywhere...which
> > >  might be an even bigger mess)
> > > 
> > 
> > BTW, I've tried removing the patching in CONFIG_PHYS_VIRT and replaced it
> > with references to __pv_phys_pfn_offset, which surprisingly only grew
> > .text from 4901692 to 4904300 bytes, so the size overhead of doing this
> > would be close to zero.
> > 
> >       Arnd
> 
> Cool. If you come up with a patch, I'll give it a try.

It was really just a hack, deleting code that we normally need,  but
you can work on top of that. This is still not useful unless you
also find a way to guess the __pv_phys_pfn_offset value. Maybe
there is even a way to derive that from the stack pointer if we
can safely assume that it points into RAM ?

	Arnd

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 9427fd632552..3f797bc5d73f 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -175,10 +175,11 @@
 #define __PV_BITS_7_0	0x81
 
 extern unsigned long __pv_phys_pfn_offset;
-extern u64 __pv_offset;
+extern phys_addr_t __pv_offset;
 extern void fixup_pv_table(const void *, unsigned long);
 extern const void *__pv_table_begin, *__pv_table_end;
 
+#define PAGE_SHIFT 12
 #define PHYS_OFFSET	((phys_addr_t)__pv_phys_pfn_offset << PAGE_SHIFT)
 #define PHYS_PFN_OFFSET	(__pv_phys_pfn_offset)
 
@@ -186,75 +187,14 @@ extern const void *__pv_table_begin, *__pv_table_end;
 	((((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT) + \
 	 PHYS_PFN_OFFSET)
 
-#define __pv_stub(from,to,instr,type)			\
-	__asm__("@ __pv_stub\n"				\
-	"1:	" instr "	%0, %1, %2\n"		\
-	"	.pushsection .pv_table,\"a\"\n"		\
-	"	.long	1b\n"				\
-	"	.popsection\n"				\
-	: "=r" (to)					\
-	: "r" (from), "I" (type))
-
-#define __pv_stub_mov_hi(t)				\
-	__asm__ volatile("@ __pv_stub_mov\n"		\
-	"1:	mov	%R0, %1\n"			\
-	"	.pushsection .pv_table,\"a\"\n"		\
-	"	.long	1b\n"				\
-	"	.popsection\n"				\
-	: "=r" (t)					\
-	: "I" (__PV_BITS_7_0))
-
-#define __pv_add_carry_stub(x, y)			\
-	__asm__ volatile("@ __pv_add_carry_stub\n"	\
-	"1:	adds	%Q0, %1, %2\n"			\
-	"	adc	%R0, %R0, #0\n"			\
-	"	.pushsection .pv_table,\"a\"\n"		\
-	"	.long	1b\n"				\
-	"	.popsection\n"				\
-	: "+r" (y)					\
-	: "r" (x), "I" (__PV_BITS_31_24)		\
-	: "cc")
-
-static inline phys_addr_t __virt_to_phys(unsigned long x)
-{
-	phys_addr_t t;
-
-	if (sizeof(phys_addr_t) == 4) {
-		__pv_stub(x, t, "add", __PV_BITS_31_24);
-	} else {
-		__pv_stub_mov_hi(t);
-		__pv_add_carry_stub(x, t);
-	}
-	return t;
-}
-
-static inline unsigned long __phys_to_virt(phys_addr_t x)
-{
-	unsigned long t;
-
-	/*
-	 * 'unsigned long' cast discard upper word when
-	 * phys_addr_t is 64 bit, and makes sure that inline
-	 * assembler expression receives 32 bit argument
-	 * in place where 'r' 32 bit operand is expected.
-	 */
-	__pv_stub((unsigned long) x, t, "sub", __PV_BITS_31_24);
-	return t;
-}
-
-#else
-
-#define PHYS_OFFSET	PLAT_PHYS_OFFSET
-#define PHYS_PFN_OFFSET	((unsigned long)(PHYS_OFFSET >> PAGE_SHIFT))
-
 static inline phys_addr_t __virt_to_phys(unsigned long x)
 {
-	return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
+	return (phys_addr_t)x - PAGE_OFFSET + __pv_offset;
 }
 
 static inline unsigned long __phys_to_virt(phys_addr_t x)
 {
-	return x - PHYS_OFFSET + PAGE_OFFSET;
+	return x - __pv_offset + PAGE_OFFSET;
 }
 
 #define virt_to_pfn(kaddr) \
