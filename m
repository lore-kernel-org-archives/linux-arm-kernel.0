From: e.robertson.svg@gmail.com (E Robertson)
Date: Thu, 5 Nov 2009 11:07:41 -0600
Subject: kernel BUG at kernel/posix-cpu-timers.c:1389!
In-Reply-To: <20091102165441.GE5785@n2100.arm.linux.org.uk>
References: <3972542e0910300953s725bebd0ua5a0d1db557d408a@mail.gmail.com>
	<f17812d70910310732o5568a183i2504d2d926a95df1@mail.gmail.com>
	<4AEF0D3D.4070708@atmel.com>
	<20091102165441.GE5785@n2100.arm.linux.org.uk>
Message-ID: <3972542e0911050907y37f7112frdcb6354313d40c2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 2, 2009 at 10:54 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 02, 2009 at 05:47:57PM +0100, Nicolas Ferre wrote:
>> in arch/arm/mach-at91/at91sam926x_time.c +125
>> ?.flags = IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
>>
>> IRQF_DISABLED is positionned. But on the other hand, I saw in the kernel
>> booting messages that:
>> "IRQ 1/rtc0: IRQF_DISABLED is not guaranteed on shared IRQs"
>>
>> What does this mean ? what is the difference with former way of managing
>> shared interrupts ?
>
> If the first IRQ action which is run was registered without IRQF_DISABLED
> the entire set will be run without interrupts disabled.
>
>> And above all, what is the proper way to set an IRQ on a shared
>> interrupt line ?
>
> The only real solution is to ensure that all requesters use IRQF_DISABLED.
>

I don't see where this could be the cause of this problem. The bug
happens after the system is running and I attempt to use the select
method for polling (serial port & uevents).  Without this the bug [
BUG_ON(!irqs_disabled()); ]  did not occur.  I added the flag to the
requesters but that did not help, maybe I overlooked something.

I notice this change from 2.6.18 but didn't follow why the change.

 --- linux-2.6.31/arch/arm/mach-at91/at91sam926x_time.c	2009-11-05
09:34:49.000000000 -0600
+++ linux-2.6.28/arch/arm/mach-at91/at91sam926x_time.c	2009-02-06
15:47:45.000000000 -0600
@@ -31,7 +31,7 @@
  * Clocksource:  just a monotonic counter of MCK/16 cycles.
  * We don't care whether or not PIT irqs are enabled.
  */
-static cycle_t read_pit_clk(struct clocksource *cs)
+static cycle_t read_pit_clk(void)
 {
 	unsigned long flags;
 	u32 elapsed;
@@ -91,6 +91,7 @@
 	.features	= CLOCK_EVT_FEAT_PERIODIC,
 	.shift		= 32,
 	.rating		= 100,
+	.cpumask	= CPU_MASK_CPU0,
 	.set_mode	= pit_clkevt_mode,
 };

@@ -172,7 +173,6 @@

 	/* Set up and register clockevents */
 	pit_clkevt.mult = div_sc(pit_rate, NSEC_PER_SEC, pit_clkevt.shift);
-	pit_clkevt.cpumask = cpumask_of(0);
 	clockevents_register_device(&pit_clkevt);
 }


kernel BUG at kernel/posix-cpu-timers.c:1389!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c1d60000
[00000000] *pgd=21c81031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
CPU: 0    Not tainted  (2.6.31.5 #17)
PC is at __bug+0x20/0x2c
LR is at release_console_sem+0x1a4/0x1d8
pc : [<c00da230>]    lr : [<c00edc1c>]    psr: 60000013
sp : c1de3e54  ip : c1de3d94  fp : c1de3e60
r10: c1de3e78  r9 : c1de2000  r8 : c0312954
r7 : 00000000  r6 : c1c506a0  r5 : c1c506a0  r4 : 00000001
r3 : 00000000  r2 : 60000013  r1 : 0001c1b0  r0 : 00000034
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 21d60000  DAC: 00000015
...
[<c00da3a8>] (__bug+0x0/0x2c) from [<c0105444>] (run_posix_cpu_timers+0x34/0x88
4)
[<c0105410>] (run_posix_cpu_timers+0x0/0x884) from [<c00f8a24>] (update_process
_times+0x5c/0x60)
[<c00f89c8>] (update_process_times+0x0/0x60) from [<c010dafc>] (tick_periodic+0
xb8/0xdc)
 r6:00000001 r5:c0345790 r4:00000000
[<c010da44>] (tick_periodic+0x0/0xdc) from [<c010db40>] (tick_handle_periodic+0
x20/0xd0)
 r5:c032a954 r4:00000001
[<c010db20>] (tick_handle_periodic+0x0/0xd0) from [<c00dfaf0>] (at91sam926x_pit
_interrupt+0x60/0x90)
[<c00dfa90>] (at91sam926x_pit_interrupt+0x0/0x90) from [<c0113ba8>] (handle_IRQ
_event+0x44/0x10c)
 r5:00000001 r4:c032a99c
[<c0113b64>] (handle_IRQ_event+0x0/0x10c) from [<c011582c>] (handle_level_irq+0
xc4/0x13c)
 r8:00000000 r7:c032a99c r6:00000000 r5:00000001 r4:c032e034
[<c0115768>] (handle_level_irq+0x0/0x13c) from [<c00d606c>] (asm_do_IRQ+0x6c/0x
9c)
 r7:00000001 r6:00000000 r5:c0333e58 r4:00000001
[<c00d6000>] (asm_do_IRQ+0x0/0x9c) from [<c00d6a5c>] (__irq_svc+0x3c/0x80)
Exception stack(0xc1ce5f60 to 0xc1ce5fa8)
5f60: 00000006 beebaaa8 00000000 00000000 beebaaa0 beebaaa8 00000005 0000008e
5f80: c00d6fe4 c1ce4000 4004e108 00000000 00000000 c1ce5fa8 c00d6e40 c014bc68
5fa0: 80000013 ffffffff
 r6:00000001 r5:fefff000 r4:ffffffff
