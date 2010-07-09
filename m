From: peer@peer-ware.de (peer at peer-ware.de)
Date: Fri, 9 Jul 2010 02:32:30 +0200
Subject: Suspend problem on AT91RM9200
Message-ID: <201007090232.30990.peer@peer-ware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi developers,

i have a strange problem with an AT91RM9200 based target and suspend mode.
What I do is the following (pseudo code):
  
  while (1)
    {
      echo -n standby > /sys/power/state
      Wait for around 400ms();
      Wake it using an I/O pin(). 
    }
(Device is woken up by another MCU which is programmed to do so...)

The problem is that sometimes the target freezes.
Sometimes means any time between one minute and some hours.

Using a JTAG debugger (openocd + galep5D) I can see that the 
kernel (2.6.33 with at91 patches) crashes as following:

<7>platform at91_udc: LATE suspend
<7>atmel_usart atmel_usart.1: LATE suspend, may wakeup
<7>atmel_usart atmel_usart.0: LATE suspend, may wakeup
<6>PM: late suspend of devices complete after 1.739 msecs
<7>GPIO-A may wake for 00000020
<7>GPIO-B may wake for 00080400
<7>AT91: PM - wake mask 0000000c, pm state 1
<1>Unable to handle kernel NULL pointer dereference at virtual address 
00000028
<1>pgd = c1ea4000
<1>[00000028] *pgd=21f1f031, *pte=00000000, *ppte=00000000
<0>Internal error: Oops: 817 [#1]
<0>last sysfs file: /sys/power/state
<4>Modules linked in: wakeup msdos fat at91_mci mmc_block mmc_core [last 
unloaded: at91_udc]
<4>CPU: 0    Not tainted  (2.6.33 #1)
<4>PC is at at91_slow_clock+0xd8/0x130
<4>LR is at try_acquire_console_sem+0x38/0x6c
<4>pc : [<c002d018>]    lr : [<c0041580>]    psr: 60000093
<4>sp : c1e11e94  ip : c1e11de8  fp : c1e11ea8
<4>r10: 00000001  r9 : ffffffea  r8 : 00000009
<4>r7 : c0229d48  r6 : 00000000  r5 : 00000000  r4 : 00000000
<4>r3 : 00000000  r2 : fefff000  r1 : 00000000  r0 : 00000001
<4>Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
<4>Control: c000717f  Table: 21ea4000  DAC: 00000015
<0>Process scTest (pid: 1023, stack limit = 0xc1e10260)
<0>Stack: (0xc1e11e94 to 0xc1e12000)
<0>1e80:", ' ' <repeats 46 times>, "c02f30c8 00000001 c1e11ec4
<0>1ea0: c1e11eac c006aa20 c002cdc8 00000000 00000001 c0229d44 c1e11ee0 
c1e11ec8
<0>1ec0: c006abb8 c006a8f4 c0292908 00000007 c1e57000 c1e11f0c c1e11ee4 
c006a2fc
<0>1ee0: c006aadc c1c2bd20 c1c0fc14 0000000

4(tick_nohz_stop_sched_tick+0x54/0x49c)
<4>[<c00613c0>] (tick_nohz_stop_sched_tick+0x0/0x49c) from [<c00249e8>] 
(cpu_idle+0x28/0xa8)
<4>[<c00249c0>] (cpu_idle+0x0/0xa8) from [<c0225564>] (rest_init+0x58/0x6c)
<4> r4:c02f3450
<4>[<c022550c>] (rest_init+0x0/0x6c) from [<c000895c>] 
(start_kernel+0x28c/0x2f4)
<4>[<c00086d0>] (start_kernel+0x0/0x2f4) from [<20008034>] (0x20008034)
<4> r6:c0020008 r5:c02ebeb8 r4:c0007175
<4>---[ end trace 5e000e684a96473e ]---
<4>", '-' <repeats 12 times>, "[ cut here ]", '-' <repeats 12 times>, "
<4>WARNING: at kernel/time/timekeeping.c:226 getnstimeofday+0x2c/0x15c()
<4>Modules linked in: wakeup msdos fat at91_mci mmc_block mmc_core [last 
unloaded: at91_udc]
<4>Backtrace:
<4>[<c00274a4>] (dump_backtrace+0x0/0x104) from [<c00275c0>] 
(dump_stack+0x18/0x1c)
<4> r7:00000000 r6:c005c120 r5:c0291a68 r4:000000e2
<4>[<c00275a8>] (dump_stack+0x0/0x1c) from [<c0040c68>] 
(warn_slowpath_common+0x4c/0x64)
<4>[<c0040c1c>] (warn_slowpath_common+0x0/0x64) from [<c0040c98>] 
(warn_slowpath_null+0x18/0x1c)
<4> r7:c02f9c90 r6:c02cbf64 r5:c02cf770 r4:c02cbf64
<4>[<c0040c80>] (warn_slowpath_null+0x0/0x1c) from [<c005c120>] 
(getnstimeofday+0x2c/0x15c)
<4>[<c005c0f4>] (getnstimeofday+0x0/0x15c) from [<c005c4cc>] 
(do_gettimeofday+0x1c/0x3c)
<4>[<c005c4b0>] (do_gettimeofday+0x0/0x3c) from [<c002d0d0>] 
(at91_enter_idle+0x30/0xcc)
<4> r4:c02cf708
<4>[<c002d0a0>] (at91_enter_idle+0x0/0xcc) from [<c01a390c>] 
(cpuidle_idle_call+0xb0/0x128)
<4> r6:c02cf708 r5:c02ebe4c r4:c02cf770
<4>[<c01a385c>] (cpuidle_idle_call+0x0/0x128) from [<c0024a2c>] 
(cpu_idle+0x6c/0xa8)
<4> r9:41129200 r8:2001db84 r7:c02cdb88 r6:c002000c r5:c02ebe4c
<4>r4:c02ca000
<4>[<c00249c0>] (cpu_idle+0x0/0xa8) from [<c0225564>] (rest_init+0x58/0x6c)
<4> r4:c02f3450
<4>[<c022550c>] (rest_init+0x0/0x6c) from [<c000895c>] 
(start_kernel+0x28c/0x2f4)
<4>[<c00086d0>] (start_kernel+0x0/0x2f4) from [<20008034>] (0x20008034)
<4> r6:c0020008 r5:c02ebeb8 r4:c0007175
<4>---[ end trace 5e000e684a96473f ]---
.164 msecs
<7>at91_rtc at91_rtc: LATE suspend, may wakeup
<7>at91_mci at91_mci: LATE suspend, may wakeup
<7>at91_spi at91_spi.0: LATE suspend


I realy not understand the value or r1!
Take a look to disassembly.

linux-2.6.33/arch/arm/mach-at91/pm_slowclock.S:

at91_slow_clock()
   // .. //
   0xc002cff4 <+180>:   beq     0xc002d014 <at91_slow_clock+212>
   0xc002cff8 <+184>:   mov     r4, #1000       ; 0x3e8    <- wait pllB lock
   0xc002cffc <+188>:   sub     r4, r4, #1
   0xc002d000 <+192>:   cmp     r4, #0
   0xc002d004 <+196>:   beq     0xc002d014 <at91_slow_clock+212>
   0xc002d008 <+200>:   ldr     r3, [r1, #104]  ; 0x68
   0xc002d00c <+204>:   tst     r3, #4
   0xc002d010 <+208>:   beq     0xc002cffc <at91_slow_clock+188>
   0xc002d014 <+212>:   ldr     r3, [pc, #88]   ; 0xc002d074
   0xc002d018 <+216>:   str     r3, [r1, #40]   ; 0x28      <- here we crash!
   0xc002d01c <+220>:   tst     r3, #16711680   ; 0xff0000
   // .. //

HOW r1 can be 0x00000000 at this address ?! (I have another dump with 
linux-2.6.31-6 + at91 patches where r1 is 0x0000001 at nearly same address.)
r1 should never modified in this sequence. (I'm right ?)



Any suggestions? 
  Any ideas? 
    Wrong dump?

---
Some facts:
  * target AT91RM9200 + 32MB SDRAM (Custom board.)
  * linux 2.6.33 + at91 patches
  * Same results on linux-2.6.31.6 + at91 patches
  * gcc-3.3
  * gdb 7.1 for arm
  * JTAG debugger: openocd+Galep 5D


Regards and thanks in advance,
  Peer Georgi.
