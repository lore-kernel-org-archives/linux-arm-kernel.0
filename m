From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:19 -0700
Subject: [PATCH 28/34] Davinci: eliminate pinmux offset verbosity
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-29-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

Pinmux registers are sequential, and do not need to be enumerated out as they
currently are.  This reduces code volume and keeps things simple.

If some future SoC comes up with a discontiguous register map, PINMUX() can
then be expanded with local token pasting.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dm355.c              |    5 -----
 arch/arm/mach-davinci/dm365.c              |    5 -----
 arch/arm/mach-davinci/dm644x.c             |    3 ---
 arch/arm/mach-davinci/dm646x.c             |    3 ---
 arch/arm/mach-davinci/gpio.c               |    6 +-----
 arch/arm/mach-davinci/include/mach/da8xx.h |   21 ---------------------
 arch/arm/mach-davinci/include/mach/mux.h   |    2 ++
 arch/arm/mach-davinci/mux.h                |    2 +-
 8 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index f9a54ff..f91e9a1 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -450,11 +450,6 @@ void __init dm355_init_spi0(unsigned chipselect_mask,
 
 /*----------------------------------------------------------------------*/
 
-#define PINMUX0		0x00
-#define PINMUX1		0x04
-#define PINMUX2		0x08
-#define PINMUX3		0x0c
-#define PINMUX4		0x10
 #define INTMUX		0x18
 #define EVTMUX		0x1c
 
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 0566675..f2b1d93 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -467,11 +467,6 @@ static struct clk_lookup dm365_clks[] = {
 
 /*----------------------------------------------------------------------*/
 
-#define PINMUX0		0x00
-#define PINMUX1		0x04
-#define PINMUX2		0x08
-#define PINMUX3		0x0c
-#define PINMUX4		0x10
 #define INTMUX		0x18
 #define EVTMUX		0x1c
 
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 4af349e..85c88ec 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -350,9 +350,6 @@ static struct platform_device dm644x_emac_device = {
        .resource	= dm644x_emac_resources,
 };
 
-#define PINMUX0		0x00
-#define PINMUX1		0x04
-
 /*
  * Device specific mux setup
  *
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index bdb1ace..a8189c9 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -401,9 +401,6 @@ static struct platform_device dm646x_emac_device = {
 	.resource	= dm646x_emac_resources,
 };
 
-#define PINMUX0		0x00
-#define PINMUX1		0x04
-
 /*
  * Device specific mux setup
  *
diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index b62d5e2..2efb446 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -71,11 +71,7 @@ static int __init davinci_gpio_irq_setup(void);
 
 /*--------------------------------------------------------------------------*/
 
-/*
- * board setup code *MUST* set PINMUX0 and PINMUX1 as
- * needed, and enable the GPIO clock.
- */
-
+/* board setup code *MUST* setup pinmux and enable the GPIO clock. */
 static inline int __davinci_direction(struct gpio_chip *chip,
 			unsigned offset, bool out, int value)
 {
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 33471c9..dbb4ebe 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -64,27 +64,6 @@ extern void __iomem *da8xx_syscfg1_base;
 #define DA8XX_DDR2_CTL_BASE	0xb0000000
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
-#define PINMUX0			0x00
-#define PINMUX1			0x04
-#define PINMUX2			0x08
-#define PINMUX3			0x0c
-#define PINMUX4			0x10
-#define PINMUX5			0x14
-#define PINMUX6			0x18
-#define PINMUX7			0x1c
-#define PINMUX8			0x20
-#define PINMUX9			0x24
-#define PINMUX10		0x28
-#define PINMUX11		0x2c
-#define PINMUX12		0x30
-#define PINMUX13		0x34
-#define PINMUX14		0x38
-#define PINMUX15		0x3c
-#define PINMUX16		0x40
-#define PINMUX17		0x44
-#define PINMUX18		0x48
-#define PINMUX19		0x4c
-
 void __init da830_init(void);
 void __init da850_init(void);
 
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 923debe..743dbd2 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -1174,6 +1174,8 @@ enum davinci_tnetv107x_index {
 	TNETV107X_TDM0_RX,
 };
 
+#define PINMUX(x)		(4 * (x))
+
 #ifdef CONFIG_DAVINCI_MUX
 /* setup pin muxing */
 extern int davinci_cfg_reg(unsigned long reg_cfg);
diff --git a/arch/arm/mach-davinci/mux.h b/arch/arm/mach-davinci/mux.h
index adc8694..5aad1e7 100644
--- a/arch/arm/mach-davinci/mux.h
+++ b/arch/arm/mach-davinci/mux.h
@@ -20,7 +20,7 @@
 			.name =  #desc,					\
 			.debug = dbg,					\
 			.mux_reg_name = "PINMUX"#muxreg,		\
-			.mux_reg = PINMUX##muxreg,			\
+			.mux_reg = PINMUX(muxreg),			\
 			.mask_offset = mode_offset,			\
 			.mask = mode_mask,				\
 			.mode = mux_mode,				\
-- 
1.7.0.2
