From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 2 Nov 2017 17:46:25 -0400 (EDT)
Subject: syntax unified,
 was Re: [PATCH 3/3] ARM: early_printk: use printascii()
 rather than printch()
In-Reply-To: <ba9a7e8b-822b-60d0-e714-2e849b39b083@arm.com>
References: <20171102000945.GT9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
 <SG2PR06MB11655BDEF09BB62D268A29DD8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102112041.GW9463@n2100.armlinux.org.uk>
 <SG2PR06MB11653D39086B1F58497C9FE08A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1711021044380.21665@knanqh.ubzr>
 <SG2PR06MB116563CB4F1B55160392AAC68A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1711021132170.21665@knanqh.ubzr>
 <nycvar.YSQ.7.76.1711021157560.21665@knanqh.ubzr>
 <SG2PR06MB116509D159F4E79D5A788DCE8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102171018.GH9463@n2100.armlinux.org.uk>
 <ba9a7e8b-822b-60d0-e714-2e849b39b083@arm.com>
Message-ID: <nycvar.YSQ.7.76.1711021514200.21665@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Nov 2017, Robin Murphy wrote:
> On 02/11/17 17:10, Russell King - ARM Linux wrote:
> > There is another solution to this: I augment the patch system with an
> > ARM assembly parser that detects this before it gets accepted,
> > rejecting patches that omit the # for constants.  However, that is
> > incomplete, because we now live in a world where ARM assembly gets
> > added to the kernel via many different git trees.
> 
> Or we could just enable unified syntax by default. AFAICT, binutils has
> supported UAL for over 12 years now, and the minimal supported version
> of 2.20 quoted in Documentation/process/ is considerably more recent
> than that.

You have a point here. So let's see in details...

Documentation/process/changes.rst sais:

|Upgrade to at **least** these software revisions before thinking you've
|encountered a bug!  If you're unsure what version you're currently
|running, the suggested command should tell you.
[...]
|GNU C                  3.2              gcc --version
|GNU make               3.81             make --version
|binutils               2.20             ld -v
[...]

On ARM we enforce these additional restrictions in 
arch/arm/kernel/asm-offsets.c:

|/*
| * GCC 3.0, 3.1: general bad code generation.
| * GCC 3.2.0: incorrect function argument offset calculation.
| * GCC 3.2.x: miscompiles NEW_AUX_ENT in fs/binfmt_elf.c
| *            (http://gcc.gnu.org/PR8896) and incorrect structure
| *            initialisation in fs/jffs2/erase.c
| * GCC 4.8.0-4.8.2: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58854
| *            miscompiles find_get_entry(), and can result in EXT3 and EXT4
| *            filesystem corruption (possibly other FS too).
| */
|#ifdef __GNUC__
|#if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
|#error Your compiler is too buggy; it is known to miscompile kernels.
|#error    Known good compilers: 3.3, 4.x
|#endif
[...]

It should be quite safe to assume that any gcc-3.3 installations came 
with@least binutils-2.20.

So let's try that out:

binutils-2.20.1]$ ./gas/as-new --version
GNU assembler (GNU Binutils) 2.20.1.20100303
[...]
binutils-2.20.1]$ echo "mov r0, '\r'" | ./gas/as-new - -o /tmp/t.o
{standard input}: Assembler messages:
{standard input}:1: Error: immediate expression requires a # prefix -- `mov r0,13'
binutils-2.20.1]$ echo ".syntax unified; mov r0, '\r'" | ./gas/as-new - -o /tmp/t.o
(nothing)
binutils-2.20.1]$ ./binutils/objdump  -d /tmp/t.o

/tmp/t.o:     file format elf32-littlearm

Disassembly of section .text:

00000000 <.text>:
   0:   e3a0000d        mov     r0, #13

Digging into the binutils git repository, it looks like the unified 
syntax was indeed supported in 2005.

Therefore every setup capable of compiling the latest linux kernel for 
ARM should be ".syntax unified" ready as Robin said.

So... I think the best thing to do at this point is to enable the 
unified syntax unconditionally as suggested. This even has the side 
effect of removing a bunch of macros that cause trouble with LTO builds.

I propose the following patch:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7888c9803e..de1dd6e9cf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1531,12 +1531,10 @@ config THUMB2_KERNEL
 	bool "Compile the kernel in Thumb-2 mode" if !CPU_THUMBONLY
 	depends on (CPU_V7 || CPU_V7M) && !CPU_V6 && !CPU_V6K
 	default y if CPU_THUMBONLY
-	select ARM_ASM_UNIFIED
 	select ARM_UNWIND
 	help
 	  By enabling this option, the kernel will be compiled in
-	  Thumb-2 mode. A compiler/assembler that understand the unified
-	  ARM-Thumb syntax is needed.
+	  Thumb-2 mode.
 
 	  If unsure, say N.
 
@@ -1571,9 +1569,6 @@ config THUMB2_AVOID_R_ARM_THM_JUMP11
 
 	  Unless you are sure your tools don't have this problem, say Y.
 
-config ARM_ASM_UNIFIED
-	bool
-
 config ARM_PATCH_IDIV
 	bool "Runtime patch udiv/sdiv instructions into __aeabi_{u}idiv()"
 	depends on CPU_32v7 && !XIP_KERNEL
diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index a91ae49961..2c3b952be6 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -20,8 +20,10 @@
 #ifndef __ASM_UNIFIED_H
 #define __ASM_UNIFIED_H
 
-#if defined(__ASSEMBLY__) && defined(CONFIG_ARM_ASM_UNIFIED)
+#if defined(__ASSEMBLY__)
 	.syntax unified
+#else
+__asm__(".syntax unified");
 #endif
 
 #ifdef CONFIG_CPU_V7M
@@ -64,77 +66,4 @@
 
 #endif	/* CONFIG_THUMB2_KERNEL */
 
-#ifndef CONFIG_ARM_ASM_UNIFIED
-
-/*
- * If the unified assembly syntax isn't used (in ARM mode), these
- * macros expand to an empty string
- */
-#ifdef __ASSEMBLY__
-	.macro	it, cond
-	.endm
-	.macro	itt, cond
-	.endm
-	.macro	ite, cond
-	.endm
-	.macro	ittt, cond
-	.endm
-	.macro	itte, cond
-	.endm
-	.macro	itet, cond
-	.endm
-	.macro	itee, cond
-	.endm
-	.macro	itttt, cond
-	.endm
-	.macro	ittte, cond
-	.endm
-	.macro	ittet, cond
-	.endm
-	.macro	ittee, cond
-	.endm
-	.macro	itett, cond
-	.endm
-	.macro	itete, cond
-	.endm
-	.macro	iteet, cond
-	.endm
-	.macro	iteee, cond
-	.endm
-#else	/* !__ASSEMBLY__ */
-__asm__(
-"	.macro	it, cond\n"
-"	.endm\n"
-"	.macro	itt, cond\n"
-"	.endm\n"
-"	.macro	ite, cond\n"
-"	.endm\n"
-"	.macro	ittt, cond\n"
-"	.endm\n"
-"	.macro	itte, cond\n"
-"	.endm\n"
-"	.macro	itet, cond\n"
-"	.endm\n"
-"	.macro	itee, cond\n"
-"	.endm\n"
-"	.macro	itttt, cond\n"
-"	.endm\n"
-"	.macro	ittte, cond\n"
-"	.endm\n"
-"	.macro	ittet, cond\n"
-"	.endm\n"
-"	.macro	ittee, cond\n"
-"	.endm\n"
-"	.macro	itett, cond\n"
-"	.endm\n"
-"	.macro	itete, cond\n"
-"	.endm\n"
-"	.macro	iteet, cond\n"
-"	.endm\n"
-"	.macro	iteee, cond\n"
-"	.endm\n");
-#endif	/* __ASSEMBLY__ */
-
-#endif	/* CONFIG_ARM_ASM_UNIFIED */
-
 #endif	/* !__ASM_UNIFIED_H */
