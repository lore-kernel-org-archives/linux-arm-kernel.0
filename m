From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 19 Jul 2013 11:58:45 +0100
Subject: alignment handler instruction endian-ness
Message-ID: <51E91BE5.8070809@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I ran in to an issue with the alignment handler when running BE8 where
it loads instructions and fails to swap.

Is there a better way of swapping instructions for ARM when loading
from arbitrary places? Have I missed any other places this could happen?

The following patch is my first attempt at solving the problem for the
alignment handler:

> Author: Ben Dooks <ben.dooks@codethink.co.uk>
> Date:   Thu Jul 18 21:10:56 2013 +0100
>
>     arm: alignment: deal with be8 mode when decoding instructions
>
>     If we are in BE8 mode, we must deal with the instruction stream being
>     in LE order when data is being loaded in BE order. Ensure the data is
>     swapped before processing to avoid thre following:
>
>     Alignment trap: not handling instruction 030091e8 at [<80333e8c>]
>     Unhandled fault: alignment exception (0x001) at 0xbfa09567
>
>     Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
 >
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index db26e2e..e8793a7 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -87,6 +87,12 @@ core_param(alignment, ai_usermode, int, 0600);
>  #define UM_FIXUP       (1 << 1)
>  #define UM_SIGNAL      (1 << 2)
>
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +#define need_swap()    true
> +#else
> +#define need_swap()    false
> +#endif
> +
>  /* Return true if and only if the ARMv6 unaligned access model is in use. */
>  static bool cpu_is_v6_unaligned(void)
>  {
> @@ -762,12 +768,16 @@ do_alignment(unsigned long addr, unsigned int fsr, struct
>         if (thumb_mode(regs)) {
>                 u16 *ptr = (u16 *)(instrptr & ~1);
>                 fault = probe_kernel_address(ptr, tinstr);
> +               if (need_swap())
> +                       tinstr = cpu_to_le16(tinstr);
>                 if (!fault) {
>                         if (cpu_architecture() >= CPU_ARCH_ARMv7 &&
>                             IS_T32(tinstr)) {
>                                 /* Thumb-2 32-bit */
>                                 u16 tinst2 = 0;
>                                 fault = probe_kernel_address(ptr + 1, tinst2);
> +                               if (need_swap())
> +                                       tinst2 = cpu_to_le16(tinst2);
>                                 instr = (tinstr << 16) | tinst2;
>                                 thumb2_32b = 1;
>                         } else {
> @@ -775,8 +785,11 @@ do_alignment(unsigned long addr, unsigned int fsr, struct p
>                                 instr = thumb2arm(tinstr);
>                         }
>                 }
> -       } else
> +       } else {
>                 fault = probe_kernel_address(instrptr, instr);
> +               if (need_swap())
> +                       instr = cpu_to_le32(instr);
> +       }
>
>         if (fault) {
>                 type = TYPE_FAULT;


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
