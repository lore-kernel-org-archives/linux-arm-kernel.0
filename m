From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 7 Oct 2017 02:42:13 +0200
Subject: arm64: 4.14 of_match_node() issues
Message-ID: <5d2ff063-1f7e-0200-cc02-99804f7d9219@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Since 4.14-rc1 I am seeing frequent oopses during module loading (e.g.,
MMC, USB) from initrd on aarch64. Symptoms are similar to this in -rc3:

[  OK  ] Started udev Coldplug all Devices.
[   10.117775] usbcore: registered new interface driver usbfs
[   10.118235] Unable to handle kernel paging request at virtual address
ffff000008e5abc0
[   10.118238] Mem abort info:
[   10.118245]   Exception class = DABT (current EL), IL = 32 bits
[   10.118249]   SET = 0, FnV = 0
[   10.118253]   EA = 0, S1PTW = 0
[   10.118256] Data abort info:
[   10.118261]   ISV = 0, ISS = 0x00000006
[   10.118264]   CM = 0, WnR = 0
[   10.118274] swapper pgtable: 4k pages, 48-bit VAs, pgd = ffff0000094a5000
[   10.118279] [ffff000008e5abc0] *pgd=00000000bfffe003,
*pud=00000000bfffd003, *pmd=0000000000000000
[   10.118299] Internal error: Oops: 96000006 [#1] SMP
[   10.118305] Modules linked in: fixed usbcore(+) sunxi_mmc mmc_core
phy_sun4i_usb sg
[   10.118341] CPU: 3 PID: 49 Comm: kworker/3:1 Not tainted
4.14.0-rc3-2.gf27997b-default #1
[   10.118345] Hardware name: sunxi sunxi/sunxi, BIOS 2017.05-rc1 04/13/2017
[   10.118369] Workqueue: events deferred_probe_work_func
[   10.118378] task: ffff80007c8f4000 task.stack: ffff0000099d8000
[   10.118394] PC is at __of_match_node.part.1+0x48/0x88
[   10.118403] LR is at of_match_node+0x40/0x70
[   10.118411] pc : [<ffff00000879aed0>] lr : [<ffff00000879af50>]
pstate: a00001c5
[   10.118414] sp : ffff0000099dbbc0
[   10.118419] x29: ffff0000099dbbc0 x28: 0000000000000000
[   10.118429] x27: 0000000000000000 x26: ffff000008bb9620
[   10.118440] x25: 00000000fffffef7 x24: ffff000009328000
[   10.118450] x23: ffff0000093840e8 x22: ffff80007ffde170
[   10.118461] x21: 0000000000000000 x20: 0000000000000000
[   10.118471] x19: ffff000008e5abc0 x18: ffffffffffffffff
[   10.118481] x17: 0000ffff99368ee0 x16: ffff0000081700b0
[   10.118491] x15: ffff000009219c08 x14: ffff80007a6ae91c
[   10.118501] x13: 0000000000000040 x12: 0000000000000020
[   10.118511] x11: 0000000000000001 x10: 0101010101010101
[   10.118521] x9 : 06fefeff01fefeff x8 : 7f7f7f7f7f7f7f7f
[   10.118532] x7 : 2d2f2f2f652f6230 x6 : 4306574b54455d43
[   10.118542] x5 : 435d45544b570643 x4 : 0000000000000000
[   10.118551] x3 : 0000000000000000 x2 : 0000000000000000
[   10.118561] x1 : ffff80007ffde170 x0 : ffff00000879af50
[   10.118574] Process kworker/3:1 (pid: 49, stack limit =
0xffff0000099d8000)
[   10.118578] Call trace:
[   10.118587] Exception stack(0xffff0000099dba80 to 0xffff0000099dbbc0)
[   10.118599] ba80: ffff00000879af50 ffff80007ffde170 0000000000000000
0000000000000000
[   10.118609] baa0: 0000000000000000 435d45544b570643 4306574b54455d43
2d2f2f2f652f6230
[   10.118620] bac0: 7f7f7f7f7f7f7f7f 06fefeff01fefeff 0101010101010101
0000000000000001
[   10.118631] bae0: 0000000000000020 0000000000000040 ffff80007a6ae91c
ffff000009219c08
[   10.118641] bb00: ffff0000081700b0 0000ffff99368ee0 ffffffffffffffff
ffff000008e5abc0
[   10.118652] bb20: 0000000000000000 0000000000000000 ffff80007ffde170
ffff0000093840e8
[   10.118662] bb40: ffff000009328000 00000000fffffef7 ffff000008bb9620
0000000000000000
[   10.118673] bb60: 0000000000000000 ffff0000099dbbc0 ffff00000879af50
ffff0000099dbbc0
[   10.118683] bb80: ffff00000879aed0 00000000a00001c5 0000000000000000
ffff80007ffde170
[   10.118694] bba0: ffffffffffffffff ffff000009328000 ffff0000099dbbc0
ffff00000879aed0
[   10.118707] [<ffff00000879aed0>] __of_match_node.part.1+0x48/0x88
[   10.118718] [<ffff00000879af50>] of_match_node+0x40/0x70
[   10.118730] [<ffff00000879d0f8>] of_match_device+0x30/0x50
[   10.118742] [<ffff00000869208c>] platform_match+0x4c/0xe8
[   10.118756] [<ffff00000868f2a4>] __device_attach_driver+0x44/0x150
[   10.118768] [<ffff00000868ca54>] bus_for_each_drv+0x5c/0xa8
[   10.118780] [<ffff00000868ead0>] __device_attach+0xc8/0x160
[   10.118793] [<ffff00000868f42c>] device_initial_probe+0x24/0x30
[   10.118805] [<ffff00000868dc98>] bus_probe_device+0xa0/0xa8
[   10.118817] [<ffff00000868e300>] deferred_probe_work_func+0x60/0x180
[   10.118832] [<ffff0000080ea284>] process_one_work+0x1e4/0x448
[   10.118844] [<ffff0000080ea538>] worker_thread+0x50/0x498
[   10.118855] [<ffff0000080f15e8>] kthread+0x138/0x140
[   10.118869] [<ffff000008084e74>] ret_from_fork+0x10/0x1c
[   10.118884] Code: 1a80d281 9a93d2b5 2a0103f4 91032273 (39400264)
[   10.118893] ---[ end trace 4d55fd47910d1a86 ]---

This has been observed on Pine64 (>60%; also by Stefan) and Odroid-C2;
my other arm64 boards such as Raspberry Pi 3 have not run into this so
far. No such problems on 32-bit boards.

This is using the openSUSE config:
https://kernel.opensuse.org/cgit/kernel-source/plain/config/arm64/default

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
