From: yao@codesourcery.com (Yao Qi)
Date: Mon, 27 Jun 2011 22:58:59 +0800
Subject: Problem with GDB when debugging IRQ handlers
In-Reply-To: <4E088DE1.2060809@gmail.com>
References: <20110627125306.GA30646@doriath.ww600.siemens.net>
	<20110627132735.GE16103@n2100.arm.linux.org.uk>
	<4E088DE1.2060809@gmail.com>
Message-ID: <4E089AB3.1090801@codesourcery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2011 10:04 PM, Dmitry Eremin-Solenikov wrote:
> Hello,
> 
> On 27.06.2011 17:27, Russell King - ARM Linux wrote:
>> On Mon, Jun 27, 2011 at 04:53:06PM +0400, Dmitry Eremin-Solenikov wrote:
>>> I've got into a problem when trying to debug irq handlers on PXA (in
>>> qemu). backtrace is really strange from my POV (a target is just a qemu
>>> running a bit modified 3.0-rc2 kernel):
>> ...
>>> Breakpoint 1, handle_level_irq (irq=42, desc=0xc3e06000) at
>>> kernel/irq/chip.c:329
>>> 329        mask_ack_irq(desc);
>>> (gdb) bt
>>> #0  handle_level_irq (irq=42, desc=0xc3e06000) at kernel/irq/chip.c:329
>>> #1  0xc0085f64 in generic_handle_irq_desc (irq=42) at
>>> include/linux/irqdesc.h:111
>>> #2  generic_handle_irq (irq=42) at kernel/irq/irqdesc.c:304
>>> #3  0xc0033060 in asm_do_IRQ (irq=42, regs=<value optimized out>) at
>>> arch/arm/kernel/irq.c:90
>>> #4  0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #5  0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #6  0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #7  0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #8  0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #9  0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #10 0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #11 0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #12 0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>>
>>> ... and so on it continues ad infinitum. Is it the expected behaviour?
>>> Because I'm pretty much sure that this isn't a desired behaviour.
>>

Usually, if debugging information is not there, GDB will try to unwind
stacks by analyzing function's prologue.  It looks arm prologue analyzer
goes into an endless loop, because of (I guess) the irregular register
usage in low-level kernel asm code.

arm/gdb's prologue analyzer can handle common code, but I am afraid it
is unable to handle kernel-specific code, unless we make gdb
kernel-aware.  At least, we may teach gdb to stop at __irq_svc.

Please file a bug report against gdb, and post the disassembly of
__irq_svc in bug report.

>> We _really_ _do_ want to unwind through this so that we can see the
>> parent kernel context information in backtraces - and the fact that

I am not sure GDB is able to unwind stacks across processes (from child
to parent).

-- 
Yao (??)
