From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 06 Sep 2010 16:16:30 +0100
Subject: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
In-Reply-To: <20100906104413.GD20903@n2100.arm.linux.org.uk>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100906104413.GD20903@n2100.arm.linux.org.uk>
Message-ID: <1283786190.12076.106.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Mon, 2010-09-06 at 11:44 +0100, Russell King - ARM Linux wrote:
> +#ifdef CONFIG_SMP_ON_UP
> +__fixup_smp:
> +       mov     r7, #0x00070000
> +       orr     r6, r7, #0xff000000     @ mask 0xff070000
> +       orr     r7, r7, #0x41000000     @ val 0x41070000
> +       and     r0, r9, r6
> +       teq     r0, r7                  @ ARM CPU and ARMv6/v7?
> +       bne     __fixup_smp_on_up       @ no, assume UP
> +
> +       orr     r6, r6, #0x0000ff00
> +       orr     r6, r6, #0x000000f0     @ mask 0xff07fff0
> +       orr     r7, r7, #0x0000b000
> +       orr     r7, r7, #0x00000020     @ val 0x4107b020
> +       and     r0, r9, r6
> +       teq     r0, r7                  @ ARM 11MPCore?
> +       moveq   pc, lr                  @ yes, assume SMP
> +
> +       mrc     p15, 0, r0, c0, c0, 5   @ read MIDR
> +       tst     r0, #1 << 31
> +       movne   pc, lr                  @ bit 31 => SMP

An alternative would be to check for hardware coherency support in the
shareability domain using the MMFR0 register. If we have the new CPUID
format (all MP systems):

	if (ID_MMFR0<15:12> == 0) 
		HWCoherency = (ID_MMFR0<11:8> == 1)
	else 
		HWCoherency = (ID_MMFR0<31:28> == 1)

The hw coherency is built for MP systems and this register should be
valid for both ARMv6 and ARMv7 configurations.

Something like below, untested:

	mov	r6, #0x000f0000		@ mask/val new CPUID
	and	r0, r9, r6
	teq	r0, r6			@ ARMv6/v7 new CPUID
	bne	__fixup_smp_on_up	@ no, assume UP

	mrc	p15, 0, r0, c0, c1, 4	@ MMFR0
	mov	r6, #0x0000f000		@ mask shareability levels
	tst	r0, r6
	moveq	r0, r0, lsr #8		@ outermost shareability
	movne	r0, r0, lsr #28		@ innermost shareability
	and	r0, r0, #15
	cmp	r0, #1			@ check hw coherency support
	bne	__fixup_smp_on_up	@ no, assume UP

We still cannot optimise the case where you have an MP capable processor
but in a UP-only configuration (maxcpus=1).

For the availability of the Inner Shareable cache and TLB operations, we
would need to check for the MMFR3<15:12> bits.

-- 
Catalin
