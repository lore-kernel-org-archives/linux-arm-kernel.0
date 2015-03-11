From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 11 Mar 2015 19:11:18 +0100
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid
 crash on armada-xp
In-Reply-To: <550081E2.5030807@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150311175227.499612af@free-electrons.com>
 <55007ADD.6080505@list.ru>
 <20150311174618.GE8656@n2100.arm.linux.org.uk>
 <550081E2.5030807@list.ru>
Message-ID: <20150311191118.1edb2ed8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stas Sergeev,

On Wed, 11 Mar 2015 20:56:50 +0300, Stas Sergeev wrote:

> It doesn't look like it works as intended.
> Got the crash below.
> Please note the mappings beyond 0xe0000000, so I wonder if
> the option worked as expected?

Are you sure you're not confusing virtual addresses and physical
addresses? I'm not sure where you see mappings beyond 0xe0000000,
except virtual addresses, which are not relevant here, as we are
talking about physical addresses.

> [    6.122188] Unable to handle kernel NULL pointer dereference at
> virtual address 000002d4
> [    6.130298] pgd = c0004000
> [    6.133022] [000002d4] *pgd=00000000
> [    6.136617] Internal error: Oops: 5 [#1] SMP ARM
> [    6.141244] Modules linked in:
> [    6.144317] CPU: 0 PID: 6 Comm: kworker/u8:0 Not tainted
> 4.0.0-rc2-00137-gb672c98-dirty #2
> [    6.152600] Hardware name: Marvell Armada 370/XP (Device Tree)
> [    6.158452] Workqueue: events_unbound async_run_entry_fn
> [    6.163786] task: ed426c00 ti: ed452000 task.ti: ed452000
> [    6.169196] PC is at 0x0
> [    6.171734] LR is at 0xfafeff5c
> [    6.174883] pc : [<00000000>]    lr : [<fafeff5c>]    psr: 00000000
> [    6.174883] sp : ffd6d7ff  ip : 00000000  fp : 00000200
> [    6.186388] r10: ed453d90  r9 : 00000001  r8 : 00000000
> [    6.191624] r7 : ed5857c0  r6 : 00000000  r5 : ed80c60a  r4 : 00000000
> [    6.198166] r3 : 76c06305  r2 : c200f010  r1 : 00000000  r0 : 00000000
> [    6.204709] Flags: nzcv  IRQs on  FIQs on  Mode USER_26  ISA ARM 
> Segment kernel
> [    6.212121] Control: 10c5387d  Table: 0000406a  DAC: 00000015
> [    6.217880] Process kworker/u8:0 (pid: 6, stack limit = 0xed452220)
> [    6.224183] ---[ end trace 93bf56ab1670c925 ]---
> [    6.228824] Unable to handle kernel NULL pointer dereference at
> virtual address 000002d4

This looks indeed weird.

What I did to work around this problem is to:

 1/ Boot in appended DT mode so that the bootloader doesn't mess up
    with the DTB

 2/ Disable CONFIG_ARM_ATAG_DTB_COMPAT so that the kernel doesn't
    update the /memory/reg DT node with the (bogus) ATAGS passed by the
    bootloader.

Of course, this means you'll have to have a proper /memory/reg value in
your DT, and a correct /chosen/bootargs value, since all info passed by
the bootloader will essentially be ignored.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
