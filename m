From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 25 Nov 2010 09:07:18 +0900
Subject: [PATCH] ARM: s5pv310: Correct data alignment in headsmp.S for
	CONFIG_THUMB2_KERNEL
In-Reply-To: <1289913260-8772-1-git-send-email-dave.martin@linaro.org>
References: <1289913260-8772-1-git-send-email-dave.martin@linaro.org>
Message-ID: <006301cb8c34$bb650920$322f1b60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin wrote:
> 
> Directives such as .long and .word do not magically cause the
> assembler location counter to become aligned in gas.  As a
> result, using these directives in code sections can result in
> misaligned data words when building a Thumb-2 kernel
> (CONFIG_THUMB2_KERNEL).
> 
> This is a Bad Thing, since the ABI permits the compiler to
> assume that fundamental types of word size or above are word-
> aligned when accessing them from C.  If the data is not really
> word-aligned, this can cause impaired performance and stray
> alignment faults in some circumstances.
> 
> In general, the following rules should be applied when using
> data word declaration directives inside code sections:
> 
>     * .quad and .double:
>          .align 3
> 
>     * .long, .word, .single, .float:
>          .align (or .align 2)
> 
>     * .short:
>         No explicit alignment required, since Thumb-2
>         instructions are always 2 or 4 bytes in size.
>         immediately after an instruction.
> 
> Applies cleanly on v2.6.37-rc1.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
>  arch/arm/mach-s5pv310/headsmp.S |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv310/headsmp.S b/arch/arm/mach-
> s5pv310/headsmp.S
> index 164b7b0..65f8574 100644
> --- a/arch/arm/mach-s5pv310/headsmp.S
> +++ b/arch/arm/mach-s5pv310/headsmp.S
> @@ -37,5 +37,6 @@ pen:	ldr	r7, [r6]
>  	 */
>  	b	secondary_startup
> 
> +	.align
>  1:	.long	.
>  	.long	pen_release
> --

Hi Dave,

Following is from Mr. Suh who is my team member.
Please refer to that.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

---

Dear Mr. Martin,

As far as I know, gas adds padding data not to generate misaligned data.
In your word, gas cannot give any additional treat on assembly code.
There is a mismatch.
 
Can you give me more comments?
When I make mis-aligned data like below, gas automatically gives pad.
During test, I use gcc and gas from Linaro for Ubuntu.
gcc version 4.5.1 (Ubuntu/Linaro 4.5.1-7ubuntu1) 
GNU assembler version 2.20.51 (arm-linux-gnueabi) using BFD version (GNU
Binutils for Ubuntu) 2.20.51.20100908
 
BRs,
        Suh.
 
modified source to test:
ENTRY(s5pv310_secondary_startup)
        mrc     p15, 0, r0, c0, c0, 5
        and     r0, r0, #15
        adr     r4, 1f
        ldmia   r4, {r5, r6}
        sub     r4, r4, r5
        add     r6, r6, r4
pen:    ldr     r7, [r6]
        cmp     r7, r0
        bne     pen
        /*
         * we've been released from the holding pen: secondary_stack
         * should now contain the SVC stack for this core
         */
        b       secondary_startup
        nop
1:      .long   .
        .long   pen_release
 
 
disassembled data:
8000c832 <pen>:
8000c832:       6837            ldr     r7, [r6, #0]
8000c834:       4287            cmp     r7, r0
8000c836:       d1fc            bne.n   8000c832 <pen>
8000c838:       f7fb bc00       b.w     8000803c <__bss_stop+0xffc3753c>
8000c83c:       bf00            nop
8000c83e:       c83e            .short  0xc83e
8000c840:       36208000        .word   0x36208000
8000c844:       bf008039        .word   0xbf008039
