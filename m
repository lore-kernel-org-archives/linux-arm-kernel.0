From: javier.martin@vista-silicon.com (Javier Martin)
Date: Tue, 10 Apr 2012 11:26:59 +0200
Subject: [PATCH 1/2] Visstrim_M10: Add board version detection.
Message-ID: <1334050019-21549-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Visstrim_M10 boards have 3 gpios to detect the
expansion board version attached and other 3 to
detect the motherboard revision.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   55 +++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index f9aa657..adbadf1 100644
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
@@ -119,6 +128,23 @@ static const int visstrim_m10_pins[] __initconst = {
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
+};
+
+static struct gpio visstrim_m10_version_gpios[] = {
+	{ EXPBOARD_BIT0, GPIOF_IN, "exp-version-0" },
+	{ EXPBOARD_BIT1, GPIOF_IN, "exp-version-1" },
+	{ EXPBOARD_BIT2, GPIOF_IN, "exp-version-2" },
+	{ MOTHERBOARD_BIT0, GPIOF_IN, "mother-version-0" },
+	{ MOTHERBOARD_BIT1, GPIOF_IN, "mother-version-1" },
+	{ MOTHERBOARD_BIT2, GPIOF_IN, "mother-version-2" },
 };
 
 /* Camera */
@@ -399,11 +425,40 @@ static const struct imx_ssi_platform_data visstrim_m10_ssi_pdata __initconst = {
 	.flags			= IMX_SSI_DMA | IMX_SSI_SYN,
 };
 
+static void __init visstrim_m10_revision(void)
+{
+	int exp_version = 0;
+	int mo_version = 0;
+	int ret;
+
+	ret = gpio_request_array(visstrim_m10_version_gpios,
+				 ARRAY_SIZE(visstrim_m10_version_gpios));
+	if (ret) {
+		pr_err("Failed to request version gpios");
+		return;
+	}
+
+	/* Get expansion board version (negative logic) */
+	exp_version |= !gpio_get_value(EXPBOARD_BIT2) << 2;
+	exp_version |= !gpio_get_value(EXPBOARD_BIT1) << 1;
+	exp_version |= !gpio_get_value(EXPBOARD_BIT0);
+
+	/* Get mother board version (negative logic) */
+	mo_version |= !gpio_get_value(MOTHERBOARD_BIT2) << 2;
+	mo_version |= !gpio_get_value(MOTHERBOARD_BIT1) << 1;
+	mo_version |= !gpio_get_value(MOTHERBOARD_BIT0);
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
