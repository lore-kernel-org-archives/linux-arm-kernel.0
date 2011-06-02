From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 2 Jun 2011 22:41:17 +0530
Subject: [PATCH v3 3/3] davinci: da850: move input frequency to board specific
	files
In-Reply-To: <1307034677-27236-2-git-send-email-nsekhar@ti.com>
References: <1307034677-27236-1-git-send-email-nsekhar@ti.com>
	<1307034677-27236-2-git-send-email-nsekhar@ti.com>
Message-ID: <1307034677-27236-3-git-send-email-nsekhar@ti.com>
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
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-da850-evm.c     |    2 +-
 arch/arm/mach-davinci/board-mityomapl138.c  |    2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |    2 +-
 arch/arm/mach-davinci/da850.c               |    5 ++++-
 arch/arm/mach-davinci/include/mach/da8xx.h  |    3 ++-
 5 files changed, 9 insertions(+), 5 deletions(-)

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
index 133aac4..7f94d77 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1104,10 +1104,13 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.reset_device		= &da8xx_wdt_device,
 };
 
-void __init da850_init(void)
+void __init da850_init(struct davinci_board_info *board)
 {
 	unsigned int v;
 
+	if (board && board->ref_clk_rate)
+		ref_clk.rate = board->ref_clk_rate;
+
 	davinci_common_init(&davinci_soc_info_da850);
 
 	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index ad64da7..90227ce 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -17,6 +17,7 @@
 #include <linux/davinci_emac.h>
 #include <linux/spi/spi.h>
 
+#include <mach/common.h>
 #include <mach/serial.h>
 #include <mach/edma.h>
 #include <mach/i2c.h>
@@ -70,7 +71,7 @@ extern unsigned int da850_max_speed;
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
 void __init da830_init(void);
-void __init da850_init(void);
+void __init da850_init(struct davinci_board_info *info);
 
 int da830_register_edma(struct edma_rsv_info *rsv);
 int da850_register_edma(struct edma_rsv_info *rsv[2]);
-- 
1.7.3.2
