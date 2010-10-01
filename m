From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:38 -0700
Subject: [PATCH 14/47] DA850: move MII/RMII pin lists to the board file
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-15-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

The CPGMAC pin list in da850.c was incorrectly split into two MII/RMII mode
specific pin lists, while what pin group is used is a function of how the board
is wired.  Copy the pin lists to board-da850-evm.c, renaming them accordingly,
and merge the two lists in da850.c into one, da850_cpgmac_pins[], representing
the CPGMAC module as a whole...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Tested-by: Ben Gardiner <bengardiner@nanometrics.ca>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da850-evm.c    |   21 +++++++++++++++++++--
 arch/arm/mach-davinci/da850.c              |   12 +++---------
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 -
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 482d458..190ebd3 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -600,6 +600,23 @@ static const short da850_evm_lcdc_pins[] = {
 	-1
 };
 
+static const short da850_evm_mii_pins[] = {
+	DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
+	DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
+	DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_RXD_3,
+	DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_MDIO_CLK,
+	DA850_MDIO_D,
+	-1
+};
+
+static const short da850_evm_rmii_pins[] = {
+	DA850_RMII_TXD_0, DA850_RMII_TXD_1, DA850_RMII_TXEN,
+	DA850_RMII_CRS_DV, DA850_RMII_RXD_0, DA850_RMII_RXD_1,
+	DA850_RMII_RXER, DA850_RMII_MHZ_50_CLK, DA850_MDIO_CLK,
+	DA850_MDIO_D,
+	-1
+};
+
 static int __init da850_evm_config_emac(void)
 {
 	void __iomem *cfg_chip3_base;
@@ -617,12 +634,12 @@ static int __init da850_evm_config_emac(void)
 
 	if (rmii_en) {
 		val |= BIT(8);
-		ret = davinci_cfg_reg_list(da850_rmii_pins);
+		ret = davinci_cfg_reg_list(da850_evm_rmii_pins);
 		pr_info("EMAC: RMII PHY configured, MII PHY will not be"
 							" functional\n");
 	} else {
 		val &= ~BIT(8);
-		ret = davinci_cfg_reg_list(da850_cpgmac_pins);
+		ret = davinci_cfg_reg_list(da850_evm_mii_pins);
 		pr_info("EMAC: MII PHY configured, RMII PHY will not be"
 							" functional\n");
 	}
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index efb904e..c2a3ce5 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -574,15 +574,9 @@ const short da850_cpgmac_pins[] __initdata = {
 	DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
 	DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_RXD_3,
 	DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_MDIO_CLK,
-	DA850_MDIO_D,
-	-1
-};
-
-const short da850_rmii_pins[] __initdata = {
-	DA850_RMII_TXD_0, DA850_RMII_TXD_1, DA850_RMII_TXEN,
-	DA850_RMII_CRS_DV, DA850_RMII_RXD_0, DA850_RMII_RXD_1,
-	DA850_RMII_RXER, DA850_RMII_MHZ_50_CLK, DA850_MDIO_CLK,
-	DA850_MDIO_D,
+	DA850_MDIO_D, DA850_RMII_TXD_0, DA850_RMII_TXD_1, DA850_RMII_TXEN,
+	DA850_RMII_CRS_DV, DA850_RMII_RXD_0, DA850_RMII_RXD_1, DA850_RMII_RXER,
+	DA850_RMII_MHZ_50_CLK,
 	-1
 };
 
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 8de2dbb..504f2f6 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -121,7 +121,6 @@ extern const short da850_uart2_pins[];
 extern const short da850_i2c0_pins[];
 extern const short da850_i2c1_pins[];
 extern const short da850_cpgmac_pins[];
-extern const short da850_rmii_pins[];
 extern const short da850_mcasp_pins[];
 extern const short da850_lcdcntl_pins[];
 extern const short da850_mmcsd0_pins[];
-- 
1.7.2.1
