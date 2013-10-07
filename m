From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Sun,  6 Oct 2013 23:47:37 -0700
Subject: [PATCH] ARM: tlb: __flush_tlb_mm need to use int asid var for BE
 correct operation
Message-ID: <1381128458-32140-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Could you please review patch following this cover letter. I've run
into this problem when Linaro big endian topic branch received 3.12-rc2 
update and as result got your f0915781bd5edf78b1154e61efe962dc15872d09
"ARM: tlb: don't perform inner-shareable invalidation for local TLB ops"
commit. My Big Endian Arndale image was getting very weird user-land
crashes while fork glib call was performed.

It turns out that in __flush_tlb_mm function code passes 'ASID(mm)'
directly to tlb_op macro, unlike in other functions (i.e local_flush_tlb_mm)
where asid initially assigned to local variable with 'int' type and then
such variable is passed to tlb_op macro. Direct use of 'ASID(mm)'
in tlb_op macro does not work in big endian case. Resulting generated
code look like this (from flush_tlb_mm that uses __flush_tlb_mm):

(gdb) disassemble flush_tlb_mm
Dump of assembler code for function flush_tlb_mm:
<snip>
   0x80011984 <+32>:	dsb	ishst
   0x80011988 <+36>:	movs	r4, #0     <---------------------
   0x8001198a <+38>:	ldrb.w	r5, [r2, #375]	; 0x177
   0x8001198e <+42>:	ldr	r3, [r3, #8]
   0x80011990 <+44>:	tst.w	r3, #65536	; 0x10000
   0x80011994 <+48>:	it	ne
   0x80011996 <+50>:	mcrne	15, 0, r5, cr8, cr7, {2}
   0x8001199a <+54>:	tst.w	r1, #4194304	; 0x400000
   0x8001199e <+58>:	it	ne
   0x800119a0 <+60>:	mcrne	15, 0, r4, cr8, cr3, {2} <-------
   0x800119a4 <+64>:	dsb	ish

'15, 0, r4, cr8, cr3, {2}' receives 0 through r4 register.
Note that in LE case correct code is generated. 
If I change code to use intermediate int variable asid as
other places do, correct code is generated for __flush_tlb_mm.

My explanation is that ASID macro actually produces
64 bit integer. When passed to inline assembler as 'r'
operand is not really defined behaviour and it is 
wrong in BE case. When intermidiate 'int' variable is used 
ASID macro value is properly converted to 32 bit integer.
And inline assembler received int type, which works
correctly.

Note other possible ways to fix it is to add 'int' cast
either outside of ASID macro call or inside of it.
Personally I prefer variant that follows this cover
letter, because it is similar to other cases where 
such code pattern is used.

I've tried to understand whether proposed fix is really 
workaround for compiler bug. I failed to find clear 
explanation how gcc need to handle such situation.
Here is quote from gcc manual:

> The compiler cannot
> check whether the operands have data types that are reasonable for the
> instruction being executed.  It does not parse the assembler instruction
> template and does not know what it means or even whether it is valid
> assembler input.  The extended `asm' feature is most often used for
> machine instructions the compiler itself does not know exist.  If the
> output expression cannot be directly addressed (for example, it is a
> bit-field), your constraint must allow a register.  In that case, GCC
> will use the register as the output of the `asm', and then store that
> register into the output.

It is not clear whether 'unsigned long long' is 
"reasonable" type for arm "r" inline asm operand. So
it seems it is gray area. Personally I suspect this
issue came up before because in many places of tlbflush.h
'zero' local variable is used and 'asid' local
variable is used.

Here is small test case that illustrate code
generation issue and difference between LE and BE cases:

[kamensky at kamensky-w530 asid_inline]$ cat asid_inline.c
typedef unsigned long long u64;

struct mm_struct {
    unsigned long dummy1;
    u64 __attribute__((aligned(8))) counter;
};

void test1(struct mm_struct *mm)
{
    const int asid = ((mm)->counter & ~((~0ULL) << 8));
    do {
        asm("mcr " "p15, 0, %0, " "c8, c3, 2" : : "r" (asid) : "cc");
    } while (0);
}

void test2(struct mm_struct *mm)
{
    do {
        asm("mcr " "p15, 0, %0, " "c8, c3, 2" : : "r" (((mm)->counter & ~((~0ULL) << 8))) : "cc");
       
    } while (0);
}

void test3(struct mm_struct *mm)
{
    do {
        asm("mcr " "p15, 0, %0, " "c8, c3, 2" : : "r" ((int)((mm)->counter & ~((~0ULL) << 8))) : "cc");
       
    } while (0);
}

[kamensky@kamensky-w530 asid_inline]$ ./asid_inline.sh
+ arm-linux-gnueabihf-gcc -nostdinc -mbig-endian -O2 -mabi=aapcs-linux -mno-thumb-interwork -mthumb -march=armv7-a -msoft-float -c -o asid_inline.be.o asid_inline.c
+ arm-linux-gnueabihf-objdump --disassemble --reloc asid_inline.be.o

asid_inline.be.o:     file format elf32-bigarm


Disassembly of section .text:

00000000 <test1>:
   0:	7bc3      	ldrb	r3, [r0, #15]
   2:	ee08 3f53 	mcr	15, 0, r3, cr8, cr3, {2}
   6:	4770      	bx	lr

00000008 <test2>:
   8:	7bc3      	ldrb	r3, [r0, #15]
   a:	2200      	movs	r2, #0
   c:	ee08 2f53 	mcr	15, 0, r2, cr8, cr3, {2}
  10:	4770      	bx	lr
  12:	bf00      	nop

00000014 <test3>:
  14:	7bc3      	ldrb	r3, [r0, #15]
  16:	ee08 3f53 	mcr	15, 0, r3, cr8, cr3, {2}
  1a:	4770      	bx	lr
+ arm-linux-gnueabihf-gcc -nostdinc -mlittle-endian -O2 -mabi=aapcs-linux -mno-thumb-interwork -mthumb -march=armv7-a -msoft-float -c -o asid_inline.le.o asid_inline.c
+ arm-linux-gnueabihf-objdump --disassemble --reloc asid_inline.le.o

asid_inline.le.o:     file format elf32-littlearm


Disassembly of section .text:

00000000 <test1>:
   0:	7a03      	ldrb	r3, [r0, #8]
   2:	ee08 3f53 	mcr	15, 0, r3, cr8, cr3, {2}
   6:	4770      	bx	lr

00000008 <test2>:
   8:	7a02      	ldrb	r2, [r0, #8]
   a:	2300      	movs	r3, #0
   c:	ee08 2f53 	mcr	15, 0, r2, cr8, cr3, {2}
  10:	4770      	bx	lr
  12:	bf00      	nop

00000014 <test3>:
  14:	7a03      	ldrb	r3, [r0, #8]
  16:	ee08 3f53 	mcr	15, 0, r3, cr8, cr3, {2}
  1a:	4770      	bx	lr
[kamensky at kamensky-w530 asid_inline]$ 

Thanks,
Victor

Victor Kamensky (1):
  ARM: tlb: __flush_tlb_mm need to use int asid var for BE correct
    operation

 arch/arm/include/asm/tlbflush.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.1.4
