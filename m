From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 18 Dec 2012 00:01:35 -0200
Subject: 3.7 kernel hangs when doing scp
Message-ID: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Booting a 3.7 kernel on a mx6qsabrelite board via NFS and using an
asix USB/Ethernet adapter and then I try to transfer a 10MB file from
the target to the host:

root at freescale /home$ scp test.tar.gz fabio at 192.168.1.100:/home/fabio
fabio at 192.168.1.100's password:
test.tar.gz                                      0%    0     0.0KB/s   --:-- ETA
------------[ cut here ]------------
WARNING: at net/sched/sch_generic.c:255 dev_watchdog+0x2cc/0x2f0()
NETDEV WATCHDOG: eth0 (asix): transmit queue 0 timed out
Modules linked in:
Backtrace:
[<80011c94>] (dump_backtrace+0x0/0x10c) from [<804d3a5c>] (dump_stack+0x18/0x1c)
 r6:000000ff r5:80412388 r4:80685dc0 r3:80696cc0
[<804d3a44>] (dump_stack+0x0/0x1c) from [<80021868>]
(warn_slowpath_common+0x54/0x6c)
[<80021814>] (warn_slowpath_common+0x0/0x6c) from [<80021924>]
(warn_slowpath_fmt+0x38/0x40)
 r8:00000000 r7:806c6ec7 r6:806860c0 r5:00000000 r4:bf0cd800
r3:00000009
[<800218ec>] (warn_slowpath_fmt+0x0/0x40) from [<80412388>]
(dev_watchdog+0x2cc/0x2f0)
 r3:bf0cd800 r2:8060b170
[<804120bc>] (dev_watchdog+0x0/0x2f0) from [<8002ef90>]
(call_timer_fn.isra.29+0x2c/0x8c)
[<8002ef64>] (call_timer_fn.isra.29+0x0/0x8c) from [<8002f220>]
(run_timer_softirq+0x230/0x24c)
 r7:80709954 r6:806860c0 r5:00000000 r4:80709140
[<8002eff0>] (run_timer_softirq+0x0/0x24c) from [<8002938c>]
(__do_softirq+0xd4/0x198)
[<800292b8>] (__do_softirq+0x0/0x198) from [<8002977c>] (irq_exit+0x88/0x90)
[<800296f4>] (irq_exit+0x0/0x90) from [<8000ee98>] (handle_IRQ+0x58/0xb4)
 r4:8068d170 r3:00000180
[<8000ee40>] (handle_IRQ+0x0/0xb4) from [<80008500>] (gic_handle_irq+0x30/0x64)
 r8:00000000 r7:f4000100 r6:80685f28 r5:8068c974 r4:f400010c
r3:00000000
[<800084d0>] (gic_handle_irq+0x0/0x64) from [<8000e100>] (__irq_svc+0x40/0x54)
Exception stack(0x80685f28 to 0x80685f70)
BUG: scheduling while atomic: swapper/0/0/0x40000100
Modules linked in:
Backtrace:
[<80011c94>] (dump_backtrace+0x0/0x10c) from [<804d3a5c>] (dump_stack+0x18/0x1c)
 r6:80684000 r5:8068fc28 r4:80f2e240 r3:60000113
[<804d3a44>] (dump_stack+0x0/0x1c) from [<804d4148>] (__schedule_bug+0x48/0x5c)
[<804d4100>] (__schedule_bug+0x0/0x5c) from [<804d8b08>]
(__schedule+0x52c/0x580)
[<804d85dc>] (__schedule+0x0/0x580) from [<8004a208>] (__cond_resched+0x28/0x38)
[<8004a1e0>] (__cond_resched+0x0/0x38) from [<804d8bf0>]
(_cond_resched+0x38/0x48)
 r4:80685f28 r3:00000100
[<804d8bb8>] (_cond_resched+0x0/0x48) from [<80011c0c>] (dump_mem+0x11c/0x1a4)
[<80011af0>] (dump_mem+0x0/0x1a4) from [<80011e20>]
(dump_backtrace_entry+0x60/0x7c)
[<80011dc0>] (dump_backtrace_entry+0x0/0x7c) from [<8024c464>]
(for_each_frame+0x3c/0x88)
 r5:80685f7c r4:80685f24
[<80011c94>] (dump_backtrace+0x0/0x10c) from [<804d3a5c>] (dump_stack+0x18/0x1c)
 r6:000000ff r5:80412388 r4:80685dc0 r3:80696cc0
[<804d3a44>] (dump_stack+0x0/0x1c) from [<80021868>]
(warn_slowpath_common+0x54/0x6c)
[<80021814>] (warn_slowpath_common+0x0/0x6c) from [<80021924>]
(warn_slowpath_fmt+0x38/0x40)
 r8:00000000 r7:806c6ec7 r6:806860c0 r5:00000000 r4:bf0cd800
r3:00000009
[<800218ec>] (warn_slowpath_fmt+0x0/0x40) from [<80412388>]
(dev_watchdog+0x2cc/0x2f0)
 r3:bf0cd800 r2:8060b170
[<804120bc>] (dev_watchdog+0x0/0x2f0) from [<8002ef90>]
(call_timer_fn.isra.29+0x2c/0x8c)
[<8002ef64>] (call_timer_fn.isra.29+0x0/0x8c) from [<8002f220>]
(run_timer_softirq+0x230/0x24c)
 r7:80709954 r6:806860c0 r5:00000000 r4:80709140
[<8002eff0>] (run_timer_softirq+0x0/0x24c) from [<8002938c>]
(__do_softirq+0xd4/0x198)
[<800292b8>] (__do_softirq+0x0/0x198) from [<8002977c>] (irq_exit+0x88/0x90)
[<800296f4>] (irq_exit+0x0/0x90) from [<8000ee98>] (handle_IRQ+0x58/0xb4)
 r4:8068d170 r3:00000180
[<8000ee40>] (handle_IRQ+0x0/0xb4) from [<80008500>] (gic_handle_irq+0x30/0x64)
 r8:00000000 r7:f4000100 r6:80685f28 r5:8068c974 r4:f400010c
r3:00000000
[<800084d0>] (gic_handle_irq+0x0/0x64) from [<8000e100>] (__irq_svc+0x40/0x54)
Exception stack(0x80685f28 to 0x80685f70)
5f20:                   00000000 00000000 0000000f 80018fa0 80684000 80684000
5f40: 806c7008 804dbe24 00000000 80684000 80690968 80685f7c 80685f80 80685f70
5f60: 8000f168 8000f16c 60000013 ffffffff
 r7:80685f5c r6:ffffffff r5:60000013 r4:8000f16c
[<8000f134>] (default_idle+0x0/0x44) from [<8000f324>] (cpu_idle+0xa8/0xf4)
[<8000f27c>] (cpu_idle+0x0/0xf4) from [<804c3744>] (rest_init+0x64/0x7c)
[<804c36e0>] (rest_init+0x0/0x7c) from [<8063c820>] (start_kernel+0x29c/0x2ec)
[<8063c584>] (start_kernel+0x0/0x2ec) from [<10008078>] (0x10008078)
5f20:                   00000000 00000000 0000000f 80018fa0 80684000 80684000
5f40: 806c7008 804dbe24 00000000 80684000 80690968 80685f7c 80685f80 80685f70
5f60: 8000f168 8000f16c 60000013 ffffffff
 r7:80685f5c r6:ffffffff r5:60000013 r4:8000f16c
[<8000f134>] (default_idle+0x0/0x44) from [<8000f324>] (cpu_idle+0xa8/0xf4)
[<8000f27c>] (cpu_idle+0x0/0xf4) from [<804c3744>] (rest_init+0x64/0x7c)
[<804c36e0>] (rest_init+0x0/0x7c) from [<8063c820>] (start_kernel+0x29c/0x2ec)
[<8063c584>] (start_kernel+0x0/0x2ec) from [<10008078>] (0x10008078)
---[ end trace 12cd5962244d1a4c ]---
nfs: server 192.168.1.100 not responding, still trying
nfs: server 192.168.1.100 not responding, still trying
nfs: server 192.168.1.100 not responding, still trying
nfs: server 192.168.1.100 not responding, still trying
(system hang)

The scp transfer works fine when using the FEC interface instead of
USB to Ethernet.

I haven't started bisecting this yet, but any suggestions are welcome.

Regards,

Fabio Estevam
