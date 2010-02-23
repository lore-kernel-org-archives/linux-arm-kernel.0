From: sebastien@kolios.dk (Sebastien Requiem)
Date: Tue, 23 Feb 2010 14:51:24 +0100
Subject: [PATCH] Support for Buffalo WXL (Terastation Duo)
Message-ID: <4B83DD5C.2080607@kolios.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,



I have created a patch to support a new Sub architecture.


Description of patch:

* Modification of Kconfig to add the Option
* 1 new file : buffalo-wxl-setup.c
This file is inspired from the db-78xx0-setup.c already present.
The following is done:
  - Configure MPP Lines for the plateform (see my patch for MPP)
This is taken from the stock kernel provided by buffalotech (the vendor)
  - GigaBit Ethernet
  - Sata
  - Uart are initiallized in a different way than on the dev board as we 
have one core only.
  - USB


The kernel has been running for some days now on my plateform.

I would appreciate if you had time to review my patch and give me any 
comments/feedback
regarding my work.

==== PATCH ====

  arch/arm/mach-mv78xx0/Kconfig             |    9 ++
  arch/arm/mach-mv78xx0/buffalo-wxl-setup.c |  189 
+++++++++++++++++++++++++++++
  2 files changed, 198 insertions(+), 0 deletions(-)
  create mode 100644 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c

diff --git a/arch/arm/mach-mv78xx0/Kconfig b/arch/arm/mach-mv78xx0/Kconfig
index 6fbe68f..4129d29 100644
--- a/arch/arm/mach-mv78xx0/Kconfig
+++ b/arch/arm/mach-mv78xx0/Kconfig
@@ -14,6 +14,15 @@ config MACH_RD78X00_MASA
        Say 'Y' here if you want your kernel to support the
        Marvell RD-78x00-mASA Reference Design.

+
+config MACH_BUFFALO_WXL
+    bool "Buffalo WLX plateform"
+    help
+      Say 'Y' here if you want your kernel to support the
+      Buffalo WXL Nas.
+
+
+
  endmenu

  endif
diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c 
b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
new file mode 100644
index 0000000..9d00e28
--- /dev/null
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -0,0 +1,189 @@
+/*
+ * arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+ *
+ * Buffalo WXL (Terastation Duo) Setup routines
+ *
+ * sebastien requiem <sebastien@requiem.fr>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/ata_platform.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/ethtool.h>
+#include <linux/i2c.h>
+#include <mach/mv78xx0.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include "common.h"
+#include "mpp.h"
+
+
+/* This arch has 2 Giga Ethernet */
+
+static struct mv643xx_eth_platform_data db78x00_ge00_data = {
+    .phy_addr    = MV643XX_ETH_PHY_ADDR(0),
+};
+
+static struct mv643xx_eth_platform_data db78x00_ge01_data = {
+    .phy_addr    = MV643XX_ETH_PHY_ADDR(8),
+};
+
+/* 2 STAT controller supporting HotPlug */
+
+static struct mv_sata_platform_data db78x00_sata_data = {
+    .n_ports    = 2,
+};
+
+static struct i2c_board_info __initdata db78x00_i2c_rtc = {
+    I2C_BOARD_INFO("ds1338", 0x68),
+};
+
+
+/*  MPP values extracted from stock kernel 2.6.22                   */
+/*  MPP[0] = GE_TXCLK               MPP[1] = GE_TXCTL               */
+/*  MPP[2] = GE_RXCTL               MPP[3] = GE_RXCLK               */
+/*  MPP[4] = GE_TXD0                MPP[5] = GE_TXD1                */
+/*  MPP[6] = GE_TXD2                MPP[7] = GE_TXD3                */
+/*  #define BUFFALO_DB_78XX0_MPP0_7   0x22222222                    */
+
+/*  MPP[8] = GE_RXD0                MPP[9]  = GE_RXD1               */
+/*  MPP[10] = GE_RXD2               MPP[11] = GE_RXD3               */
+/*  MPP[12] = GPIO[12] - USB1_VBUS  MPP[13] = MV_SYS_RST            */
+/*  MPP[14] = SATA1_ACT             MPP[15] = SATA2_ACT             */
+/*  #define BUFFALO_DB_78XX0_MPP8_15  0x00552222                    */
+
+/*  MPP[16] = UART2_TXD             MPP[17] = UART2_RXD             */
+/*  MPP[18] = UART0_CTS             MPP[19] = UART0_RTS             */
+/*  MPP[20] = UART1_CTS             MPP[21] = UART1_RTS             */
+/*  MPP[22] = UART3_TXD             MPP[23] = UART3_RXD             */
+/*  #define BUFFALO_DB_78XX0_MPP16_23 0x00000000                    */
+
+/*  MPP[24] = DC                    MPP[25] = DC                    */
+/*  MPP[26] = DC                    MPP[26] = DC                    */
+/*  MPP[28] = DC                    MPP[27] = DC                    */
+/*  MPP[30] = DC                    MPP[28] = DC                    */
+/*  #define BUFFALO_DB_78XX0_MPP24_31 0x00504444                    */
+
+/*  MPP[32] = FAN_SENCE_CHANNEL     MPP[33] = FAN_SENCE_CHANNEL     */
+/*  MPP[34] = FAN_SENCE_CHANNEL     MPP[35] = USB3(VBUS)            */
+/*  MPP[36] = DC                    MPP[37] = DC                    */
+/*  MPP[38] = DC                    MPP[39] = DC                    */
+
+/*  #define BUFFALO_DB_78XX0_MPP32_39 0x00001111                    */
+/*  #define BUFFALO_DB_78XX0_MPP40_47 0x00000000                    */
+/*  #define BUFFALO_DB_78XX0_MPP48_55 0x00000033                    */
+
+static unsigned int wxl_mpp_config[] __initdata = {
+    MPP0_GE1_TXCLK,
+    MPP1_GE1_TXCTL,
+    MPP2_GE1_RXCTL,
+    MPP3_GE1_RXCLK,
+    MPP4_GE1_TXD0,
+    MPP5_GE1_TXD1,
+    MPP6_GE1_TXD2,
+    MPP7_GE1_TXD3,
+    MPP8_GE1_RXD0,
+    MPP9_GE1_RXD1,
+    MPP10_GE1_RXD2,
+    MPP11_GE1_RXD3,
+    MPP12_GPIO,
+    MPP13_SYSRST_OUTn,
+    MPP14_SATA1_ACTn,
+    MPP15_SATA0_ACTn,
+    MPP16_GPIO,
+    MPP17_GPIO,
+    MPP18_GPIO,
+    MPP19_GPIO,
+    MPP20_GPIO,
+    MPP21_GPIO,
+    MPP22_GPIO,
+    MPP23_GPIO,
+    MPP24_UA2_TXD,
+    MPP25_UA2_RXD,
+    MPP26_UA2_CTSn,
+    MPP27_UA2_RTSn,
+    MPP28_GPIO,
+    MPP29_SYSRST_OUTn,
+    MPP30_GPIO,
+    MPP31_GPIO,
+    MPP32_GPIO,
+    MPP33_GPIO,
+    MPP34_GPIO,
+    MPP35_GPIO,
+    MPP36_GPIO,
+    MPP37_GPIO,
+    MPP38_GPIO,
+    MPP39_GPIO,
+    MPP40_UNUSED,
+    MPP41_UNUSED,
+    MPP42_UNUSED,
+    MPP43_UNUSED,
+    MPP44_UNUSED,
+    MPP45_UNUSED,
+    MPP46_UNUSED,
+    MPP47_UNUSED,
+    MPP48_SATA1_ACTn,
+    MPP49_SATA0_ACTn,
+    0
+};
+
+
+
+static void __init wxl_init(void)
+{
+    /*
+     * Basic MV78xx0 setup. Needs to be called early.
+     */
+    mv78xx0_init();
+    mv78xx0_mpp_conf(wxl_mpp_config);
+
+    /*
+     * Partition on-chip peripherals between the two CPU cores.
+     */
+    mv78xx0_ehci0_init();
+    mv78xx0_ehci1_init();
+    mv78xx0_ehci2_init();
+    mv78xx0_ge00_init(&db78x00_ge00_data);
+    mv78xx0_ge01_init(&db78x00_ge01_data);
+    mv78xx0_sata_init(&db78x00_sata_data);
+    mv78xx0_uart0_init();
+    mv78xx0_uart1_init();
+    mv78xx0_uart2_init();
+    mv78xx0_uart3_init();
+    mv78xx0_i2c_init();
+    i2c_register_board_info(0, &db78x00_i2c_rtc, 1);
+}
+
+static int __init wxl_pci_init(void)
+{
+    if (machine_is_db78x00_bp()) {
+        /*
+        * Assign the x16 PCIe slot on the board to CPU core
+        * #0, and let CPU core #1 have the four x1 slots.
+        */
+        if (mv78xx0_core_index() == 0)
+            mv78xx0_pcie_init(0, 1);
+        else
+            mv78xx0_pcie_init(1, 0);
+    }
+
+    return 0;
+}
+subsys_initcall(wxl_pci_init);
+
+MACHINE_START(TERASTATION_WXL, "Buffalo Nas WXL")
+    /* Maintainer: Sebastien Requiem <sebastien@requiem.fr> */
+    .phys_io    = MV78XX0_REGS_PHYS_BASE,
+    .io_pg_offst    = ((MV78XX0_REGS_VIRT_BASE) >> 18) & 0xfffc,
+    .boot_params    = 0x00000100,
+    .init_machine    = wxl_init,
+    .map_io        = mv78xx0_map_io,
+    .init_irq    = mv78xx0_init_irq,
+    .timer        = &mv78xx0_timer,
+MACHINE_END
-- 
1.5.6.5

Signed-off-by: Sebastien Requiem <sebastien@kolios.dk>

-- 
sebastien requiem
kolios.dk
tel: +45.50.14.00.02
