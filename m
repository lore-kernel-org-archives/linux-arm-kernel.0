From: hechtb@gmail.com (Bastian Hecht)
Date: Mon, 18 Feb 2013 08:57:20 -0600
Subject: [PATCH 01/08] ARM: shmobile: Fix base address readout in
 headsmp-scu.S
In-Reply-To: <20130218134657.17303.35378.sendpatchset@w520>
References: <20130218134648.17303.97576.sendpatchset@w520>
 <20130218134657.17303.35378.sendpatchset@w520>
Message-ID: <CABYn4swi1K6m5YnPGWemLF0ybDxzC=yRCCv3hhX9nGT15=S7vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

yes using the physical address works.

Thanks,

 Bastian

2013/2/18 Magnus Damm <magnus.damm@gmail.com>:
> From: Magnus Damm <damm@opensource.se>
>
> Rework the early SCU setup code in headsmp-scu.S to read
> the base address in the same way as we use to fetch the
> address of the invalidation function.
>
> Reported-by: Bastian Hecht <hechtb@gmail.com>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
>  Tested on r8a7779. Feel free to add incrementally or fold into:
>  [PATCH 05/06] ARM: shmobile: Common shmobile_scu_base in headsmp-scu.S
>
>  Bastian, does this solve your problem?
>
>  arch/arm/mach-shmobile/headsmp-scu.S |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> --- 0001/arch/arm/mach-shmobile/headsmp-scu.S
> +++ work/arch/arm/mach-shmobile/headsmp-scu.S   2013-02-18 16:17:58.000000000 +0900
> @@ -39,7 +39,7 @@ ENTRY(shmobile_secondary_vector_scu)
>         mrc     p15, 0, r0, c0, c0, 5   @ read MIPDR
>         and     r0, r0, #3              @ mask out cpu ID
>         lsl     r0, r0, #3              @ we will shift by cpu_id * 8 bits
> -       ldr     r1, =shmobile_scu_base
> +       ldr     r1, 2f
>         ldr     r1, [r1]                @ SCU base address
>         ldr     r2, [r1, #8]            @ SCU Power Status Register
>         mov     r3, #3
> @@ -48,6 +48,7 @@ ENTRY(shmobile_secondary_vector_scu)
>
>         ldr     pc, 1f
>  1:     .long shmobile_invalidate_start - PAGE_OFFSET + PLAT_PHYS_OFFSET
> +2:     .long shmobile_scu_base - PAGE_OFFSET + PLAT_PHYS_OFFSET
>  ENDPROC(shmobile_secondary_vector_scu)
>
>         .text
