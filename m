From: darian59@rocketmail.com (Mars Steeve)
Date: Fri, 27 Aug 2010 08:02:44 +0000 (GMT)
Subject: AT91 UDC softirq problem
Message-ID: <384846.65848.qm@web24820.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


I'm currently working on an AT91SAM9G20 based board, and I encounter a problem 
with the USB Gadget driver (at91_udc) and the Ethernet gadget with RNDIS 
support.
The board shall be connected with USB on a Windows platform (Vista or Seven) and 
communicate with an embedded http server (lighttpd), that's why I need the RNDIS 
support (I read on the Internet that vista supports CDC ECM but I don't know how 
to use it).

I first tried a 2.6.34 kernel version but unfortunately the link was very 
unstable, I lost 10% of my ICMP ping packet  and the HTTP browsing is unusable.
Note: I have no problem with CDC ECM and a Linux host.

Then I compiled a 2.6.36-rc2 kernel (with the at91_udc softirq patch) and now my 
link is stable but I always have a warning message when I plug my device on the 
host:

[    2.170000] ------------[ cut here ]------------
[    2.170000] WARNING: at kernel/softirq.c:143 local_bh_enable+0x80/0xac()
[    2.170000] Modules linked in:
[    2.170000] [<c0025cb0>] (unwind_backtrace+0x0/0xf4) from [<c0032574>] 
(warn_slowpath_common+0x4c/0x64)
[    2.170000] [<c0032574>] (warn_slowpath_common+0x4c/0x64) from [<c00325a8>] 
(warn_slowpath_null+0x1c/0x24)
[    2.170000] [<c00325a8>] (warn_slowpath_null+0x1c/0x24) from [<c00389f4>] 
(local_bh_enable+0x80/0xac)
[    2.170000] [<c00389f4>] (local_bh_enable+0x80/0xac) from [<c01e012c>] 
(dev_txq_stats_fold+0xa0/0xec)
[    2.170000] [<c01e012c>] (dev_txq_stats_fold+0xa0/0xec) from [<c01e0268>] 
(dev_get_stats+0xf0/0xf8)
[    2.170000]  [<c01e0268>] (dev_get_stats+0xf0/0xf8) from [<c01c45c8>] 
(gen_ndis_query_resp+0x58/0x4a0)
[    2.170000] [<c01c45c8>] (gen_ndis_query_resp+0x58/0x4a0) from [<c01c4c7c>] 
(rndis_msg_parser+0x26c/0x458)
[    2.170000] [<c01c4c7c>] (rndis_msg_parser+0x26c/0x458) from [<c01c4e8c>] 
(rndis_command_complete+0x24/0x58)
[    2.170000] [<c01c4e8c>] (rndis_command_complete+0x24/0x58) from [<c01c01c4>] 
(done+0x84/0xcc)
[    2.170000] [<c01c01c4>] (done+0x84/0xcc) from [<c01c11e4>] 
(read_fifo+0xf8/0x10c)
[    2.170000] [<c01c11e4>] (read_fifo+0xf8/0x10c) from [<c01c1830>] 
(at91_udc_irq+0x3a8/0x97c)
[    2.170000] [<c01c1830>] (at91_udc_irq+0x3a8/0x97c) from [<c0063a18>] 
(handle_IRQ_event+0x40/0x118)
[    2.170000] [<c0063a18>]  (handle_IRQ_event+0x40/0x118) from [<c0065c58>] 
(handle_level_irq+0xa8/0x17c)
[    2.170000] [<c0065c58>] (handle_level_irq+0xa8/0x17c) from [<c0020044>] 
(asm_do_IRQ+0x44/0xa4)
[    2.170000] [<c0020044>] (asm_do_IRQ+0x44/0xa4) from [<c0020b28>] 
(__irq_svc+0x48/0x8c)
[    2.170000] Exception stack(0xc0319f80 to 0xc0319fc8)
[    2.170000] 9f80: c0318000 60000013 00000001 60000013 c0318000 c03397a8 
c031bc90 c031bc88
[    2.170000] 9fa0: 2001c838 41069265 2001c804 00000000 00000000 c0319fc8 
c0022180 c0022120
[    2.170000] 9fc0: 60000013 ffffffff
[    2.170000] [<c0020b28>] (__irq_svc+0x48/0x8c) from [<c0022120>] 
(cpu_idle+0x28/0xc0)
[    2.170000] [<c0022120>] (cpu_idle+0x28/0xc0) from [<c0008924>] 
(start_kernel+0x230/0x274)
[    2.170000]  [<c0008924>] (start_kernel+0x230/0x274) from [<20008034>] 
(0x20008034)
[    2.170000] ---[ end trace d1eb86bf710a14c5 ]---

Is this message important or can I still use this version without problem in the 
future ?

Thanks


      
