From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 22 May 2014 22:56:51 +0800
Subject: The resume of sgtl5000 causes kernel Oops
Message-ID: <20140522145650.GD32184@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The suspend/resume test on imx51-babbage board discovers a kernel Oops
caused by sgtl5000_resume().  I believe it happens due to commit
e5d80e82e32e (ASoC: sgtl5000: Convert to use regmap directly).  After
the commit, it seems that the codec->reg_cache in function
sgtl5000_restore_regs() becomes invalid.  It looks that the register
restoring in the function requires some strict sequence, I'm not sure
what the correct fix is.

Shawn

$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.006 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.004 seconds) done.
PM: Entering mem sleep
PM: suspend of devices complete after 41.598 msecs
PM: suspend devices took 0.050 seconds
PM: late suspend of devices complete after 6.434 msecs
PM: noirq suspend of devices complete after 6.735 msecs
Disabling non-boot CPUs ...
PM: noirq resume of devices complete after 10.871 msecs
PM: early resume of devices complete after 5.241 msecs
Unable to handle kernel NULL pointer dereference at virtual address 00000010
pgd = 80004000
[00000010] *pgd=00000000
Internal error: Oops: 17 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 21 Comm: kworker/0:1 Not tainted 3.15.0-rc3-00071-g49a96400a142-dirty #118
Workqueue: events soc_resume_deferred
task: 9e11c440 ti: 9e14e000 task.ti: 9e14e000
PC is at sgtl5000_resume+0x7c/0x124
LR is at mark_held_locks+0x70/0x94
pc : [<804e8fb8>]    lr : [<800661b8>]    psr: 80000013
sp : 9e14fe40  ip : 80a26e60  fp : 9e14fe5c
r10: 9fbd6b00  r9 : 00000001  r8 : 00000000
r7 : 00000010  r6 : 9e369a00  r5 : 00000002  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 9e369a00
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: ac828019  DAC: 00000015
Process kworker/0:1 (pid: 21, stack limit = 0x9e14e240)
Stack: (0x9e14fe40 to 0x9e150000)
fe40: 9e387d84 9e369a00 9e387c64 9e387da4 9e14fe84 9e14fe60 804d90d0 804e8f48
fe60: 9e135300 9e387d84 9fbd36c0 9e14e000 00000000 9fbd6b00 9e14fee4 9e14fe88
fe80: 8003f060 804d8fd0 00000001 00000000 8003efec 9fbd36c0 8003f620 00000000
fea0: 00000000 9e14fea8 80e981a0 80a26e60 00000000 80843dfc 80661fac 9e135300
fec0: 9fbd36f0 9e14e000 9e135318 9e14e000 9fbd36c0 8094e442 9e14ff24 9e14fee8
fee0: 8003f700 8003eec4 80662510 00000000 9e134ac0 9e14e000 8003f5dc 00000000
ff00: 9e134ac0 9e135300 8003f5dc 00000000 00000000 00000000 9e14ffac 9e14ff28
ff20: 800463bc 8003f5e8 800663bc 00000000 9e14ff54 9e135300 00000000 00000000
ff40: dead4ead ffffffff ffffffff 80952424 00000000 00000000 807cc28c 9e14ff5c
ff60: 9e14ff5c 00000000 00000000 dead4ead ffffffff ffffffff 80952424 00000000
ff80: 00000000 807cc28c 9e14ff88 9e14ff88 9e134ac0 800462ec 00000000 00000000
ffa0: 00000000 9e14ffb0 8000eb68 800462f8 00000000 00000000 00000000 00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 00c37f70 76f142d0
Backtrace:
[<804e8f3c>] (sgtl5000_resume) from [<804d90d0>] (soc_resume_deferred+0x10c/0x30c)
 r7:9e387da4 r6:9e387c64 r5:9e369a00 r4:9e387d84
[<804d8fc4>] (soc_resume_deferred) from [<8003f060>] (process_one_work+0x1a8/0x444)
 r10:9fbd6b00 r8:00000000 r7:9e14e000 r6:9fbd36c0 r5:9e387d84 r4:9e135300
[<8003eeb8>] (process_one_work) from [<8003f700>] (worker_thread+0x124/0x398)
 r10:8094e442 r9:9fbd36c0 r8:9e14e000 r7:9e135318 r6:9e14e000 r5:9fbd36f0
 r4:9e135300
[<8003f5dc>] (worker_thread) from [<800463bc>] (kthread+0xd0/0xec)
 r10:00000000 r9:00000000 r8:00000000 r7:8003f5dc r6:9e135300 r5:9e134ac0
 r4:00000000
[<800462ec>] (kthread) from [<8000eb68>] (ret_from_fork+0x14/0x2c)
 r7:00000000 r6:00000000 r5:800462ec r4:9e134ac0
Code: e1a03084 e1a01004 e1a00006 0afffff0 (e19720b3)
---[ end trace eeb2712470f0de34 ]---
Unable to handle kernel paging request at virtual address ffffffd0
pgd = 80004000
[ffffffd0] *pgd=afff6821, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#2] SMP ARM
Modules linked in:
CPU: 0 PID: 21 Comm: kworker/0:1 Tainted: G      D       3.15.0-rc3-00071-g49a96400a142-dirty #118
task: 9e11c440 ti: 9e14e000 task.ti: 9e14e000
PC is at kthread_data+0x10/0x18
LR is at wq_worker_sleeping+0x14/0xc8
pc : [<8004673c>]    lr : [<8004047c>]    psr: 00000193
sp : 9e14fb00  ip : 9e14fb10  fp : 9e14fb0c
r10: 808f2d2c  r9 : 9e11c698  r8 : 808e8c40
r7 : 00000000  r6 : 9e14e000  r5 : 9e11c440  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 9e11c440
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: ac828019  DAC: 00000015
Process kworker/0:1 (pid: 21, stack limit = 0x9e14e240)
Stack: (0x9e14fb00 to 0x9e150000)
fb00: 9e14fb24 9e14fb10 8004047c 80046738 00000020 9fbd3c40 9e14fbc4 9e14fb28
fb20: 8065dd8c 80040474 9e14e000 60000113 9e14fb4c 9e14fb40 800663bc 800661e8
fb40: 9e14fb74 9e14fb50 808e8c40 808e8c40 9e11c440 9e1078c0 8094fe04 9e116100
fb60: 9e116604 9e11c440 9e14fb84 9e14fb78 800786f0 80078498 9e14fbd4 9e14fb88
fb80: 80029c60 800786e4 00000000 00000000 800299ec 9e11c438 808e7390 00000001
fba0: 9e11c438 9e11c440 9e11c438 9e14e000 9e11c614 9e068000 9e14fbd4 9e14fbc8
fbc0: 8065e114 8065da60 9e14fc0c 9e14fbd8 8002b088 8065e0e8 9e14e000 00000001
fbe0: 9e11c614 9e14fbf0 8094e944 9e11c65c 9e14fbf0 9e14fbf0 80028d90 808f760c
fc00: 9e14fc8c 9e14fc10 80011ff4 8002aa90 9e14e240 0000000b 00000008 00000000
fc20: 00000000 60000113 65000001 33306131 20343830 30613165 34303031 61316520
fc40: 30303030 61302036 66666666 28203066 37393165 33623032 80002029 80659664
fc60: 80823f48 00000010 00000017 00000000 9e14fdf8 00000010 00000001 9e11c440
fc80: 9e14fca4 9e14fc90 80658498 80011dfc 9e14fdf8 00000017 9e14fd44 9e14fca8
fca0: 8001bcd8 80658448 00000037 00000000 9e14fccc 9e14fcc0 800613d0 800612f8
fcc0: 9e14fcf4 9e14fcd0 8007911c 800613c8 9fbd3c40 9e14e000 808e7ffc 9e14e000
fce0: 00000004 00000001 00000004 00000006 9e11c440 60000013 60000013 00000000
fd00: 9e14fd2c 9e14fd10 800661b8 80063254 9e14e000 80012928 9e11c440 00000017
fd20: 8001bb20 808f8314 00000010 9e14fdf8 00000001 9fbd6b00 9e14fdf4 9e14fd48
fd40: 8000840c 8001bb2c 800663bc 800661e8 9e14fe0c 9e14fd60 80012928 800663b4
fd60: 00000001 9e11c8a0 00000000 9e11c440 00000001 00000007 80903a24 80e3ea20
fd80: 60000013 60000013 00000000 9e14fe0c 80a26e60 9e14fda8 800661b8 8006d650
fda0: 20000013 ffffffff 00000000 00000000 00000000 00000000 80e3f308 00000007
fdc0: 60000013 80660be4 9e14fde4 00000000 00000000 804e8fb8 80000013 ffffffff
fde0: 9e14fe2c 00000000 9e14fe5c 9e14fdf8 800128a4 800083dc 9e369a00 00000000
fe00: 00000000 00000000 00000000 00000002 9e369a00 00000010 00000000 00000001
fe20: 9fbd6b00 9e14fe5c 80a26e60 9e14fe40 800661b8 804e8fb8 80000013 ffffffff
fe40: 9e387d84 9e369a00 9e387c64 9e387da4 9e14fe84 9e14fe60 804d90d0 804e8f48
fe60: 9e135300 9e387d84 9fbd36c0 9e14e000 00000000 9fbd6b00 9e14fee4 9e14fe88
fe80: 8003f060 804d8fd0 00000001 00000000 8003efec 9fbd36c0 8003f620 00000000
fea0: 00000000 9e14fea8 80e981a0 80a26e60 00000000 80843dfc 80661fac 9e135300
fec0: 9fbd36f0 9e14e000 9e135318 9e14e000 9fbd36c0 8094e442 9e14ff24 9e14fee8
fee0: 8003f700 8003eec4 80662510 00000000 9e134ac0 9e14e000 8003f5dc 00000000
ff00: 9e134ac0 9e135300 8003f5dc 00000000 00000000 00000000 9e14ffac 9e14ff28
ff20: 800463bc 8003f5e8 800663bc 00000000 9e14ff54 9e135300 00000000 00000000
ff40: dead4ead ffffffff ffffffff 80952424 00000000 00000000 807cc28c 9e14ff5c
ff60: 9e14ff5c 00000001 00010001 dead4ead ffffffff ffffffff 80952424 00000000
ff80: 00000000 807cc28c 9e14ff88 9e14ff88 9e134ac0 800462ec 00000000 00000000
ffa0: 00000000 9e14ffb0 8000eb68 800462f8 00000000 00000000 00000000 00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 00c37f70 76f142d0
Backtrace:
[<8004672c>] (kthread_data) from [<8004047c>] (wq_worker_sleeping+0x14/0xc8)
[<80040468>] (wq_worker_sleeping) from [<8065dd8c>] (__schedule+0x338/0x5cc)
 r4:9fbd3c40 r3:00000020
[<8065da54>] (__schedule) from [<8065e114>] (schedule+0x38/0x88)
 r10:9e068000 r9:9e11c614 r8:9e14e000 r7:9e11c438 r6:9e11c440 r5:9e11c438
 r4:00000001
[<8065e0dc>] (schedule) from [<8002b088>] (do_exit+0x604/0x8d8)
[<8002aa84>] (do_exit) from [<80011ff4>] (die+0x204/0x3c0)
 r7:808f760c
[<80011df0>] (die) from [<80658498>] (__do_kernel_fault.part.9+0x5c/0x7c)
 r10:9e11c440 r9:00000001 r8:00000010 r7:9e14fdf8 r6:00000000 r5:00000017
 r4:00000010
[<8065843c>] (__do_kernel_fault.part.9) from [<8001bcd8>] (do_page_fault+0x1b8/0x3e4)
 r7:00000017 r3:9e14fdf8
[<8001bb20>] (do_page_fault) from [<8000840c>] (do_DataAbort+0x3c/0xa0)
 r10:9fbd6b00 r9:00000001 r8:9e14fdf8 r7:00000010 r6:808f8314 r5:8001bb20
 r4:00000017
[<800083d0>] (do_DataAbort) from [<800128a4>] (__dabt_svc+0x44/0x80)
Exception stack(0x9e14fdf8 to 0x9e14fe40)
fde0:                                                       9e369a00 00000000
fe00: 00000000 00000000 00000000 00000002 9e369a00 00000010 00000000 00000001
fe20: 9fbd6b00 9e14fe5c 80a26e60 9e14fe40 800661b8 804e8fb8 80000013 ffffffff
 r8:00000000 r7:9e14fe2c r6:ffffffff r5:80000013 r4:804e8fb8
[<804e8f3c>] (sgtl5000_resume) from [<804d90d0>] (soc_resume_deferred+0x10c/0x30c)
 r7:9e387da4 r6:9e387c64 r5:9e369a00 r4:9e387d84
[<804d8fc4>] (soc_resume_deferred) from [<8003f060>] (process_one_work+0x1a8/0x444)
 r10:9fbd6b00 r8:00000000 r7:9e14e000 r6:9fbd36c0 r5:9e387d84 r4:9e135300
[<8003eeb8>] (process_one_work) from [<8003f700>] (worker_thread+0x124/0x398)
 r10:8094e442 r9:9fbd36c0 r8:9e14e000 r7:9e135318 r6:9e14e000 r5:9fbd36f0
 r4:9e135300
[<8003f5dc>] (worker_thread) from [<800463bc>] (kthread+0xd0/0xec)
 r10:00000000 r9:00000000 r8:00000000 r7:8003f5dc r6:9e135300 r5:9e134ac0
 r4:00000000
[<800462ec>] (kthread) from [<8000eb68>] (ret_from_fork+0x14/0x2c)
 r7:00000000 r6:00000000 r5:800462ec r4:9e134ac0
Code: e1a0c00d e92dd800 e24cb004 e590322c (e5130030)
---[ end trace eeb2712470f0de35 ]---
Fixing recursive fault but reboot is needed!
BUG: spinlock lockup suspected on CPU#0, kworker/0:1/21
 lock: 0x9fbd3c40, .magic: dead4ead, .owner: kworker/0:1/21, .owner_cpu: 0
CPU: 0 PID: 21 Comm: kworker/0:1 Tainted: G      D       3.15.0-rc3-00071-g49a96400a142-dirty #118
Backtrace:
[<80011c50>] (dump_backtrace) from [<80011dec>] (show_stack+0x18/0x1c)
 r6:016e3600 r5:00000000 r4:00000000 r3:00000000
[<80011dd4>] (show_stack) from [<8065b720>] (dump_stack+0x88/0xa4)
[<8065b698>] (dump_stack) from [<806595ac>] (spin_dump+0x7c/0x90)
 r5:9fbd3c40 r4:9e11c440
[<80659530>] (spin_dump) from [<80068a74>] (do_raw_spin_lock+0x110/0x198)
 r5:00000000 r4:016e3600
[<80068964>] (do_raw_spin_lock) from [<80661fac>] (_raw_spin_lock_irq+0x44/0x4c)
 r10:808f2d2c r9:8094e944 r8:808e8c40 r7:00000000 r6:9e14e000 r5:8065dab4
 r4:9fbd3c40 r3:9e11c440
[<80661f68>] (_raw_spin_lock_irq) from [<8065dab4>] (__schedule+0x60/0x5cc)
 r5:9e11c440 r4:9fbd3c40
[<8065da54>] (__schedule) from [<8065e114>] (schedule+0x38/0x88)
 r10:00000001 r9:8094e944 r8:9e14e000 r7:808f760c r6:9e11c440 r5:0000000b
 r4:0000000b
[<8065e0dc>] (schedule) from [<8002b2dc>] (do_exit+0x858/0x8d8)
[<8002aa84>] (do_exit) from [<80011ff4>] (die+0x204/0x3c0)
 r7:808f760c
[<80011df0>] (die) from [<80658498>] (__do_kernel_fault.part.9+0x5c/0x7c)
 r10:9e11c440 r9:9e11c698 r8:ffffffd0 r7:9e14fab8 r6:00000000 r5:00000017
 r4:ffffffd0
[<8065843c>] (__do_kernel_fault.part.9) from [<8001bcd8>] (do_page_fault+0x1b8/0x3e4)
 r7:00000017 r3:9e14fab8
[<8001bb20>] (do_page_fault) from [<8000840c>] (do_DataAbort+0x3c/0xa0)
 r10:808f2d2c r9:9e11c698 r8:9e14fab8 r7:ffffffd0 r6:808f8314 r5:8001bb20
 r4:00000017
[<800083d0>] (do_DataAbort) from [<800128a4>] (__dabt_svc+0x44/0x80)
Exception stack(0x9e14fab8 to 0x9e14fb00)
faa0:                                                       9e11c440 00000000
fac0: 00000000 00000000 00000000 9e11c440 9e14e000 00000000 808e8c40 9e11c698
fae0: 808f2d2c 9e14fb0c 9e14fb10 9e14fb00 8004047c 8004673c 00000193 ffffffff
 r8:808e8c40 r7:9e14faec r6:ffffffff r5:00000193 r4:8004673c
[<8004672c>] (kthread_data) from [<8004047c>] (wq_worker_sleeping+0x14/0xc8)
[<80040468>] (wq_worker_sleeping) from [<8065dd8c>] (__schedule+0x338/0x5cc)
 r4:9fbd3c40 r3:00000020
[<8065da54>] (__schedule) from [<8065e114>] (schedule+0x38/0x88)
 r10:9e068000 r9:9e11c614 r8:9e14e000 r7:9e11c438 r6:9e11c440 r5:9e11c438
 r4:00000001
[<8065e0dc>] (schedule) from [<8002b088>] (do_exit+0x604/0x8d8)
[<8002aa84>] (do_exit) from [<80011ff4>] (die+0x204/0x3c0)
 r7:808f760c
[<80011df0>] (die) from [<80658498>] (__do_kernel_fault.part.9+0x5c/0x7c)
 r10:9e11c440 r9:00000001 r8:00000010 r7:9e14fdf8 r6:00000000 r5:00000017
 r4:00000010
[<8065843c>] (__do_kernel_fault.part.9) from [<8001bcd8>] (do_page_fault+0x1b8/0x3e4)
 r7:00000017 r3:9e14fdf8
[<8001bb20>] (do_page_fault) from [<8000840c>] (do_DataAbort+0x3c/0xa0)
 r10:9fbd6b00 r9:00000001 r8:9e14fdf8 r7:00000010 r6:808f8314 r5:8001bb20
 r4:00000017
[<800083d0>] (do_DataAbort) from [<800128a4>] (__dabt_svc+0x44/0x80)
Exception stack(0x9e14fdf8 to 0x9e14fe40)
fde0:                                                       9e369a00 00000000
fe00: 00000000 00000000 00000000 00000002 9e369a00 00000010 00000000 00000001
fe20: 9fbd6b00 9e14fe5c 80a26e60 9e14fe40 800661b8 804e8fb8 80000013 ffffffff
 r8:00000000 r7:9e14fe2c r6:ffffffff r5:80000013 r4:804e8fb8
[<804e8f3c>] (sgtl5000_resume) from [<804d90d0>] (soc_resume_deferred+0x10c/0x30c)
 r7:9e387da4 r6:9e387c64 r5:9e369a00 r4:9e387d84
[<804d8fc4>] (soc_resume_deferred) from [<8003f060>] (process_one_work+0x1a8/0x444)
 r10:9fbd6b00 r8:00000000 r7:9e14e000 r6:9fbd36c0 r5:9e387d84 r4:9e135300
[<8003eeb8>] (process_one_work) from [<8003f700>] (worker_thread+0x124/0x398)
 r10:8094e442 r9:9fbd36c0 r8:9e14e000 r7:9e135318 r6:9e14e000 r5:9fbd36f0
 r4:9e135300
[<8003f5dc>] (worker_thread) from [<800463bc>] (kthread+0xd0/0xec)
 r10:00000000 r9:00000000 r8:00000000 r7:8003f5dc r6:9e135300 r5:9e134ac0
 r4:00000000
[<800462ec>] (kthread) from [<8000eb68>] (ret_from_fork+0x14/0x2c)
 r7:00000000 r6:00000000 r5:800462ec r4:9e134ac0
