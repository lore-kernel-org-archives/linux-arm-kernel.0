From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Feb 2014 18:16:33 -0800
Subject: [PATCH 2/3] ARM: msm: Silence readb/writeb warnings due to missing
 IOMEM()
In-Reply-To: <1393467394-10907-1-git-send-email-sboyd@codeaurora.org>
References: <1393467394-10907-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1393467394-10907-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TROUT_CPLD_BASE needs the IOMEM() treatment to avoid warnings
from the read/writeb functions.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/board-trout-gpio.c | 2 +-
 arch/arm/mach-msm/board-trout.c      | 2 +-
 arch/arm/mach-msm/board-trout.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-msm/board-trout-gpio.c b/arch/arm/mach-msm/board-trout-gpio.c
index 87e1d01edecc..2c25050209ce 100644
--- a/arch/arm/mach-msm/board-trout-gpio.c
+++ b/arch/arm/mach-msm/board-trout-gpio.c
@@ -89,7 +89,7 @@ static int trout_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 			.base		  = base_gpio,			\
 			.ngpio		  = 8,				\
 		},							\
-		.reg = (void *) reg_num + TROUT_CPLD_BASE,		\
+		.reg = reg_num + TROUT_CPLD_BASE,			\
 		.shadow = shadow_val,					\
 	}
 
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index 015d544aa017..5edfbd904d06 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -78,7 +78,7 @@ static void __init trout_init(void)
 
 static struct map_desc trout_io_desc[] __initdata = {
 	{
-		.virtual = TROUT_CPLD_BASE,
+		.virtual = (unsigned long)TROUT_CPLD_BASE,
 		.pfn     = __phys_to_pfn(TROUT_CPLD_START),
 		.length  = TROUT_CPLD_SIZE,
 		.type    = MT_DEVICE_NONSHARED
diff --git a/arch/arm/mach-msm/board-trout.h b/arch/arm/mach-msm/board-trout.h
index b2379ede43bc..adb757abbb92 100644
--- a/arch/arm/mach-msm/board-trout.h
+++ b/arch/arm/mach-msm/board-trout.h
@@ -58,7 +58,7 @@
 #define TROUT_4_TP_LS_EN    19
 #define TROUT_5_TP_LS_EN    1
 
-#define TROUT_CPLD_BASE   0xE8100000
+#define TROUT_CPLD_BASE   IOMEM(0xE8100000)
 #define TROUT_CPLD_START  0x98000000
 #define TROUT_CPLD_SIZE   SZ_4K
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
