From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 27 Mar 2010 13:57:03 +0100
Subject: [PATCH] netdev/fec.c: add phylib supporting to enable carrier
	detection
In-Reply-To: <1269597052-10104-1-git-send-email-bryan.wu@canonical.com>
References: <1269597052-10104-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <20100327125703.GB5880@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 05:50:52PM +0800, Bryan Wu wrote:
> BugLink: http://bugs.launchpad.net/bugs/457878
> 
>  - removed old MII phy control code
>  - add phylib supporting
>  - add ethtool interface to make user space NetworkManager works
> 
> Tested on Freescale i.MX51 Babbage board.

Sadly, I have problems here booting a custom board:

...
FEC Ethernet Driver
fec_enet_mii_bus: probed
eth0: Freescale FEC PHY driver [SMSC LAN8700] (mii_bus:phy_addr=0:1f, irq=-1)

... (That's fine, so far)

PHY: 0:1f - Link is Up - 100/Full

... (also nice)

------------[ cut here ]------------
WARNING: at net/sched/sch_generic.c:255 dev_watchdog+0x2c0/0x2e0()
NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out
Modules linked in:
[<c001f8d4>] (unwind_backtrace+0x0/0xe4) from [<c002d1d0>] (warn_slowpath_common+0x4c/0x80)
[<c002d1d0>] (warn_slowpath_common+0x4c/0x80) from [<c002d240>] (warn_slowpath_fmt+0x28/0x38)
[<c002d240>] (warn_slowpath_fmt+0x28/0x38) from [<c01be32c>] (dev_watchdog+0x2c0/0x2e0)
[<c01be32c>] (dev_watchdog+0x2c0/0x2e0) from [<c0038740>] (run_timer_softirq+0x1c0/0x274)
[<c0038740>] (run_timer_softirq+0x1c0/0x274) from [<c0032f98>] (__do_softirq+0x8c/0x120)
[<c0032f98>] (__do_softirq+0x8c/0x120) from [<c00330b0>] (irq_exit+0x84/0xa0)
[<c00330b0>] (irq_exit+0x84/0xa0) from [<c001a040>] (asm_do_IRQ+0x40/0x8c)
[<c001a040>] (asm_do_IRQ+0x40/0x8c) from [<c001ab8c>] (__irq_svc+0x4c/0x8c)
Exception stack(0xc02c3f78 to 0xc02c3fc0)
3f60:                                                       00000000 0005317f
3f80: 0005217f 60000013 c02c2000 c02db7ec c02c59c4 c02c59b8 a0018270 41069264
3fa0: a001823c 00000000 600000d3 c02c3fc0 c001ba8c c001ba98 60000013 ffffffff
[<c001ab8c>] (__irq_svc+0x4c/0x8c) from [<c001ba98>] (default_idle+0x2c/0x34)
[<c001ba98>] (default_idle+0x2c/0x34) from [<c001bfac>] (cpu_idle+0x90/0xc8)
[<c001bfac>] (cpu_idle+0x90/0xc8) from [<c000898c>] (start_kernel+0x234/0x2c0)
[<c000898c>] (start_kernel+0x234/0x2c0) from [<a0008034>] (0xa0008034)
---[ end trace ce1c823381bff119 ]---
eth0: tx queue full!.
eth0: tx queue full!.
eth0: tx queue full!.
eth0: tx queue full!.
eth0: tx queue full!.
eth0: tx queue full!.
...

I just threw the patch on top of 2.6.33.1, after picking
633e7533cec78b99d806248e832fc83e689d2453 (fec: fix uninitialized rx buffer
usage), too. Just needed to adapt the Kconfig entry, the patch for fec.c went
smooth. So, I doubt the slightly older kernel is the problem (but will check
net-next somewhen later)? Using the "old" method for the LAN8700, I get a
working eth0, so the hardware should work in general. I will have a closer look
on Monday, this was just a quick try. If you happen to have pointers where to
start, this is appreciated.

Kind regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100327/185ae337/attachment.sig>
