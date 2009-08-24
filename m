From: marco.hoefle@nanotronic.ch (hoefle marco)
Date: Mon, 24 Aug 2009 11:59:32 +0200
Subject: i.MX35 Kernel without ARM EABI support cannot execute init
Message-ID: <1251107972.4782.123.camel@wks02-lin.nanotronic.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> I have an issue with the ARM EABI kernel option.
>> right now we have two ARM boards and two embedded linux distributions
>> (Emdebian and OSELAS). The CPUs are PXA270 and Freescale i.MX35.
>> The aim is to have emdebian on both boards.
>> When trying to boot the i.MX35 Kernel (with ARM EABI or without, the
>> kernel panic remains exactly the same) using the emdebian rootfs I
>> get this:
>>
>> Kernel panic - not syncing: Attempted to kill init!
>> Backtrace:
>> [<c0026430>] (dump_backtrace+0x0/0x10c) from [<c02515dc>] (dump_stack
>> +0x18/0x1c)
>>  r7:c7817f54 r6:c7813c40 r5:c7813c40 r4:00000004
>> [<c02515c4>] (dump_stack+0x0/0x1c) from [<c025161c>] (panic+
>> 0x3c/0x110)
>> [<c02515e0>] (panic+0x0/0x110) from [<c0034a14>] (do_exit+0x6c/0x5b8)
>>  r3:c0301bd4 r2:c7813c40 r1:c7817d14 r0:c02b478a
>> [<c00349a8>] (do_exit+0x0/0x5b8) from [<c0034fe0>] (do_group_exit
>> +0x80/0xb4)
>> [<c0034f60>] (do_group_exit+0x0/0xb4) from [<c003ea60>]
>> (get_signal_to_deliver+0x2c0/0x2f0)
>>  r4:00000004
>> [<c003e7a0>] (get_signal_to_deliver+0x0/0x2f0) from [<c0024ecc>]
>> (do_signal+0x58/0x4e4)
>> [<c0024e74>] (do_signal+0x0/0x4e4) from [<c0025384>] >> 
>> (do_notify_resume
>> +0x2c/0x30)
>> [<c0025358>] (do_notify_resume+0x0/0x30) from [<c0022dac>] 
>> (work_pending
>> +0x1c/0x20)
>>
>> The PXA270 kernel (same settings except ARM system type and ARM EABI
>> disabled) boots the emdebian root file-system successfully.
>>
>> The i.MX35 Kernel boots with ARM EABI support the OSELAS file-system.
>> Both Kernels are version 2.6.30.4 and were compiled with the same
>> arm-linux-gnu-gcc compiler.
>>
>> From my understanding it should be possible to use the same root
>> file-system on both CPUs.
>>
>> Has anybody an idea why this is not working?

> Curious.  I'm having the same issue on a ep93xx system.

> I switched from an OABI toolchain to an EABI one a while back. 
> Everything
> was working fine but I realized that my rootfs was still built with
> the older OABI toolchain.  So I nuked the rootfs and re-built 
> everything.

> Now the kernel boots fine but it hangs with the same Kernel panic you
> are seeing.

> In my case I think it's an issue with the external toolchain support
> in buildroot.  The toolchain I am using (CodeSourcery 2009q1-203) is
> a multilib toolchain and needs the -march=armv4t option to use the
> correct instructions for the architecture.  It also needs this option
> to correctly identify the directory location for the libraries.

> I have been able to staticlly compile a test init and replaced the
> one in my rootfs.  Doing that I don't get the Kernel panic so I think
> I'm on the right track to finding a fix.

Emdebian builds the root filesystem from pre-built packages for ARM. So
init is part of the busybox package emdebian crush is using.
But the thing is that the same init works for the pxa270 but not for the
freescale i.mx35.
I will try to cross-compile a test init as you did with the toolchain
with and without EABI. 
Using the options "Use the ARM EABI to compile the kernel" + "Allow old
ABI binaries to run with this kernel" should allow to run init compiled
with the EABI toolchain and with the old arm toolchain.  


> Are you also using buildroot?  Could your problem be similar?
No, but the problem might be similar.

> I have cc'ed the buildroot list and Thomas Petrazzoni just in case
> your issue is the same.
