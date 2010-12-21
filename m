From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Dec 2010 14:41:39 +0000
Subject: [RFC][PATCH] ARM: Add initial hibernation support for Cortex A8
	and A9
In-Reply-To: <1292910239-4313-1-git-send-email-myungjoo.ham@samsung.com>
References: <1292910239-4313-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <AANLkTinFTAHzuEaLMn=xcevLCFvjga7RC6yztzC1fO5d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 December 2010 05:43, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> Hibernation (Suspend-To-Disk) support for ARM Cortex A8 and A9.
>
> This patch is based on the work of Hiroshi DOYU at Nokia, which is
> stated to be based on the original work of Romit and Raghu at TI.
>
> The hibernation support is tested with S5PC210 (ARM Cortex A9 MP2). In
> order to add support for Cortex A9 on the original patch of Hiroshi
> DOYU, which support Cortex A8 only, we have edited the list of registers
> to be saved in the case of A9.
>
> In the original work of Hiroshi DOYU, arch/arm/kernel/vmlinux.lds.S was
> modified; however, we have reverted it because it only created build
> failure in our tested system.
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Please note that I only had a quick look at the code and I won't have
time to do a proper review before the end of the year. But I have a
few comments which are consider essential.

> --- /dev/null
> +++ b/arch/arm/kernel/hibernate.c
> @@ -0,0 +1,323 @@
> +/*
> + * Hibernation support specific for ARM
> + *
> + * Copyright (C) 2010 Nokia Corporation
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
> + *
> + * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +
> +
> +/* The following architectures are known to be CORTEX_A9 */
> +#if defined(CONFIG_ARCH_S5PV310) || defined(CONFIG_ARCH_U8500)
> +#define CORTEX_A9
> +#else
> +/* Assume CORTEX_A8 as default */
> +#define CORTEX_A8
> +#endif

We should use run-time detection of the CPU rather than #ifdef's. We
have the ability to build multiple processors support into the same
kernel image.

> +struct saved_context {
> +/*
> + * FIXME: Only support for Cortex A8 and Cortex A9 now
> + */
> + ? ? ? /* CR0 */
> + ? ? ? u32 cssr; ? ? ? /* Cache Size Selection */
> + ? ? ? /* CR1 */
> +#ifdef CORTEX_A8
> + ? ? ? u32 cr; ? ? ? ? /* Control */
> + ? ? ? u32 cacr; ? ? ? /* Coprocessor Access Control */
> +#elif defined(CORTEX_A9)
> + ? ? ? u32 cr;
> + ? ? ? u32 actlr;
> + ? ? ? u32 cacr;
> + ? ? ? u32 sder;
> + ? ? ? u32 vcr;
> +#endif

We could follow the ARM ARM and define a save_context structure which
has architected registers and implementation-defined ones. For the
latter you could use a union inside this structure to differentiate
between A8, A9 and other registers for different implementations.

> + ? ? ? /* CR2 */
> + ? ? ? u32 ttb_0r; ? ? /* Translation Table Base 0 */
> + ? ? ? u32 ttb_1r; ? ? /* Translation Table Base 1 */
> + ? ? ? u32 ttbcr; ? ? ?/* Translation Talbe Base Control */
> + ? ? ? /* CR3 */
> + ? ? ? u32 dacr; ? ? ? /* Domain Access Control */
> + ? ? ? /* CR5 */
> + ? ? ? u32 d_fsr; ? ? ?/* Data Fault Status */
> + ? ? ? u32 i_fsr; ? ? ?/* Instruction Fault Status */
> + ? ? ? u32 d_afsr; ? ? /* Data Auxilirary Fault Status */ ? ? ? ;
> + ? ? ? u32 i_afsr; ? ? /* Instruction Auxilirary Fault Status */;
> +       /* CR6 */
> +       u32 d_far;      /* Data Fault Address */
> +       u32 i_far;      /* Instruction Fault Address */

I haven't checked the ARM ARM but some registers may be read-only and
not really needing saving/restoring. Some of them also don't have any
information that is essential when coming back from hibernation (like
the FSR/FAR ones).

> +static inline void __save_processor_state(struct saved_context *ctxt)
> +{
> + ? ? ? /* CR0 */
> + ? ? ? asm volatile ("mrc p15, 2, %0, c0, c0, 0" : "=r"(ctxt->cssr));
> + ? ? ? /* CR1 */
> +#ifdef CORTEX_A8
> + ? ? ? asm volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r"(ctxt->cr));
> + ? ? ? asm volatile ("mrc p15, 0, %0, c1, c0, 2" : "=r"(ctxt->cacr));
> +#elif defined(CORTEX_A9)
> + ? ? ? asm volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r"(ctxt->cr));
> + ? ? ? asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=r"(ctxt->actlr));
> + ? ? ? asm volatile ("mrc p15, 0, %0, c1, c0, 2" : "=r"(ctxt->cacr));
> + ? ? ? asm volatile ("mrc p15, 0, %0, c1, c1, 1" : "=r"(ctxt->sder));
> + ? ? ? asm volatile ("mrc p15, 0, %0, c1, c1, 3" : "=r"(ctxt->vcr));
> +#endif

I think this could be split into a generic state saving function and a
per-processor one. You can then do some checks on the CPU ID to and
call the corresponding implementation-specific save function.

> +static inline void __restore_processor_state(struct saved_context *ctxt)
> +{
[...]
> +#ifdef CORTEX_A8
> + ? ? ? asm volatile ("mcr p15, 1, %0, c9, c0, 0" : : "r"(ctxt->l2clr));
> +#endif

This register (and maybe others) is not always writable in non-secure
mode. If running in non-secure mode (which cannot easily be detected
at run-time), we should first check the Nonsecure Access Control
Register.

-- 
Catalin
