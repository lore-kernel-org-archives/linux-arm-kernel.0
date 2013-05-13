From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:24 +0400
Subject: [PATCH 03/15] ARM: clps711x: autcpu12: Move LCD DPOT definitions to
 board file
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We do not have driver for Up/Down digital potentiometer (DPOT), so
just define pins as GPIOs and export these pins to user.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-autcpu12.c        | 14 ++++++++++++++
 arch/arm/mach-clps711x/include/mach/autcpu12.h |  8 --------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index 1e22cb4..78b528a 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -51,12 +51,18 @@
 #define AUTCPU12_SMC_BASE	(CS1_PHYS_BASE + 0x06000000)
 #define AUTCPU12_SMC_SEL_BASE	(AUTCPU12_SMC_BASE + 0x10)
 
+/* NAND flash */
 #define AUTCPU12_MMGPIO_BASE	(CLPS711X_NR_GPIO)
 #define AUTCPU12_SMC_NCE	(AUTCPU12_MMGPIO_BASE + 0) /* Bit 0 */
 #define AUTCPU12_SMC_RDY	CLPS711X_GPIO(1, 2)
 #define AUTCPU12_SMC_ALE	CLPS711X_GPIO(1, 3)
 #define AUTCPU12_SMC_CLE	CLPS711X_GPIO(1, 3)
 
+/* LCD contrast digital potentiometer */
+#define AUTCPU12_DPOT_CS	CLPS711X_GPIO(4, 0)
+#define AUTCPU12_DPOT_CLK	CLPS711X_GPIO(4, 1)
+#define AUTCPU12_DPOT_UD	CLPS711X_GPIO(4, 2)
+
 static struct resource autcpu12_cs8900_resource[] __initdata = {
 	DEFINE_RES_MEM(AUTCPU12_CS8900_BASE, SZ_1K),
 	DEFINE_RES_IRQ(AUTCPU12_CS8900_IRQ),
@@ -148,6 +154,12 @@ static struct platform_device autcpu12_mmgpio_pdev __initdata = {
 	},
 };
 
+static const struct gpio autcpu12_gpios[] __initconst = {
+	{ AUTCPU12_DPOT_CS,	GPIOF_OUT_INIT_HIGH,	"DPOT CS" },
+	{ AUTCPU12_DPOT_CLK,	GPIOF_OUT_INIT_LOW,	"DPOT CLK" },
+	{ AUTCPU12_DPOT_UD,	GPIOF_OUT_INIT_LOW,	"DPOT UD" },
+};
+
 static void __init autcpu12_init(void)
 {
 	clps711x_devices_init();
@@ -160,6 +172,8 @@ static void __init autcpu12_init(void)
 
 static void __init autcpu12_init_late(void)
 {
+	gpio_request_array(autcpu12_gpios, ARRAY_SIZE(autcpu12_gpios));
+
 	if (IS_ENABLED(MTD_NAND_GPIO) && IS_ENABLED(GPIO_GENERIC_PLATFORM)) {
 		/* We are need both drivers to handle NAND */
 		platform_device_register(&autcpu12_nand_pdev);
diff --git a/arch/arm/mach-clps711x/include/mach/autcpu12.h b/arch/arm/mach-clps711x/include/mach/autcpu12.h
index 0452f5f..b95d60a 100644
--- a/arch/arm/mach-clps711x/include/mach/autcpu12.h
+++ b/arch/arm/mach-clps711x/include/mach/autcpu12.h
@@ -48,12 +48,4 @@
 
 #define AUTCPU12_PHYS_LPT              	CS1_PHYS_BASE +0x0E000000  /* physical */
 
-/*
-* defines for lcd contrast 
-*/
-#define AUTCPU12_DPOT_PORT_OFFSET	PEDR
-#define	AUTCPU12_DPOT_CS		(1<<0)
-#define AUTCPU12_DPOT_CLK    		(1<<1)
-#define	AUTCPU12_DPOT_UD		(1<<2)
-
 #endif
-- 
1.8.1.5
