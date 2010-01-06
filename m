From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:53 -0800
Subject: [PATCH 11/35] davinci: add support for DM6467T EVM
In-Reply-To: <1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

DM6467T (T for Turbo) is a newer and faster DM6467
part from TI. The new part supports 1080p video and
has the ARM running at 495MHz. More SoC information:

http://focus.ti.com/docs/prod/folders/print/tms320dm6467t.html

Spectrum Digital, Inc has a new EVM for this part.
It is _mostly_ same as the older DM6467 EVM except
for a 33MHz crystal input and THS8200 video encoder
for 1080p support.

The meat of this patch is dedicated to initializing
the crystal frequency from EVM board file.

Additional notes:
I did consider some alternative ways to make the crystal
input board specific including - (1) having board code
initialize the crystal frequency using the first member
of soc_info->cpu_clks array (2) introducing a new ref_clk_rate
member in soc_info structure.

But, the current way seems to be the simplest and least
intruding considering that both the clock array and SoC
info structure are actually private to the SoC file. Also
the fact that davinci_common_init() initializes both the
soc_info and clocks in one go.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/Kconfig               |    4 ++++
 arch/arm/mach-davinci/board-dm646x-evm.c    |   24 ++++++++++++++++++++++++
 arch/arm/mach-davinci/dm646x.c              |    3 +--
 arch/arm/mach-davinci/include/mach/dm646x.h |    2 ++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 033bfed..0ebe185 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -91,10 +91,14 @@ config MACH_DAVINCI_DM6467_EVM
 	bool "TI DM6467 EVM"
 	default ARCH_DAVINCI_DM646x
 	depends on ARCH_DAVINCI_DM646x
+	select MACH_DAVINCI_DM6467TEVM
 	help
 	  Configure this option to specify the whether the board used
 	  for development is a DM6467 EVM
 
+config MACH_DAVINCI_DM6467TEVM
+	bool
+
 config MACH_DAVINCI_DM365_EVM
 	bool "TI DM365 EVM"
 	default ARCH_DAVINCI_DM365
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 8c05343..542bfdb 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -30,6 +30,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/clk.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -40,6 +41,8 @@
 #include <mach/i2c.h>
 #include <mach/nand.h>
 
+#include "clock.h"
+
 #define NAND_BLOCK_SIZE		SZ_128K
 
 /* Note: We are setting first partition as 'bootloader' constituting UBL, U-Boot
@@ -713,6 +716,17 @@ static __init void davinci_dm646x_evm_irq_init(void)
 	davinci_irq_init();
 }
 
+#define DM646X_EVM_REF_FREQ		27000000
+#define DM6467T_EVM_REF_FREQ		33000000
+
+void __init dm646x_board_setup_refclk(struct clk *clk)
+{
+	if (machine_is_davinci_dm6467tevm())
+		clk->rate = DM6467T_EVM_REF_FREQ;
+	else
+		clk->rate = DM646X_EVM_REF_FREQ;
+}
+
 MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.phys_io      = IO_PHYS,
 	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
@@ -723,3 +737,13 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.init_machine = evm_init,
 MACHINE_END
 
+MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
+	.phys_io      = IO_PHYS,
+	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
+	.boot_params  = (0x80000100),
+	.map_io       = davinci_map_io,
+	.init_irq     = davinci_dm646x_evm_irq_init,
+	.timer        = &davinci_timer,
+	.init_machine = evm_init,
+MACHINE_END
+
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 829a44b..515d3ed 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -42,7 +42,6 @@
 /*
  * Device specific clocks
  */
-#define DM646X_REF_FREQ		27000000
 #define DM646X_AUX_FREQ		24000000
 
 static struct pll_data pll1_data = {
@@ -57,7 +56,6 @@ static struct pll_data pll2_data = {
 
 static struct clk ref_clk = {
 	.name = "ref_clk",
-	.rate = DM646X_REF_FREQ,
 };
 
 static struct clk aux_clkin = {
@@ -925,6 +923,7 @@ void dm646x_setup_vpif(struct vpif_display_config *display_config,
 
 void __init dm646x_init(void)
 {
+	dm646x_board_setup_refclk(&ref_clk);
 	davinci_common_init(&davinci_soc_info_dm646x);
 }
 
diff --git a/arch/arm/mach-davinci/include/mach/dm646x.h b/arch/arm/mach-davinci/include/mach/dm646x.h
index 8cec746..8221153 100644
--- a/arch/arm/mach-davinci/include/mach/dm646x.h
+++ b/arch/arm/mach-davinci/include/mach/dm646x.h
@@ -16,6 +16,7 @@
 #include <mach/asp.h>
 #include <linux/i2c.h>
 #include <linux/videodev2.h>
+#include <linux/clk.h>
 
 #define DM646X_EMAC_BASE		(0x01C80000)
 #define DM646X_EMAC_CNTRL_OFFSET	(0x0000)
@@ -30,6 +31,7 @@ void __init dm646x_init(void);
 void __init dm646x_init_ide(void);
 void __init dm646x_init_mcasp0(struct snd_platform_data *pdata);
 void __init dm646x_init_mcasp1(struct snd_platform_data *pdata);
+void __init dm646x_board_setup_refclk(struct clk *clk);
 
 void dm646x_video_init(void);
 
-- 
1.6.6.rc2.1.g42108
