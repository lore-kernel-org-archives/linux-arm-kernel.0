From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 29 Jun 2017 19:20:48 +0530
Subject: Warning dump on OMAP-L138 when g_zero module is removed
Message-ID: <748a9491-e834-34cb-993f-e8c7e2538961@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre, Bin,

With latest linux-next, I see a warning dump when I remove g_zero[1] on 
OMAP-L138 LCDK board. I am building the kernel with davinci_all_defconfig.

It is not present in latest mainline because the warnings are introduced
with CPPI DMA getting enabled in latest -next.

Subsequent insertion of g_ether leads to a warning too[2], although the 
gadget seems to work (ping test).

Since these are pretty annoying, it will be nice to get rid of them. I 
have not been able to debug any further. But if you have
ideas/experiments to try, I can do that.

Thanks,
Sekhar

[1] 
root at omapl138-lcdk:~# modprobe g_zero
zero gadget: Gadget Zero, version: Cinco de Mayo 2008
zero gadget: zero ready
musb_g_ep0_irq 712: SetupEnd came in a wrong ep0stage setup
root at omapl138-lcdk:~# zero gadget: high-speed config #3: source/sink

root at omapl138-lcdk:~# modprobe -r g_zero                                                                                                                                                                                                      
------------[ cut here ]------------
WARNING: CPU: 0 PID: 464 at drivers/dma/cppi41.c:694 cppi41_stop_chan+0x208/0x338 [cppi41]
Modules linked in: usb_f_ss_lb g_zero(-) libcomposite configfs ofpart davinci_nand nand nand_ecc cppi41 mtd vpif_display tvp514x vpif_capture videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_core v4l2_fwnode v4l2_common vid4
CPU: 0 PID: 464 Comm: modprobe Tainted: G        W       4.12.0-rc7-next-20170629-10695-g3fb8ba638d53 #76
Hardware name: Generic DA850/OMAP-L138/AM18x
Backtrace: 
[<c000d794>] (dump_backtrace) from [<c000da38>] (show_stack+0x18/0x1c)
 r7:00000009 r6:00000000 r5:bf3a19f0 r4:00000000
[<c000da20>] (show_stack) from [<c043b310>] (dump_stack+0x20/0x28)
[<c043b2f0>] (dump_stack) from [<c001b830>] (__warn+0xdc/0x104)
[<c001b754>] (__warn) from [<c001b910>] (warn_slowpath_null+0x28/0x30)
 r9:000000d8 r8:bf2d9e00 r7:00000001 r6:c5b5b010 r5:c5b5b014 r4:c7b2b8a0
[<c001b8e8>] (warn_slowpath_null) from [<bf3a075c>] (cppi41_stop_chan+0x208/0x338 [cppi41])
[<bf3a0554>] (cppi41_stop_chan [cppi41]) from [<bf2d688c>] (cppi41_dma_channel_abort+0x118/0x290 [musb_hdrc])
 r7:c5848010 r6:00020000 r5:00000001 r4:c7077454
[<bf2d6774>] (cppi41_dma_channel_abort [musb_hdrc]) from [<bf2d4bcc>] (musb_gadget_disable+0xfc/0x240 [musb_hdrc])
 r10:c7077000 r9:fee00410 r8:20000093 r7:c5848010 r6:bf2d9de4 r5:c5848010
 r4:c5848410
[<bf2d4ad0>] (musb_gadget_disable [musb_hdrc]) from [<bf261f8c>] (usb_ep_disable+0x30/0x3c [udc_core])
 r10:00000000 r9:c7144000 r8:c000a604 r7:c7334ba0 r6:c584846c r5:00000000
 r4:c5848410 r3:bf2d4ad0
[<bf261f5c>] (usb_ep_disable [udc_core]) from [<bf3eb740>] (disable_endpoints+0x20/0x4c [usb_f_ss_lb])
 r5:00000000 r4:00000000
[<bf3eb720>] (disable_endpoints [usb_f_ss_lb]) from [<bf3eb7a0>] (disable_source_sink+0x34/0x3c [usb_f_ss_lb])
 r7:c7334ba0 r6:00000000 r5:60000013 r4:c7159e40
[<bf3eb76c>] (disable_source_sink [usb_f_ss_lb]) from [<bf3eb7b8>] (sourcesink_disable+0x10/0x14 [usb_f_ss_lb])
[<bf3eb7a8>] (sourcesink_disable [usb_f_ss_lb]) from [<bf3d5e38>] (composite_disconnect+0x58/0xd0 [libcomposite])
[<bf3d5de0>] (composite_disconnect [libcomposite]) from [<bf261cf8>] (usb_gadget_remove_driver+0x58/0xa8 [udc_core])
 r7:00000081 r6:00000800 r5:c5849138 r4:c7b52600
[<bf261ca0>] (usb_gadget_remove_driver [udc_core]) from [<bf2625b4>] (usb_gadget_unregister_driver+0x68/0xd0 [udc_core])
 r5:bf3e591c r4:c7b52600
[<bf26254c>] (usb_gadget_unregister_driver [udc_core]) from [<bf3d6484>] (usb_composite_unregister+0x14/0x18 [libcomposite])
 r5:0003af5c r4:bf3e59e0
[<bf3d6470>] (usb_composite_unregister [libcomposite]) from [<bf3e5444>] (zero_driver_exit+0x14/0x1c [g_zero])
[<bf3e5430>] (zero_driver_exit [g_zero]) from [<c00802ec>] (SyS_delete_module+0x168/0x1e8)
[<c0080184>] (SyS_delete_module) from [<c000a460>] (ret_fast_syscall+0x0/0x38)
 r6:00000000 r5:0003af5c r4:0003af20
---[ end trace 3d9a1549a3b9c32f ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 464 at drivers/dma/cppi41.c:700 cppi41_stop_chan+0x248/0x338 [cppi41]
Modules linked in: usb_f_ss_lb g_zero(-) libcomposite configfs ofpart davinci_nand nand nand_ecc cppi41 mtd vpif_display tvp514x vpif_capture videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_core v4l2_fwnode v4l2_common vid4
CPU: 0 PID: 464 Comm: modprobe Tainted: G        W       4.12.0-rc7-next-20170629-10695-g3fb8ba638d53 #76
Hardware name: Generic DA850/OMAP-L138/AM18x
Backtrace: 
[<c000d794>] (dump_backtrace) from [<c000da38>] (show_stack+0x18/0x1c)
 r7:00000009 r6:00000000 r5:bf3a19f0 r4:00000000
[<c000da20>] (show_stack) from [<c043b310>] (dump_stack+0x20/0x28)
[<c043b2f0>] (dump_stack) from [<c001b830>] (__warn+0xdc/0x104)
[<c001b754>] (__warn) from [<c001b910>] (warn_slowpath_null+0x28/0x30)
 r9:000000d8 r8:bf2d9e00 r7:00000001 r6:c5b5b010 r5:c5b5b014 r4:c7b2b8a0
[<c001b8e8>] (warn_slowpath_null) from [<bf3a079c>] (cppi41_stop_chan+0x248/0x338 [cppi41])
[<bf3a0554>] (cppi41_stop_chan [cppi41]) from [<bf2d688c>] (cppi41_dma_channel_abort+0x118/0x290 [musb_hdrc])
 r7:c5848010 r6:00020000 r5:00000001 r4:c7077454
[<bf2d6774>] (cppi41_dma_channel_abort [musb_hdrc]) from [<bf2d4bcc>] (musb_gadget_disable+0xfc/0x240 [musb_hdrc])
 r10:c7077000 r9:fee00410 r8:20000093 r7:c5848010 r6:bf2d9de4 r5:c5848010
 r4:c5848410
[<bf2d4ad0>] (musb_gadget_disable [musb_hdrc]) from [<bf261f8c>] (usb_ep_disable+0x30/0x3c [udc_core])
 r10:00000000 r9:c7144000 r8:c000a604 r7:c7334ba0 r6:c584846c r5:00000000
 r4:c5848410 r3:bf2d4ad0
[<bf261f5c>] (usb_ep_disable [udc_core]) from [<bf3eb740>] (disable_endpoints+0x20/0x4c [usb_f_ss_lb])
 r5:00000000 r4:00000000
[<bf3eb720>] (disable_endpoints [usb_f_ss_lb]) from [<bf3eb7a0>] (disable_source_sink+0x34/0x3c [usb_f_ss_lb])
 r7:c7334ba0 r6:00000000 r5:60000013 r4:c7159e40
[<bf3eb76c>] (disable_source_sink [usb_f_ss_lb]) from [<bf3eb7b8>] (sourcesink_disable+0x10/0x14 [usb_f_ss_lb])
[<bf3eb7a8>] (sourcesink_disable [usb_f_ss_lb]) from [<bf3d5e38>] (composite_disconnect+0x58/0xd0 [libcomposite])
[<bf3d5de0>] (composite_disconnect [libcomposite]) from [<bf261cf8>] (usb_gadget_remove_driver+0x58/0xa8 [udc_core])
 r7:00000081 r6:00000800 r5:c5849138 r4:c7b52600
[<bf261ca0>] (usb_gadget_remove_driver [udc_core]) from [<bf2625b4>] (usb_gadget_unregister_driver+0x68/0xd0 [udc_core])
 r5:bf3e591c r4:c7b52600
[<bf26254c>] (usb_gadget_unregister_driver [udc_core]) from [<bf3d6484>] (usb_composite_unregister+0x14/0x18 [libcomposite])
 r5:0003af5c r4:bf3e59e0
[<bf3d6470>] (usb_composite_unregister [libcomposite]) from [<bf3e5444>] (zero_driver_exit+0x14/0x1c [g_zero])
[<bf3e5430>] (zero_driver_exit [g_zero]) from [<c00802ec>] (SyS_delete_module+0x168/0x1e8)
[<c0080184>] (SyS_delete_module) from [<c000a460>] (ret_fast_syscall+0x0/0x38)
 r6:00000000 r5:0003af5c r4:0003af20
---[ end trace 3d9a1549a3b9c330 ]---

[2]
root at omapl138-lcdk:~# modprobe g_ether
using random self ethernet address
using random host ethernet address
usb0: HOST MAC 66:6b:3b:7f:71:64
usb0: MAC aa:26:23:3a:e7:b3
using random self ethernet address
using random host ethernet address
g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
g_ether gadget: g_ether ready
------------[ cut here ]------------
WARNING: CPU: 0 PID: 467 at drivers/dma/cppi41.c:335 cppi41_irq+0x1fc/0x230 [cppi41]
Modules linked in: usb_f_ecm g_ether(+) usb_f_rndis u_ether usb_f_ss_lb libcomposite configfs ofpart davinci_nand nand nand_ecc cppi41 mtd vpif_display tvp514x vpif_capture videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_c]
CPU: 0 PID: 467 Comm: modprobe Tainted: G        W       4.12.0-rc7-next-20170629-10695-g3fb8ba638d53 #76
Hardware name: Generic DA850/OMAP-L138/AM18x
Backtrace: 
[<c000d794>] (dump_backtrace) from [<c000da38>] (show_stack+0x18/0x1c)
 r7:00000009 r6:00000000 r5:bf3a19f0 r4:00000000
[<c000da20>] (show_stack) from [<c043b310>] (dump_stack+0x20/0x28)
[<c043b2f0>] (dump_stack) from [<c001b830>] (__warn+0xdc/0x104)
[<c001b754>] (__warn) from [<c001b910>] (warn_slowpath_null+0x28/0x30)
 r9:c05adffc r8:00000000 r7:80000000 r6:c5b5b010 r5:c05adffc r4:c5bed140
[<c001b8e8>] (warn_slowpath_null) from [<bf3a0b78>] (cppi41_irq+0x1fc/0x230 [cppi41])
[<bf3a097c>] (cppi41_irq [cppi41]) from [<c0055880>] (__handle_irq_event_percpu+0x8c/0x138)
 r10:c05b4c2c r9:c05adffc r8:0000003a r7:c7b21c2c r6:00000000 r5:c05adffc
 r4:c5bed140
[<c00557f4>] (__handle_irq_event_percpu) from [<c0055950>] (handle_irq_event_percpu+0x24/0x60)
 r10:bf401940 r9:00000000 r8:c7b21cb0 r7:00000000 r6:00000000 r5:c05adffc
 r4:c05adffc
[<c005592c>] (handle_irq_event_percpu) from [<c00559e0>] (handle_irq_event+0x54/0x8c)
 r5:c05cac14 r4:c05adffc
[<c005598c>] (handle_irq_event) from [<c0059044>] (handle_edge_irq+0x148/0x200)
 r5:c05cac14 r4:c05adffc
[<c0058efc>] (handle_edge_irq) from [<c00550d4>] (__handle_domain_irq+0x88/0x104)
 r5:c05cac14 r4:00000862
[<c005504c>] (__handle_domain_irq) from [<c0009020>] (asm_do_IRQ+0x20/0x24)
 r9:c7b20000 r8:00000098 r7:c7b21ce4 r6:febfd000 r5:a0000013 r4:bf320058
[<c0009000>] (asm_do_IRQ) from [<c000e680>] (__irq_svc+0x60/0xd8)
Exception stack(0xc7b21cb0 to 0xc7b21cf8)
1ca0:                                     fee00000 fee00024 01000000 bf2cadd8
1cc0: bf2d9e00 fee00000 bf2d9de0 c5849010 00000098 c7b21f40 bf401940 c7b21d14
1ce0: c7b21d00 c7b21d00 bf320058 bf320058 a0000013 ffffffff
[<bf320000>] (da8xx_musb_enable [da8xx]) from [<bf2cbf80>] (musb_start+0xe8/0x118 [musb_hdrc])
 r5:fee00400 r4:c5848010
[<bf2cbe98>] (musb_start [musb_hdrc]) from [<bf2d3aac>] (musb_gadget_start+0xcc/0x140 [musb_hdrc])
 r9:c7b21f40 r8:60000013 r7:c711bb90 r6:c5848010 r5:c5849138 r4:c5848138
[<bf2d39e0>] (musb_gadget_start [musb_hdrc]) from [<bf26227c>] (udc_bind_to_driver+0xb8/0xf0 [udc_core])
 r9:c7b21f40 r8:bf262fac r7:bf4018b4 r6:00000000 r5:bf4018b4 r4:c7b52600
[<bf2621c4>] (udc_bind_to_driver [udc_core]) from [<bf262714>] (usb_gadget_probe_driver+0xf8/0x144 [udc_core])
 r7:bf4018b4 r6:00000000 r5:bf262fbc r4:c7b52600
[<bf26261c>] (usb_gadget_probe_driver [udc_core]) from [<bf3d6444>] (usb_composite_probe+0xa8/0xd4 [libcomposite])
 r9:c7b21f40 r8:00000001 r7:bf3d6960 r6:bf4018b4 r5:bf401678 r4:bf40188c
[<bf3d639c>] (usb_composite_probe [libcomposite]) from [<bf403014>] (eth_driver_init+0x14/0x1c [g_ether])
 r7:00000000 r6:00000000 r5:bf403000 r4:ffffe000
[<bf403000>] (eth_driver_init [g_ether]) from [<c00096dc>] (do_one_initcall+0x44/0x17c)
[<c0009698>] (do_one_initcall) from [<c0082b94>] (do_init_module+0x60/0x1b0)
 r9:c7b21f40 r8:00000001 r7:00000000 r6:c70254e0 r5:bf40194c r4:bf401940
[<c0082b34>] (do_init_module) from [<c0081ef4>] (load_module+0xe70/0xfd4)
 r6:00000000 r5:bf40194c r4:00000000
[<c0081084>] (load_module) from [<c008226c>] (SyS_finit_module+0xac/0xc0)
 r10:00000000 r9:c7b20000 r8:c000a604 r7:0000017b r6:00028440 r5:00000005
 r4:00000000
[<c00821c0>] (SyS_finit_module) from [<c000a460>] (ret_fast_syscall+0x0/0x38)
 r6:00000000 r5:00040000 r4:00000000
---[ end trace 3d9a1549a3b9c331 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 467 at drivers/dma/cppi41.c:342 cppi41_irq+0x1c8/0x230 [cppi41]
Modules linked in: usb_f_ecm g_ether(+) usb_f_rndis u_ether usb_f_ss_lb libcomposite configfs ofpart davinci_nand nand nand_ecc cppi41 mtd vpif_display tvp514x vpif_capture videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_c]
CPU: 0 PID: 467 Comm: modprobe Tainted: G        W       4.12.0-rc7-next-20170629-10695-g3fb8ba638d53 #76
Hardware name: Generic DA850/OMAP-L138/AM18x
Backtrace: 
[<c000d794>] (dump_backtrace) from [<c000da38>] (show_stack+0x18/0x1c)
 r7:00000009 r6:00000000 r5:bf3a19f0 r4:00000000
[<c000da20>] (show_stack) from [<c043b310>] (dump_stack+0x20/0x28)
[<c043b2f0>] (dump_stack) from [<c001b830>] (__warn+0xdc/0x104)
[<c001b754>] (__warn) from [<c001b910>] (warn_slowpath_null+0x28/0x30)
 r9:00000000 r8:00000000 r7:00000000 r6:c5b5b010 r5:c733f100 r4:0000001f
[<c001b8e8>] (warn_slowpath_null) from [<bf3a0b44>] (cppi41_irq+0x1c8/0x230 [cppi41])
[<bf3a097c>] (cppi41_irq [cppi41]) from [<c0055880>] (__handle_irq_event_percpu+0x8c/0x138)
 r10:c05b4c2c r9:c05adffc r8:0000003a r7:c7b21c2c r6:00000000 r5:c05adffc
 r4:c5bed140
[<c00557f4>] (__handle_irq_event_percpu) from [<c0055950>] (handle_irq_event_percpu+0x24/0x60)
 r10:bf401940 r9:00000000 r8:c7b21cb0 r7:00000000 r6:00000000 r5:c05adffc
 r4:c05adffc
[<c005592c>] (handle_irq_event_percpu) from [<c00559e0>] (handle_irq_event+0x54/0x8c)
 r5:c05cac14 r4:c05adffc
[<c005598c>] (handle_irq_event) from [<c0059044>] (handle_edge_irq+0x148/0x200)
 r5:c05cac14 r4:c05adffc
[<c0058efc>] (handle_edge_irq) from [<c00550d4>] (__handle_domain_irq+0x88/0x104)
 r5:c05cac14 r4:00000862
[<c005504c>] (__handle_domain_irq) from [<c0009020>] (asm_do_IRQ+0x20/0x24)
 r9:c7b20000 r8:00000098 r7:c7b21ce4 r6:febfd000 r5:a0000013 r4:bf320058
[<c0009000>] (asm_do_IRQ) from [<c000e680>] (__irq_svc+0x60/0xd8)
Exception stack(0xc7b21cb0 to 0xc7b21cf8)
1ca0:                                     fee00000 fee00024 01000000 bf2cadd8
1cc0: bf2d9e00 fee00000 bf2d9de0 c5849010 00000098 c7b21f40 bf401940 c7b21d14
1ce0: c7b21d00 c7b21d00 bf320058 bf320058 a0000013 ffffffff
[<bf320000>] (da8xx_musb_enable [da8xx]) from [<bf2cbf80>] (musb_start+0xe8/0x118 [musb_hdrc])
 r5:fee00400 r4:c5848010
[<bf2cbe98>] (musb_start [musb_hdrc]) from [<bf2d3aac>] (musb_gadget_start+0xcc/0x140 [musb_hdrc])
 r9:c7b21f40 r8:60000013 r7:c711bb90 r6:c5848010 r5:c5849138 r4:c5848138
[<bf2d39e0>] (musb_gadget_start [musb_hdrc]) from [<bf26227c>] (udc_bind_to_driver+0xb8/0xf0 [udc_core])
 r9:c7b21f40 r8:bf262fac r7:bf4018b4 r6:00000000 r5:bf4018b4 r4:c7b52600
[<bf2621c4>] (udc_bind_to_driver [udc_core]) from [<bf262714>] (usb_gadget_probe_driver+0xf8/0x144 [udc_core])
 r7:bf4018b4 r6:00000000 r5:bf262fbc r4:c7b52600
[<bf26261c>] (usb_gadget_probe_driver [udc_core]) from [<bf3d6444>] (usb_composite_probe+0xa8/0xd4 [libcomposite])
 r9:c7b21f40 r8:00000001 r7:bf3d6960 r6:bf4018b4 r5:bf401678 r4:bf40188c
[<bf3d639c>] (usb_composite_probe [libcomposite]) from [<bf403014>] (eth_driver_init+0x14/0x1c [g_ether])
 r7:00000000 r6:00000000 r5:bf403000 r4:ffffe000
[<bf403000>] (eth_driver_init [g_ether]) from [<c00096dc>] (do_one_initcall+0x44/0x17c)
[<c0009698>] (do_one_initcall) from [<c0082b94>] (do_init_module+0x60/0x1b0)
 r9:c7b21f40 r8:00000001 r7:00000000 r6:c70254e0 r5:bf40194c r4:bf401940
[<c0082b34>] (do_init_module) from [<c0081ef4>] (load_module+0xe70/0xfd4)
 r6:00000000 r5:bf40194c r4:00000000
[<c0081084>] (load_module) from [<c008226c>] (SyS_finit_module+0xac/0xc0)
 r10:00000000 r9:c7b20000 r8:c000a604 r7:0000017b r6:00028440 r5:00000005
 r4:00000000
[<c00821c0>] (SyS_finit_module) from [<c000a460>] (ret_fast_syscall+0x0/0x38)
 r6:00000000 r5:00040000 r4:00000000
---[ end trace 3d9a1549a3b9c332 ]---
cppi41_irq() q 31 desc c733f100
IPv6: ADDRCONF(NETDEV_UP): usb0: link is not ready

g_ether gadget: high-speed config #1: CDC Ethernet (ECM)
IPv6: ADDRCONF(NETDEV_CHANGE): usb0: link becomes ready
------------[ cut here ]------------
WARNING: CPU: 0 PID: 461 at drivers/dma/cppi41.c:342 cppi41_irq+0x1c8/0x230 [cppi41]
Modules linked in: usb_f_ecm g_ether(+) usb_f_rndis u_ether usb_f_ss_lb libcomposite configfs ofpart davinci_nand nand nand_ecc cppi41 mtd vpif_display tvp514x vpif_capture videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_c]
CPU: 0 PID: 461 Comm: syslog-ng Tainted: G        W       4.12.0-rc7-next-20170629-10695-g3fb8ba638d53 #76
Hardware name: Generic DA850/OMAP-L138/AM18x
Backtrace: 
[<c000d794>] (dump_backtrace) from [<c000da38>] (show_stack+0x18/0x1c)
 r7:00000009 r6:00000000 r5:bf3a19f0 r4:00000000
[<c000da20>] (show_stack) from [<c043b310>] (dump_stack+0x20/0x28)
[<c043b2f0>] (dump_stack) from [<c001b830>] (__warn+0xdc/0x104)
[<c001b754>] (__warn) from [<c001b910>] (warn_slowpath_null+0x28/0x30)
 r9:00000000 r8:00000000 r7:00000000 r6:c5b5b010 r5:c733f020 r4:00000018
[<c001b8e8>] (warn_slowpath_null) from [<bf3a0b44>] (cppi41_irq+0x1c8/0x230 [cppi41])
[<bf3a097c>] (cppi41_irq [cppi41]) from [<c0055880>] (__handle_irq_event_percpu+0x8c/0x138)
 r10:c05b4c2c r9:c05adffc r8:0000003a r7:c5b3de4c r6:00000000 r5:c05adffc
 r4:c5bed140
[<c00557f4>] (__handle_irq_event_percpu) from [<c0055950>] (handle_irq_event_percpu+0x24/0x60)
 r10:0003a500 r9:00000000 r8:c5b3ded0 r7:00000000 r6:c5b3dfb0 r5:c05adffc
 r4:c05adffc
[<c005592c>] (handle_irq_event_percpu) from [<c00559e0>] (handle_irq_event+0x54/0x8c)
 r5:c05cac14 r4:c05adffc
[<c005598c>] (handle_irq_event) from [<c0059044>] (handle_edge_irq+0x148/0x200)
 r5:c05cac14 r4:c05adffc
[<c0058efc>] (handle_edge_irq) from [<c00550d4>] (__handle_domain_irq+0x88/0x104)
 r5:c05cac14 r4:00000862
[<c005504c>] (__handle_domain_irq) from [<c0009020>] (asm_do_IRQ+0x20/0x24)
 r9:c5b3c000 r8:c5b3dfb0 r7:c5b3df04 r6:febfd000 r5:20000013 r4:c001f2b0
[<c0009000>] (asm_do_IRQ) from [<c000e680>] (__irq_svc+0x60/0xd8)
Exception stack(0xc5b3ded0 to 0xc5b3df18)
dec0:                                     00000000 c04f21b8 c05d03c0 20000013
dee0: 00000000 00000004 00000000 c5b3c000 c5b3dfb0 00000000 0003a500 c5b3df64
df00: c5b3df10 c5b3df20 c022fa30 c001f2b0 20000013 ffffffff
[<c001f230>] (__do_softirq) from [<c001f7d0>] (irq_exit+0xdc/0x130)
 r10:0003a500 r9:00000000 r8:c5b3dfb0 r7:00000000 r6:00000000 r5:c05cac14
 r4:00000000
[<c001f6f4>] (irq_exit) from [<c00550dc>] (__handle_domain_irq+0x90/0x104)
[<c005504c>] (__handle_domain_irq) from [<c0009020>] (asm_do_IRQ+0x20/0x24)
 r9:b5b02c10 r8:00053177 r7:0005317f r6:febfd000 r5:60000010 r4:476e8358
[<c0009000>] (asm_do_IRQ) from [<c000ea70>] (__irq_usr+0x50/0xc0)
Exception stack(0xc5b3dfb0 to 0xc5b3dff8)
dfa0:                                     00000000 47ec1440 00727041 00000000
dfc0: 000ae520 ffffffff b5b02c10 47ec143c 47ee9e04 b5b02c10 0003a500 b66b518c
dfe0: 47b803e4 b66b50d8 47af9410 476e8358 60000010 ffffffff
---[ end trace 3d9a1549a3b9c333 ]---
cppi41_irq() q 24 desc c733f020
root at omapl138-lcdk:~# 
root at omapl138-lcdk:~# g_ether gadget: high-speed config #1: CDC Ethernet (ECM)
