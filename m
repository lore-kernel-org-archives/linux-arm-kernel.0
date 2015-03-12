From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 20:30:14 +0000
Subject: [arm] kernel dumped register values are not right
In-Reply-To: <AF7C0ADF1FEABA4DABABB97411952A2ECD52F8@CN-MBX01.HTC.COM.TW>
References: <AF7C0ADF1FEABA4DABABB97411952A2ECD52F8@CN-MBX01.HTC.COM.TW>
Message-ID: <20150312203014.GA29844@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 09:57:08AM +0000, zhiyuan_zhu at htc.com wrote:
> Hi Russell
> 
> My name is Zhiyuan zhu, an android development engineer in htc company.
> There is a kernel panic in android platform with arm chipset.
> After checked the scene of the panic, I found that some of the kernel
> dumped register values are not right.
> Could you help to give me some suggestion about this issue? Many thanks.

I'd trust the kernel dumping code any day.  It's not been known to be
wrong in the last 23 or so years. :)  Having diagnostics we can rely
upon is absolutely vital.

> The scene of the panic
> [77584.244336] c0      0 Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [77584.244361] c0      0 pgd = c0004000
> [77584.244373] c0      0 [00000000] *pgd=00000000
> [77584.244394] c0      0 Internal error: Oops: 805 [#1] PREEMPT SMP ARM
> [77584.244409] c0      0 Modules linked in: adsprpc ecryptfs(O) dm_crypt(O) moc_crypto(PO) moc_platform_mod(O) texfat(PO) [last unloaded: wlan]
> [77584.244462] c0      0 CPU: 0    Tainted: P        W  O  (3.4.0-gdd2de78 #1)
> [77584.244486] c0      0 PC is at diag_process_apps_pkt+0x380/0x1118
> [77584.244504] c0      0 LR is at load_balance+0x50/0x720
> [77584.244523] c0      0 pc : [<c0407558>]    lr : [<c01d036c>]    psr: 40000113
> [77584.244532] c0      0 sp : c0f37d90  ip : c0f37dec  fp : 00000000
> [77584.244549] c0      0 r10: c0f380c0  r9 : 00000001  r8 : 00000000
> [77584.244566] c0      0 r7 : 00000000  r6 : 01e29000  r5 : e6564500  r4 : c0f31c24
> [77584.244583] c0      0 r3 : 00000000  r2 : ffffffec  r1 : 00000000  r0 : c0f37dcc
> [77584.244602] c0      0 Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [77584.244620] c0      0 Control: 10c5387d  Table: 2d3ec06a  DAC: 00000015
> 
> Check the diag_process_apps_pkt assemble code
> Accoring the scene of the panic, we can know, kernel panic at:
>    0xc0407558 <+896>:       str   r4, [r2, #20]

Right, so looking at this and refering back to the registers and the
faulting address, the values for r2 agree - 0xffffffec + 20 = 0.

> And from the code as blew at address: 0xc0407524 to the address
> 0xc0407558, we know, r0's value should be 0x4b
> And r1's value should be 0x910, but the kernel dumped r0/r1 values
> are: r1 : 00000000  r0 : c0f37dcc
> So the kernel debug fuction dumped values maybe not right, could
> you help to give me some suggestions? Thanks.

You've cut quite a lot of code from the disassembly below, so it's hard
to see whether there's any jumps to 0xc0407554, 0xc0407558, or similar
areas.

Another culpret could be that you've taken some other kind of exception
around the same time (like an interrupt) which has corrupted the saved
register state, resulting in the register values changing unexpectedly.

Another possibility is that the CPU jumped through a bad function
pointer and ended up directly at 0xc0407558.

This is more likely, as if the instruction at 0xc0407554 was executed,
it would have faulted instead, because r3 = 0.

In order to start ruling some of these out, having the full oops dump
and disassembly of this function would be useful - for example, we can
ask the question "does the function's initial register push and
adjustment to SP correspond with the stack dump and backtrace - in
other words, does the saved value of LR correspond with the callpath?"
And "do the values for r4-r11 also saved on the stack look like they
contain sane values from the parent function."

The reason we dump soo much information is to allow that level of
forensic analysis of hard to believe bug reports.

What I also notice is that you have out of tree and proprietary
modules loaded - are you certain that none of these are responsible
for this (eg, containing subtle memory corruption bugs, use after
free bugs, etc.)  Can you reproduce it without these modules loaded?

I also notice that your kernel has hit a WARN_ON() at some point in
the past - which should be solved before debugging this problem.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
