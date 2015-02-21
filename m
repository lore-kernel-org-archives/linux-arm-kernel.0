From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 21 Feb 2015 16:08:21 +0100
Subject: [PATCH] ARM: imx/iomux-v3: allow pad_list to be const
Message-ID: <1424531301-7075-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also fix all machine files to make use of it and while at it also make
the pad lists __initconst.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I already sent a similar patch before, see
http://thread.gmane.org/gmane.linux.ports.arm.kernel/181242.

Shawn didn't want to take the patch back then as it touched some files he
wanted to remove. Assuming his changes are through now, I'm resending :-)

Best regards
Uwe

 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c | 2 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c | 2 +-
 arch/arm/mach-imx/iomux-v3.c                   | 5 +++--
 arch/arm/mach-imx/iomux-v3.h                   | 3 ++-
 arch/arm/mach-imx/mach-cpuimx35.c              | 2 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c       | 2 +-
 arch/arm/mach-imx/mach-mx25_3ds.c              | 2 +-
 arch/arm/mach-imx/mach-mx35_3ds.c              | 2 +-
 arch/arm/mach-imx/mach-pcm043.c                | 2 +-
 arch/arm/mach-imx/mach-vpr200.c                | 2 +-
 10 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index e77cc3af6db2..10e53818e003 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -35,7 +35,7 @@
 #include "iomux-mx25.h"
 #include "mx25.h"
 
-static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
+static const iomux_v3_cfg_t eukrea_mbimxsd_pads[] __initconst = {
 	/* LCD */
 	MX25_PAD_LD0__LD0,
 	MX25_PAD_LD1__LD1,
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index 14d6c8249b76..6edc940e0865 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -100,7 +100,7 @@ static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.num_modes	= ARRAY_SIZE(fb_modedb),
 };
 
-static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
+static const iomux_v3_cfg_t eukrea_mbimxsd_pads[] __initconst = {
 	/* LCD */
 	MX35_PAD_LD0__IPU_DISPB_DAT_0,
 	MX35_PAD_LD1__IPU_DISPB_DAT_1,
diff --git a/arch/arm/mach-imx/iomux-v3.c b/arch/arm/mach-imx/iomux-v3.c
index d61f9606fc56..a53b2e64f98d 100644
--- a/arch/arm/mach-imx/iomux-v3.c
+++ b/arch/arm/mach-imx/iomux-v3.c
@@ -56,9 +56,10 @@ int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t pad)
 	return 0;
 }
 
-int mxc_iomux_v3_setup_multiple_pads(iomux_v3_cfg_t *pad_list, unsigned count)
+int mxc_iomux_v3_setup_multiple_pads(const iomux_v3_cfg_t *pad_list,
+		unsigned count)
 {
-	iomux_v3_cfg_t *p = pad_list;
+	const iomux_v3_cfg_t *p = pad_list;
 	int i;
 	int ret;
 
diff --git a/arch/arm/mach-imx/iomux-v3.h b/arch/arm/mach-imx/iomux-v3.h
index 2fa3b5430102..5f4bbf124832 100644
--- a/arch/arm/mach-imx/iomux-v3.h
+++ b/arch/arm/mach-imx/iomux-v3.h
@@ -131,7 +131,8 @@ int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t pad);
  * setups mutliple pads
  * convenient way to call the above function with tables
  */
-int mxc_iomux_v3_setup_multiple_pads(iomux_v3_cfg_t *pad_list, unsigned count);
+int mxc_iomux_v3_setup_multiple_pads(const iomux_v3_cfg_t *pad_list,
+		unsigned count);
 
 /*
  * Initialise the iomux controller
diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index 62a6e02f4763..922ffd6ca039 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -75,7 +75,7 @@ static struct i2c_board_info eukrea_cpuimx35_i2c_devices[] = {
 	},
 };
 
-static iomux_v3_cfg_t eukrea_cpuimx35_pads[] = {
+static const iomux_v3_cfg_t eukrea_cpuimx35_pads[] __initconst = {
 	/* UART1 */
 	MX35_PAD_CTS1__UART1_CTS,
 	MX35_PAD_RTS1__UART1_RTS,
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index b2ee6e009fe4..026321918843 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -45,7 +45,7 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static iomux_v3_cfg_t eukrea_cpuimx25_pads[] = {
+static const iomux_v3_cfg_t eukrea_cpuimx25_pads[] __initconst = {
 	/* FEC - RMII */
 	MX25_PAD_FEC_MDC__FEC_MDC,
 	MX25_PAD_FEC_MDIO__FEC_MDIO,
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 0d01e367b062..584248a5e1e9 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -50,7 +50,7 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static iomux_v3_cfg_t mx25pdk_pads[] = {
+static const iomux_v3_cfg_t mx25pdk_pads[] __initconst = {
 	MX25_PAD_FEC_MDC__FEC_MDC,
 	MX25_PAD_FEC_MDIO__FEC_MDIO,
 	MX25_PAD_FEC_TDATA0__FEC_TDATA0,
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 72cd77d21f63..7e315f00648d 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -166,7 +166,7 @@ static struct platform_device *devices[] __initdata = {
 	&mx35pdk_flash,
 };
 
-static iomux_v3_cfg_t mx35pdk_pads[] = {
+static const iomux_v3_cfg_t mx35pdk_pads[] __initconst = {
 	/* UART1 */
 	MX35_PAD_CTS1__UART1_CTS,
 	MX35_PAD_RTS1__UART1_RTS,
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index b623bcaca76c..e447e59c0604 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -129,7 +129,7 @@ static struct platform_device *devices[] __initdata = {
 	&pcm043_flash,
 };
 
-static iomux_v3_cfg_t pcm043_pads[] = {
+static const iomux_v3_cfg_t pcm043_pads[] __initconst = {
 	/* UART1 */
 	MX35_PAD_CTS1__UART1_CTS,
 	MX35_PAD_RTS1__UART1_RTS,
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 97836e94451c..27a8f7e3ec08 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -161,7 +161,7 @@ static struct i2c_board_info vpr200_i2c_devices[] = {
 	}
 };
 
-static iomux_v3_cfg_t vpr200_pads[] = {
+static const iomux_v3_cfg_t vpr200_pads[] __initconst = {
 	/* UART1 */
 	MX35_PAD_TXD1__UART1_TXD_MUX,
 	MX35_PAD_RXD1__UART1_RXD_MUX,
-- 
2.1.4
