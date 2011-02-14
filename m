From: zintis.petersons@abcsolutions.lv (=?windows-1257?Q?Zintis_P=E7tersons?=)
Date: Mon, 14 Feb 2011 18:38:13 +0200
Subject: [PATCH] Kirkwood: initialize PCIE1 for QNAP TS-419P+
Message-ID: <000001cbcc65$92744e10$b75cea30$@abcsolutions.lv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize PCIE1 on the 6282-based QNAP TS-419P+ since it has a Marvell 9125
SATA chip on each PCI bus.

 

Signed-off-by: Zintis P?tersons <zintis.petersons@abcsolutions.lv>

 

diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c
b/arch/arm/mach-kirkwood/ts41x-setup.c

index 9a44029..11f23c3 100644

--- a/arch/arm/mach-kirkwood/ts41x-setup.c

+++ b/arch/arm/mach-kirkwood/ts41x-setup.c

@@ -153,6 +153,8 @@ static void __init qnap_ts41x_init(void)

 static int __init ts41x_pci_init(void)

{

+             u32 dev, rev;

+

               if (machine_is_ts41x()) {

                               /*

                                * Without this explicit reset, the PCIe SATA
controller @@ -161,7 +163,11 @@ static int __init ts41x_pci_init(void)

                                */

                               orion_pcie_reset((void __iomem
*)PCIE_VIRT_BASE);

-                              kirkwood_pcie_init(KW_PCIE0);

+                             kirkwood_pcie_id(&dev, &rev);

+                             if (dev == MV88F6282_DEV_ID)

+                                             kirkwood_pcie_init(KW_PCIE1 |
KW_PCIE0);

+                             else

+                                             kirkwood_pcie_init(KW_PCIE0);

               }

    return 0;

 

 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110214/1bb9a865/attachment-0001.html>
