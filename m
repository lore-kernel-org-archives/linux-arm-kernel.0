From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 15 Aug 2011 15:54:58 +0800
Subject: [RFC PATCH 2/2] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <CAGsJ_4yigTt40g0-9jrz5qAbdrQdsXuQ65MhX+x1AZ1M4Ztr=w@mail.gmail.com>
References: <1312512888-25070-1-git-send-email-bs14@csr.com>
	<1312512888-25070-3-git-send-email-bs14@csr.com>
	<20110814075927.GB4986@n2100.arm.linux.org.uk>
	<CAGsJ_4yigTt40g0-9jrz5qAbdrQdsXuQ65MhX+x1AZ1M4Ztr=w@mail.gmail.com>
Message-ID: <CAGsJ_4yZGp2giGNPW2-pqbskmBVs_onB0sc3V7ZPoAu1-2xyUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
Thanks!

2011/8/14 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Aug 04, 2011 at 07:54:48PM -0700, Barry Song wrote:
>> +ENTRY(sirfsoc_sleep)
>> +sirfsoc_sleep:
>
> POINT A
>
>> +     stmdb  sp!, {r0-r12, lr}                @ Push SVC state onto our stack
>> +
>> +     mrc     p15, 0, r2, c1, c0, 1           @ cp15 c1 auxiliary Control register
>> +     mrc     p15, 0, r3, c1, c0, 2           @ cp15 c1 coprocessor access control register
>> +     mrc     p15, 0, r4, c2, c0, 0           @ cp15 c2_r0 translation table base resigter 0
>> +     mrc     p15, 0, r5, c2, c0, 1           @ cp15 c2_r1 translation table base resigter 1
>> +
>> +     mrc     p15, 0, r6, c2, c0, 2           @ cp15 c2_r2 translation table base control resigter
>> +
>> +     mrc     p15, 0, r7, c3, c0, 0           @ load r2 with domain access control.
>> +     mrc     p15, 0, r8, c1, c0, 0           @ MMU Control
>> +     mrc     p15, 0, r9, c10,c2, 0           @ cp15 PRRR register
>> +     mrc     p15, 0, r10, c10,c2, 1          @ cp15 NMRR register
>> +     mov     r11, sp
>> +     ldr     r0, =save_context
>> +     add     r0, r0, #124
>> +     stmdb   r0!, {r2-r11}                   @ Save CP15 and the SP to stack
>> +
>> +     mov     r1, #FIQ_MODE|PSR_I_BIT|PSR_F_BIT       @ Enter FIQ mode, no interrupts
>> +     msr     cpsr, r1
>> +     mrs     r2, spsr
>> +     stmdb   r0!, {r2, r8-r12, sp, lr}       @ store the FIQ Mode Registers
>> +
>> +     mov     r1, #ABT_MODE|PSR_I_BIT|PSR_F_BIT       @ Enter ABT mode, no interrupts
>> +     msr     cpsr, r1
>> +     mrs     r2, spsr
>> +     stmdb   r0!, {r2, sp, lr}               @ store the ABT Mode Registers
>> +
>> +     mov     r1, #IRQ_MODE|PSR_I_BIT|PSR_F_BIT       @ Enter IRQ mode, no interrupts
>> +     msr     cpsr, r1
>> +     mrs     r2, spsr
>> +     stmdb   r0!, {r2, sp, lr}               @ store the IRQ Mode Registers
>> +
>> +     mov     r1, #UND_MODE|PSR_I_BIT|PSR_F_BIT       @ Enter UND mode, no interrupts
>> +     msr     cpsr, r1
>> +     mrs     r2, spsr
>> +     stmdb   r0!, {r2, sp, lr}               @ store the UND Mode Registers
>> +
>> +     mov     r1, #SYSTEM_MODE|PSR_I_BIT|PSR_F_BIT    @ Enter SYS mode, no interrupts
>> +     msr     cpsr, r1
>> +     mrs     r2, spsr
>> +     stmdb   r0!, {r2, sp, lr}               @ store the SYS Mode Registers
>> +
>> +     mov     r1, #SVC_MODE|PSR_I_BIT|PSR_F_BIT @ Enter SVC mode, no interrupts
>> +     msr     cpsr, r1
>> +
>> +     ldr     r1, =save_context                  @ Get address of label save_sp in r1
>> +     sub     r0, r0, r1
>> +     str     r0, [r1]                      @ Store context offset to label memory
>
> POINT B
>
>> +
>> +     bl      sirfsoc_pre_suspend_power_off
>> +     cmp     r0,#0
>> +     bne     sirfsoc_sleep_exit
>> +
>
> POINT C
>
>> +     @ r5:   mem controller
>> +     ldr     r0, =sirfsoc_memc_base
>> +     ldr     r5, [r0]
>> +     @ r7:   rtc iobrg controller
>> +     ldr     r0, =sirfsoc_rtciobrg_base
>> +     ldr     r7, [r0]
>> +
>> +     @ Clean and invalidate all caches
>> +     bl v7_flush_kern_cache_all
>
> POINT D
>
>> +
>> +#ifdef CONFIG_CACHE_L2X0
>> +     ldr     r1, =sirfsoc_l2x_base
>> +     ldr     r0, [r1]
>> +     ldr     r1, =L2X0_CLEAN_INV_WAY
>> +     mov     r2, #0xff
>> +     str     r2, [r0,r1]
>> +     mov     r2, #0
>> +1:
>> +     ldr     r3, [r0,r1]
>> +     cmp     r2,r3
>> +     bne     1b
>> +     ldr     r1, =L2X0_CACHE_SYNC
>> +     mov     r2, #0
>> +     str     r2, [r0,r1]
>> +
>> +     ldr     r1, =L2X0_CTRL
>> +     mov     r2, #0
>> +     str     r2, [r0,r1]
>> +#endif
>> +
>> +     @ Read the power control register and set the
>> +     @ sleep force bit.
>> +     ldr     r0, =SIRFSOC_PWRC_PDN_CTRL
>> +     bl      __sirfsoc_rtc_iobrg_readl
>> +     orr     r0,r0,#SIRFSOC_PWR_SLEEPFORCE
>> +     ldr     r1, =SIRFSOC_PWRC_PDN_CTRL
>> +     bl      sirfsoc_rtc_iobrg_pre_writel
>> +     mov     r1, #0x1
>> +
>> +     @ The following code is arranged in such a way
>> +     @ that the code to be run after memory is put
>> +     @ into self refresh fits in a cache line (32 bytes).
>> +     @ This is done to make sure the code runs from
>> +     @ cache after memory is put into self refresh.
>> +
>> +     @ read the MEM ctl register and set the self
>> +     @ refresh bit
>> +
>> +     ldr     r2, [r5, #DENALI_CTL_22_OFF]
>> +     orr     r2, r2, #0x1
>> +
>> +     @ Following code has to run from cache since
>> +     @ the RAM is going to self refresh mode
>> +     .align 5
>> +     str     r2, [r5, #DENALI_CTL_22_OFF]
>> +
>> +1:
>> +     ldr     r4, [r5, #DENALI_CTL_112_OFF]
>> +     tst     r4, #0x1
>> +     bne     1b
>> +
>> +     @ write SLEEPFORCE through rtc iobridge
>> +
>> +     str     r1, [r7]
>> +     @ wait rtc io bridge sync
>> +1:
>> +     ldr     r3, [r7]
>> +     tst     r3, #0x01
>> +     bne     1b
>> +     b .
>> +
>> +     @ bootloader will jump here on wakeup
>> +
>> +     .align 5
>> +.globl sirfsoc_wakeup
>> +sirfsoc_wakeup:
>> +
>
> POINT E
>
>> +     mov r4, #0
>> +        mcr p15,0,r4,c8,c7,0            @invalid all unified tlb
>> +        mcr p15,0,r4,c8,c6,0            @invalid all data tlb
>> +        mcr p15,0,r4,c8,c5,0            @invalid all instruction tlb
>> +        mcr p15,0,r4,c7,c5,4            @flush prefetch buffer
>> +        mcr p15,0,r4,c7,c10,4           @Drain write buffer
>> +     mcr p15,0,r4,c7,c5,0            @invalid instruction cache
>> +
>> +     mov     r0, #PSR_I_BIT | PSR_F_BIT | SVC_MODE
>> +     msr     cpsr, r0                        @ set SVC, irqs off
>> +
>> +     @ Get save_context phys address
>> +     ldr     r1, =save_context
>> +     ldr     r3, =(.+12)
>> +     sub     r3, r3, pc
>> +     sub     r1, r1, r3
>> +     ldr     r0, [r1]
>> +
>> +     add     r0, r0, r1
>> +
>> +     mov     r1, #SYSTEM_MODE|PSR_I_BIT|PSR_F_BIT    @ Enter SYS mode, no interrupts
>> +     msr     cpsr, r1
>> +     ldmfd   r0!, {r2, sp, lr}               @ store the SYS Mode Registers
>> +     msr     spsr, r2
>> +
>> +     mov     r1, #UND_MODE|PSR_I_BIT|PSR_F_BIT       @ Enter UND mode, no interrupts
>> +     msr     cpsr, r1
>> +     ldmfd   r0!, {r2, sp, lr}               @ store the UND Mode Registers
>> +     msr     spsr, r2
>> +
>> +     mov     r1, #IRQ_MODE|PSR_I_BIT|PSR_F_BIT       @ Enter IRQ mode, no interrupts
>> +     msr     cpsr, r1
>> +     ldmfd   r0!, {r2, sp, lr}               @ store the IRQ Mode Registers
>> +     msr     spsr, r2
>> +
>> +     mov     r1, #ABT_MODE|PSR_I_BIT|PSR_F_BIT       @ Enter ABT mode, no interrupts
>> +     msr     cpsr, r1
>> +     ldmfd   r0!, {r2, sp, lr}               @ store the ABT Mode Registers
>> +     msr     spsr, r2
>> +
>> +     mov     r1, #FIQ_MODE|PSR_I_BIT|PSR_F_BIT       @ Enter FIQ mode, no interrupts
>> +     msr     cpsr, r1
>> +     ldmfd   r0!, {r2, r8-r12,sp, lr}        @ store the FIQ Mode Registers
>> +     msr     spsr, r2
>> +
>> +     mov     r1, #SVC_MODE|PSR_I_BIT|PSR_F_BIT       @ Enter SVC mode, no interrupts
>> +     msr     cpsr, r1
>> +
>> +     ldr     r1, =sirfsoc_sleep_exit         @ its absolute virtual address
>> +     ldmfd   r0, {r2 - r10, sp}              @ CP regs + virt stack ptr
>> +
>> +     mcr     p15, 0, r7, c3, c0, 0           @ load r2 with domain access control.
>> +     mcr     p15, 0, r6, c2, c0, 2           @ cp15 c2_r2 translation table base control resigter
>> +     mcr     p15, 0, r4, c2, c0, 0           @ cp15 c2_r0 translation table base resigter 0
>> +     mcr     p15, 0, r5, c2, c0, 1           @ cp15 c2_r1 translation table base resigter 1
>> +
>> +     mcr     p15, 0, r3, c1, c0, 2           @ cp15 c1 coprocessor access control register
>> +     mcr     p15, 0, r2, c1, c0, 1           @ cp15 c1 auxiliary Control register
>> +     mcr     p15, 0, r10, c10,c2, 1          @ cp15 NMRR register
>> +     mcr     p15, 0, r9, C10,c2, 0           @ cp15 PRRR register
>> +     b       resume_turn_on_mmu              @ cache align execution
>> +
>> +     .align 5
>> +resume_turn_on_mmu:
>> +     mcr     p15, 0, r8, c1, c0, 0           @ MMU Control
>> +     nop
>> +     mov     pc, r1                          @ jump to virtual addr
>> +     nop
>> +     nop
>> +     nop
>> +
>> +sirfsoc_sleep_exit:
>> +     ldmfd   sp!, {r0 - r12, pc}             @ return to caller
>> +     /* back to caller of sleep */
>> +     nop
>> +     nop
>> +     nop
>> +@    .data
>> +     .align 5
>> +save_context:
>> +     .space 128,0
>> +
>
> POINT F
>
> NAK, at least until you look at the generic CPU suspend support in
> mainline kernels.  At least until you look at what actually needs to
> be saved.  At least until you do some investigation into what is
> actually required rather than simply believing silly statements in
> chip manuals which says you have to save the entire planet.

Sorry, my fault. i simply picked these lines which have been verified
to be working in local old 2.6.38.8 kernel and really didn't think and
refine more carefully.
in deep sleep mode, SiRFprimaII will powerdown CPU core. due to this,
i just ignored to delete the codes saving registers of all kinds of
CPU modes. but it is not the real situation in kernel. For example,
IRQ mode used the stack of corrupted thread, and kernel was not in
interrupt while going to pm_ops->enter(), then it is unnecessary to
enter IRQ and save sp of IRQ:
        mov     r1, #IRQ_MODE|PSR_I_BIT|PSR_F_BIT       @ Enter IRQ
mode, no interrupts
        msr     cpsr, r1
        mrs     r2, spsr
        stmdb   r0!, {r2, sp, lr}               @ store the IRQ Mode Registers

For CP15 saving, we should be able to get into cpu_suspend -> cpu_v7_do_suspend.

>
> I assert you can get rid of all code between points A to B, C to D,
> E to F using the generic CPU suspend support, which is most of your
> code.

Ok. agree. then the work flow for SiRFprimaII suspend can be:
pm.enter()->
    sirfsoc_cpu_sleep(v:p offset)
    1. save registers on stack
    2. load sirfsoc_cpu_resume to r3
    3. bl cpu_suspend
    4. make sdram self-refresh
    5. write force DEEPSLEEP by rtciobrg


One issue is L2 cache. we actually shutdown the L2 and re-initilized
L2 again after resuming. that required l2x0_init() to be not in __init
section. i remember Colin Cross has sent a patch about that before.
"[PATCH] ARM: mm: cache-l2x0: Add support for re-enabling l2x0"


Thanks
Barry
