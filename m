From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 16 Aug 2011 09:34:35 +0800
Subject: [RFC PATCH 2/2] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <CAGsJ_4wyGUC=gNagaGGVcr=+nrJU2xjGJDxwS+H-UKPLajrLpg@mail.gmail.com>
References: <1312512888-25070-1-git-send-email-bs14@csr.com>
	<1312512888-25070-3-git-send-email-bs14@csr.com>
	<20110814075927.GB4986@n2100.arm.linux.org.uk>
	<CAGsJ_4yigTt40g0-9jrz5qAbdrQdsXuQ65MhX+x1AZ1M4Ztr=w@mail.gmail.com>
	<20110815082027.GA26827@n2100.arm.linux.org.uk>
	<CAGsJ_4wyGUC=gNagaGGVcr=+nrJU2xjGJDxwS+H-UKPLajrLpg@mail.gmail.com>
Message-ID: <CAGsJ_4yon5jPkwVkohiokSm1=_gNG=+Hvv55JYQ7-BeHxPkeaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/15 Barry Song <21cnbao@gmail.com>:
> 2011/8/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> On Mon, Aug 15, 2011 at 03:43:13PM +0800, Barry Song wrote:
>>> Sorry, my fault. i simply picked these lines which have been verified
>>> to be working in local old 2.6.38.8 kernel and really didn't think and
>>> refine more carefully.
>>> in deep sleep mode, SiRFprimaII will powerdown CPU core.
>>
>> ... just like everyone else.
>>
>>> due to this,
>>> i just ignored to delete the codes saving registers of all kinds of
>>> CPU modes. but it is not the real situation in kernel. For example,
>>> IRQ mode used the stack of corrupted thread, and kernel was not in
>>> interrupt while going to pm_ops->enter(), then it is unnecessary to
>>> enter IRQ and save sp of IRQ:
>>
>> No. ?There is _no_ need to save and restore these registers. ?They
>> can simply be re-setup. ?The generic cpu_suspend stuff already
>> takes care of that.
>
> i did have saied it is not necessary to save and restore if you read
> my reply carefully :-)

just as you said, after deleting all codes to save/restore regsiters:
@@ -73,31 +73,6 @@ sirfsoc_sleep:
 	add	r0, r0, #124
 	stmdb	r0!, {r2-r11}			@ Save CP15 and the SP to stack

-	mov     r1, #FIQ_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter FIQ mode, no interrupts
-	msr     cpsr, r1
-	mrs     r2, spsr
-	stmdb   r0!, {r2, r8-r12, sp, lr}      	@ store the FIQ Mode Registers
-
-	mov     r1, #ABT_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter ABT mode, no interrupts
-	msr     cpsr, r1
-	mrs     r2, spsr
-	stmdb   r0!, {r2, sp, lr}               @ store the ABT Mode Registers
-
-	mov     r1, #IRQ_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter IRQ mode, no interrupts
-	msr     cpsr, r1
-	mrs     r2, spsr
-	stmdb   r0!, {r2, sp, lr}               @ store the IRQ Mode Registers
-
-	mov     r1, #UND_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter UND mode, no interrupts
-	msr     cpsr, r1
-	mrs     r2, spsr
-	stmdb   r0!, {r2, sp, lr}               @ store the UND Mode Registers
-
-	mov     r1, #SYSTEM_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter SYS mode, no interrupts
-	msr     cpsr, r1
-	mrs     r2, spsr
-	stmdb   r0!, {r2, sp, lr}               @ store the SYS Mode Registers
-
 	mov     r1, #SVC_MODE|PSR_I_BIT|PSR_F_BIT @ Enter SVC mode, no interrupts
 	msr	cpsr, r1

@@ -209,35 +184,6 @@ sirfsoc_wakeup:

 	add	r0, r0, r1

-	mov     r1, #SYSTEM_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter SYS mode, no interrupts
-	msr     cpsr, r1
-	ldmfd   r0!, {r2, sp, lr}               @ store the SYS Mode Registers
-	msr     spsr, r2
-
-	mov     r1, #UND_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter UND mode, no interrupts
-	msr     cpsr, r1
-	ldmfd   r0!, {r2, sp, lr}               @ store the UND Mode Registers
-	msr     spsr, r2
-
-	mov     r1, #IRQ_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter IRQ mode, no interrupts
-	msr     cpsr, r1
-	ldmfd   r0!, {r2, sp, lr}               @ store the IRQ Mode Registers
-	msr     spsr, r2
-
-	mov     r1, #ABT_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter ABT mode, no interrupts
-	msr     cpsr, r1
-	ldmfd   r0!, {r2, sp, lr}               @ store the ABT Mode Registers
-	msr     spsr, r2
-
-	mov     r1, #FIQ_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter FIQ mode, no interrupts
-	msr     cpsr, r1
-	ldmfd   r0!, {r2, r8-r12,sp, lr}     	@ store the FIQ Mode Registers
-	msr     spsr, r2
-
-
-	mov     r1, #SVC_MODE|PSR_I_BIT|PSR_F_BIT 	@ Enter SVC mode, no interrupts
-	msr	cpsr, r1
-
 	ldr	r1, =sirfsoc_sleep_exit		@ its absolute virtual address
 	ldmfd	r0, {r2 - r10, sp}		@ CP regs + virt stack ptr



and call cpu_init() to re-setup while resuming, things go well.

>
>>
>>> Ok. agree. then the work flow for SiRFprimaII suspend can be:
>>> pm.enter()->
>>> ? ? sirfsoc_cpu_sleep(v:p offset)
>>> ? ? 1. save registers on stack
>>> ? ? 2. load sirfsoc_cpu_resume to r3
>>> ? ? 3. bl cpu_suspend
>>> ? ? 4. make sdram self-refresh
>>> ? ? 5. write force DEEPSLEEP by rtciobrg
>>>
>>> One issue is L2
>>
>> That's why I did not include it in the list of code which could be
>> eliminated.

we actually shutdown the L2 and re-initilized L2 again after resuming.
that required l2x0_init() to be not in __init
section. i remember Colin Cross has sent a patch about that before:
"[PATCH] ARM: mm: cache-l2x0: Add support for re-enabling l2x0"

Thanks
Barry
