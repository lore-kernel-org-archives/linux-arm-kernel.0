From: sajithpv@gmail.com (Sajith P V)
Date: Wed, 4 Aug 2010 09:47:14 +0530
Subject: Enabling/disabling MMU in kernel power management suspend handler
Message-ID: <AANLkTimuys1GCBtm=oewUKp6ftDHjA0eNvT5Lfwac71A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I need to disable and re-enable MMU and caches in the power management
suspend handler in order to save and restore complete ARM state information in
DDR memory (this is to take the ARM1136JF-S through the dormant sleep state).
I'm working on 2.6.29 kernel (Eclair). To achieve this, I'm testing
the following code sequence that will first disable mmu, then branch
to a function which re enables MMU (attached text file).

This sequence is not working. I've pored through ARM1136JF-S rev r1p5
data sheets and could not figure out what is wrong here. The
observations are as follows:

1. When the above code sequence is executed and when I attach a
debugger I see that the PC is at some address starting with 0xCxxxxxxx
and not looping at 'restore'.

2. When I step through the code and then forcefully change the PC
value to equivalent physical address at the instruction 'mov pc,r3' in
the routine dormant_sleep, then the control is successfully
transferred to dormant_restore. The same behavior holds good when I
forcefully set the PC to equivalent virtual address at the instruction
'mov    r1,r1' in the routine dormant_restore.

What could be incorrect in the above sequence?

Regards,
Sajith
-------------- next part --------------

ENTRY(dormant_sleep)
	@ initialize restore_func_phys_addr to physical address
	@ of dormant_restore routine
	...

	@ Take a backup of the cp15 control reg into the location
	@ cp15_control_reg
	...

	@ Load phys addr of restore func
	ldr     r3,restore_func_phys_addr

	@ Turn off MMU, I cache and D cache
	bl      cache_mmu_off
	mov     pc,r3

ENTRY(cache_mmu_off)
	mov     r0,#0
	mcr     p15,0,r0,c13,c0,0          @ Clear FCSE PID
	mrc     p15,0,r2,c1,c0,0           @ Read ctrl reg
	bic     r2,r2,#DISABLE_DCACHE_MMU
	bic     r2,r2,#DISABLE_ICACHE
	mcr     p15,0,r2,c1,c0,0           @ Disable Dcache
	mov     r0,#0
	mcr     p15,0,r0,c7,c7,0           @ Invalidate whole cache
	mcr     p15,0,r0,c8,c7,0           @ Invalidate whole TLB
	mov     pc,r14


ENTRY(dormant_restore)
restore:
	@ This loop is to enable a debugger to be attached
	b       restore

	@ Read cp15 control reg
	ldr     r1,cp15_control_reg
	mcr     p15,0,r1,c1,c0,0
	mov	r1,r1
	mov	r1,r1
	
	@ At this point virtual memory should be kicked in
	...

cp15_control_reg:
	.word	0
restore_func_phys_addr:
	.word	0

	
