From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Jul 2015 12:54:41 +0200
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <20150703024044.GB24695@verge.net.au>
References: <20150703024044.GB24695@verge.net.au>
Message-ID: <20150703105441.GF1521@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

> I have observed what appears to be a regression while testing next-20150702
> which seems to be caused by 2951d5c031a3 ("tick: broadcast: Prevent
> livelock from event handler").

Does reverting help? I see a similar case with your branch
renesas-devel-20150629-v4.1 which does not include both commits.

For this branch, if I select CONFIG_NO_HZ_IDLE and *no* CONFIG_HIGH_RES_TIMERS,
I see the case you described:

> input: gpio_keys as /devices/platform/gpio_keys/input/input0
> hctosys: unable to open rtc device (rtc0)
> 
> The boot hangs here.
> The next line should be:
> 
> smsc911x 20000000.ethernet eth0: SMSC911x/921x identified at 0xc8880000, IRQ: 33

There is no OOPS, it just stops here. With CONFIG_HIGH_RES_TIMERS, the
system boots to the prompt.

Enabling all lockdep features doesn't show anything for the non-working
case. However, I get warning for the working case:

[    2.560000] input: gpio_keys as /devices/platform/gpio_keys/input/input0
[    2.610000] smsc911x 20000000.ethernet eth0: SMSC911x/921x identified at 0xc8880000, IRQ: 33
[    5.510000] Sending DHCP requests ., OK
[    5.580000] IP-Config: Got DHCP answer from 192.168.64.1, my address is 192.168.64.14
[    5.580000] IP-Config: Complete:
[    5.590000]      device=eth0, hwaddr=00:01:9b:04:03:ce, ipaddr=192.168.64.14, mask=255.255.255.0, gw=192.168.64.1
[    5.600000]      host=192.168.64.14, domain=local, nis-domain=(none)
[    5.600000]      bootserver=192.168.64.1, rootserver=192.168.64.1, rootpath=
[    5.610000]      nameserver0=192.168.64.1
[    5.630000] Freeing unused kernel memory: 632K (c0306000 - c03a4000)
[    5.660000] random: init urandom read with 14 bits of entropy available
[    5.820000] ------------[ cut here ]------------
[    5.820000] WARNING: CPU: 0 PID: 282 at kernel/locking/lockdep.c:3557 check_flags+0x84/0x1f4()
[    5.820000] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
[    5.820000] CPU: 0 PID: 282 Comm: rcS Tainted: G        W       4.1.0-00002-g5b076054611833 #179
[    5.820000] Hardware name: Generic Emma Mobile EV2 (Flattened Device Tree)
[    5.820000] Backtrace: 
[    5.820000] [<c0012c94>] (dump_backtrace) from [<c0012e3c>] (show_stack+0x18/0x1c)
[    5.820000]  r6:c02dcc67 r5:00000009 r4:00000000 r3:00400000
[    5.820000] [<c0012e24>] (show_stack) from [<c02510c8>] (dump_stack+0x20/0x28)
[    5.820000] [<c02510a8>] (dump_stack) from [<c0022c44>] (warn_slowpath_common+0x8c/0xb4)
[    5.820000] [<c0022bb8>] (warn_slowpath_common) from [<c0022cd8>] (warn_slowpath_fmt+0x38/0x40)
[    5.820000]  r8:c780f470 r7:00000000 r6:00000000 r5:c03b0570 r4:c0b7ec04
[    5.820000] [<c0022ca4>] (warn_slowpath_fmt) from [<c004cd38>] (check_flags+0x84/0x1f4)
[    5.820000]  r3:c02e13d8 r2:c02dceaa
[    5.820000] [<c004ccb4>] (check_flags) from [<c0050e50>] (lock_acquire+0x4c/0xbc)
[    5.820000]  r5:00000000 r4:60000193
[    5.820000] [<c0050e04>] (lock_acquire) from [<c0256000>] (_raw_spin_lock+0x34/0x44)
[    5.820000]  r9:000a8d5c r8:00000001 r7:c7806000 r6:c780f460 r5:c03b06a0 r4:c780f460
[    5.820000] [<c0255fcc>] (_raw_spin_lock) from [<c005a8cc>] (handle_fasteoi_irq+0x20/0x11c)
[    5.820000]  r4:c780f400
[    5.820000] [<c005a8ac>] (handle_fasteoi_irq) from [<c0057a4c>] (generic_handle_irq+0x28/0x38)
[    5.820000]  r6:00000000 r5:c03b038c r4:00000012 r3:c005a8ac
[    5.820000] [<c0057a24>] (generic_handle_irq) from [<c0057ae4>] (__handle_domain_irq+0x88/0xa8)
[    5.820000]  r4:00000000 r3:00000026
[    5.820000] [<c0057a5c>] (__handle_domain_irq) from [<c000a3cc>] (gic_handle_irq+0x40/0x58)
[    5.820000]  r8:10c5347d r7:10c5347d r6:c35b1fb0 r5:c03a6304 r4:c8802000 r3:c35b1fb0
[    5.820000] [<c000a38c>] (gic_handle_irq) from [<c0013bc8>] (__irq_usr+0x48/0x60)
[    5.820000] Exception stack(0xc35b1fb0 to 0xc35b1ff8)
[    5.820000] 1fa0:                                     00000061 00000000 000ab736 00000066
[    5.820000] 1fc0: 00000061 000aa1f0 000a8d54 000a8d54 000a8d88 000a8d5c 000a8cc8 000a8d68
[    5.820000] 1fe0: 72727272 bef8a528 000398c0 00031334 20000010 ffffffff
[    5.820000]  r6:ffffffff r5:20000010 r4:00031334 r3:00000061
[    5.820000] ---[ end trace cb88537fdc8fa202 ]---
[    5.820000] possible reason: unannotated irqs-off.
[    5.820000] irq event stamp: 769
[    5.820000] hardirqs last  enabled at (769): [<c000f82c>] ret_fast_syscall+0x2c/0x54
[    5.820000] hardirqs last disabled at (768): [<c000f80c>] ret_fast_syscall+0xc/0x54
[    5.820000] softirqs last  enabled at (0): [<c0020ec4>] copy_process.part.65+0x2e8/0x11dc
[    5.820000] softirqs last disabled at (0): [<  (null)>]   (null)

I haven't further researched, but wanted to share this already.

All the best,

   Wolfram#

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150703/de035c94/attachment.sig>
