From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 17 Apr 2014 17:53:14 +0200
Subject: [PATCH 5/5] ARM: Kirkwood: t5325: Use simple-card to instantiate audio
In-Reply-To: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
Message-ID: <1397749994-24983-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree nodes to instantiate the audio drivers on the HP T5325
device. Remove platform driver instantiating of the audio, which
results in board-t5325.c being removed.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-t5325.dts | 25 +++++++++++++++++++++++++
 arch/arm/mach-mvebu/board-t5325.c    | 26 --------------------------
 arch/arm/mach-mvebu/board.h          |  6 ------
 arch/arm/mach-mvebu/kirkwood.c       |  3 ---
 4 files changed, 25 insertions(+), 35 deletions(-)
 delete mode 100644 arch/arm/mach-mvebu/board-t5325.c

diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index dbb730642543..2cf3fe38404d 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -192,6 +192,31 @@
 		gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
 	};
 
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPL",
+			"Headphone Jack", "HPR",
+			"Speaker", "SPKOUT",
+			"Speaker", "SPKOUTN",
+			"MIC1", "Mic Jack",
+			"MIC2", "Mic Jack";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker",
+			"Microphone", "Mic Jack";
+
+		simple-audio-card,mclk-factor = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&audio>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&alc5621>;
+		};
+	};
 };
 
 &mdio {
diff --git a/arch/arm/mach-mvebu/board-t5325.c b/arch/arm/mach-mvebu/board-t5325.c
deleted file mode 100644
index f2401b298218..000000000000
--- a/arch/arm/mach-mvebu/board-t5325.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * HP T5325 Board Setup
- *
- * Copyright (C) 2014
- *
- * Andrew Lunn <andrew@lunn.ch>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include "board.h"
-
-static struct platform_device hp_t5325_audio_device = {
-	.name		= "t5325-audio",
-	.id		= -1,
-};
-
-void __init t5325_init(void)
-{
-	platform_device_register(&hp_t5325_audio_device);
-}
diff --git a/arch/arm/mach-mvebu/board.h b/arch/arm/mach-mvebu/board.h
index de7f0a191394..9c7bb4386f8b 100644
--- a/arch/arm/mach-mvebu/board.h
+++ b/arch/arm/mach-mvebu/board.h
@@ -13,10 +13,4 @@
 #ifndef __ARCH_MVEBU_BOARD_H
 #define __ARCH_MVEBU_BOARD_H
 
-#ifdef CONFIG_MACH_T5325
-void t5325_init(void);
-#else
-static inline void t5325_init(void) {};
-#endif
-
 #endif
diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 120207fc36f1..c30bc316f40d 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -180,9 +180,6 @@ static void __init kirkwood_dt_init(void)
 	kirkwood_pm_init();
 	kirkwood_dt_eth_fixup();
 
-	if (of_machine_is_compatible("hp,t5325"))
-		t5325_init();
-
 	of_platform_populate(NULL, of_default_bus_match_table, auxdata, NULL);
 }
 
-- 
1.9.2
