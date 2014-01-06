From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 06 Jan 2014 20:28:20 +0100
Subject: Regression (ARM) arch/arm/mm/init.c doesn't build without
 CONFIG_ARM_PATCH_PHYS_VIRT.
In-Reply-To: <m38uv1uuzr.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of "Tue, 31 Dec 2013 12:20:56 +0100")
References: <m38uv1uuzr.fsf@t19.piap.pl>
Message-ID: <m3ha9gx63v.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, Santosh,

the unneeded commit causing regression is still in place. Please try to
compile an ARM kernel without CONFIG_ARM_PATCH_PHYS_VIRT and with
CONFIG_ZONE_DMA and see for yourself, if you don't believe me.

Please be aware that this commit fixes nothing, its only function is
causing the regression - so we don't lose anything by reverting it.

If the attached wasn't clear, what the defective commit presently does
is changing a perfectly valid code into a code referencing a variable
which (without CONFIG_ARM_PATCH_PHYS_VIRT set) doesn't at all exist.

With CONFIG_ARM_PATCH_PHYS_VIRT set, this commit does precisely nothing.

grep __pv_phys_offset * -r gives:

Broken by the commit in question:

arch/arm/mm/init.c:             arm_dma_limit = __pv_phys_offset + arm_dma_zone_size - 1;

All of the following are only compiled/assembled with
CONFIG_ARM_PATCH_PHYS_VIRT set:

arch/arm/include/asm/memory.h:extern u64 __pv_phys_offset;
arch/arm/include/asm/memory.h:#define PHYS_OFFSET __pv_phys_offset
arch/arm/kernel/armksyms.c:EXPORT_SYMBOL(__pv_phys_offset);
arch/arm/kernel/head.S: add     r6, r6, r3      @ adjust
__pv_phys_offset address
arch/arm/kernel/head.S: str     r8, [r6, #LOW_OFFSET]   @ save computed
PHYS_OFFSET to __pv_phys_offset
arch/arm/kernel/head.S:2:       .long   __pv_phys_offset
arch/arm/kernel/head.S: .globl  __pv_phys_offset
arch/arm/kernel/head.S: .type   __pv_phys_offset, %object
arch/arm/kernel/head.S:__pv_phys_offset:
arch/arm/kernel/head.S: .size   __pv_phys_offset, . -__pv_phys_offset

In short, please revert 787b0d5c1ca7ff24feb6f92e4c7f4410ee7d81a8.
Or, do you want me to send a patch which does that?

HTH and TIA.

> arch/arm/mm/init.c: In function 'setup_dma_zone':
> arch/arm/mm/init.c:232:19: error: '__pv_phys_offset' undeclared (first use in this function)
>
> Reverting the following commit fixes it:
>
> commit 787b0d5c1ca7ff24feb6f92e4c7f4410ee7d81a8
> Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date:   Mon Dec 2 20:29:12 2013 +0100
>
>     ARM: 7908/1: mm: Fix the arm_dma_limit calculation
>
>     Current code is using PHYS_OFFSET to calculate the arm_dma_limit which
>     will lead to wrong calculations in cases where PHYS_OFFSET is updated
>     runtime.
>
>     So fix the code by using __pv_phys_offset instead of PHYS_OFFSET.
>
> It seems PHYS_OFFSET is equal to __pv_phys_offset if the latter is
> available:
>
> arch/arm/include/asm/memory.h:#define PHYS_OFFSET __pv_phys_offset
>
> Otherwise (without CONFIG_ARM_PATCH_PHYS_VIRT) PHYS_OFFSET is a
> hard-coded CONFIG value, or whatever the platform/CPU code needs:
>
> arch/arm/include/asm/memory.h:#define PHYS_OFFSET     PLAT_PHYS_OFFSET
>
> Perhaps the patch in question was needed at some point but I think the
> situation had changed before it was commited.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
