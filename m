From: p.pisati@gmail.com (Paolo Pisati)
Date: Mon, 8 Oct 2018 17:11:38 +0200
Subject: 4.19-rcX: WARN_ON() arch/arm64/kernel/setup.c:271
 reserve_memblock_reserved_regions
Message-ID: <20181008151138.GA19635@harukaze>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This on my dragonboard 410c:

...
[    0.170657] WARNING: CPU: 2 PID: 1 at arch/arm64/kernel/setup.c:271 reserve_memblock_reserved_regions+0xd4/0x150
[    0.170666] Modules linked in:
[    0.170680] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7-dirty #3
[    0.170687] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    0.170696] pstate: 20000005 (nzCv daif -PAN -UAO)
[    0.170707] pc : reserve_memblock_reserved_regions+0xd4/0x150
[    0.170718] lr : reserve_memblock_reserved_regions+0xcc/0x150
[    0.170725] sp : ffff000008033d30
[    0.170731] x29: ffff000008033d30 x28: ffff000009048050
[    0.170744] x27: ffff000009048078 x26: ffff000008f871b0
[    0.170755] x25: 0000000000000000 x24: 0000000000488020
[    0.170767] x23: 00000000bfffffff x22: ffff000008f3ca28
[    0.170778] x21: ffff000008e61840 x20: ffff0000090e9000
[    0.170789] x19: ffff80003a218e00 x18: 0000000000000000
[    0.170800] x17: 0000000000000000 x16: 0000000000000000
[    0.170811] x15: 0000000000000000 x14: 0000000000000400
[    0.170822] x13: 0000000000000000 x12: 0000000000000028
[    0.170833] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[    0.170844] x9 : 0000000000000000 x8 : ffff80003a218e80
[    0.170855] x7 : 0000000000000000 x6 : ffff80003d9ffc70
[    0.170866] x5 : 0000000000000000 x4 : 00000000bfffffff
[    0.170877] x3 : 00000000bff00000 x2 : 0000000000000000
[    0.170888] x1 : ffff800009ff0000 x0 : 0000000000000000
[    0.170899] Call trace:
[    0.170910]  reserve_memblock_reserved_regions+0xd4/0x150
[    0.170921]  do_one_initcall+0x58/0x170
[    0.170931]  kernel_init_freeable+0x1a4/0x264
[    0.170942]  kernel_init+0x10/0x108
[    0.170952]  ret_from_fork+0x10/0x18
[    0.170962] ---[ end trace c7ce9242331f7319 ]---
[    0.170974] name: reserved res: [mem 0xbff00000-0xbfffffff flags 0x200]
...

that memory region corresponds to the ramoops node:

        reserved-memory {
                ramoops at bff00000{
                        compatible = "ramoops";
                        reg = <0x0 0xbff00000 0x0 0x100000>;

                        record-size = <0x20000>;
                        console-size = <0x20000>;
                        ftrace-size = <0x20000>;
                };
        };

According to the comment in reserve_memblock_reserved_regions():

               /*
                 * We expected memblock_reserve() regions to conflict with
                 * memory created by request_standard_resources().
                 */

and the reserved-memory region evades this condition, but i'm not entirely sure how to
properly fix this - any idea?
-- 
bye,
p.
