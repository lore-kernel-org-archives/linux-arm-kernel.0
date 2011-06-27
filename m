From: teawater@gmail.com (Hui Zhu)
Date: Mon, 27 Jun 2011 22:11:05 +0800
Subject: Problem with GDB when debugging IRQ handlers
In-Reply-To: <4E088DE1.2060809@gmail.com>
References: <20110627125306.GA30646@doriath.ww600.siemens.net>
	<20110627132735.GE16103@n2100.arm.linux.org.uk>
	<4E088DE1.2060809@gmail.com>
Message-ID: <BANLkTin1qv4+W2yrJQgKQSBUWKQGJsnWUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If I remember is right, kernel didn't supply enough debug info in
entry-armv.S.  So GDB cannot got enough debug info, then got some
frame parse bug inside it.

I think add some cfi
code(http://sourceware.org/binutils/docs/as/CFI-directives.html) like
x86 entry did can handle this issue.

Thanks,
Hui

On Mon, Jun 27, 2011 at 22:04, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Hello,
>
> On 27.06.2011 17:27, Russell King - ARM Linux wrote:
>>
>> On Mon, Jun 27, 2011 at 04:53:06PM +0400, Dmitry Eremin-Solenikov wrote:
>>>
>>> I've got into a problem when trying to debug irq handlers on PXA (in
>>> qemu). backtrace is really strange from my POV (a target is just a qemu
>>> running a bit modified 3.0-rc2 kernel):
>>
>> ...
>>>
>>> Breakpoint 1, handle_level_irq (irq=42, desc=0xc3e06000) at
>>> kernel/irq/chip.c:329
>>> 329 ? ? ? ? ? ? mask_ack_irq(desc);
>>> (gdb) bt
>>> #0 ?handle_level_irq (irq=42, desc=0xc3e06000) at kernel/irq/chip.c:329
>>> #1 ?0xc0085f64 in generic_handle_irq_desc (irq=42) at
>>> include/linux/irqdesc.h:111
>>> #2 ?generic_handle_irq (irq=42) at kernel/irq/irqdesc.c:304
>>> #3 ?0xc0033060 in asm_do_IRQ (irq=42, regs=<value optimized out>) at
>>> arch/arm/kernel/irq.c:90
>>> #4 ?0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #5 ?0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #6 ?0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #7 ?0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #8 ?0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #9 ?0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #10 0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #11 0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>> #12 0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
>>>
>>> ... and so on it continues ad infinitum. Is it the expected behaviour?
>>> Because I'm pretty much sure that this isn't a desired behaviour.
>>
>> My guess is that gdb is trying to unwind using the unwind information.
>> However, I don't think we actually give the assembler the full information
>> to be able to unwind this. ?I've no idea how to solve this as I'm no
>> expert at the debug info.
>>
>> We _really_ _do_ want to unwind through this so that we can see the
>> parent kernel context information in backtraces - and the fact that
>> the kernel itself can unwind through these means we can't tell the
>> unwinder not to.
>>
>> So, no idea. ?I think you need someone who knows debug info to sort
>> this one out.
>
> Adding gdb ML to cc in the hope to get any assistance.
>
> --
> With best wishes
> Dmitry
>
>
