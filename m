From: vm.rod25@gmail.com (vm.rod25 at gmail.com)
Date: Fri, 12 Nov 2010 16:38:51 -0600
Subject: [PATCH v8 5/9] davinci: Audio support for Omapl138-Hawkboard
In-Reply-To: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
References: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
Message-ID: <1289601535-6746-6-git-send-email-vm.rod25@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch adds sound support for the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
Tested-by: Rene Gonzalez <renegs.2378@gmail.com>
---
Notes:

This patch works with da8xx_omapl_defconfig

In order to test ALSA utils select in menuconfig like insmodule:

Sound card support  --->
      Advanced Linux Sound Architecture  --->
              ALSA for SoC audio support  --->
              SoC Audio for the TI DAVINCI chip
              SoC Audio support for DA850/OMAP-L138 EVM/Hawkboard

 arch/arm/mach-davinci/board-omapl138-hawk.c |   46 +++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 114fc9b..115dac0 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/gpio.h>
+#include <linux/i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -110,6 +111,38 @@ static struct edma_rsv_info *da850_edma_rsv[2] = {
 	&da850_edma_cc1_rsv,
 };
 
+static struct i2c_board_info __initdata omapl138_hawk_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("tlv320aic3x", 0x18),
+	},
+};
+
+static struct davinci_i2c_platform_data omapl138_hawk_i2c_0_pdata = {
+	.bus_freq	= 100,	/* kHz */
+	.bus_delay	= 0,	/* usec */
+};
+
+/* davinci Hawkboard audio machine driver */
+static u8 da850_iis_serializer_direction[] = {
+	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
+	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
+	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
+	INACTIVE_MODE,	TX_MODE,	RX_MODE,	INACTIVE_MODE,
+};
+
+static struct snd_platform_data omapl138_hawk_snd_data = {
+	.tx_dma_offset	= 0x2000,
+	.rx_dma_offset	= 0x2000,
+	.op_mode	= DAVINCI_MCASP_IIS_MODE,
+	.num_serializer	= ARRAY_SIZE(da850_iis_serializer_direction),
+	.tdm_slots	= 2,
+	.serial_dir	= da850_iis_serializer_direction,
+	.asp_chan_q	= EVENTQ_1,
+	.version	= MCASP_VERSION_2,
+	.txnumevt	= 1,
+	.rxnumevt	= 1,
+};
+
 static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
 	.enabled_uarts = 0x7,
 };
@@ -127,6 +160,19 @@ static __init void omapl138_hawk_init(void)
 		pr_warning("%s: EDMA registration failed: %d\n",
 			__func__, ret);
 
+	i2c_register_board_info(1, omapl138_hawk_i2c_devices,
+			ARRAY_SIZE(omapl138_hawk_i2c_devices));
+
+	ret = da8xx_register_i2c(0, &omapl138_hawk_i2c_0_pdata);
+	if (ret)
+		pr_warning("%s: i2c0 registration failed: %d\n",
+			__func__, ret);
+
+	ret = davinci_cfg_reg_list(da850_mcasp_pins);
+	if (ret)
+		pr_warning("%s: mcasp mux setup failed: %d\n", __func__, ret);
+	da8xx_register_mcasp(0, &omapl138_hawk_snd_data);
+
 	ret = da8xx_register_watchdog();
 	if (ret)
 		pr_warning("omapl138_hawk_init: "
-- 
1.7.0.4
