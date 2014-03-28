From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Mar 2014 17:44:42 +0100
Subject: __pv_phys_offset, inline assembly functions, and such like
In-Reply-To: <20140328152831.GK7528@n2100.arm.linux.org.uk>
References: <20140328152831.GK7528@n2100.arm.linux.org.uk>
Message-ID: <31244110.z9r85lquQQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 March 2014 15:28:32 Russell King - ARM Linux wrote:
> 
> The second problem is virt_to_page() itself.  Let's look at what that
> involves:
> 
> #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
> 
> For flatmem (which is single-zImage's only supported memory model):

A side note on this: I don't think there is a strong reason why we
can't also support sparsemem in multiplatform. I believe we have
so far avoided it because nobody really needed it to be in multiplatform,
and because the mach-realview Kconfig doesn't allow it in combination
with ARM_PATCH_PHYS_VIRT.

I would probably suggest changing two things here:
a) allow sparsemem with multiplatform, for more efficient support
   of some platforms
b) change mach-realview to decouple sparsemem from the custom
   __virt_to_phys implementation, at the same time as getting
   realview ready for multiplatform.

I don't think any of these will fundamentally change your analysis,
but I thought it might help to mention this in case you see other
problems with sparsemem enabled.

> With the inline assembly eliminated from the macro, and __pv_phys_offset
> converted to a PFN offset instead, the above assembly code shrinks
> dramatically:
> 
>      a20:       e59331d4        ldr     r3, [r3, #468]  ; get_dma_ops
>      a24:       e3001000        movw    r1, #0
>                         a24: R_ARM_MOVW_ABS_NC  arm_dma_ops
>      a28:       e3401000        movt    r1, #0		; &arm_dma_ops
>                         a28: R_ARM_MOVT_ABS     arm_dma_ops
>      a2c:       e3530000        cmp     r3, #0		; get_dma_ops
>      a30:       01a03001        moveq   r3, r1		; get_dma_ops
>      a34:       e28a1101        add     r1, sl, #1073741824 ; r1 = addr - PAGE_OFFSET
>      a38:       e3002000        movw    r2, #0
>                         a38: R_ARM_MOVW_ABS_NC  mem_map
>      a3c:       e3402000        movt    r2, #0		; r2 = &mem_map
>                         a3c: R_ARM_MOVT_ABS     mem_map
>      a40:       e3a0e001        mov     lr, #1		; direction
>      a44:       e1a01621        lsr     r1, r1, #12	; r1 = (addr - PAGE_OFFSET) >> 12 (pfn offset)
>      a48:       e592c000        ldr     ip, [r2]	; ip = &mem_map[0]
>      a4c:       e1a02a0a        lsl     r2, sl, #20	; r2 = part converted offset into page
>      a50:       e58de000        str     lr, [sp]	; stack direction
>      a54:       e3a0a000        mov     sl, #0		; attr
>      a58:       e08c1281        add     r1, ip, r1, lsl #5 ; r1 = &mem_map[(addr - PAGE_OFFSET) >> 12]
>      a5c:       e58da004        str     sl, [sp, #4]	; stack attr
>      a60:       e1a02a22        lsr     r2, r2, #20	; r2 = offset
>      a64:       e593c010        ldr     ip, [r3, #16]	; ops->map_page
>      a68:       e1a03006        mov     r3, r6		; length
>      a6c:       e12fff3c        blx     ip		; call map_page
> 
> With this in place, I see a reduction of 4220 bytes in the kernel image,
> and that's from just fixing virt_to_page() and changing __pv_phys_offset
> to be PFN-based (so it can be 32-bit in all cases.)

Ah, nice. Another idea: have you considered making the entire function extern?
The only advantage I see in the inline version is saving one function call,
but even with your new version there seems to be a noticeable size overhead.

	Arnd
