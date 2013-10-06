From: tom@sharkbay.at (Thomas Scheiblauer)
Date: Sun, 06 Oct 2013 12:01:26 +0200
Subject: BUG: imx6q-wandboard: Ethernet tx-queue timeouts when SATA is active
Message-ID: <1381053686.1282.12.camel@mako.sharkbay.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I experience transmit queue timeouts every few seconds on the ethernet
port when SATA is transfering data at the same time e.g. when copying
from HD over NFS or piping HD data through ssh or netcat.
When the first timeout happens I get this kernel message:

WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:264 dev_watchdog
+0x278/0x298()
NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out
Modules linked in: uio_pdrv_genirq uio
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 3.12.0-rc3 #1
Backtrace: 
[<80011a94>] (dump_backtrace+0x0/0x10c) from [<80011c30>] (show_stack
+0x18/0x1c)
 r6:00000108 r5:00000009 r4:00000000 r3:00000000
[<80011c18>] (show_stack+0x0/0x1c) from [<804b4418>] (dump_stack
+0x78/0x94)
[<804b43a0>] (dump_stack+0x0/0x94) from [<800228b4>]
(warn_slowpath_common+0x6c/0x90)
 r4:ef0b9e18 r3:8062f4b4
[<80022848>] (warn_slowpath_common+0x0/0x90) from [<8002297c>]
(warn_slowpath_fmt+0x38/0x40)
 r8:80661e48 r7:806340c0 r6:ef353100 r5:ef368800 r4:00000000
[<80022944>] (warn_slowpath_fmt+0x0/0x40) from [<803f3660>]
(dev_watchdog+0x278/0x298)
 r3:ef368800 r2:805cec10
[<803f33e8>] (dev_watchdog+0x0/0x298) from [<8002c62c>]
(call_timer_fn.isra.24+0x2c/0x8c)
 r8:ef034814 r7:806340c0 r6:803f33e8 r5:00000100 r4:ef0b8000After it
[<8002c600>] (call_timer_fn.isra.24+0x0/0x8c) from [<8002c804>]
(run_timer_softirq+0x178/0x200)
 r7:806340c0 r6:00200200 r5:00000000 r4:ef0b9e90
[<8002c68c>] (run_timer_softirq+0x0/0x200) from [<800265d4>]
(__do_softirq+0xf4/0x1e0)
[<800264e0>] (__do_softirq+0x0/0x1e0) from [<80026a04>] (irq_exit
+0xa0/0xf0)
[<80026964>] (irq_exit+0x0/0xf0) from [<8000ef7c>] (handle_IRQ
+0x44/0x9c)
 r4:8062fd88 r3:00000180
[<8000ef38>] (handle_IRQ+0x0/0x9c) from [<800084d4>] (gic_handle_irq
+0x30/0x64)
 r6:ef0b9f70 r5:8063a778 r4:f400010c r3:000000a0
[<800084a4>] (gic_handle_irq+0x0/0x64) from [<80012700>] (__irq_svc
+0x40/0x50)
Exception stack(0xef0b9f70 to 0xef0b9fb8)
9f60:                                     81e1e970 00000000 00574db0
00000000
9f80: 80661d47 00000001 80661d47 8063a3e0 804badbc ef0b8000 8063a388
ef0b9fc4
9fa0: ef0b9fc8 ef0b9fb8 8000f184 8000f188 600e0013 ffffffff
 r7:ef0b9fa4 r6:ffffffff r5:600e0013 r4:8000f188
[<8000f158>] (arch_cpu_idle+0x0/0x38) from [<80057814>]
(cpu_startup_entry+0x68/0x138)
[<800577ac>] (cpu_startup_entry+0x0/0x138) from [<80013578>]
(secondary_start_kernel+0xd4/0xe8)
 r7:806621f4 r3:00000005
[<800134a4>] (secondary_start_kernel+0x0/0xe8) from [<100085a4>]
(0x100085a4)
 r4:7f09c06a r3:8000858c
---[ end trace db3ced4bf31e8711 ]---

I tried with kernels 3.11.1, 3.12.0-rc2 and 3.12.0-rc3, vanilla as well
as with all ARM fixes from rmk/for-next and the RobertCNelson patchset
applied.

Steps to reproduce:
     1. boot one of the mentioned kernel releases (either patched or
        unpatched)
     2. copy some file from a storage device connected to the Quad's
        SATA port (or just /dev/sda if sda is your SATA storage) over
        the network to another machine either using nfs or piping
        through ssh (use the HPN patched ssh and its "None" cipher to
        make it fast because I suspect it happens more often when
        copying with high throughput) or just pipe it directly through a
        network socket (preferably UDP because it's faster) using e.g.
        "netcat" (nc),
     3. Look at the network throughput using e.g. "dstat" and at dmesg
     4. network throughput will drop to zero every few seconds (seldom
        it keeps stable for more tan 30 seconds) and will take about 3
        or 4 seconds to recover.
     5. additionally you may spot the above mentioned kernel warning
        once in dmesg.
     6. In addition when you use nfs (nfs4 server on the Wandboard in my
        case) you will spot messages like this in dmesg every time a
        throughput drop happens: "rpc-srv/tcp: nfsd: sent only 118848
        when sending 262208 bytes - shutting down socket"

The drops ONLY happen when using SATA at the same time as ethernet. If
you just copy e.g. /dev/zero or some data from the SD-Card (testet with
the internal SD) it will constantly run with about 408 MBit/s without
interruptions.

I have posted my current kernel config to
ftp://ftp.arm.linux.org.uk/pub/linux/arm/incoming/tom.sharkbay.at_config-3.12.0-rc3
I have already tried many different configurations regarding
IO-schedulers, preemption models, dynticks, static ticks, etc...

Btw, I'm running ArchLinux on the Wandboard and tried ext4 and btrfs
filesystems on the SATA HD (it seems not to be a filesystem problem
since it also happens when just copying /dev/sda)

Regards,
Tom
