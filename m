From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 19 Apr 2015 21:45:08 +0200
Subject: [PATCH v2 1/8] ARM: replace PROCINFO embedded branch with
 relative offset
In-Reply-To: <20150419192836.GO12732@n2100.arm.linux.org.uk>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426248452-4773-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAGhQ9VynJZWRb4iysXPE3X0GRaZNDNObz2Bgys01Kn7gjav7ag@mail.gmail.com>
 <20150419170819.GN12732@n2100.arm.linux.org.uk>
 <6D2381CE-C6EB-4B18-972D-DA07FD77C2D4@linaro.org>
 <20150419192836.GO12732@n2100.arm.linux.org.uk>
Message-ID: <CAGhQ9VywEc2aFuwrUJq79SpwXNazPQ52SFxKniBWzTA61N+j5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2015 at 21:28, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Apr 19, 2015 at 07:41:08PM +0200, Ard Biesheuvel wrote:
>> I am away from my work pc so i can't check but i wonder if all setup
>> functions are correctly annotated as thumb2 when built in thumb2 mode.
>> If not, it would explain why a plain branch works but doing arithmetic
>> on the address doesn't.
>
> Yes, it's a Thumb2 kernel, but more importantly, it's a nommu kernel,
> and the nommu code wasn't touched.
>
> So, the entry code looks like this:
>
> 28008000:       f8df 9024       ldr.w   r9, [pc, #36]   ; 28008028 <__after_proc_init+0x4>
> 28008004:       f8d9 9000       ldr.w   r9, [r9]
> 28008008:       f001 f926       bl      28009258 <__lookup_processor_type>
> 2800800c:       ea5f 0a05       movs.w  sl, r5
> 28008010:       f001 8164       beq.w   280092dc <__error_p>
> 28008014:       f8df d014       ldr.w   sp, [pc, #20]   ; 2800802c <__after_proc_init+0x8>
> 28008018:       f20f 0e07       addw    lr, pc, #7
> 2800801c:       f10a 0c10       add.w   ip, sl, #16
> 28008020:       46e7            mov     pc, ip
> 28008022:       e7ff            b.n     28008024 <__after_proc_init>
>
> which results in us jumping to:
>
> 2822091c <__proc_info_begin>:
> 2822091c:       000f0000        andeq   r0, pc, r0
> 28220920:       000f0000        andeq   r0, pc, r0
>         ...
> 2822092c:       fff5ce6d                        ; <UNDEFINED> instruction: 0xfff5ce6d
>
> ^^^ here.  That's an offset from the beginning of the structure, which
> gives us an address of 0x2817d789, which would be correct:
>
> 2817d788 <__v7m_setup>:
> 2817d788:       4829            ldr     r0, [pc, #164]  ; (2817d830 <v7m_processor_functions+0x30>)
> 2817d78a:       f8df c0a8       ldr.w   ip, [pc, #168]  ; 2817d834 <v7m_processor_functions+0x34>
> 2817d78e:       f8c0 c008       str.w   ip, [r0, #8]
>
> The patch below should resolve it - Joachim, please confirm:

Yep, patch below makes Linus master boot again on my Cortex-M4 board.
Tested-by: Joachim Eastwood <manabian@gmail.com>


Thanks for debugging and fixing the problem Russell.

regards,
Joachim Eastwood


> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index 455033110078..5925449f6f04 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -80,9 +80,9 @@ ENTRY(stext)
>         ldr     r13, =__mmap_switched           @ address to jump to after
>                                                 @ initialising sctlr
>         adr     lr, BSYM(1f)                    @ return (PIC) address
> - ARM(  add     pc, r10, #PROCINFO_INITFUNC     )
> - THUMB(        add     r12, r10, #PROCINFO_INITFUNC    )
> - THUMB(        ret     r12                             )
> +       ldr     r12, [r10, #PROCINFO_INITFUNC]
> +       add     r12, r12, r10
> +       ret     r12
>   1:    b       __after_proc_init
>  ENDPROC(stext)
>
> @@ -117,9 +117,9 @@ ENTRY(secondary_startup)
>
>         adr     lr, BSYM(__after_proc_init)     @ return address
>         mov     r13, r12                        @ __secondary_switched address
> - ARM(  add     pc, r10, #PROCINFO_INITFUNC     )
> - THUMB(        add     r12, r10, #PROCINFO_INITFUNC    )
> - THUMB(        ret     r12                             )
> +       ldr     r12, [r10, #PROCINFO_INITFUNC]
> +       add     r12, r12, r10
> +       ret     r12
>  ENDPROC(secondary_startup)
>
>  ENTRY(__secondary_switched)
>
>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
