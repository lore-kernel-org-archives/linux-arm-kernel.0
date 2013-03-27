From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 27 Mar 2013 22:03:20 +0100
Subject: [PATCH 3/3] ARM: ux500: Enable the clock controlling Ethernet on
 Snowball
In-Reply-To: <1364418200-15628-1-git-send-email-linus.walleij@stericsson.com>
References: <1364418200-15628-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1364418200-15628-4-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

This fixes a regression introduced by common clk enablement.

On some u8500 based boards, the FMSC clock which is usually used
for flash, is wired up to the SMSC911x Ethernet driver. However,
the SMSC911x doesn't have common clk support yet, rendering it
unusable. Prior to the introduction of common clk the FMSC clock
was default on; however, common clk disables all clocks by default
and insists drivers take responsibility to enable theirs.

This fix enables the FMSC clock on Snowball, subsequently turning
on the SMSC911x Ethernet chip. It will be removed when the driver
is compatible with common clk.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 12 ++++++++++++
 arch/arm/mach-ux500/board-mop500.h |  1 +
 arch/arm/mach-ux500/cpu-db8500.c   |  5 +++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index b034578..87d2d7b 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/i2c-nomadik.h>
@@ -439,6 +440,15 @@ static void mop500_prox_deactivate(struct device *dev)
 	regulator_put(prox_regulator);
 }
 
+void mop500_snowball_ethernet_clock_enable(void)
+{
+	struct clk *clk;
+
+	clk = clk_get_sys("fsmc", NULL);
+	if (!IS_ERR(clk))
+		clk_prepare_enable(clk);
+}
+
 static struct cryp_platform_data u8500_cryp1_platform_data = {
 		.mem_to_engine = {
 				.dir = STEDMA40_MEM_TO_PERIPH,
@@ -683,6 +693,8 @@ static void __init snowball_init_machine(void)
 	mop500_audio_init(parent);
 	mop500_uart_init(parent);
 
+	mop500_snowball_ethernet_clock_enable();
+
 	/* This board has full regulator constraints */
 	regulator_has_full_constraints();
 }
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index eaa605f..d38951b 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -104,6 +104,7 @@ void __init mop500_pinmaps_init(void);
 void __init snowball_pinmaps_init(void);
 void __init hrefv60_pinmaps_init(void);
 void mop500_audio_init(struct device *parent);
+void mop500_snowball_ethernet_clock_enable(void);
 
 int __init mop500_uib_init(void);
 void mop500_uib_i2c_add(int busnum, struct i2c_board_info *info,
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 19235cf..f1a5818 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -312,9 +312,10 @@ static void __init u8500_init_machine(void)
 	/* Pinmaps must be in place before devices register */
 	if (of_machine_is_compatible("st-ericsson,mop500"))
 		mop500_pinmaps_init();
-	else if (of_machine_is_compatible("calaosystems,snowball-a9500"))
+	else if (of_machine_is_compatible("calaosystems,snowball-a9500")) {
 		snowball_pinmaps_init();
-	else if (of_machine_is_compatible("st-ericsson,hrefv60+"))
+		mop500_snowball_ethernet_clock_enable();
+	} else if (of_machine_is_compatible("st-ericsson,hrefv60+"))
 		hrefv60_pinmaps_init();
 	else if (of_machine_is_compatible("st-ericsson,ccu9540")) {}
 		/* TODO: Add pinmaps for ccu9540 board. */
-- 
1.7.11.3
