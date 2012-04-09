From: javier.martin@vista-silicon.com (Javier Martin)
Date: Mon,  9 Apr 2012 10:52:03 +0200
Subject: [PATCH] Visstrim_M10: Add board version detection.
Message-ID: <1333961523-16356-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visstrim_M10 boards have 3 gpios to detect the
expansion board version attached and other 3 to
detect the motherboard revision.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   38 +++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index f9aa657..cdf277e 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -38,6 +38,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/system.h>
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
 
@@ -48,6 +49,14 @@
 #define OTG_PHY_CS_GPIO (GPIO_PORTF + 17)
 #define SDHC1_IRQ IRQ_GPIOB(25)
 
+#define MOTHERBOARD_BIT2	(GPIO_PORTD + 31)
+#define MOTHERBOARD_BIT1	(GPIO_PORTD + 30)
+#define MOTHERBOARD_BIT0	(GPIO_PORTD + 29)
+
+#define EXPBOARD_BIT2		(GPIO_PORTD + 25)
+#define EXPBOARD_BIT1		(GPIO_PORTD + 27)
+#define EXPBOARD_BIT0		(GPIO_PORTD + 28)
+
 static const int visstrim_m10_pins[] __initconst = {
 	/* UART1 (console) */
 	PE12_PF_UART1_TXD,
@@ -119,6 +128,14 @@ static const int visstrim_m10_pins[] __initconst = {
 	PB19_PF_CSI_D7,
 	PB20_PF_CSI_VSYNC,
 	PB21_PF_CSI_HSYNC,
+	/* mother board version */
+	MOTHERBOARD_BIT2 | GPIO_GPIO | GPIO_IN | GPIO_PUEN,
+	MOTHERBOARD_BIT1 | GPIO_GPIO | GPIO_IN | GPIO_PUEN,
+	MOTHERBOARD_BIT0 | GPIO_GPIO | GPIO_IN | GPIO_PUEN,
+	/* expansion board version */
+	EXPBOARD_BIT2 | GPIO_GPIO | GPIO_IN | GPIO_PUEN,
+	EXPBOARD_BIT1 | GPIO_GPIO | GPIO_IN | GPIO_PUEN,
+	EXPBOARD_BIT0 | GPIO_GPIO | GPIO_IN | GPIO_PUEN,
 };
 
 /* Camera */
@@ -399,11 +416,32 @@ static const struct imx_ssi_platform_data visstrim_m10_ssi_pdata __initconst = {
 	.flags			= IMX_SSI_DMA | IMX_SSI_SYN,
 };
 
+static void __init visstrim_m10_revision(void)
+{
+	int exp_version = 0;
+	int mo_version = 0;
+
+	/* Get expansion board version (negative logic) */
+	exp_version |= ((!gpio_get_value(EXPBOARD_BIT2) << 2) & (1 << 2));
+	exp_version |= ((!gpio_get_value(EXPBOARD_BIT1) << 1) & (1 << 1));
+	exp_version |= ((!gpio_get_value(EXPBOARD_BIT0)) & 1);
+
+	/* Get mother board version (negative logic) */
+	mo_version |= ((!gpio_get_value(MOTHERBOARD_BIT2) << 2) & (1 << 2));
+	mo_version |= ((!gpio_get_value(MOTHERBOARD_BIT1) << 1) & (1 << 1));
+	mo_version |= ((!gpio_get_value(MOTHERBOARD_BIT0)) & 1);
+
+	system_rev = 0x27000;
+	system_rev |= (mo_version << 4);
+	system_rev |= exp_version;
+}
+
 static void __init visstrim_m10_board_init(void)
 {
 	int ret;
 
 	imx27_soc_init();
+	visstrim_m10_revision();
 
 	ret = mxc_gpio_setup_multiple_pins(visstrim_m10_pins,
 			ARRAY_SIZE(visstrim_m10_pins), "VISSTRIM_M10");
-- 
1.7.0.4
