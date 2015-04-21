From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Apr 2015 15:10:42 +0200
Subject: your mail
In-Reply-To: <20150421125049.GW12732@n2100.arm.linux.org.uk>
References: <CAKv+Gu9u73+YKn+aR1vk+1eNF_voC71THWRQS96jyAt4HB3BQw@mail.gmail.com>
 <20150421104634.GA3996@e103592.cambridge.arm.com>
 <CAKv+Gu-3iM2+TvAgfV91FzfgAQuZhr=beeJ8RWmmGjTChbUrtQ@mail.gmail.com>
 <20150421111042.GB3996@e103592.cambridge.arm.com>
 <20150421112420.GV12732@n2100.arm.linux.org.uk>
 <20150421125049.GW12732@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu9TkvEGLz-8K_F3jbvourWw8R-XScGSPagxbaakRXZKpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 April 2015 at 14:50, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Apr 21, 2015 at 12:24:20PM +0100, Russell King - ARM Linux wrote:
>> We should probably create a badr macro to complement the adr pseudo-op
>> which incorporates the BSYM thing so make this clearer - and a comment
>> before it.  This is really the case where BSYM should be used.
>
> Something like this.  Note that I've also removed the BSYM() usage in
> the KVM code.
>

Yes, that is much better. It is a pity that we still can't use '| 1'
but the fact that you are forced to use 'adr' now probably mostly
eliminates the risk regarding that.

I did notice that are are 4 or 5 instances (commented inline) of an
ARM to thumb mode switch which can just as easily be implemented as
'blx 1f' instead of using this badr macro (whose use we want to
discourage, I assume, since the address arithmetic is still slightly
dodgy). Do you think we should do something about that as well?

>  arch/arm/boot/compressed/head.S          |  4 ++--
>  arch/arm/common/mcpm_head.S              |  2 +-
>  arch/arm/include/asm/assembler.h         | 17 ++++++++++++++++-
>  arch/arm/include/asm/entry-macro-multi.S |  4 ++--
>  arch/arm/include/asm/unified.h           |  2 --
>  arch/arm/kernel/entry-armv.S             | 12 ++++++------
>  arch/arm/kernel/entry-common.S           |  6 +++---
>  arch/arm/kernel/entry-ftrace.S           |  2 +-
>  arch/arm/kernel/head-nommu.S             |  6 +++---
>  arch/arm/kernel/head.S                   |  8 ++++----
>  arch/arm/kernel/sleep.S                  |  2 +-
>  arch/arm/kvm/interrupts.S                |  2 +-
>  arch/arm/lib/call_with_stack.S           |  2 +-
>  arch/arm/mm/proc-v7m.S                   |  2 +-
>  14 files changed, 42 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 2c45b5709fa4..06e983f59980 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -130,7 +130,7 @@ start:
>                 .endr
>     ARM(                mov     r0, r0          )
>     ARM(                b       1f              )
> - THUMB(                adr     r12, BSYM(1f)   )
> + THUMB(                badr    r12, 1f         )
>   THUMB(                bx      r12             )
>

blx 1f

>                 .word   _magic_sig      @ Magic numbers to help the loader
> @@ -447,7 +447,7 @@ dtb_check_done:
>
>                 bl      cache_clean_flush
>
> -               adr     r0, BSYM(restart)
> +               badr    r0, restart
>                 add     r0, r0, r6
>                 mov     pc, r0
>
> diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
> index e02db4b81a66..08b3bb9bc6a2 100644
> --- a/arch/arm/common/mcpm_head.S
> +++ b/arch/arm/common/mcpm_head.S
> @@ -49,7 +49,7 @@
>  ENTRY(mcpm_entry_point)
>
>   ARM_BE8(setend        be)
> - THUMB(        adr     r12, BSYM(1f)   )
> + THUMB(        badr    r12, 1f         )
>   THUMB(        bx      r12             )
>   THUMB(        .thumb                  )
>  1:

likewise

> [...]
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index 84da14b7cd04..c9660167ef1a 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -46,7 +46,7 @@ ENTRY(stext)
>         .arm
>  ENTRY(stext)
>
> - THUMB(        adr     r9, BSYM(1f)    )       @ Kernel is always entered in ARM.
> + THUMB(        badr    r9, 1f          )       @ Kernel is always entered in ARM.
>   THUMB(        bx      r9              )       @ If this is a Thumb-2 kernel,
>   THUMB(        .thumb                  )       @ switch to Thumb now.
>   THUMB(1:                      )

likewise

> @@ -79,7 +79,7 @@ ENTRY(stext)
>  #endif
>         ldr     r13, =__mmap_switched           @ address to jump to after
>                                                 @ initialising sctlr
> -       adr     lr, BSYM(1f)                    @ return (PIC) address
> +       badr    lr, 1f                          @ return (PIC) address
>         ldr     r12, [r10, #PROCINFO_INITFUNC]
>         add     r12, r12, r10
>         ret     r12
> @@ -115,7 +115,7 @@ ENTRY(secondary_startup)
>         bl      __setup_mpu                     @ Initialize the MPU
>  #endif
>
> -       adr     lr, BSYM(__after_proc_init)     @ return address
> +       badr    lr, __after_proc_init           @ return address
>         mov     r13, r12                        @ __secondary_switched address
>         ldr     r12, [r10, #PROCINFO_INITFUNC]
>         add     r12, r12, r10
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 7304b4c44b52..1eecd57453be 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -80,7 +80,7 @@
>  ENTRY(stext)
>   ARM_BE8(setend        be )                    @ ensure we are in BE8 mode
>
> - THUMB(        adr     r9, BSYM(1f)    )       @ Kernel is always entered in ARM.
> + THUMB(        badr    r9, 1f          )       @ Kernel is always entered in ARM.
>   THUMB(        bx      r9              )       @ If this is a Thumb-2 kernel,
>   THUMB(        .thumb                  )       @ switch to Thumb now.
>   THUMB(1:                      )

likewise

> @@ -148,7 +148,7 @@ ENTRY(stext)
>          */
>         ldr     r13, =__mmap_switched           @ address to jump to after
>                                                 @ mmu has been enabled
> -       adr     lr, BSYM(1f)                    @ return (PIC) address
> +       badr    lr, 1f                          @ return (PIC) address
>  #ifdef CONFIG_ARM_LPAE
>         mov     r5, #0                          @ high TTBR0
>         mov     r8, r4, lsr #12                 @ TTBR1 is swapper_pg_dir pfn
> @@ -364,7 +364,7 @@ __turn_mmu_on_loc:
>         .text
>  ENTRY(secondary_startup_arm)
>         .arm
> - THUMB(        adr     r9, BSYM(1f)    )       @ Kernel is entered in ARM.
> + THUMB(        badr    r9, 1f          )       @ Kernel is entered in ARM.
>   THUMB(        bx      r9              )       @ If this is a Thumb-2 kernel,
>   THUMB(        .thumb                  )       @ switch to Thumb now.
>   THUMB(1:                      )

likewise

-- 
Ard.
