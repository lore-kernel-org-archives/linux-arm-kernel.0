From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 02 Jun 2014 16:09:28 +0100
Subject: [PATCH v4 20/20] arm64: KVM: vgic: add GICv3 world switch
In-Reply-To: <20140528191110.GF20523@arm.com> (Will Deacon's message of "Wed,
 28 May 2014 20:11:10 +0100")
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
 <1400176719-31275-21-git-send-email-marc.zyngier@arm.com>
 <20140528191110.GF20523@arm.com>
Message-ID: <87y4xfz6tz.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28 2014 at  8:11:10 pm BST, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, May 15, 2014 at 06:58:39PM +0100, Marc Zyngier wrote:
>> Introduce the GICv3 world switch code and helper functions, enabling
>> GICv2 emulation on GICv3 hardware.
>> 
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>
> [...]
>
>> diff --git a/arch/arm64/kvm/vgic-v3-switch.S b/arch/arm64/kvm/vgic-v3-switch.S
>> new file mode 100644
>> index 0000000..791a9ab
>> --- /dev/null
>> +++ b/arch/arm64/kvm/vgic-v3-switch.S
>> @@ -0,0 +1,271 @@
>> +/*
>> + * Copyright (C) 2012,2013 - ARM Ltd
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <linux/irqchip/arm-gic-v3.h>
>> +
>> +#include <asm/assembler.h>
>> +#include <asm/memory.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/kvm.h>
>> +#include <asm/kvm_asm.h>
>> +#include <asm/kvm_arm.h>
>> +
>> +	.text
>> +	.pushsection	.hyp.text, "ax"
>> +
>> +/*
>> + * Save the VGIC CPU state into memory
>> + * x0: Register pointing to VCPU struct
>> + * Do not corrupt x1!!!
>> + */
>> +.macro	save_vgic_v3_state
>> +	// Compute the address of struct vgic_cpu
>> +	add	x3, x0, #VCPU_VGIC_CPU
>> +
>> +	// Make sure stores to the GIC via the memory mapped interface
>> +	// are now visible to the system register interface
>> +	dsb	sy
>
> Stores you say? There's an option for that (-st).
>
>> +	// Save all interesting registers
>> +	mrs	x4, ICH_HCR_EL2
>> +	mrs	x5, ICH_VMCR_EL2
>> +	mrs	x6, ICH_MISR_EL2
>> +	mrs	x7, ICH_EISR_EL2
>> +	mrs	x8, ICH_ELSR_EL2
>> +
>> +	str	w4, [x3, #VGIC_V3_CPU_HCR]
>> +	str	w5, [x3, #VGIC_V3_CPU_VMCR]
>> +	str	w6, [x3, #VGIC_V3_CPU_MISR]
>> +	str	w7, [x3, #VGIC_V3_CPU_EISR]
>> +	str	w8, [x3, #VGIC_V3_CPU_ELRSR]
>> +
>> +	msr	ICH_HCR_EL2, xzr
>> +
>> +	mrs	x21, ICH_VTR_EL2
>> +	and	w22, w21, #0xf
>> +	mov	w23, #0xf
>> +	sub	w23, w23, w22	// How many regs we have to skip
>
> 	mvn	w22, w21
> 	ubfiz	w23, w22, 2, 4

Substract, extract and multiply in 2 instructions. Slick. Sick, even. ;-)

>> +	adr	x24, 1f
>> +	add	x24, x24, x23, lsl #2
>
> ... then you don't need this lsl.

Indeed.

>> +	br	x24
>> +
>> +1:
>> +	mrs	x20, ICH_LR15_EL2
>> +	mrs	x19, ICH_LR14_EL2
>> +	mrs	x18, ICH_LR13_EL2
>> +	mrs	x17, ICH_LR12_EL2
>> +	mrs	x16, ICH_LR11_EL2
>> +	mrs	x15, ICH_LR10_EL2
>> +	mrs	x14, ICH_LR9_EL2
>> +	mrs	x13, ICH_LR8_EL2
>> +	mrs	x12, ICH_LR7_EL2
>> +	mrs	x11, ICH_LR6_EL2
>> +	mrs	x10, ICH_LR5_EL2
>> +	mrs	x9, ICH_LR4_EL2
>> +	mrs	x8, ICH_LR3_EL2
>> +	mrs	x7, ICH_LR2_EL2
>> +	mrs	x6, ICH_LR1_EL2
>> +	mrs	x5, ICH_LR0_EL2
>> +
>> +	adr	x24, 1f
>> +	add	x24, x24, x23, lsl #2	// adr(1f) + unimp_nr*4
>
> Same here (you can drop the shift with the above)
>
>> +	br	x24
>> +
>> +1:
>> +	str	x20, [x3, #(VGIC_V3_CPU_LR + 15*8)]
>> +	str	x19, [x3, #(VGIC_V3_CPU_LR + 14*8)]
>> +	str	x18, [x3, #(VGIC_V3_CPU_LR + 13*8)]
>> +	str	x17, [x3, #(VGIC_V3_CPU_LR + 12*8)]
>> +	str	x16, [x3, #(VGIC_V3_CPU_LR + 11*8)]
>> +	str	x15, [x3, #(VGIC_V3_CPU_LR + 10*8)]
>> +	str	x14, [x3, #(VGIC_V3_CPU_LR + 9*8)]
>> +	str	x13, [x3, #(VGIC_V3_CPU_LR + 8*8)]
>> +	str	x12, [x3, #(VGIC_V3_CPU_LR + 7*8)]
>> +	str	x11, [x3, #(VGIC_V3_CPU_LR + 6*8)]
>> +	str	x10, [x3, #(VGIC_V3_CPU_LR + 5*8)]
>> +	str	x9, [x3, #(VGIC_V3_CPU_LR + 4*8)]
>> +	str	x8, [x3, #(VGIC_V3_CPU_LR + 3*8)]
>> +	str	x7, [x3, #(VGIC_V3_CPU_LR + 2*8)]
>> +	str	x6, [x3, #(VGIC_V3_CPU_LR + 1*8)]
>> +	str	x5, [x3, #VGIC_V3_CPU_LR]
>
> Do you have to store these backwards? I worry that it could defect some CPU
> optimisations detecting streaming stores.

The alternative is to organize the array back to front (element 0 would
store LR15). Certainly doable with a bit of hacking in the backend
functions that deal with an LR number.

>> +
>> +	lsr	w22, w21, #29	// Get PRIbits
>> +	cmp	w22, #4		// 5 bits
>> +	b.eq	5f
>
> Can you lsr by 33 and use cbz for the 5 bits case?

One thing I could do use ICH_VTR_EL2[30:29], and just test one bit at a
time:
- bit 1 set, 7 bits
- bit 0 set, 6 bits
- otherwise, 4 bits

This could entierly be implemented with a pair of tbz instructions,
loosing all the cmps.

>> +	cmp	w22, #5		// 6 bits
>> +	b.eq	6f
>> +				// 7 bits
>> +	mrs	x20, ICH_AP0R3_EL2
>> +	str	w20, [x3, #(VGIC_V3_CPU_AP0R + 3*4)]
>> +	mrs	x19, ICH_AP0R2_EL2
>> +	str	w19, [x3, #(VGIC_V3_CPU_AP0R + 2*4)]
>
> I'm slightly confused here... Why do we access ICH_AP0R3_EL2 when we have 7
> bits of priority? Shouldn't we have a check for 8 bits?

For n bits of priority, you need 2^n bits to describe the active
priorities:

- 5 bits of priority: 32 levels -> 1 register
- 6 bits of priority: 64 levels -> 2 registers
- 7 bits of priority: 128 levels -> 4 registers

>> +1:
>> +	msr	ICH_LR15_EL2, x20
>> +	msr	ICH_LR14_EL2, x19
>> +	msr	ICH_LR13_EL2, x18
>> +	msr	ICH_LR12_EL2, x17
>> +	msr	ICH_LR11_EL2, x16
>> +	msr	ICH_LR10_EL2, x15
>> +	msr	ICH_LR9_EL2,  x14
>> +	msr	ICH_LR8_EL2,  x13
>> +	msr	ICH_LR7_EL2,  x12
>> +	msr	ICH_LR6_EL2,  x11
>> +	msr	ICH_LR5_EL2,  x10
>> +	msr	ICH_LR4_EL2,   x9
>> +	msr	ICH_LR3_EL2,   x8
>> +	msr	ICH_LR2_EL2,   x7
>> +	msr	ICH_LR1_EL2,   x6
>> +	msr	ICH_LR0_EL2,   x5
>> +
>> +	// Ensure that the above will be visible via the memory-mapped
>> +	// view of the CPU interface (GICV).
>> +	isb
>> +	dsb	sy
>
> Bah, I'm sure I asked this before, but what is that dsb doing? I can't see
> any memory accesses or cache maintenance that need to be completed.

The GICv3 architecture uses dsb to synchronize between sysreg ang
memory-mapped accesses. Otherwise, there is no guarantee that a
memory-mapped guest will be able to observe the freshly populated list
registers.

Thanks for the review!

	M.
-- 
Jazz is not dead. It just smells funny.
