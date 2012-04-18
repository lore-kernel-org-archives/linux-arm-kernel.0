From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Apr 2012 21:55:03 +0530
Subject: [PATCH] ARM: davinci: mark spi_board_info arg to
 da8xx_register_spi as const
In-Reply-To: <1333138433-14637-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1333138433-14637-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4F8EEADF.60505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 3/31/2012 1:43 AM, Uwe Kleine-K?nig wrote:
> No further changes necessary
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks for the patch. I extended this to include some other spi
registration routines being used for DM355 and DM365. Here is the
updated patch. Can you see if this is OK.

Also, please also Cc davinci-linux-open-source at linux.davincidsp.com on
davinci patches.

Thanks,
Sekhar

---8<----
Subject: [PATCH 1/1] ARM: davinci: mark spi_board_info arguments as const

spi_board_info is not modified in any of the spi registeration
functions and passed along as-is to the generic SPI layer.

Mark spi_board_info arguments as const to signal this.

Signed-off-by: Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de>[nsekhar at ti.com: extended for dm365 and
dm355]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/davinci.h            |    4 ++--
 arch/arm/mach-davinci/devices-da8xx.c      |    2 +-
 arch/arm/mach-davinci/dm355.c              |    2 +-
 arch/arm/mach-davinci/dm365.c              |    2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h |    3 ++-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/davinci.h
b/arch/arm/mach-davinci/davinci.h
index 3e519da..8db0fc6 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -72,7 +72,7 @@ void davinci_map_sysmod(void);
 /* DM355 function declarations */
 void __init dm355_init(void);
 void dm355_init_spi0(unsigned chipselect_mask,
-		struct spi_board_info *info, unsigned len);
+		const struct spi_board_info *info, unsigned len);
 void __init dm355_init_asp1(u32 evt_enable, struct snd_platform_data
*pdata);
 void dm355_set_vpfe_config(struct vpfe_config *cfg);

@@ -83,7 +83,7 @@ void __init dm365_init_vc(struct snd_platform_data
*pdata);
 void __init dm365_init_ks(struct davinci_ks_platform_data *pdata);
 void __init dm365_init_rtc(void);
 void dm365_init_spi0(unsigned chipselect_mask,
-			struct spi_board_info *info, unsigned len);
+			const struct spi_board_info *info, unsigned len);
 void dm365_set_vpfe_config(struct vpfe_config *cfg);

 /* DM644x function declarations */
diff --git a/arch/arm/mach-davinci/devices-da8xx.c
b/arch/arm/mach-davinci/devices-da8xx.c
index 42dbf3d..d1624a3 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -831,7 +831,7 @@ static struct platform_device da8xx_spi_device[] = {
 	},
 };

-int __init da8xx_register_spi(int instance, struct spi_board_info *info,
+int __init da8xx_register_spi(int instance, const struct spi_board_info
*info,
 			      unsigned len)
 {
 	int ret;
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index fd3d09a..678cd99 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -424,7 +424,7 @@ static struct platform_device dm355_spi0_device = {
 };

 void __init dm355_init_spi0(unsigned chipselect_mask,
-		struct spi_board_info *info, unsigned len)
+		const struct spi_board_info *info, unsigned len)
 {
 	/* for now, assume we need MISO */
 	davinci_cfg_reg(DM355_SPI0_SDI);
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 1a2e953..a50d49d 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -676,7 +676,7 @@ static struct platform_device dm365_spi0_device = {
 };

 void __init dm365_init_spi0(unsigned chipselect_mask,
-		struct spi_board_info *info, unsigned len)
+		const struct spi_board_info *info, unsigned len)
 {
 	davinci_cfg_reg(DM365_SPI0_SCLK);
 	davinci_cfg_reg(DM365_SPI0_SDI);
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h
b/arch/arm/mach-davinci/include/mach/da8xx.h
index ee3461d..a2f1f27 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -76,7 +76,8 @@ void __init da850_init(void);
 int da830_register_edma(struct edma_rsv_info *rsv);
 int da850_register_edma(struct edma_rsv_info *rsv[2]);
 int da8xx_register_i2c(int instance, struct davinci_i2c_platform_data
*pdata);
-int da8xx_register_spi(int instance, struct spi_board_info *info,
unsigned len);
+int da8xx_register_spi(int instance,
+		const struct spi_board_info *info, unsigned len);
 int da8xx_register_watchdog(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
 int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
