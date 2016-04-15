From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 15 Apr 2016 09:57:53 +0200
Subject: [PATCH v2 2/4] arm64: move early boot code to the .init segment
In-Reply-To: <CAKv+Gu_4dK_2yR6gru2r6GJ4zTshg8mkjBxU9DZzaM8yio+=jg@mail.gmail.com>
References: <1459352589-28721-1-git-send-email-ard.biesheuvel@linaro.org>
 <1459352589-28721-3-git-send-email-ard.biesheuvel@linaro.org>
 <20160414163235.GE4584@arm.com>
 <CAKv+Gu_4dK_2yR6gru2r6GJ4zTshg8mkjBxU9DZzaM8yio+=jg@mail.gmail.com>
Message-ID: <57109F01.8010408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/14/2016 06:39 PM, Ard Biesheuvel wrote:
> On 14 April 2016 at 18:32, Will Deacon <will.deacon@arm.com> wrote:
>> Hi Ard,
>>
>> On Wed, Mar 30, 2016 at 05:43:07PM +0200, Ard Biesheuvel wrote:
>>> Apart from the arm64/linux and EFI header data structures, there is nothing
>>> in the .head.text section that must reside at the beginning of the Image.
>>> So let's move it to the .init section where it belongs.
>>>
>>> Note that this involves some minor tweaking of the EFI header, primarily
>>> because the address of 'stext' no longer coincides with the start of the
>>> .text section. It also requires a couple of relocated symbol references
>>> to be slightly rewritten or their definition moved to the linker script.
>>
>> [...]
>>
>>>  ENTRY(stext)
>>>       bl      preserve_boot_args
>>>       bl      el2_setup                       // Drop to EL1, w20=cpu_boot_mode
>>> @@ -223,12 +224,12 @@ ENTRY(stext)
>>>        * the TCR will have been set.
>>>        */
>>>       ldr     x27, 0f                         // address to jump to after
>>> -                                             // MMU has been enabled
>>> +     neg     x27, x27                        // MMU has been enabled
>>>       adr_l   lr, __enable_mmu                // return (PIC) address
>>>       b       __cpu_setup                     // initialise processor
>>>  ENDPROC(stext)
>>>       .align  3
>>> -0:   .quad   __mmap_switched - (_head - TEXT_OFFSET) + KIMAGE_VADDR
>>> +0:   .quad   (_text - TEXT_OFFSET) - __mmap_switched - KIMAGE_VADDR
>>
>> I'm struggling to understand why you need to change this. Furthermore,
>> it looks like the gas docs for expressions require that addition/subtraction
>> can only be performed on arguments that are in the same section, so
>> this feels pretty rickety.
>>
>> What's the problem you're solving here?
>>
> 
> The problem is that this function is no longer in the same section as
> _head aka _text, so the latter can only appear in the reloc expression
> as a positive term, and the remaining ones will all be combined into
> the addend.
> 

Alternatively, if you prefer, we could move the relocation processing
out of __mmap_switched() and run the code from the ID map, while
accessing the relocations via the virtual mapping. That way, all the
dodgy arithmetic (which actually doesn't look as dodgy anymore) is
confined to #ifdef CONFIG_RELOCATABLE sections. Something like

------8<--------
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4203d5f257bc..f9eeb1936c38 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -222,13 +222,11 @@ ENTRY(stext)
 	 * On return, the CPU will be ready for the MMU to be turned on and
 	 * the TCR will have been set.
 	 */
-	ldr	x27, 0f				// address to jump to after
+	adr_l	x27, __relocate_kernel		// address to jump to after
 						// MMU has been enabled
 	adr_l	lr, __enable_mmu		// return (PIC) address
 	b	__cpu_setup			// initialise processor
 ENDPROC(stext)
-	.align	3
-0:	.quad	__mmap_switched - (_head - TEXT_OFFSET) + KIMAGE_VADDR
 
 /*
  * Preserve the arguments passed by the bootloader in x0 .. x3
@@ -437,44 +435,6 @@ __mmap_switched:
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
-#ifdef CONFIG_RELOCATABLE
-
-	/*
-	 * Iterate over each entry in the relocation table, and apply the
-	 * relocations in place.
-	 */
-	adr_l	x8, __dynsym_start		// start of symbol table
-	adr_l	x9, __reloc_start		// start of reloc table
-	adr_l	x10, __reloc_end		// end of reloc table
-
-0:	cmp	x9, x10
-	b.hs	2f
-	ldp	x11, x12, [x9], #24
-	ldr	x13, [x9, #-8]
-	cmp	w12, #R_AARCH64_RELATIVE
-	b.ne	1f
-	add	x13, x13, x23			// relocate
-	str	x13, [x11, x23]
-	b	0b
-
-1:	cmp	w12, #R_AARCH64_ABS64
-	b.ne	0b
-	add	x12, x12, x12, lsl #1		// symtab offset: 24x top word
-	add	x12, x8, x12, lsr #(32 - 3)	// ... shifted into bottom word
-	ldrsh	w14, [x12, #6]			// Elf64_Sym::st_shndx
-	ldr	x15, [x12, #8]			// Elf64_Sym::st_value
-	cmp	w14, #-0xf			// SHN_ABS (0xfff1) ?
-	add	x14, x15, x23			// relocate
-	csel	x15, x14, x15, ne
-	add	x15, x13, x15
-	str	x15, [x11, x23]
-	b	0b
-
-2:	adr_l	x8, kimage_vaddr		// make relocated kimage_vaddr
-	dc	cvac, x8			// value visible to secondaries
-	dsb	sy				// with MMU off
-#endif
-
 	adr_l	sp, initial_sp, x4
 	mov	x4, sp
 	and	x4, x4, #~(THREAD_SIZE - 1)
@@ -795,7 +755,6 @@ __enable_mmu:
 	ic	iallu				// flush instructions fetched
 	dsb	nsh				// via old mapping
 	isb
-	add	x27, x27, x23			// relocated __mmap_switched
 #endif
 	br	x27
 ENDPROC(__enable_mmu)
@@ -808,3 +767,50 @@ __no_granule_support:
 	wfi
 	b 1b
 ENDPROC(__no_granule_support)
+
+__relocate_kernel:
+#ifdef CONFIG_RELOCATABLE
+	/*
+	 * Iterate over each entry in the relocation table, and apply the
+	 * relocations in place.
+	 */
+	ldr	w8, =__dynsym_start_offset	// offset to symbol table
+	ldr	w9, =__reloc_start_offset	// offset to reloc table
+	ldr	w10, =__reloc_end_offset	// offset to end of reloc table
+
+	ldr	x11, =KIMAGE_VADDR		// default virtual offset
+	add	x11, x11, x23			// actual virtual offset
+	add	x8, x8, x11			// __va(.dynsym)
+	add	x9, x9, x11			// __va(.reloc)
+	add	x10, x10, x11			// __va(.reloc) + sizeof(.reloc)
+
+0:	cmp	x9, x10
+	b.hs	2f
+	ldp	x11, x12, [x9], #24
+	ldr	x13, [x9, #-8]
+	cmp	w12, #R_AARCH64_RELATIVE
+	b.ne	1f
+	add	x13, x13, x23			// relocate
+	str	x13, [x11, x23]
+	b	0b
+
+1:	cmp	w12, #R_AARCH64_ABS64
+	b.ne	0b
+	add	x12, x12, x12, lsl #1		// symtab offset: 24x top word
+	add	x12, x8, x12, lsr #(32 - 3)	// ... shifted into bottom word
+	ldrsh	w14, [x12, #6]			// Elf64_Sym::st_shndx
+	ldr	x15, [x12, #8]			// Elf64_Sym::st_value
+	cmp	w14, #-0xf			// SHN_ABS (0xfff1) ?
+	add	x14, x15, x23			// relocate
+	csel	x15, x14, x15, ne
+	add	x15, x13, x15
+	str	x15, [x11, x23]
+	b	0b
+
+2:	ldr	x8, =kimage_vaddr		// make relocated kimage_vaddr
+	dc	cvac, x8			// value visible to secondaries
+	dsb	sy				// with MMU off
+#endif
+	ldr	x8, =__mmap_switched
+	br	x8
+ENDPROC(__relocate_kernel)
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5a1939a74ff3..e9278013d5d2 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -154,12 +154,12 @@ SECTIONS
 		*(.altinstr_replacement)
 	}
 	.rela : ALIGN(8) {
-		__reloc_start = .;
+		__reloc_start_offset = ABSOLUTE(. - KIMAGE_VADDR);
 		*(.rela .rela*)
-		__reloc_end = .;
+		__reloc_end_offset = ABSOLUTE(. - KIMAGE_VADDR);
 	}
 	.dynsym : ALIGN(8) {
-		__dynsym_start = .;
+		__dynsym_start_offset = ABSOLUTE(. - KIMAGE_VADDR);
 		*(.dynsym)
 	}
 	.dynstr : {
