From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 02 Nov 2009 17:47:57 +0100
Subject: kernel BUG at kernel/posix-cpu-timers.c:1389!
In-Reply-To: <f17812d70910310732o5568a183i2504d2d926a95df1@mail.gmail.com>
References: <3972542e0910300953s725bebd0ua5a0d1db557d408a@mail.gmail.com>
	<f17812d70910310732o5568a183i2504d2d926a95df1@mail.gmail.com>
Message-ID: <4AEF0D3D.4070708@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao :
> On Sat, Oct 31, 2009 at 12:53 AM, E Robertson <e.robertson.svg@gmail.com> wrote:
>> Hi, I've recently migrated some code to 2.6.31 on a sam9263 board and
>> notice this on
>> several occasions. I thought it might be a serial driver port issue
>> since I haven't seen anyone with
>> this problem before, but  that doesn't seem to be the culprit.
>> Is this is known kernel bug?
> 
> Looks like this run_posix_cpu_timers() is called with IRQ enabled, I'd
> suggest you take a look into your arch/arm/mach-xxx/time.c to see if
> your timer irq_action->flags is written with IRQF_DISABLED there.

in arch/arm/mach-at91/at91sam926x_time.c +125
 .flags = IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,

IRQF_DISABLED is positionned. But on the other hand, I saw in the kernel
booting messages that:
"IRQ 1/rtc0: IRQF_DISABLED is not guaranteed on shared IRQs"

What does this mean ? what is the difference with former way of managing
shared interrupts ?

And above all, what is the proper way to set an IRQ on a shared
interrupt line ?

>> kernel BUG at kernel/posix-cpu-timers.c:1389!
>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> pgd = c1d34000
>> [00000000] *pgd=21fad031, *pte=00000000, *ppte=00000000
>> Internal error: Oops: 817 [#1]
>> CPU: 0    Not tainted  (2.6.31.5 #5)
>> PC is at __bug+0x20/0x2c
>> LR is at release_console_sem+0x1b0/0x1e4
>> pc : [<c00da2a0>]    lr : [<c00ece48>]    psr: 60000013
>> sp : c1d2be7c  ip : c1d2bdb4  fp : c1d2be88
>> r10: 4004e108  r9 : c1d2a000  r8 : c030a904
>> r7 : c031f8fc  r6 : c031f900  r5 : c1c89380  r4 : 00000001
>> r3 : 00000000  r2 : c030c0fc  r1 : 00016348  r0 : 00000034
>> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>> Control: 0005317f  Table: 21d34000  DAC: 00000015
>> Process TEST (pid: 386, stack limit = 0xc1d2a260)
>> Stack: (0xc1d2be7c to 0xc1d2c000)
>> be60:                                                                c1d2bed0
>> be80: c1d2be8c c0100738 c00da290 c1d2beb4 c1d2be9c c00e9c58 c00e6ca0 c030bbf0
>> bea0: c1d2bea0 c1d2bea0 00000001 c1c89380 c031f900 c031f8fc c030a904 c1d2a000
>> bec0: 4004e108 c1d2bee8 c1d2bed4 c00f5cdc c0100710 0000000a c0325890 c1d2bf00
>> bee0: c1d2beec c0108e84 c00f5c94 00000001 c030a904 c1d2bf38 c1d2bf04 c0108ec0
>> bf00: c0108e00 c1c884c0 beb8fa54 c1d2bf80 00000001 c030a904 c031f900 c031f8fc
>> bf20: 00000000 c1d2a000 4004e108 c1d2bf58 c1d2bf3c c00df16c c0108eb4 c030a8d8
>> bf40: 00000001 00000001 00000000 c1d2bf7c c1d2bf5c c010df28 c00df120 c030ddec
>> bf60: 00000001 00000001 000007f0 ffffffff c1d2bf94 c1d2bf80 c010fdd4 c010def0
>> bf80: 00000001 00000000 c1d2bfac c1d2bf98 c00d6070 c010fd10 ffffffff fefff000
>> bfa0: 00000000 c1d2bfb0 c00d6be4 c00d6010 ffffffff 0003fa10 00000000 0000000b
>> bfc0: 00000000 beb8faa8 00000000 000007f0 ffffffff 00000004 4004e108 00014edc
>> bfe0: 4004e528 beb8fa9c 4003840c 40037534 80000010 ffffffff f507a7b8 c87e873f
>> Backtrace:
>> [<c00da280>] (__bug+0x0/0x2c) from [<c0100738>] (run_posix_cpu_timers+0x38/0x79
>> c)
>> [<c0100700>] (run_posix_cpu_timers+0x0/0x79c) from [<c00f5cdc>] (update_process
>> _times+0x58/0x5c)
>> [<c00f5c84>] (update_process_times+0x0/0x5c) from [<c0108e84>] (tick_periodic+0
>> x94/0xb4)
>>  r5:c0325890 r4:0000000a
>> [<c0108df0>] (tick_periodic+0x0/0xb4) from [<c0108ec0>] (tick_handle_periodic+0
>> x1c/0xf4)
>>  r5:c030a904 r4:00000001
>> [<c0108ea4>] (tick_handle_periodic+0x0/0xf4) from [<c00df16c>] (at91sam926x_pit
>> _interrupt+0x5c/0x80)
>> [<c00df110>] (at91sam926x_pit_interrupt+0x0/0x80) from [<c010df28>] (handle_IRQ
>> _event+0x48/0x114)
>>  r7:00000000 r6:00000001 r5:00000001 r4:c030a8d8
>> [<c010dee0>] (handle_IRQ_event+0x0/0x114) from [<c010fdd4>] (handle_level_irq+0
>> xd4/0xec)
>>  r8:ffffffff r7:000007f0 r6:00000001 r5:00000001 r4:c030ddec
>> [<c010fd00>] (handle_level_irq+0x0/0xec) from [<c00d6070>] (asm_do_IRQ+0x70/0x9
>> 8)
>>  r5:00000000 r4:00000001
>> [<c00d6000>] (asm_do_IRQ+0x0/0x98) from [<c00d6be4>] (__irq_usr+0x44/0x80)
>> Exception stack(0xc1d2bfb0 to 0xc1d2bff8)
>> bfa0:                                     ffffffff 0003fa10 00000000 0000000b
>> bfc0: 00000000 beb8faa8 00000000 000007f0 ffffffff 00000004 4004e108 00014edc
>> bfe0: 4004e528 beb8fa9c 4003840c 40037534 80000010 ffffffff
>>  r5:fefff000 r4:ffffffff
>> Code: e1a01000 e59f000c eb004c80 e3a03000 (e5833000)
>> Kernel panic - not syncing: Fatal exception in interrupt
>> Backtrace:
>> [<c00da54c>] (dump_backtrace+0x0/0x10c) from [<c00da68c>] (dump_stack+0x18/0x1c
>> )
>>  r6:c1d2be34 r5:c031fa70 r4:c1c89380
>> [<c00da674>] (dump_stack+0x0/0x1c) from [<c00ec678>] (panic+0x4c/0x12c)
>> [<c00ec62c>] (panic+0x0/0x12c) from [<c00da7dc>] (die+0x12c/0x158)
>>  r3:00010000 r2:00000080 r1:c031fe98 r0:c02e0e08
>> [<c00da6b0>] (die+0x0/0x158) from [<c00dbd54>] (__do_kernel_fault+0x6c/0x7c)
>> [<c00dbce8>] (__do_kernel_fault+0x0/0x7c) from [<c00dbf88>] (do_page_fault+0x22
>> 4/0x244)
>>  r7:c1d2be34 r6:c1c89380 r5:c0309d10 r4:ffffffff
>> [<c00dbd64>] (do_page_fault+0x0/0x244) from [<c00d623c>] (do_DataAbort+0x3c/0xa
>> 0)
>> [<c00d6200>] (do_DataAbort+0x0/0xa0) from [<c00d69e0>] (__dabt_svc+0x40/0x60)
>> Exception stack(0xc1d2be34 to 0xc1d2be7c)
>> be20:                                              00000034 00016348 c030c0fc
>> be40: 00000000 00000001 c1c89380 c031f900 c031f8fc c030a904 c1d2a000 4004e108
>> be60: c1d2be88 c1d2bdb4 c1d2be7c c00ece48 c00da2a0 60000013 ffffffff
>>  r8:c030a904 r7:c031f8fc r6:c031f900 r5:c1d2be68 r4:ffffffff
>> [<c00da280>] (__bug+0x0/0x2c) from [<c0100738>] (run_posix_cpu_timers+0x38/0x79
>> c)
>> [<c0100700>] (run_posix_cpu_timers+0x0/0x79c) from [<c00f5cdc>] (update_process
>> _times+0x58/0x5c)
>> [<c00f5c84>] (update_process_times+0x0/0x5c) from [<c0108e84>] (tick_periodic+0
>> x94/0xb4)
>>  r5:c0325890 r4:0000000a
>> [<c0108df0>] (tick_periodic+0x0/0xb4) from [<c0108ec0>] (tick_handle_periodic+0
>> x1c/0xf4)
>>  r5:c030a904 r4:00000001
>> [<c0108ea4>] (tick_handle_periodic+0x0/0xf4) from [<c00df16c>] (at91sam926x_pit
>> _interrupt+0x5c/0x80)
>> [<c00df110>] (at91sam926x_pit_interrupt+0x0/0x80) from [<c010df28>] (handle_IRQ
>> _event+0x48/0x114)
>>  r7:00000000 r6:00000001 r5:00000001 r4:c030a8d8
>> [<c010dee0>] (handle_IRQ_event+0x0/0x114) from [<c010fdd4>] (handle_level_irq+0
>> xd4/0xec)
>>  r8:ffffffff r7:000007f0 r6:00000001 r5:00000001 r4:c030ddec
>> [<c010fd00>] (handle_level_irq+0x0/0xec) from [<c00d6070>] (asm_do_IRQ+0x70/0x9
>> 8)
>>  r5:00000000 r4:00000001
>> [<c00d6000>] (asm_do_IRQ+0x0/0x98) from [<c00d6be4>] (__irq_usr+0x44/0x80)
>> Exception stack(0xc1d2bfb0 to 0xc1d2bff8)
>> bfa0:                                     ffffffff 0003fa10 00000000 0000000b
>> bfc0: 00000000 beb8faa8 00000000 000007f0 ffffffff 00000004 4004e108 00014edc
>> bfe0: 4004e528 beb8fa9c 4003840c 40037534 80000010 ffffffff
>>  r5:fefff000 r4:ffffffff
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Nicolas Ferre
