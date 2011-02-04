From: notasas@gmail.com (Grazvydas Ignotas)
Date: Fri, 4 Feb 2011 14:04:57 +0200
Subject: [PATCH 2/5] omap: Use inituart to configure the debug serial port
	based on machine ID
In-Reply-To: <20110204012707.26410.28508.stgit@baageli.muru.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
	<20110204012707.26410.28508.stgit@baageli.muru.com>
Message-ID: <AANLkTik7ommf_4HuahAxhMdaY-h-1JGsFfDzt2826d95@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 4, 2011 at 3:27 AM, Tony Lindgren <tony@atomide.com> wrote:
> Set the debug serial port based on machine ID. Note that most
> of the patch is just trivial checking for the machine ID.
>
> Also note that this code won't work for debugging the uncompress code.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

<snip>
> diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
> index 336a838..45c29e3 100644
> --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
<snip>

> +
> + ? ? ? ? ? ? ? /* omap3 based boards using uart3 */
> + ? ? ? ? ? ? ? ldr ? ? \v, =MACH_TYPE_CM_T35
> + ? ? ? ? ? ? ? cmp ? ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_CM_T3517
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_CRANEBOARD
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_DEVKIT8000
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_IGEP0020
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_IGEP0030
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_NOKIA_RM680
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_NOKIA_RX51
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_OMAP3517EVM
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_OMAP3_BEAGLE
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_OMAP3_PANDORA
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_OMAP_LDP
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_OVERO
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldrne ? \v, =MACH_TYPE_TOUCHBOOK
> + ? ? ? ? ? ? ? cmpne ? \id, \v
> + ? ? ? ? ? ? ? ldreq ? \v, =OMAP3_UART3_BASE
> + ? ? ? ? ? ? ? streq ? \v, [\a, #0] ? ? ? ? ? ?@ save port phys addr
> + ? ? ? ? ? ? ? ldreq ? \v, =(OMAP3_UART3_BASE + OMAP2_L4_IO_OFFSET)
> + ? ? ? ? ? ? ? streq ? \v, [\a, #4] ? ? ? ? ? ?@ save port virt addr
> + ? ? ? ? ? ? ? beq ? ? 999f

This looks a bit wasteful not only because of repeated CMPs, but also
LDRs are generating a large literal pool. Maybe something like that be
better:

    adr     r0, uart3_machines
0:
    ldrh    \v, [r0], #2
    tst     \v, \v
    beq     999f                    @ end of list
    cmp     \id, \v
    bne     0b
    ldr     \v, =OMAP3_UART3_BASE
    str     \v, [\a, #0]            @ save port phys addr
    ldr     \v, =(OMAP3_UART3_BASE + OMAP2_L4_IO_OFFSET)
    str     \v, [\a, #4]            @ save port virt addr
    b       999f

    uart3_machines:
    .short MACH_TYPE_CM_T35
    .short MACH_TYPE_CM_T3517
    ...
    .short 0

of course this needs an extra register..
