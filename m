From: josh.coombs@gmail.com (Josh Coombs)
Date: Fri, 28 Dec 2012 11:09:57 -0500
Subject: Kirkwood issues with 3.8-rc1 - Ooops and hang on reboot
Message-ID: <CAMW5UfYvbaOp4yUtqE-eYQ9TcUOSSi7QbQteMFtiPTbh_vR5wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In testing 3.8-rc1, after adding the missing clk for USB devices patch
and missing sdio clk patch I got a bootable kernel on my GoFlex Net.
I've got two remaining issues however that I'm not sure are covered by
already posted fixes for -rc2 or not.  I don't dare add Tested By
lines to the current fixes pending till I know if what I'm seeing is
related or not.

The first is a kernel oops during init.  The dmesg output and
associated objdump of what I think is the offending code section is at
the bottom of this email.  This doesn't seem to impact operation on my
GoFlex Net, although I can't rule out it being involved in the second
issue I've observed.

The second issue is a hang when issuing a reboot, the kernel/init will
do everything correctly right up to the point that it should actually
restart the device, at which point it just hangs.  When I pull power
to force the issue, the kernel starts to spit something out with a log
timestamp but dies due to a lack of power before showing enough to
know what it's saying, so the kernel is still running at that point.
I haven't tested, but I suspect I could tickle other log messages out
of it by say, plugging in a USB device, etc.

If these are known issues with fixes pending, ignore me.  If not, let
me know what information is needed to assist with debugging.

Joshua Coombs

Oops output:

[   23.256445] Internal error: Oops - undefined instruction: 0 [#1] PREEMPT ARM
[   23.263538] Modules linked in: orion_wdt(+) autofs4
[   23.268477] CPU: 0    Not tainted  (3.8.0-0-ARCH+ #1)
[   23.273559] PC is at mvebu_clk_gating_get_src+0x28/0x6c
[   23.278812] LR is at of_clk_get_from_provider+0x40/0x70
[   23.284061] pc : [<c06090bc>]    lr : [<c03af224>]    psr: a0000013
sp : c7329d50  ip : 00000000  fp : c7329f58
[   23.295588] r10: bf00d000  r9 : 00000000  r8 : 38cd728f
[   23.300837] r7 : c7329d70  r6 : fffffffe  r5 : c0655adc  r4 : c7867360
[   23.307394] r3 : c3263851  r2 : c082e03c  r1 : c7861bc0  r0 : 00000000
[   23.313952] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   23.321119] Control: 0005397f  Table: 0732c000  DAC: 00000015
[   23.326891] Process systemd-udevd (pid: 96, stack limit = 0xc73281b8)
[   23.333361] Stack: (0xc7329d50 to 0xc732a000)
[   23.337742] 9d40:                                     00000001
c7329d70 00000000 00000000
[   23.345959] 9d60: fffffffe c03ad784 c7329d70 c012be7c c082e03c
00000001 00000007 0000278b
[   23.354182] 9d80: c7365f80 c7365f00 c7365f80 c012bee4 00000014
000000d0 c082e164 c03ad7dc
[   23.362405] 9da0: 00000000 c7867d60 00000000 c786c210 c02bce6c
c03ad890 00000000 00000000
[   23.370628] 9dc0: c7379310 c03ad4f0 c786c210 c786c210 c786c200
bf00b1f8 c786c210 c786c244
[   23.378851] 9de0: bf00b6f8 c02bdcb4 c02bdca0 c02bcd14 c786c210
c786c244 bf00b6f8 c02bced4
[   23.387074] 9e00: 00000000 c7329e10 bf00b6f8 c02bb510 c7805c4c
c785ded0 bf00b6f8 bf00b6f8
[   23.395297] 9e20: c73444e0 c06488c0 00000000 c02bc4c0 bf00b63d
bf00b63d bf00b6f8 00000000
[   23.403519] 9e40: 00000001 bf00b780 c7365e00 c02bd1d4 c02bdcd8
bf00b738 00000000 00000001
[   23.411742] 9e60: bf00b780 c7365e00 bf00d000 c0008618 bf00d000
00000000 00000001 bf00b738
[   23.419966] 9e80: bf00b738 00000000 00000001 bf00b780 c7365e00
0000001c 00000001 c005ada0
[   23.428192] 9ea0: bf00b744 00007fff c0056ee4 00000000 c7801200
c005870c 00000000 bf00b744
[   23.436412] 9ec0: bf00b88c 00000078 c045b958 c8a6870c c7329eec
b6ecbed8 000002d2 c05a43e4
[   23.444633] 9ee0: c7328000 00000000 00000000 c00bbd34 00000000
00000000 00000000 00000000
[   23.452847] 9f00: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   23.461062] 9f20: 00000000 00000000 00000000 00000000 000000d2
b630b008 000025ee b6ecbed8
[   23.469286] 9f40: 00000080 c0008e24 c7328000 00000000 00000000
c005b10c c8a67000 000025ee
[   23.477508] 9f60: c8a681e4 c8a68087 c8a69174 000008b4 00000a64
00000000 00000000 00000000
[   23.485731] 9f80: 00000021 00000022 00000019 00000016 00000014
00000000 00000000 00020000
[   23.493955] 9fa0: 0005bea0 c0008cc0 00000000 00020000 b630b008
000025ee b6ecbed8 0005bea0
[   23.502177] 9fc0: 00000000 00020000 0005bea0 00000080 00076830
000025ee b6ecbed8 00000000
[   23.510401] 9fe0: b6e0f590 bea1cda8 b6ec2d04 b6e0f5a0 60000010
b630b008 00000000 00000000
[   23.518643] [<c03af224>] (of_clk_get_from_provider+0x40/0x70) from
[<c03ad784>] (of_clk_get+0x38/0x4c)
[   23.528002] [<c03ad784>] (of_clk_get+0x38/0x4c) from [<c03ad7dc>]
(of_clk_get_by_name+0x44/0xbc)
[   23.536834] [<c03ad7dc>] (of_clk_get_by_name+0x44/0xbc) from
[<c03ad890>] (clk_get+0x3c/0x48)
[   23.545406] [<c03ad890>] (clk_get+0x3c/0x48) from [<c03ad4f0>]
(devm_clk_get+0x34/0x6c)
[   23.553462] [<c03ad4f0>] (devm_clk_get+0x34/0x6c) from [<bf00b1f8>]
(orion_wdt_probe+0x18/0x198 [orion_wdt])
[   23.563353] [<bf00b1f8>] (orion_wdt_probe+0x18/0x198 [orion_wdt])
from [<c02bdcb4>] (platform_drv_probe+0x14/0x18)
[   23.573756] [<c02bdcb4>] (platform_drv_probe+0x14/0x18) from
[<c02bcd14>] (driver_probe_device+0xa8/0x200)
[   23.583458] [<c02bcd14>] (driver_probe_device+0xa8/0x200) from
[<c02bced4>] (__driver_attach+0x68/0x8c)
[   23.592910] [<c02bced4>] (__driver_attach+0x68/0x8c) from
[<c02bb510>] (bus_for_each_dev+0x48/0x80)
[   23.602007] [<c02bb510>] (bus_for_each_dev+0x48/0x80) from
[<c02bc4c0>] (bus_add_driver+0xdc/0x230)
[   23.611100] [<c02bc4c0>] (bus_add_driver+0xdc/0x230) from
[<c02bd1d4>] (driver_register+0x9c/0x12c)
[   23.620196] [<c02bd1d4>] (driver_register+0x9c/0x12c) from
[<c0008618>] (do_one_initcall+0x90/0x168)
[   23.629381] [<c0008618>] (do_one_initcall+0x90/0x168) from
[<c005ada0>] (load_module+0x186c/0x1b0c)
[   23.638475] [<c005ada0>] (load_module+0x186c/0x1b0c) from
[<c005b10c>] (sys_init_module+0xcc/0xec)
[   23.647481] [<c005b10c>] (sys_init_module+0xcc/0xec) from
[<c0008cc0>] (ret_fast_syscall+0x0/0x2c)
[   23.656487] Code: 2e312e31 00000030 01724006 020a0014 (2d6e7673)
[   23.662614] ---[ end trace 408d74142c65198d ]---

objdump:

c0609094 <mvebu_clk_gating_get_src>:
c0609094:       e92d40f8        push    {r3, r4, r5, r6, r7, lr}
c0609098:       e5903004        ldr     r3, [r0, #4]
c060909c:       e1a06000        mov     r6, r0
c06090a0:       e1a05001        mov     r5, r1
c06090a4:       e3530000        cmp     r3, #0
c06090a8:       c3a04000        movgt   r4, #0
c06090ac:       ca00000c        bgt     c06090e4 <mvebu_clk_gating_get_src+0x50>
c06090b0:       ea000010        b       c06090f8 <mvebu_clk_gating_get_src+0x64>
c06090b4:       e5953000        ldr     r3, [r5]
c06090b8:       e1a07104        lsl     r7, r4, #2
c06090bc:       e7930104        ldr     r0, [r3, r4, lsl #2]
c06090c0:       ebf694d7        bl      c03ae424 <__clk_get_hw>
c06090c4:       e5962008        ldr     r2, [r6, #8]
c06090c8:       e5d0300c        ldrb    r3, [r0, #12]
c06090cc:       e1520003        cmp     r2, r3
c06090d0:       1a000002        bne     c06090e0 <mvebu_clk_gating_get_src+0x4c>
c06090d4:       e5953000        ldr     r3, [r5]
c06090d8:       e7930007        ldr     r0, [r3, r7]
c06090dc:       e8bd80f8        pop     {r3, r4, r5, r6, r7, pc}
c06090e0:       e2844001        add     r4, r4, #1
c06090e4:       e5953004        ldr     r3, [r5, #4]
c06090e8:       e1540003        cmp     r4, r3
c06090ec:       bafffff0        blt     c06090b4 <mvebu_clk_gating_get_src+0x20>
c06090f0:       e3e00012        mvn     r0, #18
c06090f4:       e8bd80f8        pop     {r3, r4, r5, r6, r7, pc}
c06090f8:       e3e00015        mvn     r0, #21
c06090fc:       e8bd80f8        pop     {r3, r4, r5, r6, r7, pc}
