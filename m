From: siarhei.siamashka@nokia.com (Siarhei Siamashka)
Date: Tue, 29 Sep 2009 15:50:44 +0300
Subject: U-Bit in CortexA8
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039AE1703C@dlee02.ent.ti.com>
References: <13B9B4C6EF24D648824FF11BE8967162039AE1703C@dlee02.ent.ti.com>
Message-ID: <200909291550.44458.siarhei.siamashka@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 September 2009 04:43:15 ext Woodruff, Richard wrote:
> Hi,
>
> Is there some reason for v7 to not allow alignment warnings and signals?

It allows warnings and signals for the unsupported types of unaligned memory
accesses, which are the most interesting from the practical point of view. But
it lacks complete flexibility for sure.

> Today no matter how you set the A bit you are going to get hardware fix ups
> for alignment faults.

It is also possible (and a good idea in general) to set /proc/cpu/alignment to
4 via some script early at bootup for example. It will help to catch bad code
instead of just suffering from a performance hit.

In addition, unaligned NEON load/store instructions with strict alignment
specifier confuse the kernel quite a bit. And really emulating NEON unaligned
memory accesses in the kernel would be rather silly IMHO.

> An mis-aligned access is almost never faster even if 
> hardware fixes it up.

Based on my experience wit this stuff, unaligned memory accesses are often
faster when dealing with inherently unaligned data. Here is just one of the
examples: http://sourceware.org/ml/libc-ports/2009-07/msg00003.html

Defining ENABLE_UNALIGNED_MEM_ACCESSES in that code provides quite a
measurable speedup on average, when dealing with very small block sizes.
But I'm not claiming that this code is perfect, any possible improvements are
welcome.

This is not the only use for the unaligned memory access instructions, I only
happened to have this link handy.

> It seems people who want to know should have the 
> ability to enable faults and check out the counters.  However, as U-bit on
> A8 is forever set we will never see any faults registered.

Theoretically, people can get this statistics using the performance monitoring
unit. From Cortex-A8 TRM:

"Table 3-97 Values for predefined events (continued)
...
0x0F Unaligned access architecturally executed. This counts each instruction 
that is an access to an unaligned address. This counter only increments for 
instructions that are unconditional or that pass their condition codes."

In practice, as we know, performance monitoring unit is a bit broken in
Cortex-A8.

> There is no U bit in ARMv7 so acting like there is seems a bit misleading.

It can be also interpreted as permanently set.

> static void omap_mask_ack_irq(unsigned int irq)
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index 3a398be..09bb5b3 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -810,7 +810,7 @@ static int __init alignment_init(void)
>          * CPUs since we spin re-faulting the instruction without
>          * making any progress.
>          */
> -       if (cpu_architecture() >= CPU_ARCH_ARMv6 && (cr_alignment & CR_U))
> { +       if (cpu_architecture() == CPU_ARCH_ARMv6 && (cr_alignment &
> CR_U)) { cr_alignment &= ~CR_A;
>                 cr_no_alignment &= ~CR_A;
>                 set_cr(cr_alignment);

This does not look right. I haven't tested it, but this patch is likely to
reintroduce the old problem with the processes getting stuck on unaligned
multiword instructions, jumping between userspace and kernelspace infinitely
(as is also explained in the comment for this block) if we want to have a
configuration which allows unaligned memory accesses.

-- 
Best regards,
Siarhei Siamashka
