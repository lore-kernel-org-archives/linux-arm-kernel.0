From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Wed, 26 Aug 2009 09:42:30 +0200
Subject: [PATCH] ARM: OpenRD base: Initialize PCI express, i2c and UART 1
Message-ID: <20090826094230.574eda24@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: OpenRD base: Initialize PCI express, i2c and UART 1

Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
---
(For the marvell git tree)

 arch/arm/mach-kirkwood/openrd_base-setup.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
index f9a2166..003db06 100644
--- a/arch/arm/mach-kirkwood/openrd_base-setup.c
+++ b/arch/arm/mach-kirkwood/openrd_base-setup.c
@@ -64,6 +64,7 @@ static void __init openrd_base_init(void)
 	kirkwood_mpp_conf(openrd_base_mpp_config);
 
 	kirkwood_uart0_init();
+	kirkwood_uart1_init();
 	kirkwood_nand_init(ARRAY_AND_SIZE(openrd_base_nand_parts), 25);
 
 	kirkwood_ehci_init();
@@ -71,8 +72,20 @@ static void __init openrd_base_init(void)
 	kirkwood_ge00_init(&openrd_base_ge00_data);
 	kirkwood_sata_init(&openrd_base_sata_data);
 	kirkwood_sdio_init(&openrd_base_mvsdio_data);
+
+	kirkwood_i2c_init();
 }
 
+static int __init openrd_base_pci_init(void)
+{
+	if (machine_is_openrd_base())
+		kirkwood_pcie_init();
+
+	return 0;
+ }
+subsys_initcall(openrd_base_pci_init);
+
+
 MACHINE_START(OPENRD_BASE, "Marvell OpenRD Base Board")
 	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
 	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-- 
1.6.0.4
