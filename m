From: marex@denx.de (Marek Vasut)
Date: Mon, 21 May 2012 05:44:25 +0200
Subject: [PATCH] GPMI-NAND: Define ecc.strength
Message-ID: <1337571865-8016-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ecc.strength wasn't set, resulting in the following crash:
[    2.550000] kernel BUG at drivers/mtd/nand/nand_base.c:3347!
[    2.550000] Internal error: Oops - BUG: 0 [#1] ARM
[    2.550000] Modules linked in:
[    2.550000] CPU: 0    Not tainted  (3.4.0-rc7-next-20120518-dirty #1211)
[    2.550000] PC is at nand_scan_tail+0x328/0x650
[    2.550000] LR is at nand_scan_tail+0x328/0x650
[    2.550000] pc : [<c020841c>]    lr : [<c020841c>]    psr: 20000013
[    2.550000] sp : c7443ea8  ip : c7448000  fp : c043dc70
[    2.550000] r10: 00000000  r9 : c059dd20  r8 : c7526300
[    2.550000] r7 : 00000001  r6 : c7479c08  r5 : c7526300  r4 : c7526098
[    2.550000] r3 : c7448000  r2 : 00000000  r1 : 00000001  r0 : 00000034
[    2.550000] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    2.550000] Control: 0005317f  Table: 40004000  DAC: 00000017
[    2.550000] Process swapper (pid: 1, stack limit = 0xc7442270)
[    2.550000] Stack: (0xc7443ea8 to 0xc7444000)
[    2.550000] 3ea0:                   c7526000 00000000 c7479c08 c02f68e0 c03d50ec c7526000
[    2.550000] 3ec0: c747c6e0 00000000 c0ae7720 00000004 00000000 00000000 c7479c08 c0ae7720
[    2.550000] 3ee0: c7479c3c c0593e20 c7572200 c01f6618 c01f6604 c01f55b0 c7479c08 c0593e20
[    2.550000] 3f00: c7479c3c c059dd20 c7572200 c01f57cc 00000000 c0593e20 c01f5738 c01f3d40
[    2.550000] 3f20: c74038a8 c74767d0 c0593e20 c04475ec c05901b8 c01f4e18 c03d50e0 c019d438
[    2.550000] 3f40: c7403800 c0593e20 c04475ec 00000000 c059dd20 c04475f8 c7442000 c01f5a70
[    2.550000] 3f60: 00000000 c044e98c c04475ec 00000000 c059dd20 c04475f8 c7442000 c043dc7c
[    2.550000] 3f80: c044e98c c0008824 c03d6c30 c040c4e4 00000006 00000006 c03b0ce4 c0bf54e0
[    2.550000] 3fa0: c044e98c c04475ec 00000006 c04475f8 0000004c c042a21c 00000000 c042a8b8
[    2.550000] 3fc0: 00000006 00000006 c042a21c 00000000 00000000 00000000 00000000 c042a7bc
[    2.550000] 3fe0: c000fab4 00000013 00000000 00000000 00000000 c000fab4 efbbfaa5 eaeafefe
[    2.550000] [<c020841c>] (nand_scan_tail+0x328/0x650) from [<c02f68e0>] (gpmi_nand_probe+0x43c/0x5a4)
[    2.550000] [<c02f68e0>] (gpmi_nand_probe+0x43c/0x5a4) from [<c01f6618>] (platform_drv_probe+0x14/0x18)
[    2.550000] [<c01f6618>] (platform_drv_probe+0x14/0x18) from [<c01f55b0>] (driver_probe_device+0x74/0x1fc)
[    2.550000] [<c01f55b0>] (driver_probe_device+0x74/0x1fc) from [<c01f57cc>] (__driver_attach+0x94/0x98)
[    2.550000] [<c01f57cc>] (__driver_attach+0x94/0x98) from [<c01f3d40>] (bus_for_each_dev+0x50/0x80)
[    2.550000] [<c01f3d40>] (bus_for_each_dev+0x50/0x80) from [<c01f4e18>] (bus_add_driver+0x188/0x25c)
[    2.550000] [<c01f4e18>] (bus_add_driver+0x188/0x25c) from [<c01f5a70>] (driver_register+0x78/0x138)
[    2.550000] [<c01f5a70>] (driver_register+0x78/0x138) from [<c043dc7c>] (gpmi_nand_init+0xc/0x30)
[    2.550000] [<c043dc7c>] (gpmi_nand_init+0xc/0x30) from [<c0008824>] (do_one_initcall+0x108/0x17c)
[    2.550000] [<c0008824>] (do_one_initcall+0x108/0x17c) from [<c042a8b8>] (kernel_init+0xfc/0x1bc)
[    2.550000] [<c042a8b8>] (kernel_init+0xfc/0x1bc) from [<c000fab4>] (kernel_thread_exit+0x0/0x8)
[    2.550000] Code: e3530000 1affff76 e59f02d0 eb03c16a (e7f001f2)
[    2.830000] ---[ end trace 3f05d4c0039432f1 ]---
[    2.840000] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Huang Shijie <b32955@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-mtd at lists.infradead.org
Cc: Artem Bityutskiy <dedekind1@gmail.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 9b4c109..f5f3d761 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1436,6 +1436,9 @@ static int gpmi_pre_bbt_scan(struct gpmi_nand_data  *this)
 	if (ret)
 		return ret;
 
+	/* Adjust the ECC strength according to the chip. */
+	this->nand.ecc.strength = this->bch_geometry.ecc_strength;
+
 	/* NAND boot init, depends on the gpmi_set_geometry(). */
 	return nand_boot_init(this);
 }
@@ -1494,6 +1497,7 @@ static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
 	chip->options		|= NAND_NO_SUBPAGE_WRITE;
 	chip->ecc.mode		= NAND_ECC_HW;
 	chip->ecc.size		= 1;
+	chip->ecc.strength	= 8;
 	chip->ecc.layout	= &gpmi_hw_ecclayout;
 
 	/* Allocate a temporary DMA buffer for reading ID in the nand_scan() */
-- 
1.7.10
