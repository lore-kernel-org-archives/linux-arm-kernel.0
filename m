From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Mon, 7 Feb 2011 18:45:37 +0300
Subject: [PATCH] DA850 EVM: kill useless variable
Message-ID: <201102071845.37812.sshtylyov@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 75e2ea643fe43d5aa836475acee5bd97cd9ea4bf (davinci: DA850/OMAP-L138 EVM
expander setup and UI card detection) introduced a useless variable: it's
always set to 1 before it's checked in da850_evm_setup_nor_nand()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent DaVinci tree. It has only been build-tested as
I don't have DA850 EVM board...

 arch/arm/mach-davinci/board-da850-evm.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-davinci/arch/arm/mach-davinci/board-da850-evm.c
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/board-da850-evm.c
+++ linux-davinci/arch/arm/mach-davinci/board-da850-evm.c
@@ -231,8 +231,6 @@ static const short da850_evm_nor_pins[] 
 	-1
 };
 
-static u32 ui_card_detected;
-
 #if defined(CONFIG_MMC_DAVINCI) || \
     defined(CONFIG_MMC_DAVINCI_MODULE)
 #define HAS_MMC 1
@@ -244,7 +242,7 @@ static inline void da850_evm_setup_nor_n
 {
 	int ret = 0;
 
-	if (ui_card_detected & !HAS_MMC) {
+	if (!HAS_MMC) {
 		ret = davinci_cfg_reg_list(da850_evm_nand_pins);
 		if (ret)
 			pr_warning("da850_evm_init: nand mux setup failed: "
@@ -394,7 +392,6 @@ static int da850_evm_ui_expander_setup(s
 		goto exp_setup_keys_fail;
 	}
 
-	ui_card_detected = 1;
 	pr_info("DA850/OMAP-L138 EVM UI card detected\n");
 
 	da850_evm_setup_nor_nand();
