From: sudhakar.raj@ti.com (Rajashekhara, Sudhakar)
Date: Mon, 4 Jul 2011 18:37:18 +0530
Subject: [PATCH v2] davinci: da850 EVM: read mac address from SPI flash
Message-ID: <1309784838-30903-1-git-send-email-sudhakar.raj@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DA850/OMAP-L138 EMAC driver uses random mac address instead of
a fixed one because the mac address is not stuffed into EMAC
platform data.

This patch provides a function which reads the mac address
stored in SPI flash (registered as MTD device) and populates the
EMAC platform data. The function which reads the mac address is
registered as a callback which gets called upon addition of MTD
device.

NOTE: In case the MAC address stored in SPI flash is erased, follow
the instructions at [1] to restore it.

[1] http://processors.wiki.ti.com/index.php/GSG:_OMAP-L138_DVEVM_Additional_Procedures#Restoring_MAC_address_on_SPI_Flash

Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
---
Since v1:
     Guarded registering the mtd_notifier only when MTD is enabled.
     Earlier this was handled using mtd_has_partitions() call, but
     this has been removed in Linux v3.0.

 arch/arm/mach-davinci/board-da850-evm.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a7b41bf..f994a1f 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -115,6 +115,23 @@ static struct spi_board_info da850evm_spi_info[] = {
 	},
 };
 
+static void da850_evm_m25p80_notify_add(struct mtd_info *mtd)
+{
+	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
+	size_t retlen;
+
+	if (!strcmp(mtd->name, "MAC-Address")) {
+		mtd->read(mtd, 0, ETH_ALEN, &retlen, mac_addr);
+		if (retlen == ETH_ALEN)
+			pr_info("Read MAC addr from SPI Flash: %pM\n",
+				mac_addr);
+	}
+}
+
+static struct mtd_notifier da850evm_spi_notifier = {
+	.add	= da850_evm_m25p80_notify_add,
+};
+
 static struct mtd_partition da850_evm_norflash_partition[] = {
 	{
 		.name           = "bootloaders + env",
@@ -1117,6 +1134,15 @@ static __init int da850_evm_init_cpufreq(void)
 static __init int da850_evm_init_cpufreq(void) { return 0; }
 #endif
 
+#ifdef CONFIG_MTD
+static void da850_evm_register_mtd_user(struct mtd_notifier *notify)
+{
+	register_mtd_user(notify);
+}
+#else
+static void da850_evm_register_mtd_user(struct mtd_notifier *notify) { }
+#endif
+
 static __init void da850_evm_init(void)
 {
 	int ret;
@@ -1237,6 +1263,8 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warning("da850_evm_init: spi 1 registration failed: %d\n",
 				ret);
+
+	da850_evm_register_mtd_user(&da850evm_spi_notifier);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
1.7.1
