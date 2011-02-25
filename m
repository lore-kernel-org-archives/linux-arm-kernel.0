From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 25 Feb 2011 15:04:14 +0100
Subject: [PATCH v2 3/6] cpuimx51sd: fix tsc2007
In-Reply-To: <1298641111-12957-3-git-send-email-eric@eukrea.com>
References: <1298641111-12957-3-git-send-email-eric@eukrea.com>
Message-ID: <1298642654-23822-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- wrong MUX was set before for IRQ
- get_pendown_state is no more needed

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v2 : use correct define for pad name (with _)

 arch/arm/mach-mx5/board-cpuimx51sd.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index 68ecfc0..6ac41d5 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -110,7 +110,7 @@ static iomux_v3_cfg_t eukrea_cpuimx51sd_pads[] = {
 
 	/* Touchscreen */
 	/* IRQ */
-	_MX51_PAD_CSI1_D8__GPIO3_12 | MUX_PAD_CTRL(PAD_CTL_PUS_22K_UP |
+	_MX51_PAD_GPIO_NAND__GPIO_NAND | MUX_PAD_CTRL(PAD_CTL_PUS_22K_UP |
 			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
 			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),
 };
@@ -119,15 +119,9 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static int ts_get_pendown_state(void)
-{
-	return gpio_get_value(TSC2007_IRQGPIO) ? 0 : 1;
-}
-
 static struct tsc2007_platform_data tsc2007_info = {
 	.model			= 2007,
 	.x_plate_ohms		= 180,
-	.get_pendown_state	= ts_get_pendown_state,
 };
 
 static struct i2c_board_info eukrea_cpuimx51sd_i2c_devices[] = {
-- 
1.7.4
