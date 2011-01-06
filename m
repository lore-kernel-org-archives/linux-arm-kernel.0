From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Thu, 6 Jan 2011 13:45:31 +0800
Subject: [PATCH] ARM i.MX53: enable fec driver on EVK board
Message-ID: <1294292731-2896-1-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

1. Adjust FEC base address name to fit macro definition
2. Add platform data and reset function for FEC

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_evk.c       |   27 +++++++++++++++++++++++++++
 arch/arm/mach-mx5/devices-imx53.h        |    4 ++++
 arch/arm/plat-mxc/devices/Kconfig        |    2 +-
 arch/arm/plat-mxc/devices/platform-fec.c |    5 +++++
 arch/arm/plat-mxc/include/mach/mx53.h    |    2 +-
 5 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index fa97d0d..b567ff0 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -21,14 +21,19 @@
 
 #include <linux/init.h>
 #include <linux/clk.h>
+#include <linux/fec.h>
+#include <linux/delay.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
+#include <mach/gpio.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx53.h>
 
+#define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
+
 #include "crm_regs.h"
 #include "devices-imx53.h"
 
@@ -60,11 +65,33 @@ static inline void mx53_evk_init_uart(void)
 	imx53_add_imx_uart(2, &mx53_evk_uart_pdata);
 }
 
+static inline void fec_reset(void)
+{
+	int ret;
+
+	/* reset FEC PHY */
+	ret = gpio_request(SMD_FEC_PHY_RST, "fec-phy-reset");
+	if (ret) {
+		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
+		return;
+	}
+	gpio_direction_output(SMD_FEC_PHY_RST, 0);
+	gpio_set_value(SMD_FEC_PHY_RST, 0);
+	msleep(1);
+	gpio_set_value(SMD_FEC_PHY_RST, 1);
+}
+
+static struct fec_platform_data fec_pdata = {
+	.phy = PHY_INTERFACE_MODE_RMII,
+};
+
 static void __init mx53_evk_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_evk_pads,
 					ARRAY_SIZE(mx53_evk_pads));
 	mx53_evk_init_uart();
+	fec_reset();
+	imx53_add_fec(&fec_pdata);
 }
 
 static void __init mx53_evk_timer_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 9d0ec25..dbf1989 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -8,6 +8,10 @@
 #include <mach/mx53.h>
 #include <mach/devices-common.h>
 
+extern const struct imx_fec_data imx53_fec_data __initconst;
+#define imx53_add_fec(pdata)   \
+	imx_add_fec(&imx53_fec_data, pdata)
+
 extern const struct imx_imx_uart_1irq_data imx53_imx_uart_data[] __initconst;
 #define imx53_add_imx_uart(id, pdata)	\
 	imx_add_imx_uart_1irq(&imx53_imx_uart_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 2537166..b9ab1d5 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -1,6 +1,6 @@
 config IMX_HAVE_PLATFORM_FEC
 	bool
-	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || SOC_IMX51
+	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53
 
 config IMX_HAVE_PLATFORM_FLEXCAN
 	select HAVE_CAN_FLEXCAN if CAN
diff --git a/arch/arm/plat-mxc/devices/platform-fec.c b/arch/arm/plat-mxc/devices/platform-fec.c
index 269ec78..b50c351 100644
--- a/arch/arm/plat-mxc/devices/platform-fec.c
+++ b/arch/arm/plat-mxc/devices/platform-fec.c
@@ -36,6 +36,11 @@ const struct imx_fec_data imx51_fec_data __initconst =
 	imx_fec_data_entry_single(MX51);
 #endif
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_fec_data imx53_fec_data __initconst =
+	imx_fec_data_entry_single(MX53);
+#endif
+
 struct platform_device *__init imx_add_fec(
 		const struct imx_fec_data *data,
 		const struct fec_platform_data *pdata)
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index 9577cdb..a35e0c7 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -136,7 +136,7 @@
 #define MX53_MIPI_HSC_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000DC000)
 #define MX53_MLB_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000E4000)
 #define MX53_SSI3_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000E8000)
-#define MX53_MXC_FEC_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000EC000)
+#define MX53_FEC_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000EC000)
 #define MX53_TVE_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000F0000)
 #define MX53_VPU_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000F4000)
 #define MX53_SAHARA_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000F8000)
-- 
1.7.1
