From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 18 Nov 2011 07:59:30 +0100
Subject: [PATCH 2/4] [orion] Move the *_mbus_dram_info structure into the
 orion platform and call it orion_mbus_dram_info everywhere.
In-Reply-To: <1321599572-705-1-git-send-email-andrew@lunn.ch>
References: <1321599572-705-1-git-send-email-andrew@lunn.ch>
Message-ID: <1321599572-705-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-dove/addr-map.c               |    8 +++-----
 arch/arm/mach-dove/common.c                 |   11 ++++++-----
 arch/arm/mach-dove/common.h                 |    1 -
 arch/arm/mach-dove/pcie.c                   |    3 ++-
 arch/arm/mach-kirkwood/addr-map.c           |    5 +----
 arch/arm/mach-kirkwood/common.c             |   15 ++++++++-------
 arch/arm/mach-kirkwood/common.h             |    1 -
 arch/arm/mach-kirkwood/pcie.c               |    3 ++-
 arch/arm/mach-mv78xx0/addr-map.c            |    4 ----
 arch/arm/mach-mv78xx0/common.c              |   17 +++++++++--------
 arch/arm/mach-mv78xx0/common.h              |    1 -
 arch/arm/mach-mv78xx0/pcie.c                |    3 ++-
 arch/arm/mach-orion5x/addr-map.c            |    4 +---
 arch/arm/mach-orion5x/common.c              |   11 ++++++-----
 arch/arm/mach-orion5x/common.h              |    1 -
 arch/arm/mach-orion5x/pci.c                 |    5 +++--
 arch/arm/plat-orion/addr-map.c              |    9 +++++----
 arch/arm/plat-orion/include/plat/addr-map.h |    3 ++-
 18 files changed, 50 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-dove/addr-map.c b/arch/arm/mach-dove/addr-map.c
index 1584726..98b8c83 100644
--- a/arch/arm/mach-dove/addr-map.c
+++ b/arch/arm/mach-dove/addr-map.c
@@ -35,8 +35,6 @@
 #define ATTR_PCIE_MEM		0xe8
 #define ATTR_SCRATCHPAD		0x0
 
-struct mbus_dram_target_info dove_mbus_dram_info;
-
 static inline void __iomem *ddr_map_sc(int i)
 {
 	return (void __iomem *)(DOVE_MC_VIRT_BASE + 0x100 + ((i) << 4));
@@ -102,7 +100,7 @@ void __init dove_setup_cpu_mbus(void)
 	/*
 	 * Setup MBUS dram target info.
 	 */
-	dove_mbus_dram_info.mbus_dram_target_id = TARGET_DDR;
+	orion_mbus_dram_info.mbus_dram_target_id = TARGET_DDR;
 
 	for (i = 0, cs = 0; i < 2; i++) {
 		u32 map = readl(ddr_map_sc(i));
@@ -113,7 +111,7 @@ void __init dove_setup_cpu_mbus(void)
 		if (map & 1) {
 			struct mbus_dram_window *w;
 
-			w = &dove_mbus_dram_info.cs[cs++];
+			w = &orion_mbus_dram_info.cs[cs++];
 			w->cs_index = i;
 			w->mbus_attr = 0; /* CS address decoding done inside */
 					  /* the DDR controller, no need to  */
@@ -122,5 +120,5 @@ void __init dove_setup_cpu_mbus(void)
 			w->size = 0x100000 << (((map & 0x000f0000) >> 16) - 4);
 		}
 	}
-	dove_mbus_dram_info.num_cs = cs;
+	orion_mbus_dram_info.num_cs = cs;
 }
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index a9e0dae..29c1881 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <plat/time.h>
 #include <plat/common.h>
+#include <plat/addr-map.h>
 #include "common.h"
 
 static int get_tclk(void);
@@ -71,7 +72,7 @@ void __init dove_map_io(void)
  ****************************************************************************/
 void __init dove_ehci0_init(void)
 {
-	orion_ehci_init(&dove_mbus_dram_info,
+	orion_ehci_init(&orion_mbus_dram_info,
 			DOVE_USB0_PHYS_BASE, IRQ_DOVE_USB0);
 }
 
@@ -80,7 +81,7 @@ void __init dove_ehci0_init(void)
  ****************************************************************************/
 void __init dove_ehci1_init(void)
 {
-	orion_ehci_1_init(&dove_mbus_dram_info,
+	orion_ehci_1_init(&orion_mbus_dram_info,
 			  DOVE_USB1_PHYS_BASE, IRQ_DOVE_USB1);
 }
 
@@ -89,7 +90,7 @@ void __init dove_ehci1_init(void)
  ****************************************************************************/
 void __init dove_ge00_init(struct mv643xx_eth_platform_data *eth_data)
 {
-	orion_ge00_init(eth_data, &dove_mbus_dram_info,
+	orion_ge00_init(eth_data, &orion_mbus_dram_info,
 			DOVE_GE00_PHYS_BASE, IRQ_DOVE_GE00_SUM,
 			0, get_tclk());
 }
@@ -107,7 +108,7 @@ void __init dove_rtc_init(void)
  ****************************************************************************/
 void __init dove_sata_init(struct mv_sata_platform_data *sata_data)
 {
-	orion_sata_init(sata_data, &dove_mbus_dram_info,
+	orion_sata_init(sata_data, &orion_mbus_dram_info,
 			DOVE_SATA_PHYS_BASE, IRQ_DOVE_SATA);
 
 }
@@ -198,7 +199,7 @@ struct sys_timer dove_timer = {
  ****************************************************************************/
 void __init dove_xor0_init(void)
 {
-	orion_xor0_init(&dove_mbus_dram_info,
+	orion_xor0_init(&orion_mbus_dram_info,
 			DOVE_XOR0_PHYS_BASE, DOVE_XOR0_HIGH_PHYS_BASE,
 			IRQ_DOVE_XOR_00, IRQ_DOVE_XOR_01);
 }
diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
index 6a2046e..7322371 100644
--- a/arch/arm/mach-dove/common.h
+++ b/arch/arm/mach-dove/common.h
@@ -15,7 +15,6 @@ struct mv643xx_eth_platform_data;
 struct mv_sata_platform_data;
 
 extern struct sys_timer dove_timer;
-extern struct mbus_dram_target_info dove_mbus_dram_info;
 
 /*
  * Basic Dove init functions used early by machine-setup.
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index aa2b3a0..42e7d22 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -19,6 +19,7 @@
 #include <plat/pcie.h>
 #include <mach/irqs.h>
 #include <mach/bridge-regs.h>
+#include <plat/addr-map.h>
 #include "common.h"
 
 struct pcie_port {
@@ -50,7 +51,7 @@ static int __init dove_pcie_setup(int nr, struct pci_sys_data *sys)
 	 */
 	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
 
-	orion_pcie_setup(pp->base, &dove_mbus_dram_info);
+	orion_pcie_setup(pp->base, &orion_mbus_dram_info);
 
 	/*
 	 * IORESOURCE_IO
diff --git a/arch/arm/mach-kirkwood/addr-map.c b/arch/arm/mach-kirkwood/addr-map.c
index 935392f..e9a7180 100644
--- a/arch/arm/mach-kirkwood/addr-map.c
+++ b/arch/arm/mach-kirkwood/addr-map.c
@@ -35,8 +35,6 @@
 #define ATTR_PCIE1_MEM		0xd8
 #define ATTR_SRAM		0x01
 
-struct mbus_dram_target_info kirkwood_mbus_dram_info;
-
 /*
  * Description of the windows needed by the platform code
  */
@@ -88,6 +86,5 @@ void __init kirkwood_setup_cpu_mbus(void)
 	/*
 	 * Setup MBUS dram target info.
 	 */
-	orion_setup_cpu_mbus_target(&addr_map_cfg, &kirkwood_mbus_dram_info,
-				    DDR_WINDOW_CPU_BASE);
+	orion_setup_cpu_mbus_target(&addr_map_cfg, DDR_WINDOW_CPU_BASE);
 }
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index f3248cf..d8b4ed2 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -30,6 +30,7 @@
 #include <plat/orion_nand.h>
 #include <plat/common.h>
 #include <plat/time.h>
+#include <plat/addr-map.h>
 #include "common.h"
 
 /*****************************************************************************
@@ -73,7 +74,7 @@ unsigned int kirkwood_clk_ctrl = CGC_DUNIT | CGC_RESERVED;
 void __init kirkwood_ehci_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_USB0;
-	orion_ehci_init(&kirkwood_mbus_dram_info,
+	orion_ehci_init(&orion_mbus_dram_info,
 			USB_PHYS_BASE, IRQ_KIRKWOOD_USB);
 }
 
@@ -85,7 +86,7 @@ void __init kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data)
 {
 	kirkwood_clk_ctrl |= CGC_GE0;
 
-	orion_ge00_init(eth_data, &kirkwood_mbus_dram_info,
+	orion_ge00_init(eth_data, &orion_mbus_dram_info,
 			GE00_PHYS_BASE, IRQ_KIRKWOOD_GE00_SUM,
 			IRQ_KIRKWOOD_GE00_ERR, kirkwood_tclk);
 }
@@ -99,7 +100,7 @@ void __init kirkwood_ge01_init(struct mv643xx_eth_platform_data *eth_data)
 
 	kirkwood_clk_ctrl |= CGC_GE1;
 
-	orion_ge01_init(eth_data, &kirkwood_mbus_dram_info,
+	orion_ge01_init(eth_data, &orion_mbus_dram_info,
 			GE01_PHYS_BASE, IRQ_KIRKWOOD_GE01_SUM,
 			IRQ_KIRKWOOD_GE01_ERR, kirkwood_tclk);
 }
@@ -178,7 +179,7 @@ void __init kirkwood_sata_init(struct mv_sata_platform_data *sata_data)
 	if (sata_data->n_ports > 1)
 		kirkwood_clk_ctrl |= CGC_SATA1;
 
-	orion_sata_init(sata_data, &kirkwood_mbus_dram_info,
+	orion_sata_init(sata_data, &orion_mbus_dram_info,
 			SATA_PHYS_BASE, IRQ_KIRKWOOD_SATA);
 }
 
@@ -221,7 +222,7 @@ void __init kirkwood_sdio_init(struct mvsdio_platform_data *mvsdio_data)
 		mvsdio_data->clock = 100000000;
 	else
 		mvsdio_data->clock = 200000000;
-	mvsdio_data->dram = &kirkwood_mbus_dram_info;
+	mvsdio_data->dram = &orion_mbus_dram_info;
 	kirkwood_clk_ctrl |= CGC_SDIO;
 	kirkwood_sdio.dev.platform_data = mvsdio_data;
 	platform_device_register(&kirkwood_sdio);
@@ -285,7 +286,7 @@ static void __init kirkwood_xor0_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_XOR0;
 
-	orion_xor0_init(&kirkwood_mbus_dram_info,
+	orion_xor0_init(&orion_mbus_dram_info,
 			XOR0_PHYS_BASE, XOR0_HIGH_PHYS_BASE,
 			IRQ_KIRKWOOD_XOR_00, IRQ_KIRKWOOD_XOR_01);
 }
@@ -364,7 +365,7 @@ static struct resource kirkwood_i2s_resources[] = {
 };
 
 static struct kirkwood_asoc_platform_data kirkwood_i2s_data = {
-	.dram        = &kirkwood_mbus_dram_info,
+	.dram        = &orion_mbus_dram_info,
 	.burst       = 128,
 };
 
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index b9b0f09..4756b94 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -30,7 +30,6 @@ void kirkwood_init(void);
 void kirkwood_init_early(void);
 void kirkwood_init_irq(void);
 
-extern struct mbus_dram_target_info kirkwood_mbus_dram_info;
 void kirkwood_setup_cpu_mbus(void);
 
 void kirkwood_enable_pcie(void);
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index 74b992d..8def894 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -17,6 +17,7 @@
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
 #include <mach/bridge-regs.h>
+#include <plat/addr-map.h>
 #include "common.h"
 
 void kirkwood_enable_pcie(void)
@@ -208,7 +209,7 @@ static int __init kirkwood_pcie_setup(int nr, struct pci_sys_data *sys)
 	 */
 	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
 
-	orion_pcie_setup(pp->base, &kirkwood_mbus_dram_info);
+	orion_pcie_setup(pp->base, &orion_mbus_dram_info);
 
 	return 1;
 }
diff --git a/arch/arm/mach-mv78xx0/addr-map.c b/arch/arm/mach-mv78xx0/addr-map.c
index 6b14555..62b53d7 100644
--- a/arch/arm/mach-mv78xx0/addr-map.c
+++ b/arch/arm/mach-mv78xx0/addr-map.c
@@ -37,8 +37,6 @@
 #define WIN0_OFF(n)		(BRIDGE_VIRT_BASE + 0x0000 + ((n) << 4))
 #define WIN8_OFF(n)		(BRIDGE_VIRT_BASE + 0x0900 + (((n) - 8) << 4))
 
-struct mbus_dram_target_info mv78xx0_mbus_dram_info;
-
 static void __init __iomem *win_cfg_base(int win)
 {
 	/*
@@ -73,11 +71,9 @@ void __init mv78xx0_setup_cpu_mbus(void)
 	 */
 	if (mv78xx0_core_index() == 0)
 		orion_setup_cpu_mbus_target(&addr_map_cfg,
-					    &mv78xx0_mbus_dram_info,
 					    DDR_WINDOW_CPU0_BASE);
 	else
 		orion_setup_cpu_mbus_target(&addr_map_cfg,
-					    &mv78xx0_mbus_dram_info,
 					    DDR_WINDOW_CPU1_BASE);
 }
 
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index 23d3980..be0c232 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -23,6 +23,7 @@
 #include <plat/orion_nand.h>
 #include <plat/time.h>
 #include <plat/common.h>
+#include <plat/addr-map.h>
 #include "common.h"
 
 static int get_tclk(void);
@@ -169,7 +170,7 @@ void __init mv78xx0_map_io(void)
  ****************************************************************************/
 void __init mv78xx0_ehci0_init(void)
 {
-	orion_ehci_init(&mv78xx0_mbus_dram_info,
+	orion_ehci_init(&orion_mbus_dram_info,
 			USB0_PHYS_BASE, IRQ_MV78XX0_USB_0);
 }
 
@@ -179,7 +180,7 @@ void __init mv78xx0_ehci0_init(void)
  ****************************************************************************/
 void __init mv78xx0_ehci1_init(void)
 {
-	orion_ehci_1_init(&mv78xx0_mbus_dram_info,
+	orion_ehci_1_init(&orion_mbus_dram_info,
 			  USB1_PHYS_BASE, IRQ_MV78XX0_USB_1);
 }
 
@@ -189,7 +190,7 @@ void __init mv78xx0_ehci1_init(void)
  ****************************************************************************/
 void __init mv78xx0_ehci2_init(void)
 {
-	orion_ehci_2_init(&mv78xx0_mbus_dram_info,
+	orion_ehci_2_init(&orion_mbus_dram_info,
 			  USB2_PHYS_BASE, IRQ_MV78XX0_USB_2);
 }
 
@@ -199,7 +200,7 @@ void __init mv78xx0_ehci2_init(void)
  ****************************************************************************/
 void __init mv78xx0_ge00_init(struct mv643xx_eth_platform_data *eth_data)
 {
-	orion_ge00_init(eth_data, &mv78xx0_mbus_dram_info,
+	orion_ge00_init(eth_data, &orion_mbus_dram_info,
 			GE00_PHYS_BASE, IRQ_MV78XX0_GE00_SUM,
 			IRQ_MV78XX0_GE_ERR, get_tclk());
 }
@@ -210,7 +211,7 @@ void __init mv78xx0_ge00_init(struct mv643xx_eth_platform_data *eth_data)
  ****************************************************************************/
 void __init mv78xx0_ge01_init(struct mv643xx_eth_platform_data *eth_data)
 {
-	orion_ge01_init(eth_data, &mv78xx0_mbus_dram_info,
+	orion_ge01_init(eth_data, &orion_mbus_dram_info,
 			GE01_PHYS_BASE, IRQ_MV78XX0_GE01_SUM,
 			NO_IRQ, get_tclk());
 }
@@ -234,7 +235,7 @@ void __init mv78xx0_ge10_init(struct mv643xx_eth_platform_data *eth_data)
 		eth_data->duplex = DUPLEX_FULL;
 	}
 
-	orion_ge10_init(eth_data, &mv78xx0_mbus_dram_info,
+	orion_ge10_init(eth_data, &orion_mbus_dram_info,
 			GE10_PHYS_BASE, IRQ_MV78XX0_GE10_SUM,
 			NO_IRQ, get_tclk());
 }
@@ -258,7 +259,7 @@ void __init mv78xx0_ge11_init(struct mv643xx_eth_platform_data *eth_data)
 		eth_data->duplex = DUPLEX_FULL;
 	}
 
-	orion_ge11_init(eth_data, &mv78xx0_mbus_dram_info,
+	orion_ge11_init(eth_data, &orion_mbus_dram_info,
 			GE11_PHYS_BASE, IRQ_MV78XX0_GE11_SUM,
 			NO_IRQ, get_tclk());
 }
@@ -277,7 +278,7 @@ void __init mv78xx0_i2c_init(void)
  ****************************************************************************/
 void __init mv78xx0_sata_init(struct mv_sata_platform_data *sata_data)
 {
-	orion_sata_init(sata_data, &mv78xx0_mbus_dram_info,
+	orion_sata_init(sata_data, &orion_mbus_dram_info,
 			SATA_PHYS_BASE, IRQ_MV78XX0_SATA);
 }
 
diff --git a/arch/arm/mach-mv78xx0/common.h b/arch/arm/mach-mv78xx0/common.h
index 632e63d..f2ca59c 100644
--- a/arch/arm/mach-mv78xx0/common.h
+++ b/arch/arm/mach-mv78xx0/common.h
@@ -23,7 +23,6 @@ void mv78xx0_init(void);
 void mv78xx0_init_early(void);
 void mv78xx0_init_irq(void);
 
-extern struct mbus_dram_target_info mv78xx0_mbus_dram_info;
 void mv78xx0_setup_cpu_mbus(void);
 void mv78xx0_setup_pcie_io_win(int window, u32 base, u32 size,
 			       int maj, int min);
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index c51af1c..9208667 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -15,6 +15,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
+#include <plat/addr-map.h>
 #include "common.h"
 
 struct pcie_port {
@@ -153,7 +154,7 @@ static int __init mv78xx0_pcie_setup(int nr, struct pci_sys_data *sys)
 	 * Generic PCIe unit setup.
 	 */
 	orion_pcie_set_local_bus_nr(pp->base, sys->busnr);
-	orion_pcie_setup(pp->base, &mv78xx0_mbus_dram_info);
+	orion_pcie_setup(pp->base, &orion_mbus_dram_info);
 
 	sys->resource[0] = &pp->res[0];
 	sys->resource[1] = &pp->res[1];
diff --git a/arch/arm/mach-orion5x/addr-map.c b/arch/arm/mach-orion5x/addr-map.c
index 73ceb49..3638e5c 100644
--- a/arch/arm/mach-orion5x/addr-map.c
+++ b/arch/arm/mach-orion5x/addr-map.c
@@ -56,7 +56,6 @@
 #define ATTR_DEV_BOOT		0xf
 #define ATTR_SRAM		0x0
 
-struct mbus_dram_target_info orion5x_mbus_dram_info;
 static int __initdata win_alloc_count;
 
 static int __init cpu_win_can_remap(const struct orion_addr_map_cfg *cfg,
@@ -114,8 +113,7 @@ void __init orion5x_setup_cpu_mbus_bridge(void)
 	/*
 	 * Setup MBUS dram target info.
 	 */
-	orion_setup_cpu_mbus_target(&addr_map_cfg, &orion5x_mbus_dram_info,
-				    ORION5X_DDR_WINDOW_CPU_BASE);
+	orion_setup_cpu_mbus_target(&addr_map_cfg, ORION5X_DDR_WINDOW_CPU_BASE);
 }
 
 void __init orion5x_setup_dev_boot_win(u32 base, u32 size)
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index ecca1e0..27addd5 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -31,6 +31,7 @@
 #include <plat/orion_nand.h>
 #include <plat/time.h>
 #include <plat/common.h>
+#include <plat/addr-map.h>
 #include "common.h"
 
 /*****************************************************************************
@@ -71,7 +72,7 @@ void __init orion5x_map_io(void)
  ****************************************************************************/
 void __init orion5x_ehci0_init(void)
 {
-	orion_ehci_init(&orion5x_mbus_dram_info,
+	orion_ehci_init(&orion_mbus_dram_info,
 			ORION5X_USB0_PHYS_BASE, IRQ_ORION5X_USB0_CTRL);
 }
 
@@ -81,7 +82,7 @@ void __init orion5x_ehci0_init(void)
  ****************************************************************************/
 void __init orion5x_ehci1_init(void)
 {
-	orion_ehci_1_init(&orion5x_mbus_dram_info,
+	orion_ehci_1_init(&orion_mbus_dram_info,
 			  ORION5X_USB1_PHYS_BASE, IRQ_ORION5X_USB1_CTRL);
 }
 
@@ -91,7 +92,7 @@ void __init orion5x_ehci1_init(void)
  ****************************************************************************/
 void __init orion5x_eth_init(struct mv643xx_eth_platform_data *eth_data)
 {
-	orion_ge00_init(eth_data, &orion5x_mbus_dram_info,
+	orion_ge00_init(eth_data, &orion_mbus_dram_info,
 			ORION5X_ETH_PHYS_BASE, IRQ_ORION5X_ETH_SUM,
 			IRQ_ORION5X_ETH_ERR, orion5x_tclk);
 }
@@ -121,7 +122,7 @@ void __init orion5x_i2c_init(void)
  ****************************************************************************/
 void __init orion5x_sata_init(struct mv_sata_platform_data *sata_data)
 {
-	orion_sata_init(sata_data, &orion5x_mbus_dram_info,
+	orion_sata_init(sata_data, &orion_mbus_dram_info,
 			ORION5X_SATA_PHYS_BASE, IRQ_ORION5X_SATA);
 }
 
@@ -158,7 +159,7 @@ void __init orion5x_uart1_init(void)
  ****************************************************************************/
 void __init orion5x_xor_init(void)
 {
-	orion_xor0_init(&orion5x_mbus_dram_info,
+	orion_xor0_init(&orion_mbus_dram_info,
 			ORION5X_XOR_PHYS_BASE,
 			ORION5X_XOR_PHYS_BASE + 0x200,
 			IRQ_ORION5X_XOR0, IRQ_ORION5X_XOR1);
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index 6276ca1..44a65af 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -20,7 +20,6 @@ extern struct sys_timer orion5x_timer;
  * functions to map its interfaces and by the machine-setup to map its on-
  * board devices. Details in /mach-orion/addr-map.c
  */
-extern struct mbus_dram_target_info orion5x_mbus_dram_info;
 void orion5x_setup_cpu_mbus_bridge(void);
 void orion5x_setup_dev_boot_win(u32 base, u32 size);
 void orion5x_setup_dev0_win(u32 base, u32 size);
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index bc4a920..ddfa01a 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -18,6 +18,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
+#include <plat/addr-map.h>
 #include "common.h"
 
 /*****************************************************************************
@@ -145,7 +146,7 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 	/*
 	 * Generic PCIe unit setup.
 	 */
-	orion_pcie_setup(PCIE_BASE, &orion5x_mbus_dram_info);
+	orion_pcie_setup(PCIE_BASE, &orion_mbus_dram_info);
 
 	/*
 	 * Check whether to apply Orion-1/Orion-NAS PCIe config
@@ -477,7 +478,7 @@ static int __init pci_setup(struct pci_sys_data *sys)
 	/*
 	 * Point PCI unit MBUS decode windows to DRAM space.
 	 */
-	orion5x_setup_pci_wins(&orion5x_mbus_dram_info);
+	orion5x_setup_pci_wins(&orion_mbus_dram_info);
 
 	/*
 	 * Master + Slave enable
diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/plat-orion/addr-map.c
index d3abb34..c27ad88 100644
--- a/arch/arm/plat-orion/addr-map.c
+++ b/arch/arm/plat-orion/addr-map.c
@@ -14,6 +14,8 @@
 #include <linux/io.h>
 #include <plat/addr-map.h>
 
+struct mbus_dram_target_info orion_mbus_dram_info;
+
 /*
  * DDR target is the same on all Orion platforms.
  */
@@ -134,14 +136,13 @@ void __init orion_config_wins(struct orion_addr_map_cfg * cfg,
  * Setup MBUS dram target info.
  */
 void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
-					struct mbus_dram_target_info *info,
 					const u32 ddr_window_cpu_base)
 {
 	void __iomem *addr;
 	int i;
 	int cs;
 
-	info->mbus_dram_target_id = TARGET_DDR;
+	orion_mbus_dram_info.mbus_dram_target_id = TARGET_DDR;
 
 	addr = (void __iomem *)ddr_window_cpu_base;
 
@@ -155,12 +156,12 @@ void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
 		if (size & 1) {
 			struct mbus_dram_window *w;
 
-			w = &info->cs[cs++];
+			w = &orion_mbus_dram_info.cs[cs++];
 			w->cs_index = i;
 			w->mbus_attr = 0xf & ~(1 << i);
 			w->base = base & 0xffff0000;
 			w->size = (size | 0x0000ffff) + 1;
 		}
 	}
-	info->num_cs = cs;
+	orion_mbus_dram_info.num_cs = cs;
 }
diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/plat-orion/include/plat/addr-map.h
index 55e40f4..fd556f7 100644
--- a/arch/arm/plat-orion/include/plat/addr-map.h
+++ b/arch/arm/plat-orion/include/plat/addr-map.h
@@ -11,6 +11,8 @@
 #ifndef __PLAT_ADDR_MAP_H
 #define __PLAT_ADDR_MAP_H
 
+extern struct mbus_dram_target_info orion_mbus_dram_info;
+
 struct orion_addr_map_cfg {
 	const int num_wins;	/* Total number of windows */
 	const int remappable_wins;
@@ -47,6 +49,5 @@ void __init orion_setup_cpu_win(const struct orion_addr_map_cfg *cfg,
 				const u8 attr, const int remap);
 
 void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
-					struct mbus_dram_target_info *info,
 					const u32 ddr_window_cpu_base);
 #endif
-- 
1.7.2.5
