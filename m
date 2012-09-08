From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sat, 8 Sep 2012 18:50:51 +0200
Subject: sata_mv hangs up while probing on LaCie Kirkwood boards
Message-ID: <20120908165050.GA31897@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have noticed recently that Linux 3.6.0-rc* hangs up while booting on
LaCie Kirkwood-based boards. I have only tested on Network Space v2 and
2Big Network v2 boards.

Here are the last messages I can see from the serial console:

mv_xor_shared mv_xor_shared.0: Marvell shared XOR driver
mv_xor_shared mv_xor_shared.1: Marvell shared XOR driver
mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
mv_xor mv_xor.1: Marvell XOR: ( xor fill cpy )
mv_xor mv_xor.2: Marvell XOR: ( xor cpy )
mv_xor mv_xor.3: Marvell XOR: ( xor fill cpy )
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
console [ttyS0] enabled
loop: module loaded
sata_mv sata_mv.0: cannot get optional clkdev
sata_mv sata_mv.0: slots 32 ports 2

If I build the sata_mv driver as a module, the boot succeeds. After, if
I try to load the sata_mv module, I get the process modprobe locked.
Here is the backtrace:

modprobe        D c0383eb4     0   595    581 0x00000000
[<c0383eb4>] (__schedule+0x200/0x4b4) from [<c0382db0>] (schedule_timeout+0x110/0x190)
[<c0382db0>] (schedule_timeout+0x110/0x190) from [<c008f390>] (dma_pool_alloc+0x230/0x288)
[<c008f390>] (dma_pool_alloc+0x230/0x288) from [<bf001934>] (mv_port_start+0xec/0x1d8 [sata_mv])
[<bf001934>] (mv_port_start+0xec/0x1d8 [sata_mv]) from [<c01e46c4>] (ata_host_start+0xf8/0x1b8)
[<c01e46c4>] (ata_host_start+0xf8/0x1b8) from [<c01e9bb8>] (ata_host_activate+0x20/0x100)
[<c01e9bb8>] (ata_host_activate+0x20/0x100) from [<bf00297c>] (mv_platform_probe+0x370/0x40c [sata_mv])
[<bf00297c>] (mv_platform_probe+0x370/0x40c [sata_mv]) from [<c01cc5e0>] (platform_drv_probe+0x14/0x18)
[<c01cc5e0>] (platform_drv_probe+0x14/0x18) from [<c01cb544>] (driver_probe_device+0x78/0x204)
[<c01cb544>] (driver_probe_device+0x78/0x204) from [<c01cb75c>] (__driver_attach+0x8c/0x90)
[<c01cb75c>] (__driver_attach+0x8c/0x90) from [<c01c9e44>] (bus_for_each_dev+0x54/0x7c)
[<c01c9e44>] (bus_for_each_dev+0x54/0x7c) from [<c01cad98>] (bus_add_driver+0x174/0x240)
[<c01cad98>] (bus_add_driver+0x174/0x240) from [<c01cba34>] (driver_register+0x78/0x144)
[<c01cba34>] (driver_register+0x78/0x144) from [<bf008024>] (mv_init+0x24/0x4c [sata_mv])
[<bf008024>] (mv_init+0x24/0x4c [sata_mv]) from [<c000859c>] (do_one_initcall+0x30/0x168)
[<c000859c>] (do_one_initcall+0x30/0x168) from [<c004b904>] (sys_init_module+0x36c/0x186c)
[<c004b904>] (sys_init_module+0x36c/0x186c) from [<c0008ca0>] (ret_fast_syscall+0x0/0x2c)

According to git-bisect, it seems this regression comes with the commit
e9da6e9: "ARM: dma-mapping: remove custom consistent dma region".

Any hints are welcome.

Thanks in advance.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120908/cb762c8c/attachment.sig>
