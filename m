From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 7 Jun 2016 14:50:12 -0400
Subject: [PATCH 17/34] clk: maxgen: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-18-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-18-stephen.boyd@linaro.org>
Message-ID: <CABxcv=mWdwPrGRrP7ay=2FBxzoew6yBdfjZNvgFeDGACnQZdcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

On Wed, Jun 1, 2016 at 7:15 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in
> these drivers, allowing us to move closer to a clear split of
> consumer and provider clk APIs.
>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

This email address doesn't exist anymore, you can use
javier at osg.samsung.com instead.

> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>
> See commit 58657d189a2f and it's children for details on this
> new registration API.
>

I tried this patch on top of linux-next and my Peach Pi Chromebook
(that has a max77802 chip) failed to boot. Following is the relevant
parts from the boot log:

[    3.096860] WARNING: CPU: 1 PID: 121 at include/linux/kref.h:46
__clk_get+0x90/0x98
[    3.096882] Modules linked in:
[    3.096896] CPU: 1 PID: 121 Comm: kworker/u16:2 Not tainted
4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[    3.096905] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    3.096926] Workqueue: deferwq deferred_probe_work_func
[    3.096956] [<c010e1ac>] (unwind_backtrace) from [<c010af38>]
(show_stack+0x10/0x14)
[    3.096971] [<c010af38>] (show_stack) from [<c032479c>]
(dump_stack+0x88/0x9c)
[    3.096986] [<c032479c>] (dump_stack) from [<c011a82c>] (__warn+0xe8/0x100)
[    3.096997] [<c011a82c>] (__warn) from [<c011a8f4>]
(warn_slowpath_null+0x20/0x28)
[    3.097009] [<c011a8f4>] (warn_slowpath_null) from [<c05528dc>]
(__clk_get+0x90/0x98)
[    3.097024] [<c05528dc>] (__clk_get) from [<c0552a40>]
(__of_clk_get_from_provider+0x70/0x10c)
[    3.097041] [<c0552a40>] (__of_clk_get_from_provider) from
[<c054f160>] (__of_clk_get_by_name+0xf0/0x108)
[    3.097055] [<c054f160>] (__of_clk_get_by_name) from [<c054f1c0>]
(clk_get+0x2c/0x5c)
[    3.097070] [<c054f1c0>] (clk_get) from [<c054ed54>] (devm_clk_get+0x3c/0x78)
[    3.097086] [<c054ed54>] (devm_clk_get) from [<c04e4798>]
(s3c_rtc_probe+0x2bc/0x438)
[    3.097101] [<c04e4798>] (s3c_rtc_probe) from [<c03fc040>]
(platform_drv_probe+0x4c/0xb0)
[    3.097115] [<c03fc040>] (platform_drv_probe) from [<c03fa794>]
(driver_probe_device+0x214/0x2c0)
[    3.097136] [<c03fa794>] (driver_probe_device) from [<c03f8bb4>]
(bus_for_each_drv+0x60/0x94)
[    3.097149] [<c03f8bb4>] (bus_for_each_drv) from [<c03fa4a0>]
(__device_attach+0xb0/0x114)
[    3.097163] [<c03fa4a0>] (__device_attach) from [<c03f9adc>]
(bus_probe_device+0x84/0x8c)
[    3.097174] [<c03f9adc>] (bus_probe_device) from [<c03f9f6c>]
(deferred_probe_work_func+0x68/0x98)
[    3.097193] [<c03f9f6c>] (deferred_probe_work_func) from
[<c012ff2c>] (process_one_work+0x124/0x338)
[    3.097208] [<c012ff2c>] (process_one_work) from [<c0130178>]
(worker_thread+0x38/0x4d4)
[    3.097224] [<c0130178>] (worker_thread) from [<c0135454>]
(kthread+0xdc/0xf4)
[    3.097239] [<c0135454>] (kthread) from [<c0107978>]
(ret_from_fork+0x14/0x3c)
[    3.097251] ---[ end trace c79e2db53b5a7881 ]---
[    3.097286] Unable to handle kernel NULL pointer dereference at
virtual address 0000003f
[    3.097293] pgd = c0004000
[    3.097312] [0000003f] *pgd=00000000
[    3.097324] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    3.097342] Modules linked in:
[    3.097354] CPU: 1 PID: 121 Comm: kworker/u16:2 Tainted: G        W
      4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[    3.097364] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    3.097384] Workqueue: deferwq deferred_probe_work_func
[    3.097394] task: ed22b200 ti: c3b9c000 task.ti: c3b9c000
[    3.097408] PC is at clk_core_enable+0x10/0x98
[    3.097420] LR is at clk_core_enable+0x40/0x98
[    3.097430] pc : [<c054fc84>]    lr : [<c054fcb4>]    psr: a0000093
[    3.097430] sp : c3b9dde8  ip : 00000000  fp : c3abed80
[    3.097442] r10: edc1a800  r9 : 00000004  r8 : 00000000
[    3.097453] r7 : edd72734  r6 : ede32a10  r5 : a0000013  r4 : ffffffff
[    3.097462] r3 : 00000000  r2 : 00000001  r1 : 00000001  r0 : ffffffff
[    3.097474] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[    3.097484] Control: 10c5387d  Table: 2000406a  DAC: 00000051
[    3.097495] Process kworker/u16:2 (pid: 121, stack limit = 0xc3b9c210)
[    3.097508] Stack: (0xc3b9dde8 to 0xc3b9e000)
[    3.097520] dde0:                   c3894340 a0000013 ede32a10
c054fcb4 edd75a40 a0000013
[    3.097532] de00: ede32a10 c0550720 edd72710 edd75a40 ede32a10
c04e48bc ede1f550 00000001
[    3.097546] de20: c089ff18 00000004 ede1f550 c3a88d70 00000000
ede1f550 00000001 c089ff18
[    3.097558] de40: edd74d70 ede32a10 ede32a10 ede32a10 ede32a10
ede32a10 ede32a10 c0b2a504
[    3.097570] de60: fffffdfb c03fc040 ede32a10 c0b8308c c0b83094
c0b2a504 00000000 c03fa794
[    3.097582] de80: 00000000 c3b9deb8 c03fa924 00000001 00000000
00000000 edc1a800 c03f8bb4
[    3.097594] dea0: edc05894 c3a69644 ede32a10 ede32a44 c0b211f0
c03fa4a0 ede32a10 00000001
[    3.097603] dec0: c0b473a8 ede32a10 ede32a10 c0b211f0 c3b5ad00
c03f9adc ede32a10 c0b20f9c
[    3.097615] dee0: c0b20fc8 c03f9f6c c3abed80 c0b20fe8 edc1a800
c012ff2c c3abed80 edc1a824
[    3.097628] df00: edc1a800 c3abed98 00000088 edc1a824 c0b02100
c3b9c000 edc1a800 c0130178
[    3.097638] df20: c3b9c000 c3ac26c0 c3abed80 00000000 c3ac26c0
c3abed80 c0130140 00000000
[    3.097649] df40: 00000000 00000000 00000000 c0135454 e7fddef0
00000000 e7fddef0 c3abed80
[    3.097663] df60: 00000000 00000000 dead4ead ffffffff ffffffff
c3b9df74 c3b9df74 00000000
[    3.097675] df80: 00000000 dead4ead ffffffff ffffffff c3b9df90
c3b9df90 c3b9dfac c3ac26c0
[    3.097688] dfa0: c0135378 00000000 00000000 c0107978 00000000
00000000 00000000 00000000
[    3.097700] dfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    3.097710] dfe0: 00000000 00000000 00000000 00000000 00000013
00000000 e7fddef0 e7fddef0
[    3.097725] [<c054fc84>] (clk_core_enable) from [<c054fcb4>]
(clk_core_enable+0x40/0x98)
[    3.097741] [<c054fcb4>] (clk_core_enable) from [<c0550720>]
(clk_enable+0x20/0x34)
[    3.097754] [<c0550720>] (clk_enable) from [<c04e48bc>]
(s3c_rtc_probe+0x3e0/0x438)
[    3.097767] [<c04e48bc>] (s3c_rtc_probe) from [<c03fc040>]
(platform_drv_probe+0x4c/0xb0)
[    3.097781] [<c03fc040>] (platform_drv_probe) from [<c03fa794>]
(driver_probe_device+0x214/0x2c0)
[    3.097792] [<c03fa794>] (driver_probe_device) from [<c03f8bb4>]
(bus_for_each_drv+0x60/0x94)
[    3.097802] [<c03f8bb4>] (bus_for_each_drv) from [<c03fa4a0>]
(__device_attach+0xb0/0x114)
[    3.097815] [<c03fa4a0>] (__device_attach) from [<c03f9adc>]
(bus_probe_device+0x84/0x8c)
[    3.097827] [<c03f9adc>] (bus_probe_device) from [<c03f9f6c>]
(deferred_probe_work_func+0x68/0x98)
[    3.097841] [<c03f9f6c>] (deferred_probe_work_func) from
[<c012ff2c>] (process_one_work+0x124/0x338)
[    3.097857] [<c012ff2c>] (process_one_work) from [<c0130178>]
(worker_thread+0x38/0x4d4)
[    3.097870] [<c0130178>] (worker_thread) from [<c0135454>]
(kthread+0xdc/0xf4)
[    3.097882] [<c0135454>] (kthread) from [<c0107978>]
(ret_from_fork+0x14/0x3c)
[    3.097897] Code: e3500000 012fff1e e92d4070 e1a04000 (e5903040)
[    3.097915] ---[ end trace c79e2db53b5a7882 ]---
[    3.097929] note: kworker/u16:2[121] exited with preempt_count 1
[    3.098019] Unable to handle kernel paging request at virtual
address ffffffe0
[    3.098029] pgd = c0004000
[    3.098064] [ffffffe0] *pgd=4fffd861, *pte=00000000, *ppte=00000000
[    3.098075] Internal error: Oops: 37 [#2] PREEMPT SMP ARM
[    3.098094] Modules linked in:
[    3.098107] CPU: 1 PID: 121 Comm: kworker/u16:2 Tainted: G      D W
      4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[    3.098117] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    3.098133] task: ed22b200 ti: c3b9c000 task.ti: c3b9c000
[    3.098143] PC is at kthread_data+0x4/0xc
[    3.098155] LR is at wq_worker_sleeping+0x8/0xc8
[    3.098166] pc : [<c0135a58>]    lr : [<c0130dbc>]    psr: 00000193
[    3.098166] sp : c3b9dc20  ip : 00000400  fp : c3b9dc4c
[    3.098175] r10: ed22b200  r9 : 00000000  r8 : c0b0261c
[    3.098185] r7 : ed22b54c  r6 : ed22b200  r5 : ee34c000  r4 : c0a64000
[    3.098195] r3 : 00000000  r2 : 00000000  r1 : ed22b200  r0 : ed22b200
[    3.098205] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[    3.098214] Control: 10c5387d  Table: 2000406a  DAC: 00000051
[    3.098224] Process kworker/u16:2 (pid: 121, stack limit = 0xc3b9c210)
[    3.098234] Stack: (0xc3b9dc20 to 0xc3b9e000)
[    3.098246] dc20: c0a64000 c06cf400 ed22b200 ee34c640 c3b9c000
c3b9d98c 00000001 edc88000
[    3.098260] dc40: c3b9dc60 ed22b4b8 c3b9dc5c c06cf61c ed22b200
c3b9d98c c3abed80 c011cf54
[    3.098270] dc60: c3b9dc60 c3b9dc60 c3b9c000 c0b45404 0000000b
c0878584 00000005 60000193
[    3.098282] dc80: c0b0680c ed22b200 c3abed80 c010b168 c3b9c210
0000000b 0000003f c3b9dd98
[    3.098296] dca0: 00000005 00000000 0000003f 00000004 edc1a800
c0114f58 00000005 c0110a08
[    3.098308] dcc0: 00000000 00000000 60000013 00000000 ffffffff
c0b06a4c 00000005 c0110aa4
[    3.098318] dce0: 0000003f c3b9dd98 00000004 edc1a800 c3abed80
c0101334 c087ac10 c3b9dd24
[    3.098329] dd00: c3abed80 c01955b8 c3abed80 c3b9dd24 00000000
00000000 00000000 c011a7e4
[    3.098343] dd20: c087ac10 ffde7db5 3b5a7881 c79e2db5 0000002e
c05528dc 00000001 00000001
[    3.098354] dd40: c0b2ff84 c3b9dd50 c0b473a8 c06d1f70 00000001
c3b9dd50 00000000 edd75a40
[    3.098366] dd60: c38944c0 c3b9dd90 ede1e380 c0552a50 ede1e380
c08c57a8 ee3a74a8 00000001
[    3.098378] dd80: c054fc84 a0000093 ffffffff c3b9ddcc 00000000
c010b960 ffffffff 00000001
[    3.098391] dda0: 00000001 00000000 ffffffff a0000013 ede32a10
edd72734 00000000 00000004
[    3.098401] ddc0: edc1a800 c3abed80 00000000 c3b9dde8 c054fcb4
c054fc84 a0000093 ffffffff
[    3.098414] dde0: 00000051 a0000013 c3894340 a0000013 ede32a10
c054fcb4 edd75a40 a0000013
[    3.098426] de00: ede32a10 c0550720 edd72710 edd75a40 ede32a10
c04e48bc ede1f550 00000001
[    3.098436] de20: c089ff18 00000004 ede1f550 c3a88d70 00000000
ede1f550 00000001 c089ff18
[    3.098450] de40: edd74d70 ede32a10 ede32a10 ede32a10 ede32a10
ede32a10 ede32a10 c0b2a504
[    3.098465] de60: fffffdfb c03fc040 ede32a10 c0b8308c c0b83094
c0b2a504 00000000 c03fa794
[    3.098478] de80: 00000000 c3b9deb8 c03fa924 00000001 00000000
00000000 edc1a800 c03f8bb4
[    3.098488] dea0: edc05894 c3a69644 ede32a10 ede32a44 c0b211f0
c03fa4a0 ede32a10 00000001
[    3.098501] dec0: c0b473a8 ede32a10 ede32a10 c0b211f0 c3b5ad00
c03f9adc ede32a10 c0b20f9c
[    3.098513] dee0: c0b20fc8 c03f9f6c c3abed80 c0b20fe8 edc1a800
c012ff2c c3abed80 edc1a824
[    3.098526] df00: edc1a800 c3abed98 00000088 edc1a824 c0b02100
c3b9c000 edc1a800 c0130178
[    3.098538] df20: c3b9c000 c3ac26c0 c3abed80 00000000 c3ac26c0
c3abed80 c0130140 00000000
[    3.098549] df40: 00000000 00000000 00000000 c0135454 e7fddef0
00000000 e7fddef0 c3abed80
[    3.098562] df60: 00000000 00000000 dead4ead ffffffff ffffffff
c3b9df74 c3b9df74 00000001
[    3.098574] df80: 00010001 dead4ead ffffffff ffffffff c3b9df90
c3b9df90 c3b9dfac c3ac26c0
[    3.098580] dfa0: c0135378 00000000 00000000 c0107978 00000000
00000000 00000000 00000000
[    3.098588] dfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    3.098593] dfe0: 00000000 00000000 00000000 00000000 00000013
00000000 e7fddef0 e7fddef0
[    3.098602] [<c0135a58>] (kthread_data) from [<c0130dbc>]
(wq_worker_sleeping+0x8/0xc8)
[    3.098619] [<c0130dbc>] (wq_worker_sleeping) from [<c06cf400>]
(__schedule+0x2d4/0x4a4)
[    3.098629] [<c06cf400>] (__schedule) from [<c06cf61c>] (schedule+0x4c/0xac)
[    3.098641] [<c06cf61c>] (schedule) from [<c011cf54>] (do_exit+0x66c/0xa44)
[    3.098655] [<c011cf54>] (do_exit) from [<c010b168>] (die+0x22c/0x2ec)
[    3.098669] [<c010b168>] (die) from [<c0114f58>]
(__do_kernel_fault.part.0+0x64/0x1e4)
[    3.098687] [<c0114f58>] (__do_kernel_fault.part.0) from
[<c0110a08>] (do_bad_area+0x0/0x8c)
[    3.098702] [<c0110a08>] (do_bad_area) from [<c0110aa4>]
(do_translation_fault+0x0/0xac)
[    3.098712] [<c0110aa4>] (do_translation_fault) from [<edc1a800>]
(0xedc1a800)
[    3.098725] Code: e3a02002 e0431101 eaffff8e e5903310 (e5130020)
[    3.098744] ---[ end trace c79e2db53b5a7883 ]---
[    3.098754] Fixing recursive fault but reboot is needed!
[    3.104585] smsc95xx 5-1.1:1.0 eth0: register 'smsc95xx' at
usb-xhci-hcd.6.auto-1.1, smsc95xx USB 2.0 Ethernet, 94:eb:2c:00:03:c0
[   43.484379] BUG: spinlock lockup suspected on CPU#1, kworker/u16:2/121
[   43.489456]  lock: 0xee34c000, .magic: dead4ead, .owner:
kworker/u16:2/121, .owner_cpu: 1
[   43.497614] CPU: 1 PID: 121 Comm: kworker/u16:2 Tainted: G      D W
      4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   43.508631] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   43.514707] [<c010e1ac>] (unwind_backtrace) from [<c010af38>]
(show_stack+0x10/0x14)
[   43.522425] [<c010af38>] (show_stack) from [<c032479c>]
(dump_stack+0x88/0x9c)
[   43.529627] [<c032479c>] (dump_stack) from [<c01582a4>]
(do_raw_spin_lock+0xfc/0x1b0)
[   43.537435] [<c01582a4>] (do_raw_spin_lock) from [<c06cf1b0>]
(__schedule+0x84/0x4a4)
[   43.545243] [<c06cf1b0>] (__schedule) from [<c06cf61c>] (schedule+0x4c/0xac)
[   43.552263] [<c06cf61c>] (schedule) from [<c011d16c>] (do_exit+0x884/0xa44)
[   43.559205] [<c011d16c>] (do_exit) from [<c010b168>] (die+0x22c/0x2ec)
[   43.565709] [<c010b168>] (die) from [<c0114f58>]
(__do_kernel_fault.part.0+0x64/0x1e4)
[   43.573607] [<c0114f58>] (__do_kernel_fault.part.0) from
[<c0110a08>] (do_bad_area+0x0/0x8c)
[   43.582023] [<c0110a08>] (do_bad_area) from [<c0110764>]
(do_page_fault+0x0/0x2a4)
[   43.589569] [<c0110764>] (do_page_fault) from [<00000030>] (0x30)
[   43.595635] Sending NMI to all CPUs:
[   43.599187] NMI backtrace for cpu 1
[   43.602663] CPU: 1 PID: 121 Comm: kworker/u16:2 Tainted: G      D W
      4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   43.613686] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   43.619759] [<c010e1ac>] (unwind_backtrace) from [<c010af38>]
(show_stack+0x10/0x14)
[   43.627482] [<c010af38>] (show_stack) from [<c032479c>]
(dump_stack+0x88/0x9c)
[   43.634683] [<c032479c>] (dump_stack) from [<c03280f0>]
(nmi_cpu_backtrace+0x78/0x7c)
[   43.642487] [<c03280f0>] (nmi_cpu_backtrace) from [<c010cb4c>]
(raise_nmi+0x60/0x64)
[   43.650208] [<c010cb4c>] (raise_nmi) from [<c0328064>]
(nmi_trigger_all_cpu_backtrace+0x118/0x12c)
[   43.659144] [<c0328064>] (nmi_trigger_all_cpu_backtrace) from
[<c01582ac>] (do_raw_spin_lock+0x104/0x1b0)
[   43.668688] [<c01582ac>] (do_raw_spin_lock) from [<c06cf1b0>]
(__schedule+0x84/0x4a4)
[   43.676494] [<c06cf1b0>] (__schedule) from [<c06cf61c>] (schedule+0x4c/0xac)
[   43.683517] [<c06cf61c>] (schedule) from [<c011d16c>] (do_exit+0x884/0xa44)
[   43.690456] [<c011d16c>] (do_exit) from [<c010b168>] (die+0x22c/0x2ec)
[   43.696963] [<c010b168>] (die) from [<c0114f58>]
(__do_kernel_fault.part.0+0x64/0x1e4)
[   43.704861] [<c0114f58>] (__do_kernel_fault.part.0) from
[<c0110a08>] (do_bad_area+0x0/0x8c)
[   43.713277] [<c0110a08>] (do_bad_area) from [<c0110764>]
(do_page_fault+0x0/0x2a4)
[   43.720821] [<c0110764>] (do_page_fault) from [<00000030>] (0x30)
[   43.727331] NMI backtrace for cpu 3
[   43.730399] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D W
4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   43.740901] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   43.746960] task: edc8c600 ti: edcc4000 task.ti: edcc4000
[   43.752343] PC is at arch_cpu_idle+0x38/0x3c
[   43.756592] LR is at arch_cpu_idle+0x34/0x3c
[   43.760844] pc : [<c01083bc>]    lr : [<c01083b8>]    psr: 60000113
[   43.767090] sp : edcc5fd8  ip : ee363f74  fp : c0b024b8
[   43.772296] r10: c0b024c0  r9 : c0a633f8  r8 : 00000000
[   43.777499] r7 : 00000000  r6 : 00000008  r5 : c0b02454  r4 : edcc4000
[   43.784007] r3 : c0113e40  r2 : 00000000  r1 : 00000000  r0 : 00000001
[   43.790515] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   43.797628] Control: 10c5387d  Table: 2000406a  DAC: 00000051
[   43.803354] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D W
4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   43.813858] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   43.819924] [<c010e1ac>] (unwind_backtrace) from [<c010af38>]
(show_stack+0x10/0x14)
[   43.827647] [<c010af38>] (show_stack) from [<c032479c>]
(dump_stack+0x88/0x9c)
[   43.834848] [<c032479c>] (dump_stack) from [<c03280d4>]
(nmi_cpu_backtrace+0x5c/0x7c)
[   43.842655] [<c03280d4>] (nmi_cpu_backtrace) from [<c010d398>]
(handle_IPI+0xd8/0x1ac)
[   43.850552] [<c010d398>] (handle_IPI) from [<c01014e4>]
(gic_handle_irq+0x94/0x98)
[   43.858096] [<c01014e4>] (gic_handle_irq) from [<c010b9d4>]
(__irq_svc+0x54/0x90)
[   43.865558] Exception stack(0xedcc5f88 to 0xedcc5fd0)
[   43.870583] 5f80:                   00000001 00000000 00000000
c0113e40 edcc4000 c0b02454
[   43.878744] 5fa0: 00000008 00000000 00000000 c0a633f8 c0b024c0
c0b024b8 ee363f74 edcc5fd8
[   43.886900] 5fc0: c01083b8 c01083bc 60000113 ffffffff
[   43.891923] [<c010b9d4>] (__irq_svc) from [<c01083bc>]
(arch_cpu_idle+0x38/0x3c)
[   43.899301] [<c01083bc>] (arch_cpu_idle) from [<c0151900>]
(cpu_startup_entry+0x1cc/0x250)
[   43.907546] [<c0151900>] (cpu_startup_entry) from [<2010158c>] (0x2010158c)
[   43.914488] NMI backtrace for cpu 4
[   43.917940] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G      D W
4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   43.928436] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   43.934492] task: edc8cb00 ti: edcc6000 task.ti: edcc6000
[   43.939869] PC is at arch_cpu_idle+0x38/0x3c
[   43.944117] LR is at arch_cpu_idle+0x34/0x3c
[   43.948369] pc : [<c01083bc>]    lr : [<c01083b8>]    psr: 60000013
[   43.954617] sp : edcc7fd8  ip : 0000abe0  fp : c0b024b8
[   43.959821] r10: c0b024c0  r9 : c0a633f8  r8 : 00000000
[   43.965028] r7 : 00000000  r6 : 00000010  r5 : c0b02454  r4 : edcc6000
[   43.971537] r3 : c0113e40  r2 : 00000000  r1 : 00000000  r0 : 00000001
[   43.978041] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   43.985154] Control: 10c5387d  Table: 2000406a  DAC: 00000051
[   43.990880] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G      D W
4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   44.001390] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   44.007450] [<c010e1ac>] (unwind_backtrace) from [<c010af38>]
(show_stack+0x10/0x14)
[   44.015180] [<c010af38>] (show_stack) from [<c032479c>]
(dump_stack+0x88/0x9c)
[   44.022380] [<c032479c>] (dump_stack) from [<c03280d4>]
(nmi_cpu_backtrace+0x5c/0x7c)
[   44.030189] [<c03280d4>] (nmi_cpu_backtrace) from [<c010d398>]
(handle_IPI+0xd8/0x1ac)
[   44.038083] [<c010d398>] (handle_IPI) from [<c01014e4>]
(gic_handle_irq+0x94/0x98)
[   44.045630] [<c01014e4>] (gic_handle_irq) from [<c010b9d4>]
(__irq_svc+0x54/0x90)
[   44.053090] Exception stack(0xedcc7f88 to 0xedcc7fd0)
[   44.058109] 7f80:                   00000001 00000000 00000000
c0113e40 edcc6000 c0b02454
[   44.066277] 7fa0: 00000010 00000000 00000000 c0a633f8 c0b024c0
c0b024b8 0000abe0 edcc7fd8
[   44.074432] 7fc0: c01083b8 c01083bc 60000013 ffffffff
[   44.079450] [<c010b9d4>] (__irq_svc) from [<c01083bc>]
(arch_cpu_idle+0x38/0x3c)
[   44.086835] [<c01083bc>] (arch_cpu_idle) from [<c0151900>]
(cpu_startup_entry+0x1cc/0x250)
[   44.095079] [<c0151900>] (cpu_startup_entry) from [<2010158c>] (0x2010158c)
[   44.102013] NMI backtrace for cpu 6
[   44.105473] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G      D W
4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   44.115985] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   44.122040] task: edc8d500 ti: edcca000 task.ti: edcca000
[   44.127418] PC is at arch_cpu_idle+0x38/0x3c
[   44.131665] LR is at arch_cpu_idle+0x34/0x3c
[   44.135918] pc : [<c01083bc>]    lr : [<c01083b8>]    psr: 60000013
[   44.142168] sp : edccbfd8  ip : 0000abe0  fp : c0b024b8
[   44.147369] r10: c0b024c0  r9 : c0a633f8  r8 : 00000000
[   44.152575] r7 : 00000000  r6 : 00000040  r5 : c0b02454  r4 : edcca000
[   44.159080] r3 : c0113e40  r2 : 00000000  r1 : 00000000  r0 : 00000001
[   44.165589] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   44.172705] Control: 10c5387d  Table: 2000406a  DAC: 00000051
[   44.178429] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G      D W
4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   44.188942] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   44.194997] [<c010e1ac>] (unwind_backtrace) from [<c010af38>]
(show_stack+0x10/0x14)
[   44.202729] [<c010af38>] (show_stack) from [<c032479c>]
(dump_stack+0x88/0x9c)
[   44.209929] [<c032479c>] (dump_stack) from [<c03280d4>]
(nmi_cpu_backtrace+0x5c/0x7c)
[   44.217742] [<c03280d4>] (nmi_cpu_backtrace) from [<c010d398>]
(handle_IPI+0xd8/0x1ac)
[   44.225633] [<c010d398>] (handle_IPI) from [<c01014e4>]
(gic_handle_irq+0x94/0x98)
[   44.233179] [<c01014e4>] (gic_handle_irq) from [<c010b9d4>]
(__irq_svc+0x54/0x90)
[   44.240639] Exception stack(0xedccbf88 to 0xedccbfd0)
[   44.245656] bf80:                   00000001 00000000 00000000
c0113e40 edcca000 c0b02454
[   44.253827] bfa0: 00000040 00000000 00000000 c0a633f8 c0b024c0
c0b024b8 0000abe0 edccbfd8
[   44.261982] bfc0: c01083b8 c01083bc 60000013 ffffffff
[   44.266998] [<c010b9d4>] (__irq_svc) from [<c01083bc>]
(arch_cpu_idle+0x38/0x3c)
[   44.274387] [<c01083bc>] (arch_cpu_idle) from [<c0151900>]
(cpu_startup_entry+0x1cc/0x250)
[   44.282629] [<c0151900>] (cpu_startup_entry) from [<2010158c>] (0x2010158c)
[   81.055964] BUG: spinlock lockup suspected on CPU#0, kworker/0:0/4
[   81.060688]  lock: enable_lock+0x0/0x10, .magic: dead4ead, .owner:
kworker/u16:2/121, .owner_cpu: 1
[   81.069700] CPU: 0 PID: 4 Comm: kworker/0:0 Tainted: G      D W
  4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   81.070847] BUG: spinlock lockup suspected on CPU#2, kworker/2:1/108
[   81.070861]  lock: enable_lock+0x0/0x10, .magic: dead4ead, .owner:
kworker/u16:2/121, .owner_cpu: 1
[   81.095720] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   81.101790] Workqueue: events dbs_work_handler
[   81.106215] [<c010e1ac>] (unwind_backtrace) from [<c010af38>]
(show_stack+0x10/0x14)
[   81.113942] [<c010af38>] (show_stack) from [<c032479c>]
(dump_stack+0x88/0x9c)
[   81.121141] [<c032479c>] (dump_stack) from [<c01582a4>]
(do_raw_spin_lock+0xfc/0x1b0)
[   81.128951] [<c01582a4>] (do_raw_spin_lock) from [<c06d3fdc>]
(_raw_spin_lock_irqsave+0x20/0x28)
[   81.137713] [<c06d3fdc>] (_raw_spin_lock_irqsave) from [<c054fdd4>]
(clk_enable_lock+0x58/0x110)
[   81.146474] [<c054fdd4>] (clk_enable_lock) from [<c0550714>]
(clk_enable+0x14/0x34)
[   81.154113] [<c0550714>] (clk_enable) from [<c04eb04c>]
(exynos5_i2c_xfer+0x28/0x2f4)
[   81.161915] [<c04eb04c>] (exynos5_i2c_xfer) from [<c04e6bc8>]
(__i2c_transfer+0x13c/0x278)
[   81.170156] [<c04e6bc8>] (__i2c_transfer) from [<c04e6d70>]
(i2c_transfer+0x6c/0xa8)
[   81.177876] [<c04e6d70>] (i2c_transfer) from [<c04e6de8>]
(i2c_master_send+0x3c/0x4c)
[   81.185685] [<c04e6de8>] (i2c_master_send) from [<c0415d30>]
(regmap_i2c_write+0x10/0x2c)
[   81.193847] [<c0415d30>] (regmap_i2c_write) from [<c0411dd0>]
(_regmap_raw_write+0x514/0x5f0)
[   81.202342] [<c0411dd0>] (_regmap_raw_write) from [<c0411154>]
(_regmap_update_bits+0xc0/0xc4)
[   81.210929] [<c0411154>] (_regmap_update_bits) from [<c04120c0>]
(regmap_update_bits_base+0x50/0x74)
[   81.220047] [<c04120c0>] (regmap_update_bits_base) from
[<c037d910>] (regulator_set_voltage_sel_regmap+0x4c/0x9c)
[   81.230277] [<c037d910>] (regulator_set_voltage_sel_regmap) from
[<c03799e4>] (_regulator_do_set_voltage+0x288/0x358)
[   81.240859] [<c03799e4>] (_regulator_do_set_voltage) from
[<c037a624>] (regulator_set_voltage_unlocked+0x1d8/0x22c)
[   81.251268] [<c037a624>] (regulator_set_voltage_unlocked) from
[<c037a6a0>] (regulator_set_voltage+0x28/0x54)
[   81.261166] [<c037a6a0>] (regulator_set_voltage) from [<c0408868>]
(_set_opp_voltage+0x30/0x98)
[   81.269834] [<c0408868>] (_set_opp_voltage) from [<c0408fa8>]
(dev_pm_opp_set_rate+0x10c/0x2b4)
[   81.278513] [<c0408fa8>] (dev_pm_opp_set_rate) from [<c050dbdc>]
(__cpufreq_driver_target+0x170/0x2d4)
[   81.287792] [<c050dbdc>] (__cpufreq_driver_target) from
[<c0510ec8>] (od_dbs_timer+0x9c/0x168)
[   81.296377] [<c0510ec8>] (od_dbs_timer) from [<c0511474>]
(dbs_work_handler+0x2c/0x60)
[   81.304271] [<c0511474>] (dbs_work_handler) from [<c012ff2c>]
(process_one_work+0x124/0x338)
[   81.312686] [<c012ff2c>] (process_one_work) from [<c0130178>]
(worker_thread+0x38/0x4d4)
[   81.320755] [<c0130178>] (worker_thread) from [<c0135454>]
(kthread+0xdc/0xf4)
[   81.327954] [<c0135454>] (kthread) from [<c0107978>]
(ret_from_fork+0x14/0x3c)
[   81.335151] Sending NMI to all CPUs:
[   81.335155] CPU: 2 PID: 108 Comm: kworker/2:1 Tainted: G      D W
    4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   81.335160] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   81.335178] Workqueue: pm pm_runtime_work
[   81.335192] [<c010e1ac>] (unwind_backtrace) from [<c010af38>]
(show_stack+0x10/0x14)
[   81.335203] [<c010af38>] (show_stack) from [<c032479c>]
(dump_stack+0x88/0x9c)
[   81.335213] [<c032479c>] (dump_stack) from [<c01582a4>]
(do_raw_spin_lock+0xfc/0x1b0)
[   81.335224] [<c01582a4>] (do_raw_spin_lock) from [<c06d3fdc>]
(_raw_spin_lock_irqsave+0x20/0x28)
[   81.335235] [<c06d3fdc>] (_raw_spin_lock_irqsave) from [<c054fdd4>]
(clk_enable_lock+0x58/0x110)
[   81.335246] [<c054fdd4>] (clk_enable_lock) from [<c05507e4>]
(clk_disable+0x1c/0x34)
[   81.335257] [<c05507e4>] (clk_disable) from [<c0372774>]
(amba_pm_runtime_suspend+0x50/0x58)
[   81.335268] [<c0372774>] (amba_pm_runtime_suspend) from
[<c0402d18>] (__rpm_callback+0x2c/0x60)
[   81.335278] [<c0402d18>] (__rpm_callback) from [<c0402d6c>]
(rpm_callback+0x20/0x80)
[   81.335289] [<c0402d6c>] (rpm_callback) from [<c0403234>]
(rpm_suspend+0xdc/0x4c0)
[   81.335299] [<c0403234>] (rpm_suspend) from [<c040453c>]
(pm_runtime_work+0x74/0xa8)
[   81.335311] [<c040453c>] (pm_runtime_work) from [<c012ff2c>]
(process_one_work+0x124/0x338)
[   81.335323] [<c012ff2c>] (process_one_work) from [<c0130178>]
(worker_thread+0x38/0x4d4)
[   81.335334] [<c0130178>] (worker_thread) from [<c0135454>]
(kthread+0xdc/0xf4)
[   81.335345] [<c0135454>] (kthread) from [<c0107978>]
(ret_from_fork+0x14/0x3c)
[   81.478460] NMI backtrace for cpu 0
[   81.481925] CPU: 0 PID: 4 Comm: kworker/0:0 Tainted: G      D W
  4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   81.492602] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   81.498669] Workqueue: events dbs_work_handler
[   81.503094] [<c010e1ac>] (unwind_backtrace) from [<c010af38>]
(show_stack+0x10/0x14)
[   81.510822] [<c010af38>] (show_stack) from [<c032479c>]
(dump_stack+0x88/0x9c)
[   81.518022] [<c032479c>] (dump_stack) from [<c03280f0>]
(nmi_cpu_backtrace+0x78/0x7c)
[   81.525829] [<c03280f0>] (nmi_cpu_backtrace) from [<c010cb4c>]
(raise_nmi+0x60/0x64)
[   81.533551] [<c010cb4c>] (raise_nmi) from [<c0328064>]
(nmi_trigger_all_cpu_backtrace+0x118/0x12c)
[   81.542487] [<c0328064>] (nmi_trigger_all_cpu_backtrace) from
[<c01582ac>] (do_raw_spin_lock+0x104/0x1b0)
[   81.552029] [<c01582ac>] (do_raw_spin_lock) from [<c06d3fdc>]
(_raw_spin_lock_irqsave+0x20/0x28)
[   81.560791] [<c06d3fdc>] (_raw_spin_lock_irqsave) from [<c054fdd4>]
(clk_enable_lock+0x58/0x110)
[   81.569553] [<c054fdd4>] (clk_enable_lock) from [<c0550714>]
(clk_enable+0x14/0x34)
[   81.577187] [<c0550714>] (clk_enable) from [<c04eb04c>]
(exynos5_i2c_xfer+0x28/0x2f4)
[   81.584994] [<c04eb04c>] (exynos5_i2c_xfer) from [<c04e6bc8>]
(__i2c_transfer+0x13c/0x278)
[   81.593234] [<c04e6bc8>] (__i2c_transfer) from [<c04e6d70>]
(i2c_transfer+0x6c/0xa8)
[   81.600955] [<c04e6d70>] (i2c_transfer) from [<c04e6de8>]
(i2c_master_send+0x3c/0x4c)
[   81.608762] [<c04e6de8>] (i2c_master_send) from [<c0415d30>]
(regmap_i2c_write+0x10/0x2c)
[   81.616918] [<c0415d30>] (regmap_i2c_write) from [<c0411dd0>]
(_regmap_raw_write+0x514/0x5f0)
[   81.625420] [<c0411dd0>] (_regmap_raw_write) from [<c0411154>]
(_regmap_update_bits+0xc0/0xc4)
[   81.634008] [<c0411154>] (_regmap_update_bits) from [<c04120c0>]
(regmap_update_bits_base+0x50/0x74)
[   81.643118] [<c04120c0>] (regmap_update_bits_base) from
[<c037d910>] (regulator_set_voltage_sel_regmap+0x4c/0x9c)
[   81.653355] [<c037d910>] (regulator_set_voltage_sel_regmap) from
[<c03799e4>] (_regulator_do_set_voltage+0x288/0x358)
[   81.663937] [<c03799e4>] (_regulator_do_set_voltage) from
[<c037a624>] (regulator_set_voltage_unlocked+0x1d8/0x22c)
[   81.674348] [<c037a624>] (regulator_set_voltage_unlocked) from
[<c037a6a0>] (regulator_set_voltage+0x28/0x54)
[   81.684238] [<c037a6a0>] (regulator_set_voltage) from [<c0408868>]
(_set_opp_voltage+0x30/0x98)
[   81.692912] [<c0408868>] (_set_opp_voltage) from [<c0408fa8>]
(dev_pm_opp_set_rate+0x10c/0x2b4)
[   81.701587] [<c0408fa8>] (dev_pm_opp_set_rate) from [<c050dbdc>]
(__cpufreq_driver_target+0x170/0x2d4)
[   81.710870] [<c050dbdc>] (__cpufreq_driver_target) from
[<c0510ec8>] (od_dbs_timer+0x9c/0x168)
[   81.719456] [<c0510ec8>] (od_dbs_timer) from [<c0511474>]
(dbs_work_handler+0x2c/0x60)
[   81.727350] [<c0511474>] (dbs_work_handler) from [<c012ff2c>]
(process_one_work+0x124/0x338)
[   81.735766] [<c012ff2c>] (process_one_work) from [<c0130178>]
(worker_thread+0x38/0x4d4)
[   81.743834] [<c0130178>] (worker_thread) from [<c0135454>]
(kthread+0xdc/0xf4)
[   81.751033] [<c0135454>] (kthread) from [<c0107978>]
(ret_from_fork+0x14/0x3c)
[   81.758426] NMI backtrace for cpu 3
[   81.761710] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D W
4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   81.772212] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   81.778277] task: edc8c600 ti: edcc4000 task.ti: edcc4000
[   81.783655] PC is at arch_cpu_idle+0x38/0x3c
[   81.787905] LR is at arch_cpu_idle+0x34/0x3c
[   81.792155] pc : [<c01083bc>]    lr : [<c01083b8>]    psr: 60000113
[   81.798403] sp : edcc5fd8  ip : ee363f74  fp : c0b024b8
[   81.803608] r10: c0b024c0  r9 : c0a633f8  r8 : 00000000
[   81.808813] r7 : 00000000  r6 : 00000008  r5 : c0b02454  r4 : edcc4000
[   81.815320] r3 : c0113e40  r2 : 00000000  r1 : 00000000  r0 : 00000001
[   81.821826] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   81.828940] Control: 10c5387d  Table: 2000406a  DAC: 00000051
[   81.834666] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D W
4.7.0-rc2-next-20160606-00009-g897c9c5cd3cf #117
[   81.845168] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   81.851233] [<c010e1ac>] (unwind_backtrace) from [<c010af38>]
(show_stack+0x10/0x14)
[   81.858960] [<c010af38>] (show_stack) from [<c032479c>]
(dump_stack+0x88/0x9c)
[   81.866160] [<c032479c>] (dump_stack) from [<c03280d4>]
(nmi_cpu_backtrace+0x5c/0x7c)
[   81.873967] [<c03280d4>] (nmi_cpu_backtrace) from [<c010d398>]
(handle_IPI+0xd8/0x1ac)
[   81.881861] [<c010d398>] (handle_IPI) from [<c01014e4>]
(gic_handle_irq+0x94/0x98)
[   81.889409] [<c01014e4>] (gic_handle_irq) from [<c010b9d4>]
(__irq_svc+0x54/0x90)
[   81.896869] Exception stack(0xedcc5f88 to 0xedcc5fd0)
[   81.901895] 5f80:                   00000001 00000000 00000000
c0113e40 edcc4000 c0b02454
[   81.910056] 5fa0: 00000008 00000000 00000000 c0a633f8 c0b024c0
c0b024b8 ee363f74 edcc5fd8
[   81.918210] 5fc0: c01083b8 c01083bc 60000113 ffffffff
[   81.923236] [<c010b9d4>] (__irq_svc) from [<c01083bc>]
(arch_cpu_idle+0x38/0x3c)
[   81.930615] [<c01083bc>] (arch_cpu_idle) from [<c0151900>]
(cpu_startup_entry+0x1cc/0x250)
[   81.938857] [<c0151900>] (cpu_startup_entry) from [<2010158c>] (0x2010158c)
