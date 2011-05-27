From: christian.riesch@omicron.at (Christian Riesch)
Date: Fri, 27 May 2011 11:20:53 +0200
Subject: [PATCH V2] davinci: da850: move input frequency to board specific
	files
In-Reply-To: <1306312622-4901-1-git-send-email-christian.riesch@omicron.at>
References: <1306312622-4901-1-git-send-email-christian.riesch@omicron.at>
Message-ID: <1306488053-27978-1-git-send-email-christian.riesch@omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bob Dunlop <bob.dunlop@xyzzy.org.uk>

Currently the input frequency of the SoC is hardcoded in the SoC specific
da850.c file to 24 MHz. Since the SoC accepts input frequencies in a wide
range from 12 to 50 MHz, boards with different oscillator/crystal
frequencies may be built.

This patch allows setting a different input frequency in the board
specific files to support boards with oscillator/crystal frequencies other
than 24 MHz.

Signed-off-by: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
Signed-off-by: Christian Riesch <christian.riesch@omicron.at>
---

Hi,
in private email Bob Dunlop suggested to pass a pointer to a small 
structure instead of the frequency value to allow future expansions, 
e.g., for the OPP list. Therefore I submit his patch as V2.
Christian

 arch/arm/mach-davinci/board-da850-evm.c     |    2 +-
 arch/arm/mach-davinci/board-mityomapl138.c  |    2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |    2 +-
 arch/arm/mach-davinci/da850.c               |    5 ++++-
 arch/arm/mach-davinci/include/mach/da8xx.h  |    6 +++++-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a7b41bf..231ff87 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1252,7 +1252,7 @@ console_initcall(da850_evm_console_init);
 
 static void __init da850_evm_map_io(void)
 {
-	da850_init();
+	da850_init(NULL);
 }
 
 MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 606a6f2..362770c 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -561,7 +561,7 @@ console_initcall(mityomapl138_console_init);
 
 static void __init mityomapl138_map_io(void)
 {
-	da850_init();
+	da850_init(NULL);
 }
 
 MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 67c38d0..c43a6c3 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -334,7 +334,7 @@ console_initcall(omapl138_hawk_console_init);
 
 static void __init omapl138_hawk_map_io(void)
 {
-	da850_init();
+	da850_init(NULL);
 }
 
 MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 133aac4..ebd0603 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1104,10 +1104,13 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.reset_device		= &da8xx_wdt_device,
 };
 
-void __init da850_init(void)
+void __init da850_init(struct da850_init_board_info *board)
 {
 	unsigned int v;
 
+	if (board && board->ref_clk_rate)
+		ref_clk.rate = board->ref_clk_rate;
+
 	davinci_common_init(&davinci_soc_info_da850);
 
 	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index ad64da7..66efc5d 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -69,8 +69,12 @@ extern unsigned int da850_max_speed;
 #define DA8XX_AEMIF_CTL_BASE	0x68000000
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
+struct da850_init_board_info {
+	unsigned long ref_clk_rate;
+};
+
 void __init da830_init(void);
-void __init da850_init(void);
+void __init da850_init(struct da850_init_board_info *board);
 
 int da830_register_edma(struct edma_rsv_info *rsv);
 int da850_register_edma(struct edma_rsv_info *rsv[2]);
-- 
1.7.0.4
