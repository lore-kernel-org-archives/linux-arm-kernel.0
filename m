From: nickpelling@nanodome.com (Nick Pelling)
Date: Tue, 12 Apr 2011 22:51:03 +0100
Subject: SDHCI pre-rootfs kernel oops problem...?
In-Reply-To: <1302641854.14216.77.camel@dev.znau.edu.ua>
References: <1302566227-23788-1-git-send-email-zajec5@gmail.com>
	<20110412133633.GR15130@legolas.emea.dhcp.ti.com>
	<1302634039.14216.10.camel@dev.znau.edu.ua>
	<BANLkTi=0sM2+nPYyd09G=Uy9rcEvaFErnA@mail.gmail.com>
	<1302635550.14216.21.camel@dev.znau.edu.ua>
	<BANLkTi=8mB9ZDTjF4yds6mkx+PmM+B_6Cg@mail.gmail.com>
	<4DA4AC4B.90409@hauke-m.de>
	<BANLkTiknRYWaDM1ThAxgXcdGqK8jeFaBPA@mail.gmail.com>
	<BANLkTikqKtJuDS17mfFvxzMoXuBtJvCgTA@mail.gmail.com>
	<1302640546.14216.65.camel@dev.znau.edu.ua>
	<BANLkTim8dmTL-BVK3fcWHNBU9Eyz1k_T+Q@mail.gmail.com>
	<1302641854.14216.77.camel@dev.znau.edu.ua>
Message-ID: <9eqkdg$ade0uu@out1.ip01ir2.opaltelecom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

My Samsung S5PC100 target bootstraps zImage from a MicroSD card, but 
then kernel oopses if an mmc error happens just before the rootfs is 
mounted. Specifically, the output I'm getting looks like this:-

1	sdhci: Secure Digital Host Controller Interface driver
2	sdhci: Copyright(c) Pierre Ossman
3	s3c-sdhci s3c-sdhci.0: clock source 0: hsmmc (133500000 Hz)
4	s3c-sdhci s3c-sdhci.0: clock source 2: sclk_mmc (66750000 Hz)
5	mmc0: SDHCI controller on samsung-hsmmc [s3c-sdhci.0] using ADMA
6	Unable to handle kernel NULL pointer dereference at virtual address 00000000
7	pgd = c0004000
8	[00000000] *pgd=00000000
9	Internal error: Oops: 5 [#1]
10	(--etc--)

The precise sequence of events that triggers the problem seems to be:-
* sdhci_drv_init() is being called and is executing OK (lines 1-2 above)
* the sdhci clocks are being set up OK (lines 3-4 above)
* sdhci_add_host() is being called and is executing OK (line 5 above)
* sdhci_irq() gets triggered with SDHCI_INT_CMD_MASK (i.e. a command 
has arrived)
* sdhci_irq() calls sdhci_cmd_irq() to handle the command
* sdhci_cmd_irq() notices that there's a SDHCI_INT_TIMEOUT (i.e. a 
timeout error)
* sdhci_cmd_irq() schedules tasklet to call sdhci_tasklet_finish() later
* sdhci_cmd_irq() exits OK
* sdhci_irq() exits OK
* the kernel immediately crashes (lines 6-9 etc)
* curiously, sdhci_tasklet_finish() is not getting called at all.

This is on 2.6.38.1, but happened on previous builds too (I only 
today managed to isolate the problem). My best current guess is that 
this is happening because the bootstrap loader loads the kernel from 
the mmc card, and then not all the SDHCI / MMC registers in the SoC 
are getting cleared before the SDHCI is reinitialized for the kernel 
booting several seconds later (hence the timeout error bit being set, 
perhaps spuriously?)

Is this perhaps a known problem with other Samsung SDHCI drivers when 
booting from mmc? If so, what were the workarounds for them?

Any suggestions and pointers much appreciated!

Cheers, ....Nick Pelling....

PS: remainder of crash output appended below...

				* * * * * * *

last sysfs file:
CPU: 0    Not tainted  (2.6.38.1 #69)
PC is at try_to_wake_up+0x20/0xa0
LR is at task_rq_lock.clone.89+0x20/0x2c
pc : [<c002f22c>]    lr : [<c002f200>]    psr: 20000193
sp : c0259ed0  ip : 00003f00  fp : c0259ef4
r10: 00000000  r9 : 412fc081  r8 : 0000000f
r7 : 00000000  r6 : 00000001  r5 : 00000001  r4 : 00000000
r3 : 00000001  r2 : 0000000f  r1 : c02621a8  r0 : c02621a8
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 20004019  DAC: 00000015
Process swapper (pid: 0, stack limit = 0xc0258268)
Stack: (0xc0259ed0 to 0xc025a000)
9ec0:                                     412fc081 60000193 c78c7e28 c78c7c00
9ee0: 00000001 00000001 c78c7e28 00018101 00000000 c01c8404 00000000 00000001
9f00: 00000000 00000000 00000001 c7826c00 c0297300 c01d3600 00000000 c7862580
9f20: 00000000 00000000 0000005a 2001ba90 412fc081 00000000 00000000 c0059ac0
9f40: 00000001 c0266c68 c0266ca8 0000005a c7862580 c005b6c4 0000005a 00000000
9f60: 00000005 c025c000 2001ba90 c001f070 60000013 ffffffff f6000000 c001f9b4
9f80: c0269d30 00000000 c0259fc8 00000000 c025a16c c001d09c c03abd00 c025c000
9fa0: 2001ba90 412fc081 00000000 00000000 c7836044 c0259fc8 c002a8d0 c002a8d4
9fc0: 60000013 ffffffff c002a8b0 c0020f7c 00000000 c00089ac c000843c 00000cb0
9fe0: 20000100 c001d09c 10c53c7d c025a0c0 c001d098 20008034 00000000 00000000
[<c002f22c>] (try_to_wake_up+0x20/0xa0) from [<c01c8404>] 
(sdhci_irq+0x584/0x5d4)
[<c01c8404>] (sdhci_irq+0x584/0x5d4) from [<c0059ac0>] 
(handle_IRQ_event+0x24/0xe0)
[<c0059ac0>] (handle_IRQ_event+0x24/0xe0) from [<c005b6c4>] 
(handle_level_irq+0xbc/0x13c)
[<c005b6c4>] (handle_level_irq+0xbc/0x13c) from [<c001f070>] 
(asm_do_IRQ+0x70/0x94)
[<c001f070>] (asm_do_IRQ+0x70/0x94) from [<c001f9b4>] (__irq_svc+0x34/0xa0)
Exception stack(0xc0259f80 to 0xc0259fc8)
9f80: c0269d30 00000000 c0259fc8 00000000 c025a16c c001d09c c03abd00 c025c000
9fa0: 2001ba90 412fc081 00000000 00000000 c7836044 c0259fc8 c002a8d0 c002a8d4
9fc0: 60000013 ffffffff
[<c001f9b4>] (__irq_svc+0x34/0xa0) from [<c002a8d4>] (s5pc100_idle+0x24/0x28)
[<c002a8d4>] (s5pc100_idle+0x24/0x28) from [<c0020f7c>] (cpu_idle+0x34/0x7c)
[<c0020f7c>] (cpu_idle+0x34/0x7c) from [<c00089ac>] (start_kernel+0x254/0x2a8)
[<c00089ac>] (start_kernel+0x254/0x2a8) from [<20008034>] (0x20008034)
Code: e1a08001 e1a07002 e24b0020 ebffffec (e5945000)


Then, about two seconds later, the following gets printk()ed - I'm 
not sure if it's connected or just a crash from an already crashed 
system, but here it is anyway:-


BUG: spinlock lockup on CPU#0, swapper/0, c02621a8
[<c0024c4c>] (unwind_backtrace+0x0/0xe0) from [<c0144b24>] 
(do_raw_spin_lock+0x10c/0x148)
[<c0144b24>] (do_raw_spin_lock+0x10c/0x148) from [<c0032304>] 
(scheduler_tick+0x18/0x188)
[<c0032304>] (scheduler_tick+0x18/0x188) from [<c003f804>] 
(update_process_times+0x3c/0x48)
[<c003f804>] (update_process_times+0x3c/0x48) from [<c002b4cc>] 
(s3c2410_timer_interrupt+0x8/0x10)
[<c002b4cc>] (s3c2410_timer_interrupt+0x8/0x10) from [<c0059ac0>] 
(handle_IRQ_event+0x24/0xe0)
[<c0059ac0>] (handle_IRQ_event+0x24/0xe0) from [<c005b6c4>] 
(handle_level_irq+0xbc/0x13c)
[<c005b6c4>] (handle_level_irq+0xbc/0x13c) from [<c002c5dc>] 
(s3c_irq_demux_vic_timer+0x20/0x24)
[<c002c5dc>] (s3c_irq_demux_vic_timer+0x20/0x24) from [<c001f070>] 
(asm_do_IRQ+0x70/0x94)
[<c001f070>] (asm_do_IRQ+0x70/0x94) from [<c001f9b4>] (__irq_svc+0x34/0xa0)
Exception stack(0xc0259d38 to 0xc0259d80)
9d20:                                                       c025c1f4 c0276c8c
9d40: c025b310 00000001 c0259e88 c025b310 c0258268 00000000 00000005 00000001
9d60: 00000000 c0259ef4 00003f00 c0259d80 c01d3600 c01d3604 60000113 ffffffff
[<c001f9b4>] (__irq_svc+0x34/0xa0) from [<c01d3604>] 
(_raw_spin_unlock_irq+0xc/0x10)
[<c01d3604>] (_raw_spin_unlock_irq+0xc/0x10) from [<c0023680>] 
(die+0x138/0x1b8)
[<c0023680>] (die+0x138/0x1b8) from [<c0025bfc>] (__do_kernel_fault+0x64/0x84)
[<c0025bfc>] (__do_kernel_fault+0x64/0x84) from [<c0025de4>] 
(do_page_fault+0x1c8/0x1e0)
[<c0025de4>] (do_page_fault+0x1c8/0x1e0) from [<c001f23c>] 
(do_DataAbort+0x30/0x98)
[<c001f23c>] (do_DataAbort+0x30/0x98) from [<c001f96c>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc0259e88 to 0xc0259ed0)
9e80:                   c02621a8 c02621a8 0000000f 00000001 00000000 00000001
9ea0: 00000001 00000000 0000000f 412fc081 00000000 c0259ef4 00003f00 c0259ed0
9ec0: c002f200 c002f22c 20000193 ffffffff
[<c001f96c>] (__dabt_svc+0x4c/0x60) from [<c002f22c>] 
(try_to_wake_up+0x20/0xa0)
[<c002f22c>] (try_to_wake_up+0x20/0xa0) from [<c01c8404>] 
(sdhci_irq+0x584/0x5d4)
[<c01c8404>] (sdhci_irq+0x584/0x5d4) from [<c0059ac0>] 
(handle_IRQ_event+0x24/0xe0)
[<c0059ac0>] (handle_IRQ_event+0x24/0xe0) from [<c005b6c4>] 
(handle_level_irq+0xbc/0x13c)
[<c005b6c4>] (handle_level_irq+0xbc/0x13c) from [<c001f070>] 
(asm_do_IRQ+0x70/0x94)
[<c001f070>] (asm_do_IRQ+0x70/0x94) from [<c001f9b4>] (__irq_svc+0x34/0xa0)
Exception stack(0xc0259f80 to 0xc0259fc8)
9f80: c0269d30 00000000 c0259fc8 00000000 c025a16c c001d09c c03abd00 c025c000
9fa0: 2001ba90 412fc081 00000000 00000000 c7836044 c0259fc8 c002a8d0 c002a8d4
9fc0: 60000013 ffffffff
[<c001f9b4>] (__irq_svc+0x34/0xa0) from [<c002a8d4>] (s5pc100_idle+0x24/0x28)
[<c002a8d4>] (s5pc100_idle+0x24/0x28) from [<c0020f7c>] (cpu_idle+0x34/0x7c)
[<c0020f7c>] (cpu_idle+0x34/0x7c) from [<c00089ac>] (start_kernel+0x254/0x2a8)
[<c00089ac>] (start_kernel+0x254/0x2a8) from [<20008034>] (0x20008034)
