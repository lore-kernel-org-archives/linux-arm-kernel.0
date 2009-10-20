From: 914059751@qq.com (rocky)
Date: Tue, 20 Oct 2009 18:18:59 +0800
Subject: =?gb2312?B?tPC4tDogQVJNMTE3NiBnb2VzIHdpbGQgd2hlbiBNTVUgb24gbGluZQ==?=
In-Reply-To: <761ea48b0910200259i7b98aa41i25af3beb58b56cda@mail.gmail.com>
References: <tencent_238CF8B63259E7C90B7B75AF@qq.com>
	<761ea48b0910200259i7b98aa41i25af3beb58b56cda@mail.gmail.com>
Message-ID: <0EDD94343D3747C4B7953C144F2E8800@dufan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM1176 is definitely an ARMv7 VMSA! Its CPUID is:0x410FB764, check the
following code to see how does kernel code decide which architecture
operation procedure to use.

BTW: S3C6410 is also based on ARM1176 core, it uses ARMv7 cache calls as
well.

--------------- Arch/arm/boot/compressed/head.S -------------------
/*
 * Here follow the relocatable cache support functions for the
 * various processors.  This is a generic hook for locating an
 * entry and jumping to an instruction at the specified offset
 * from the start of the block.  Please note this is all position
 * independent code.
 *
 *  r1  = corrupted
 *  r2  = corrupted
 *  r3  = block offset
 *  r6  = corrupted
 *  r12 = corrupted
 */

call_cache_fn:	adr	r12, proc_types
#ifdef CONFIG_CPU_CP15
		mrc	p15, 0, r6, c0, c0	@ get processor ID
#else
		ldr	r6, =CONFIG_PROCESSOR_ID
#endif
1:		ldr	r1, [r12, #0]		@ get value
		ldr	r2, [r12, #4]		@ get mask
		eor	r1, r1, r6		@ (real ^ match)
		tst	r1, r2			@       & mask
		addeq	pc, r12, r3		@ call cache function
		add	r12, r12, #4*5
		b	1b
proc_types
		.word	0x000f0000		@ new CPU Id
		.word	0x000f0000
		b	__armv7_mmu_cache_on
		b	__armv7_mmu_cache_off
		b	__armv7_mmu_cache_flush

-----????-----
???: Laurent Desnogues [mailto:laurent.desnogues at gmail.com] 
????: 2009?10?20? 18:00
???: ???
??: linux-arm-kernel
??: Re: ARM1176 goes wild when MMU on line

2009/10/20 ??? <914059751@qq.com>:
> ARM1176 has ARMv7 VMSA. ?Am I?missing something obvious?

Is that a typo? ARM1176 is an ARMv6 chip, not an ARMv7 one.


Laurent
