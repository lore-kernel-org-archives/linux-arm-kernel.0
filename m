From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 27 Feb 2013 15:58:32 +0100
Subject: ARM: perf top running with 4 v7 cores (i.MX6q)?
Message-ID: <512E1F18.3040807@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

has anybody running 'perf top' on a quad ARM v7 system with PMU enabled?

Running 'perf top' on a quad Cortex A9 based Freescale i.MX6 SabreLite 
(maxcpus=4) with PMU enabled [1] and kernel 3.8 the system freezes 
completely and after some time the system detects a RCU stall [2].

'perf top' works well using only 1 core (maxcpus=1) on the same system.

Any idea?

Many thanks

Dirk

[1]

imx_v6_v7_defconfig + CONFIG_PERF_EVENTS=y

and

http://www.spinics.net/lists/arm-kernel/msg225176.html

[2]

[bash mx6q target] /root # ./perf top
[   59.261370] INFO: rcu_sched self-detected stall on CPU { 0}  (t=2101 
jiffies g=4294967210 c=4294967209 q=478)
[   59.271367] INFO: rcu_sched detected stalls on CPUs/tasks:
[   59.271378] Backtrace:
[   59.271435] [<80012aec>] (dump_backtrace+0x0/0x10c) from [<8051ed50>] 
(dump_stack+0x18/0x1c)
[   59.271447]  r7:806ed170 r6:806e1a08 r5:806fb480 r4:80f93a08
[   59.271476] [<8051ed38>] (dump_stack+0x0/0x1c) from [<80081fa0>] 
(rcu_check_callbacks+0x19c/0x748)
[   59.271496] [<80081e04>] (rcu_check_callbacks+0x0/0x748) from 
[<80034e5c>] (update_process_times+0x40/0x70)
[   59.271523] [<80034e1c>] (update_process_times+0x0/0x70) from 
[<80067758>] (tick_sched_timer+0x8c/0xf0)
[   59.271533]  r7:bf881c30 r6:80f93940 r5:bf880000 r4:0000000d
[   59.271553] [<800676cc>] (tick_sched_timer+0x0/0xf0) from 
[<8004aa5c>] (__run_hrtimer+0x6c/0x128)
[   59.271564]  r8:ffffffff r7:00000000 r6:80f937c0 r5:80f937f8 r4:80f93940
[   59.271576] [<8004a9f0>] (__run_hrtimer+0x0/0x128) from [<8004af88>] 
(hrtimer_interrupt+0x134/0x36c)
[   59.271586]  r7:00000000 r6:80f937c0 r5:bf881b58 r4:80f937c0
[   59.271601] [<8004ae54>] (hrtimer_interrupt+0x0/0x36c) from 
[<80014a08>] (twd_handler+0x3c/0x48)
[   59.271613] [<800149cc>] (twd_handler+0x0/0x48) from [<8007c220>] 
(handle_percpu_devid_irq+0x84/0xa4)
[   59.271620]  r5:806f1500 r4:bf807600
[   59.271630] [<8007c19c>] (handle_percpu_devid_irq+0x0/0xa4) from 
[<800796bc>] (generic_handle_irq+0x30/0x38)
[   59.271644] [<8007968c>] (generic_handle_irq+0x0/0x38) from 
[<8000f6cc>] (handle_IRQ+0x54/0xb4)
[   59.271650]  r5:806ed170 r4:bf880000
[   59.271662] [<8000f678>] (handle_IRQ+0x0/0xb4) from [<80008550>] 
(gic_handle_irq+0x34/0x68)
[   59.271675]  r9:0000000a r8:00000001 r7:f4000110 r6:bf881c30 r5:806ec974
[   59.271675] r4:f400010c
[   59.271685] [<8000851c>] (gic_handle_irq+0x0/0x68) from [<8000e800>] 
(__irq_svc+0x40/0x54)
[   59.271691] Exception stack(0xbf881c30 to 0xbf881c78)
[   59.271698] 1c20:                                     bf009900 
00000000 0000018c 00000000
[   59.271707] 1c40: bf8d2c00 bf880000 806fb480 bf8d29c0 00000001 
0000000a 00000000 bf881c8c
[   59.271714] 1c60: bf881c90 bf881c78 80081450 800ce0e0 20000113 ffffffff
[   59.271724]  r7:bf881c64 r6:ffffffff r5:20000113 r4:800ce0e0
[   59.271749] [<800ce0a0>] (file_free_rcu+0x0/0x58) from [<80081450>] 
(rcu_process_callbacks+0x25c/0x544)
[   59.271755]  r5:bf880000 r4:80f93a08
[   59.271781] [<800811f4>] (rcu_process_callbacks+0x0/0x544) from 
[<8002ecd8>] (__do_softirq+0xc8/0x18c)
[   59.271794] [<8002ec10>] (__do_softirq+0x0/0x18c) from [<8002ee84>] 
(irq_exit+0x88/0x90)
[   59.271804] [<8002edfc>] (irq_exit+0x0/0x90) from [<8000f6d0>] 
(handle_IRQ+0x58/0xb4)
[   59.271811]  r5:806ed170 r4:bf880000
[   59.271821] [<8000f678>] (handle_IRQ+0x0/0xb4) from [<80008550>] 
(gic_handle_irq+0x34/0x68)
[   59.271834]  r9:806e23c0 r8:806ed170 r7:f4000110 r6:bf881d78 r5:806ec974
[   59.271834] r4:f400010c
[   59.271843] [<8000851c>] (gic_handle_irq+0x0/0x68) from [<8000e800>] 
(__irq_svc+0x40/0x54)
[   59.271849] Exception stack(0xbf881d78 to 0xbf881dc0)
[   59.271853] 1d60: 
    80f943c0 00000000
[   59.271862] 1d80: 4a264a26 00000000 00000000 80f943c0 be82e680 
00000000 806ed170 806e23c0
[   59.271870] 1da0: be97d500 bf881ddc bf881de0 bf881dc0 805209a0 
800533d0 80000013 ffffffff
[   59.271880]  r7:bf881dac r6:ffffffff r5:80000013 r4:800533d0
[   59.271897] [<80053320>] (finish_task_switch+0x0/0x108) from 
[<805209a0>] (__schedule+0x1fc/0x568)
[   59.271906]  r7:bf880000 r6:bf861880 r5:00000000 r4:80f943c0
[   59.271917] [<805207a4>] (__schedule+0x0/0x568) from [<8052107c>] 
(schedule+0x38/0x78)
[   59.271943] [<80521044>] (schedule+0x0/0x78) from [<80078990>] 
(cpu_stopper_thread+0x11c/0x180)
[   59.271967] [<80078874>] (cpu_stopper_thread+0x0/0x180) from 
[<800465f0>] (kthread+0xb0/0xbc)
[   59.271981] [<80046540>] (kthread+0x0/0xbc) from [<8000ed18>] 
(ret_from_fork+0x14/0x3c)
[   59.271991]  r8:00000000 r7:00000000 r6:00000000 r5:80046540 r4:bf857e64
[   59.617728]  { 0} (detected by 1, t=2136 jiffies, g=4294967210, 
c=4294967209, q=478)
[   59.625523] Task dump for CPU 0:
[   59.628756] migration/0     R running      0     8      2 0x00000002
[   59.635141] Backtrace:
[   59.637617] [<805207a4>] (__schedule+0x0/0x568) from [<8052107c>] 
(schedule+0x38/0x78)
[   59.645548] [<80521044>] (schedule+0x0/0x78) from [<80078990>] 
(cpu_stopper_thread+0x11c/0x180)
[   59.654260] [<80078874>] (cpu_stopper_thread+0x0/0x180) from 
[<800465f0>] (kthread+0xb0/0xbc)
[   59.662796] [<80046540>] (kthread+0x0/0xbc) from [<8000ed18>] 
(ret_from_fork+0x14/0x3c)
[   59.670801]  r8:00000000 r7:00000000 r6:00000000 r5:80046540 r4:bf857e64
