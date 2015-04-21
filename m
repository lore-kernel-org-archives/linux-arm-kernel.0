From: Dave.Martin@arm.com (Dave P Martin)
Date: Tue, 21 Apr 2015 14:18:03 +0100
Subject: your mail
In-Reply-To: <20150421125049.GW12732@n2100.arm.linux.org.uk>
References: <CAKv+Gu9u73+YKn+aR1vk+1eNF_voC71THWRQS96jyAt4HB3BQw@mail.gmail.com>
 <20150421104634.GA3996@e103592.cambridge.arm.com>
 <CAKv+Gu-3iM2+TvAgfV91FzfgAQuZhr=beeJ8RWmmGjTChbUrtQ@mail.gmail.com>
 <20150421111042.GB3996@e103592.cambridge.arm.com>
 <20150421112420.GV12732@n2100.arm.linux.org.uk>
 <20150421125049.GW12732@n2100.arm.linux.org.uk>
Message-ID: <20150421131801.GD3996@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 01:50:50PM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 21, 2015 at 12:24:20PM +0100, Russell King - ARM Linux wrote:
> > We should probably create a badr macro to complement the adr pseudo-op
> > which incorporates the BSYM thing so make this clearer - and a comment
> > before it.  This is really the case where BSYM should be used.
> 
> Something like this.  Note that I've also removed the BSYM() usage in
> the KVM code.

Nice.  Wrapping this around adr will make the assembler check that it's
not a cross-section reference too.

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
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 186270b3e194..4abe57279c66 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -178,6 +178,21 @@
>         .endm
> 
>  /*
> + * Assembly version of "adr rd, BSYM(sym)".  This should only be used to
> + * reference local symbols in the same assembly file which are to be
> + * resolved by the assembler.  Other usage is undefined.

BSYM() is gone, so this comment shouldn't refer to it...

> + */
> +       .irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo

This wrap-macro-with-cc idiom could be factored, but it may not be worth
it just yet.

[...]

Cheers
---Dave
