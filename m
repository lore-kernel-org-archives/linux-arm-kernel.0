From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Tue, 22 Jun 2010 16:16:24 +0300
Subject: [PATCH 3/4] ARM: S3C2416: Add clock definition for HSMMC1
In-Reply-To: <1277212585-25605-3-git-send-email-jekhor@gmail.com>
References: <1277212585-25605-1-git-send-email-jekhor@gmail.com>
	<1277212585-25605-2-git-send-email-jekhor@gmail.com>
	<1277212585-25605-3-git-send-email-jekhor@gmail.com>
Message-ID: <1277212585-25605-4-git-send-email-jekhor@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define clock for hsmmc1 device and register it.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |    1 +
 arch/arm/mach-s3c2416/clock.c                      |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h b/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
index 08ab9df..c073a5a 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-s3c2443-clock.h
@@ -86,6 +86,7 @@
 #define S3C2443_HCLKCON_LCDC		(1<<9)
 #define S3C2443_HCLKCON_USBH		(1<<11)
 #define S3C2443_HCLKCON_USBD		(1<<12)
+#define S3C2416_HCLKCON_HSMMC0		(1<<15)
 #define S3C2443_HCLKCON_HSMMC		(1<<16)
 #define S3C2443_HCLKCON_CFC		(1<<17)
 #define S3C2443_HCLKCON_SSMC		(1<<18)
diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 7ccf5a2..f11d131 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -93,6 +93,13 @@ static struct clksrc_clk hsmmc_mux[] = {
 	},
 };
 
+static struct clk hsmmc1_clk = {
+	.name		= "hsmmc",
+	.id		= 1,
+	.parent		= &clk_h,
+	.enable		= s3c2443_clkcon_enable_h,
+	.ctrlbit	= S3C2416_HCLKCON_HSMMC0,
+};
 
 static inline unsigned int s3c2416_fclk_div(unsigned long clkcon0)
 {
@@ -130,6 +137,8 @@ void __init s3c2416_init_clocks(int xtal)
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_register_clksrc(clksrcs[ptr], 1);
 
+	s3c24xx_register_clock(&hsmmc1_clk);
+
 	s3c_pwmclk_init();
 
 }
-- 
1.6.6.1
