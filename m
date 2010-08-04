From: sajithpv@gmail.com (Sajith P V)
Date: Wed, 4 Aug 2010 21:54:14 +0530
Subject: Enabling/disabling MMU in kernel power management suspend handler
In-Reply-To: <AANLkTimuys1GCBtm=oewUKp6ftDHjA0eNvT5Lfwac71A@mail.gmail.com>
References: <AANLkTimuys1GCBtm=oewUKp6ftDHjA0eNvT5Lfwac71A@mail.gmail.com>
Message-ID: <AANLkTik-h-LxdFw6g_yDwgCy6ipyMCqzZfDAzTanVXxE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I found out couple of issues with the sequence listed below.

1. TLB and cache invalidation was performed after disabling the MMU.
This will cause the cache lines to be flushed to addresses no longer
available.

2. The cache_mmu_off routine returned using a virtual address.

Both these issues were fixed in the below sequence. Now control is
switching back and forth between virtual and physical address spaces.
But a new issue has cropped up. As soon as the whole cache
invalidation instruction is executed, it is observed that the memory
area pointed to by the stack pointer is getting corrupted. This was
observed by stepping through using a debugger. What is happening here?

The new code sequence is as follows:

ENTRY(testcode_disable_mmu)
	stmfd   sp!, {r0-r12, lr}

	@ Save control register
	mrc     p15, 0, r1, c1, c0, 0
	str     r1, control_reg

	@ Store the phys addr of test_func in r14
	adr     r14, testcode_enable_mmu@ Virtual address in r14
	ldr     r1, page_offset         @ r1 = 0xC0000000
	ldr     r2, phys_offset         @ r2 = 0x82400000
	sub     r14, r14, r1
	add     r14, r14, r2

	@ Disable cache and mmu
	mov     r0, #0
	mcr     p15, 0, r0, c13, c0, 0  @ Clear FCSE PID
	mrc	p15, 0, r2, c1, c0, 0   @ Read ctrl reg
	bic     r2, r2, #DISABLE_DCACHE_MMU
	bic     r2, r2, #DISABLE_ICACHE
	mov	r0, #0
	mcr	p15, 0, r0, c7, c7, 0   @ Invalidate whole cache
	mcr	p15, 0, r0, c8, c7, 0   @ Invalidate whole TLB
	mcr	p15, 0, r2, c1, c0, 0   @ Disable cache and mmu
	mov     r1, r1
	mov     r1, r1
	mov     pc, r14

testcode_enable_mmu:
	b       testcode_enable_mmu

	@ Load the virt address of ret_from_func in r14
	adr     r14, ret_from_func      @ Virtual address in r14
	ldr     r2, phys_offset         @ r2 = 0x82400000
	ldr     r1, page_offset         @ r1 = 0xC0000000
	sub     r14, r14, r2
	add     r14, r14, r1

	@ Turn on mmu
	@ Sequence from arch/arm/kernel/head.S
	ldr     r0,control_reg
	nop
	nop
	nop
	mcr     p15, 0, r0, c1, c0, 0   @ write control reg
	mrc     p15, 0, r3, c0, c0, 0   @ read id reg
	mov     r1, r1
	mov     r1, r1
	mov     pc, r14

ret_from_func:
	b       ret_from_func

	ldmfd   sp!, {r0-r12, lr}
	mov     pc,lr

control_reg:
	.word	0
page_offset:
	.word	PAGE_OFFSET
phys_offset:
	.word	PHYS_OFFSET

It was also observed that without adding a nop instruction above the
MMU enable instruction in the function test_code_enable_mmu, the
following instruction caused a prefetch abort.

Regards,
Sajith

Regards,
Sajith
On Wed, Aug 4, 2010 at 9:47 AM, Sajith P V <sajithpv@gmail.com> wrote:
> Hi,
>
> I need to disable and re-enable MMU and caches in the power management
> suspend handler in order to save and restore complete ARM state information in
> DDR memory (this is to take the ARM1136JF-S through the dormant sleep state).
> I'm working on 2.6.29 kernel (Eclair). To achieve this, I'm testing
> the following code sequence that will first disable mmu, then branch
> to a function which re enables MMU (attached text file).
>
> This sequence is not working. I've pored through ARM1136JF-S rev r1p5
> data sheets and could not figure out what is wrong here. The
> observations are as follows:
>
> 1. When the above code sequence is executed and when I attach a
> debugger I see that the PC is at some address starting with 0xCxxxxxxx
> and not looping at 'restore'.
>
> 2. When I step through the code and then forcefully change the PC
> value to equivalent physical address at the instruction 'mov pc,r3' in
> the routine dormant_sleep, then the control is successfully
> transferred to dormant_restore. The same behavior holds good when I
> forcefully set the PC to equivalent virtual address at the instruction
> 'mov ? ?r1,r1' in the routine dormant_restore.
>
> What could be incorrect in the above sequence?
>
> Regards,
> Sajith
>
