From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Jul 2013 18:39:16 -0300
Subject: [PATCH v6 05/21] ARM: orion5x: Move to ID based window creation
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373060372-32357-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

With the introduction of the ID based MBus API, it's better
to switch to use it instead of the current name based scheme.

This will allow to deprecate the name based API, once every
user is removed.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-orion5x/common.c                 | 36 ++++++++++++++------------
 arch/arm/mach-orion5x/common.h                 | 17 ++++++++++++
 arch/arm/mach-orion5x/d2net-setup.c            |  6 +++--
 arch/arm/mach-orion5x/db88f5281-setup.c        | 24 +++++++++++------
 arch/arm/mach-orion5x/dns323-setup.c           |  6 +++--
 arch/arm/mach-orion5x/edmini_v2-setup.c        |  6 +++--
 arch/arm/mach-orion5x/kurobox_pro-setup.c      | 12 ++++++---
 arch/arm/mach-orion5x/ls-chl-setup.c           |  6 +++--
 arch/arm/mach-orion5x/ls_hgl-setup.c           |  6 +++--
 arch/arm/mach-orion5x/lsmini-setup.c           |  6 +++--
 arch/arm/mach-orion5x/mss2-setup.c             |  6 +++--
 arch/arm/mach-orion5x/mv2120-setup.c           |  6 +++--
 arch/arm/mach-orion5x/net2big-setup.c          |  6 +++--
 arch/arm/mach-orion5x/pci.c                    |  9 +++----
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   |  6 +++--
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    |  6 +++--
 arch/arm/mach-orion5x/rd88f5182-setup.c        | 13 ++++++----
 arch/arm/mach-orion5x/terastation_pro2-setup.c |  6 +++--
 arch/arm/mach-orion5x/ts209-setup.c            |  6 +++--
 arch/arm/mach-orion5x/ts409-setup.c            |  6 +++--
 arch/arm/mach-orion5x/wnr854t-setup.c          |  6 +++--
 arch/arm/mach-orion5x/wrt350n-v2-setup.c       |  6 +++--
 22 files changed, 137 insertions(+), 70 deletions(-)

diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index b41599f..91a5852 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -174,8 +174,10 @@ void __init orion5x_xor_init(void)
  ****************************************************************************/
 static void __init orion5x_crypto_init(void)
 {
-	mvebu_mbus_add_window("sram", ORION5X_SRAM_PHYS_BASE,
-			      ORION5X_SRAM_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_SRAM_TARGET,
+				    ORION_MBUS_SRAM_ATTR,
+				    ORION5X_SRAM_PHYS_BASE,
+				    ORION5X_SRAM_SIZE);
 	orion_crypto_init(ORION5X_CRYPTO_PHYS_BASE, ORION5X_SRAM_PHYS_BASE,
 			  SZ_8K, IRQ_ORION5X_CESA);
 }
@@ -222,22 +224,24 @@ void orion5x_setup_wins(void)
 	 * The PCIe windows will no longer be statically allocated
 	 * here once Orion5x is migrated to the pci-mvebu driver.
 	 */
-	mvebu_mbus_add_window_remap_flags("pcie0.0", ORION5X_PCIE_IO_PHYS_BASE,
+	mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCIE_IO_TARGET,
+					  ORION_MBUS_PCIE_IO_ATTR,
+					  ORION5X_PCIE_IO_PHYS_BASE,
 					  ORION5X_PCIE_IO_SIZE,
-					  ORION5X_PCIE_IO_BUS_BASE,
-					  MVEBU_MBUS_PCI_IO);
-	mvebu_mbus_add_window_remap_flags("pcie0.0", ORION5X_PCIE_MEM_PHYS_BASE,
-					  ORION5X_PCIE_MEM_SIZE,
-					  MVEBU_MBUS_NO_REMAP,
-					  MVEBU_MBUS_PCI_MEM);
-	mvebu_mbus_add_window_remap_flags("pci0.0", ORION5X_PCI_IO_PHYS_BASE,
+					  ORION5X_PCIE_IO_BUS_BASE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_PCIE_MEM_TARGET,
+				    ORION_MBUS_PCIE_MEM_ATTR,
+				    ORION5X_PCIE_MEM_PHYS_BASE,
+				    ORION5X_PCIE_MEM_SIZE);
+	mvebu_mbus_add_window_remap_by_id(ORION_MBUS_PCI_IO_TARGET,
+					  ORION_MBUS_PCI_IO_ATTR,
+					  ORION5X_PCI_IO_PHYS_BASE,
 					  ORION5X_PCI_IO_SIZE,
-					  ORION5X_PCI_IO_BUS_BASE,
-					  MVEBU_MBUS_PCI_IO);
-	mvebu_mbus_add_window_remap_flags("pci0.0", ORION5X_PCI_MEM_PHYS_BASE,
-					  ORION5X_PCI_MEM_SIZE,
-					  MVEBU_MBUS_NO_REMAP,
-					  MVEBU_MBUS_PCI_MEM);
+					  ORION5X_PCI_IO_BUS_BASE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_PCI_MEM_TARGET,
+				    ORION_MBUS_PCI_MEM_ATTR,
+				    ORION5X_PCI_MEM_PHYS_BASE,
+				    ORION5X_PCI_MEM_SIZE);
 }
 
 int orion5x_tclk;
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index a909afb..f565f99 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -7,6 +7,23 @@ struct dsa_platform_data;
 struct mv643xx_eth_platform_data;
 struct mv_sata_platform_data;
 
+#define ORION_MBUS_PCIE_MEM_TARGET    0x04
+#define ORION_MBUS_PCIE_MEM_ATTR      0x59
+#define ORION_MBUS_PCIE_IO_TARGET     0x04
+#define ORION_MBUS_PCIE_IO_ATTR       0x51
+#define ORION_MBUS_PCIE_WA_TARGET     0x04
+#define ORION_MBUS_PCIE_WA_ATTR       0x79
+#define ORION_MBUS_PCI_MEM_TARGET     0x03
+#define ORION_MBUS_PCI_MEM_ATTR       0x59
+#define ORION_MBUS_PCI_IO_TARGET      0x03
+#define ORION_MBUS_PCI_IO_ATTR        0x51
+#define ORION_MBUS_DEVBUS_BOOT_TARGET 0x01
+#define ORION_MBUS_DEVBUS_BOOT_ATTR   0x0f
+#define ORION_MBUS_DEVBUS_TARGET(cs)  0x01
+#define ORION_MBUS_DEVBUS_ATTR(cs)    (~(1 << cs))
+#define ORION_MBUS_SRAM_TARGET        0x00
+#define ORION_MBUS_SRAM_ATTR          0x00
+
 /*
  * Basic Orion init functions used early by machine-setup.
  */
diff --git a/arch/arm/mach-orion5x/d2net-setup.c b/arch/arm/mach-orion5x/d2net-setup.c
index 16c88bb..8f68b74 100644
--- a/arch/arm/mach-orion5x/d2net-setup.c
+++ b/arch/arm/mach-orion5x/d2net-setup.c
@@ -317,8 +317,10 @@ static void __init d2net_init(void)
 	d2net_sata_power_init();
 	orion5x_sata_init(&d2net_sata_data);
 
-	mvebu_mbus_add_window("devbus-boot", D2NET_NOR_BOOT_BASE,
-			      D2NET_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    D2NET_NOR_BOOT_BASE,
+				    D2NET_NOR_BOOT_SIZE);
 	platform_device_register(&d2net_nor_flash);
 
 	platform_device_register(&d2net_gpio_buttons);
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index 4e1263d..4b2aefd 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -340,19 +340,27 @@ static void __init db88f5281_init(void)
 	orion5x_uart0_init();
 	orion5x_uart1_init();
 
-	mvebu_mbus_add_window("devbus-boot", DB88F5281_NOR_BOOT_BASE,
-			      DB88F5281_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    DB88F5281_NOR_BOOT_BASE,
+				    DB88F5281_NOR_BOOT_SIZE);
 	platform_device_register(&db88f5281_boot_flash);
 
-	mvebu_mbus_add_window("devbus-cs0", DB88F5281_7SEG_BASE,
-			      DB88F5281_7SEG_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_TARGET(0),
+				    ORION_MBUS_DEVBUS_ATTR(0),
+				    DB88F5281_7SEG_BASE,
+				    DB88F5281_7SEG_SIZE);
 
-	mvebu_mbus_add_window("devbus-cs1", DB88F5281_NOR_BASE,
-			      DB88F5281_NOR_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_TARGET(1),
+				    ORION_MBUS_DEVBUS_ATTR(1),
+				    DB88F5281_NOR_BASE,
+				    DB88F5281_NOR_SIZE);
 	platform_device_register(&db88f5281_nor_flash);
 
-	mvebu_mbus_add_window("devbus-cs2", DB88F5281_NAND_BASE,
-			      DB88F5281_NAND_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_TARGET(2),
+				    ORION_MBUS_DEVBUS_ATTR(2),
+				    DB88F5281_NAND_BASE,
+				    DB88F5281_NAND_SIZE);
 	platform_device_register(&db88f5281_nand_flash);
 
 	i2c_register_board_info(0, &db88f5281_i2c_rtc, 1);
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 9e6baf5..7097473 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -611,8 +611,10 @@ static void __init dns323_init(void)
 	/* setup flash mapping
 	 * CS3 holds a 8 MB Spansion S29GL064M90TFIR4
 	 */
-	mvebu_mbus_add_window("devbus-boot", DNS323_NOR_BOOT_BASE,
-			      DNS323_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    DNS323_NOR_BOOT_BASE,
+				    DNS323_NOR_BOOT_SIZE);
 	platform_device_register(&dns323_nor_flash);
 
 	/* Sort out LEDs, Buttons and i2c devices */
diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
index 1476155..0fc33c5 100644
--- a/arch/arm/mach-orion5x/edmini_v2-setup.c
+++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
@@ -154,8 +154,10 @@ void __init edmini_v2_init(void)
 	orion5x_ehci0_init();
 	orion5x_eth_init(&edmini_v2_eth_data);
 
-	mvebu_mbus_add_window("devbus-boot", EDMINI_V2_NOR_BOOT_BASE,
-			      EDMINI_V2_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    EDMINI_V2_NOR_BOOT_BASE,
+				    EDMINI_V2_NOR_BOOT_SIZE);
 	platform_device_register(&edmini_v2_nor_flash);
 
 	pr_notice("edmini_v2: USB device port, flash write and power-off "
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index aae10e4..fe6a48a 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -359,13 +359,17 @@ static void __init kurobox_pro_init(void)
 	orion5x_uart1_init();
 	orion5x_xor_init();
 
-	mvebu_mbus_add_window("devbus-boot", KUROBOX_PRO_NOR_BOOT_BASE,
-			      KUROBOX_PRO_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    KUROBOX_PRO_NOR_BOOT_BASE,
+				    KUROBOX_PRO_NOR_BOOT_SIZE);
 	platform_device_register(&kurobox_pro_nor_flash);
 
 	if (machine_is_kurobox_pro()) {
-		mvebu_mbus_add_window("devbus-cs0", KUROBOX_PRO_NAND_BASE,
-				      KUROBOX_PRO_NAND_SIZE);
+		mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_TARGET(0),
+					    ORION_MBUS_DEVBUS_ATTR(0),
+					    KUROBOX_PRO_NAND_BASE,
+					    KUROBOX_PRO_NAND_SIZE);
 		platform_device_register(&kurobox_pro_nand_flash);
 	}
 
diff --git a/arch/arm/mach-orion5x/ls-chl-setup.c b/arch/arm/mach-orion5x/ls-chl-setup.c
index 6234977..028ea03 100644
--- a/arch/arm/mach-orion5x/ls-chl-setup.c
+++ b/arch/arm/mach-orion5x/ls-chl-setup.c
@@ -294,8 +294,10 @@ static void __init lschl_init(void)
 	orion5x_uart0_init();
 	orion5x_xor_init();
 
-	mvebu_mbus_add_window("devbus-boot", LSCHL_NOR_BOOT_BASE,
-			      LSCHL_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    LSCHL_NOR_BOOT_BASE,
+				    LSCHL_NOR_BOOT_SIZE);
 	platform_device_register(&lschl_nor_flash);
 
 	platform_device_register(&lschl_leds);
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
index fe04c4b..32b7129 100644
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ b/arch/arm/mach-orion5x/ls_hgl-setup.c
@@ -243,8 +243,10 @@ static void __init ls_hgl_init(void)
 	orion5x_uart0_init();
 	orion5x_xor_init();
 
-	mvebu_mbus_add_window("devbus-boot", LS_HGL_NOR_BOOT_BASE,
-			      LS_HGL_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    LS_HGL_NOR_BOOT_BASE,
+				    LS_HGL_NOR_BOOT_SIZE);
 	platform_device_register(&ls_hgl_nor_flash);
 
 	platform_device_register(&ls_hgl_button_device);
diff --git a/arch/arm/mach-orion5x/lsmini-setup.c b/arch/arm/mach-orion5x/lsmini-setup.c
index ca4dbe9..a6493e7 100644
--- a/arch/arm/mach-orion5x/lsmini-setup.c
+++ b/arch/arm/mach-orion5x/lsmini-setup.c
@@ -244,8 +244,10 @@ static void __init lsmini_init(void)
 	orion5x_uart0_init();
 	orion5x_xor_init();
 
-	mvebu_mbus_add_window("devbus-boot", LSMINI_NOR_BOOT_BASE,
-			      LSMINI_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    LSMINI_NOR_BOOT_BASE,
+				    LSMINI_NOR_BOOT_SIZE);
 	platform_device_register(&lsmini_nor_flash);
 
 	platform_device_register(&lsmini_button_device);
diff --git a/arch/arm/mach-orion5x/mss2-setup.c b/arch/arm/mach-orion5x/mss2-setup.c
index 827acba..e105130 100644
--- a/arch/arm/mach-orion5x/mss2-setup.c
+++ b/arch/arm/mach-orion5x/mss2-setup.c
@@ -241,8 +241,10 @@ static void __init mss2_init(void)
 	orion5x_uart0_init();
 	orion5x_xor_init();
 
-	mvebu_mbus_add_window("devbus-boot", MSS2_NOR_BOOT_BASE,
-			      MSS2_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    MSS2_NOR_BOOT_BASE,
+				    MSS2_NOR_BOOT_SIZE);
 	platform_device_register(&mss2_nor_flash);
 
 	platform_device_register(&mss2_button_device);
diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
index 92600ae..e032f01 100644
--- a/arch/arm/mach-orion5x/mv2120-setup.c
+++ b/arch/arm/mach-orion5x/mv2120-setup.c
@@ -204,8 +204,10 @@ static void __init mv2120_init(void)
 	orion5x_uart0_init();
 	orion5x_xor_init();
 
-	mvebu_mbus_add_window("devbus-boot", MV2120_NOR_BOOT_BASE,
-			      MV2120_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    MV2120_NOR_BOOT_BASE,
+				    MV2120_NOR_BOOT_SIZE);
 	platform_device_register(&mv2120_nor_flash);
 
 	platform_device_register(&mv2120_button_device);
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index dd0641a..ba73dc7 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -397,8 +397,10 @@ static void __init net2big_init(void)
 	net2big_sata_power_init();
 	orion5x_sata_init(&net2big_sata_data);
 
-	mvebu_mbus_add_window("devbus-boot", NET2BIG_NOR_BOOT_BASE,
-			      NET2BIG_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    NET2BIG_NOR_BOOT_BASE,
+				    NET2BIG_NOR_BOOT_SIZE);
 	platform_device_register(&net2big_nor_flash);
 
 	platform_device_register(&net2big_gpio_buttons);
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 5033680..7fab670 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -157,11 +157,10 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 	if (dev == MV88F5181_DEV_ID || dev == MV88F5182_DEV_ID) {
 		printk(KERN_NOTICE "Applying Orion-1/Orion-NAS PCIe config "
 				   "read transaction workaround\n");
-		mvebu_mbus_add_window_remap_flags("pcie0.0",
-						  ORION5X_PCIE_WA_PHYS_BASE,
-						  ORION5X_PCIE_WA_SIZE,
-						  MVEBU_MBUS_NO_REMAP,
-						  MVEBU_MBUS_PCI_WA);
+		mvebu_mbus_add_window_by_id(ORION_MBUS_PCIE_WA_TARGET,
+					    ORION_MBUS_PCIE_WA_ATTR,
+					    ORION5X_PCIE_WA_PHYS_BASE,
+					    ORION5X_PCIE_WA_SIZE);
 		pcie_ops.read = pcie_rd_conf_wa;
 	}
 
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index 1c4498b..213b3e1 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -123,8 +123,10 @@ static void __init rd88f5181l_fxo_init(void)
 	orion5x_eth_switch_init(&rd88f5181l_fxo_switch_plat_data, NO_IRQ);
 	orion5x_uart0_init();
 
-	mvebu_mbus_add_window("devbus-boot", RD88F5181L_FXO_NOR_BOOT_BASE,
-			      RD88F5181L_FXO_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    RD88F5181L_FXO_NOR_BOOT_BASE,
+				    RD88F5181L_FXO_NOR_BOOT_SIZE);
 	platform_device_register(&rd88f5181l_fxo_nor_boot_flash);
 }
 
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index adabe34..594800e 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -130,8 +130,10 @@ static void __init rd88f5181l_ge_init(void)
 	orion5x_i2c_init();
 	orion5x_uart0_init();
 
-	mvebu_mbus_add_window("devbus-boot", RD88F5181L_GE_NOR_BOOT_BASE,
-			      RD88F5181L_GE_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    RD88F5181L_GE_NOR_BOOT_BASE,
+				    RD88F5181L_GE_NOR_BOOT_SIZE);
 	platform_device_register(&rd88f5181l_ge_nor_boot_flash);
 
 	i2c_register_board_info(0, &rd88f5181l_ge_i2c_rtc, 1);
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index 66e77ec..b1cf684 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -264,11 +264,14 @@ static void __init rd88f5182_init(void)
 	orion5x_uart0_init();
 	orion5x_xor_init();
 
-	mvebu_mbus_add_window("devbus-boot", RD88F5182_NOR_BOOT_BASE,
-			      RD88F5182_NOR_BOOT_SIZE);
-
-	mvebu_mbus_add_window("devbus-cs1", RD88F5182_NOR_BASE,
-			      RD88F5182_NOR_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    RD88F5182_NOR_BOOT_BASE,
+				    RD88F5182_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_TARGET(1),
+				    ORION_MBUS_DEVBUS_ATTR(1),
+				    RD88F5182_NOR_BASE,
+				    RD88F5182_NOR_SIZE);
 	platform_device_register(&rd88f5182_nor_flash);
 	platform_device_register(&rd88f5182_gpio_leds);
 
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index a0bfa53..7e90648 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -329,8 +329,10 @@ static void __init tsp2_init(void)
 	/*
 	 * Configure peripherals.
 	 */
-	mvebu_mbus_add_window("devbus-boot", TSP2_NOR_BOOT_BASE,
-			      TSP2_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    TSP2_NOR_BOOT_BASE,
+				    TSP2_NOR_BOOT_SIZE);
 	platform_device_register(&tsp2_nor_flash);
 
 	orion5x_ehci0_init();
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index 80174f0..e90c061 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -286,8 +286,10 @@ static void __init qnap_ts209_init(void)
 	/*
 	 * Configure peripherals.
 	 */
-	mvebu_mbus_add_window("devbus-boot", QNAP_TS209_NOR_BOOT_BASE,
-			      QNAP_TS209_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    QNAP_TS209_NOR_BOOT_BASE,
+				    QNAP_TS209_NOR_BOOT_SIZE);
 	platform_device_register(&qnap_ts209_nor_flash);
 
 	orion5x_ehci0_init();
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index 9259279..5c079d3 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -277,8 +277,10 @@ static void __init qnap_ts409_init(void)
 	/*
 	 * Configure peripherals.
 	 */
-	mvebu_mbus_add_window("devbus-boot", QNAP_TS409_NOR_BOOT_BASE,
-			      QNAP_TS409_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    QNAP_TS409_NOR_BOOT_BASE,
+				    QNAP_TS409_NOR_BOOT_SIZE);
 	platform_device_register(&qnap_ts409_nor_flash);
 
 	orion5x_ehci0_init();
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 6b84863..80a56ee 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -127,8 +127,10 @@ static void __init wnr854t_init(void)
 	orion5x_eth_switch_init(&wnr854t_switch_plat_data, NO_IRQ);
 	orion5x_uart0_init();
 
-	mvebu_mbus_add_window("devbus-boot", WNR854T_NOR_BOOT_BASE,
-			      WNR854T_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    WNR854T_NOR_BOOT_BASE,
+				    WNR854T_NOR_BOOT_SIZE);
 	platform_device_register(&wnr854t_nor_flash);
 }
 
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index fae684b..670e30d 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -213,8 +213,10 @@ static void __init wrt350n_v2_init(void)
 	orion5x_eth_switch_init(&wrt350n_v2_switch_plat_data, NO_IRQ);
 	orion5x_uart0_init();
 
-	mvebu_mbus_add_window("devbus-boot", WRT350N_V2_NOR_BOOT_BASE,
-			      WRT350N_V2_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
+				    ORION_MBUS_DEVBUS_BOOT_ATTR,
+				    WRT350N_V2_NOR_BOOT_BASE,
+				    WRT350N_V2_NOR_BOOT_SIZE);
 	platform_device_register(&wrt350n_v2_nor_flash);
 	platform_device_register(&wrt350n_v2_leds);
 	platform_device_register(&wrt350n_v2_button_device);
-- 
1.8.1.5
