From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:37 -0700
Subject: [PATCH 13/47] DA850: move NAND/NOR pin lists to the board file
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-14-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

The NAND/NOR flash pin lists (da850_nand_pins/da850_nor_pins) are purely board
specific and as such shouldn't be in da850.c -- copy them to board-da850-evm.c,
renaming to da850_evm_nand_pins/da850_evm_nor_pins respectively, and merge the
two lists in da850.c into one, representing the EMIF 2.5 module as a whole,
just like we have it in da830.c...

While at it, remove the '__init' modifier from da850_evm_setup_nor_nand() as
this function is called from non '__init' code...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Tested-by: Ben Gardiner <bengardiner@nanometrics.ca>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da850-evm.c    |   30 +++++++++++++++++++++++--
 arch/arm/mach-davinci/da850.c              |   32 ++++++++++-----------------
 arch/arm/mach-davinci/include/mach/da8xx.h |    3 +-
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index c2800a98..482d458 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -196,6 +196,30 @@ static void __init da850_evm_init_nor(void)
 	iounmap(aemif_addr);
 }
 
+static const short da850_evm_nand_pins[] = {
+	DA850_EMA_D_0, DA850_EMA_D_1, DA850_EMA_D_2, DA850_EMA_D_3,
+	DA850_EMA_D_4, DA850_EMA_D_5, DA850_EMA_D_6, DA850_EMA_D_7,
+	DA850_EMA_A_1, DA850_EMA_A_2, DA850_NEMA_CS_3, DA850_NEMA_CS_4,
+	DA850_NEMA_WE, DA850_NEMA_OE,
+	-1
+};
+
+static const short da850_evm_nor_pins[] = {
+	DA850_EMA_BA_1, DA850_EMA_CLK, DA850_EMA_WAIT_1, DA850_NEMA_CS_2,
+	DA850_NEMA_WE, DA850_NEMA_OE, DA850_EMA_D_0, DA850_EMA_D_1,
+	DA850_EMA_D_2, DA850_EMA_D_3, DA850_EMA_D_4, DA850_EMA_D_5,
+	DA850_EMA_D_6, DA850_EMA_D_7, DA850_EMA_D_8, DA850_EMA_D_9,
+	DA850_EMA_D_10, DA850_EMA_D_11, DA850_EMA_D_12, DA850_EMA_D_13,
+	DA850_EMA_D_14, DA850_EMA_D_15, DA850_EMA_A_0, DA850_EMA_A_1,
+	DA850_EMA_A_2, DA850_EMA_A_3, DA850_EMA_A_4, DA850_EMA_A_5,
+	DA850_EMA_A_6, DA850_EMA_A_7, DA850_EMA_A_8, DA850_EMA_A_9,
+	DA850_EMA_A_10, DA850_EMA_A_11, DA850_EMA_A_12, DA850_EMA_A_13,
+	DA850_EMA_A_14, DA850_EMA_A_15, DA850_EMA_A_16, DA850_EMA_A_17,
+	DA850_EMA_A_18, DA850_EMA_A_19, DA850_EMA_A_20, DA850_EMA_A_21,
+	DA850_EMA_A_22, DA850_EMA_A_23,
+	-1
+};
+
 static u32 ui_card_detected;
 
 #if defined(CONFIG_MMC_DAVINCI) || \
@@ -205,17 +229,17 @@ static u32 ui_card_detected;
 #define HAS_MMC 0
 #endif
 
-static __init void da850_evm_setup_nor_nand(void)
+static inline void da850_evm_setup_nor_nand(void)
 {
 	int ret = 0;
 
 	if (ui_card_detected & !HAS_MMC) {
-		ret = davinci_cfg_reg_list(da850_nand_pins);
+		ret = davinci_cfg_reg_list(da850_evm_nand_pins);
 		if (ret)
 			pr_warning("da850_evm_init: nand mux setup failed: "
 					"%d\n", ret);
 
-		ret = davinci_cfg_reg_list(da850_nor_pins);
+		ret = davinci_cfg_reg_list(da850_evm_nor_pins);
 		if (ret)
 			pr_warning("da850_evm_init: nor mux setup failed: %d\n",
 				ret);
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 5af7cfb..efb904e 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -609,27 +609,19 @@ const short da850_mmcsd0_pins[] __initdata = {
 	-1
 };
 
-const short da850_nand_pins[] __initdata = {
-	DA850_EMA_D_7, DA850_EMA_D_6, DA850_EMA_D_5, DA850_EMA_D_4,
-	DA850_EMA_D_3, DA850_EMA_D_2, DA850_EMA_D_1, DA850_EMA_D_0,
-	DA850_EMA_A_1, DA850_EMA_A_2, DA850_NEMA_CS_3, DA850_NEMA_CS_4,
-	DA850_NEMA_WE, DA850_NEMA_OE,
-	-1
-};
-
-const short da850_nor_pins[] __initdata = {
+const short da850_emif25_pins[] __initdata = {
 	DA850_EMA_BA_1, DA850_EMA_CLK, DA850_EMA_WAIT_1, DA850_NEMA_CS_2,
-	DA850_NEMA_WE, DA850_NEMA_OE, DA850_EMA_D_0, DA850_EMA_D_1,
-	DA850_EMA_D_2, DA850_EMA_D_3, DA850_EMA_D_4, DA850_EMA_D_5,
-	DA850_EMA_D_6, DA850_EMA_D_7, DA850_EMA_D_8, DA850_EMA_D_9,
-	DA850_EMA_D_10, DA850_EMA_D_11, DA850_EMA_D_12, DA850_EMA_D_13,
-	DA850_EMA_D_14, DA850_EMA_D_15, DA850_EMA_A_0, DA850_EMA_A_1,
-	DA850_EMA_A_2, DA850_EMA_A_3, DA850_EMA_A_4, DA850_EMA_A_5,
-	DA850_EMA_A_6, DA850_EMA_A_7, DA850_EMA_A_8, DA850_EMA_A_9,
-	DA850_EMA_A_10, DA850_EMA_A_11, DA850_EMA_A_12, DA850_EMA_A_13,
-	DA850_EMA_A_14, DA850_EMA_A_15, DA850_EMA_A_16, DA850_EMA_A_17,
-	DA850_EMA_A_18, DA850_EMA_A_19, DA850_EMA_A_20, DA850_EMA_A_21,
-	DA850_EMA_A_22, DA850_EMA_A_23,
+	DA850_NEMA_CS_3, DA850_NEMA_CS_4, DA850_NEMA_WE, DA850_NEMA_OE,
+	DA850_EMA_D_0, DA850_EMA_D_1, DA850_EMA_D_2, DA850_EMA_D_3,
+	DA850_EMA_D_4, DA850_EMA_D_5, DA850_EMA_D_6, DA850_EMA_D_7,
+	DA850_EMA_D_8, DA850_EMA_D_9, DA850_EMA_D_10, DA850_EMA_D_11,
+	DA850_EMA_D_12, DA850_EMA_D_13, DA850_EMA_D_14, DA850_EMA_D_15,
+	DA850_EMA_A_0, DA850_EMA_A_1, DA850_EMA_A_2, DA850_EMA_A_3,
+	DA850_EMA_A_4, DA850_EMA_A_5, DA850_EMA_A_6, DA850_EMA_A_7,
+	DA850_EMA_A_8, DA850_EMA_A_9, DA850_EMA_A_10, DA850_EMA_A_11,
+	DA850_EMA_A_12, DA850_EMA_A_13, DA850_EMA_A_14, DA850_EMA_A_15,
+	DA850_EMA_A_16, DA850_EMA_A_17, DA850_EMA_A_18, DA850_EMA_A_19,
+	DA850_EMA_A_20, DA850_EMA_A_21, DA850_EMA_A_22, DA850_EMA_A_23,
 	-1
 };
 
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 2c3f418..8de2dbb 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -125,7 +125,6 @@ extern const short da850_rmii_pins[];
 extern const short da850_mcasp_pins[];
 extern const short da850_lcdcntl_pins[];
 extern const short da850_mmcsd0_pins[];
-extern const short da850_nand_pins[];
-extern const short da850_nor_pins[];
+extern const short da850_emif25_pins[];
 
 #endif /* __ASM_ARCH_DAVINCI_DA8XX_H */
-- 
1.7.2.1
