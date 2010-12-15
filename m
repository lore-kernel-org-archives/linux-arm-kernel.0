From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 15 Dec 2010 15:01:30 +0100
Subject: [PATCH 1/2] MXC IOMUX-V3 replace struct pad_desc with bitmapped
	cookie (step 2)
In-Reply-To: <1292421691-14615-1-git-send-email-s.hauer@pengutronix.de>
References: <1292421691-14615-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1292421691-14615-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lothar Wa?mann <LW@KARO-electronics.de>

This patch actually replaces the 'struct pad_desc' with a u64 cookie
to facilitate adding platform specific pad_ctrl settings to an
existing pad definition.

So, instead of:
	iomux_v3_cfg_t power_key = MX51_PAD_EIM_A27__GPIO_2_21;
	power_key.pad_ctrl = MX51_GPIO_PAD_CTRL_2;
	mxc_iomux_v3_setup_pad(&power_key);
one can write:
	mxc_iomux_v3_setup_pad((MX51_PAD_EIM_A27__GPIO_2_21 & ~MUX_PAD_CTRL_MASK) | MX51_GPIO_PAD_CTRL_2);

Patch applies to branch 'imx-for-2.6.38' of git://git.pengutronix.de/git/imx/linux-2.6

Signed-Off-By: Lothar Wa?mann <LW@KARO-electronics.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm043.c           |   14 ++--
 arch/arm/mach-mx5/board-mx51_babbage.c    |   12 ++--
 arch/arm/plat-mxc/include/mach/iomux-v3.h |   90 ++++++++++++-----------------
 arch/arm/plat-mxc/iomux-v3.c              |   25 +++++---
 4 files changed, 66 insertions(+), 75 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index e229a74..bcf83fc 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -237,7 +237,7 @@ static void pcm043_ac97_warm_reset(struct snd_ac97 *ac97)
 		return;
 	}
 
-	mxc_iomux_v3_setup_pad(&txfs_gpio);
+	mxc_iomux_v3_setup_pad(txfs_gpio);
 
 	/* warm reset */
 	gpio_direction_output(AC97_GPIO_TXFS, 1);
@@ -245,7 +245,7 @@ static void pcm043_ac97_warm_reset(struct snd_ac97 *ac97)
 	gpio_set_value(AC97_GPIO_TXFS, 0);
 
 	gpio_free(AC97_GPIO_TXFS);
-	mxc_iomux_v3_setup_pad(&txfs);
+	mxc_iomux_v3_setup_pad(txfs);
 }
 
 static void pcm043_ac97_cold_reset(struct snd_ac97 *ac97)
@@ -269,9 +269,9 @@ static void pcm043_ac97_cold_reset(struct snd_ac97 *ac97)
 	if (ret)
 		goto err3;
 
-	mxc_iomux_v3_setup_pad(&txfs_gpio);
-	mxc_iomux_v3_setup_pad(&txd_gpio);
-	mxc_iomux_v3_setup_pad(&reset_gpio);
+	mxc_iomux_v3_setup_pad(txfs_gpio);
+	mxc_iomux_v3_setup_pad(txd_gpio);
+	mxc_iomux_v3_setup_pad(reset_gpio);
 
 	gpio_direction_output(AC97_GPIO_TXFS, 0);
 	gpio_direction_output(AC97_GPIO_TXD, 0);
@@ -281,8 +281,8 @@ static void pcm043_ac97_cold_reset(struct snd_ac97 *ac97)
 	udelay(10);
 	gpio_direction_output(AC97_GPIO_RESET, 1);
 
-	mxc_iomux_v3_setup_pad(&txd);
-	mxc_iomux_v3_setup_pad(&txfs);
+	mxc_iomux_v3_setup_pad(txd);
+	mxc_iomux_v3_setup_pad(txfs);
 
 	gpio_free(AC97_GPIO_RESET);
 err3:
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 368a315..24e335c 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -193,7 +193,7 @@ static int gpio_usbh1_active(void)
 	int ret;
 
 	/* Set USBH1_STP to GPIO and toggle it */
-	mxc_iomux_v3_setup_pad(&usbh1stp_gpio);
+	mxc_iomux_v3_setup_pad(usbh1stp_gpio);
 	ret = gpio_request(BABBAGE_USBH1_STP, "usbh1_stp");
 
 	if (ret) {
@@ -206,7 +206,7 @@ static int gpio_usbh1_active(void)
 	gpio_free(BABBAGE_USBH1_STP);
 
 	/* De-assert USB PHY RESETB */
-	mxc_iomux_v3_setup_pad(&phyreset_gpio);
+	mxc_iomux_v3_setup_pad(phyreset_gpio);
 	ret = gpio_request(BABBAGE_PHY_RESET, "phy_reset");
 
 	if (ret) {
@@ -352,7 +352,8 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
 static void __init mxc_board_init(void)
 {
 	iomux_v3_cfg_t usbh1stp = MX51_PAD_USBH1_STP__USBH1_STP;
-	iomux_v3_cfg_t power_key = MX51_PAD_EIM_A27__GPIO_2_21;
+	iomux_v3_cfg_t power_key = (MX51_PAD_EIM_A27__GPIO_2_21 &
+				~MUX_PAD_CTRL_MASK) | MX51_GPIO_PAD_CTRL_2;
 
 #if defined(CONFIG_CPU_FREQ_IMX)
 	get_cpu_op = mx51_get_cpu_op;
@@ -364,8 +365,7 @@ static void __init mxc_board_init(void)
 	imx51_add_fec(NULL);
 
 	/* Set the PAD settings for the pwr key. */
-	power_key.pad_ctrl = MX51_GPIO_PAD_CTRL_2;
-	mxc_iomux_v3_setup_pad(&power_key);
+	mxc_iomux_v3_setup_pad(power_key);
 	imx51_add_gpio_keys(&imx_button_data);
 
 	imx51_add_imx_i2c(0, &babbage_i2c_data);
@@ -382,7 +382,7 @@ static void __init mxc_board_init(void)
 	gpio_usbh1_active();
 	mxc_register_device(&mxc_usbh1_device, &usbh1_config);
 	/* setback USBH1_STP to be function */
-	mxc_iomux_v3_setup_pad(&usbh1stp);
+	mxc_iomux_v3_setup_pad(usbh1stp);
 	babbage_usbhub_reset();
 
 	imx51_add_sdhci_esdhc_imx(0, NULL);
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
index 811716f..1462a1c 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
@@ -42,58 +42,42 @@
  * If <padname> or <padmode> refers to a GPIO, it is named
  * GPIO_<unit>_<num>
  *
- */
-
-typedef struct deprecated_pad_desc {
-	unsigned mux_ctrl_ofs:12; /* IOMUXC_SW_MUX_CTL_PAD offset */
-	unsigned mux_mode:8;
-	unsigned pad_ctrl_ofs:12; /* IOMUXC_SW_PAD_CTRL offset */
-#define	NO_PAD_CTRL	(1 << 16)
-	unsigned pad_ctrl:17;
-	unsigned select_input_ofs:12; /* IOMUXC_SELECT_INPUT offset */
-	unsigned select_input:3;
-} iomux_v3_cfg_t;
-
-static inline unsigned int MUX_CTRL_OFS(iomux_v3_cfg_t *pad)
-{
-	return pad->mux_ctrl_ofs;
-}
-
-static inline unsigned int MUX_MODE(iomux_v3_cfg_t *pad)
-{
-	return pad->mux_mode;
-}
-
-static inline unsigned int MUX_SELECT_INPUT_OFS(iomux_v3_cfg_t *pad)
-{
-	return pad->select_input_ofs;
-}
-
-static inline unsigned int MUX_SELECT_INPUT(iomux_v3_cfg_t *pad)
-{
-	return pad->select_input;
-}
-
-static inline unsigned int MUX_PAD_CTRL_OFS(iomux_v3_cfg_t *pad)
-{
-	return pad->pad_ctrl_ofs;
-}
-
-static inline unsigned int MUX_PAD_CTRL(iomux_v3_cfg_t *pad)
-{
-	return pad->pad_ctrl;
-}
-
-#define IOMUX_PAD(_pad_ctrl_ofs, _mux_ctrl_ofs, _mux_mode, _select_input_ofs, \
-		_select_input, _pad_ctrl)				\
-		{							\
-			.mux_ctrl_ofs     = _mux_ctrl_ofs,		\
-			.mux_mode         = _mux_mode,			\
-			.pad_ctrl_ofs     = _pad_ctrl_ofs,		\
-			.pad_ctrl         = _pad_ctrl,			\
-			.select_input_ofs = _select_input_ofs,		\
-			.select_input     = _select_input,		\
-		}
+ * IOMUX/PAD Bit field definitions
+ *
+ * MUX_CTRL_OFS:	    0..11 (12)
+ * PAD_CTRL_OFS:	   12..23 (12)
+ * SEL_INPUT_OFS:	   24..35 (12)
+ * MUX_MODE + SION:	   36..40  (5)
+ * PAD_CTRL + NO_PAD_CTRL: 41..57 (17)
+ * SEL_INP:		   58..61  (4)
+ * reserved:		     63    (1)
+*/
+
+typedef u64 iomux_v3_cfg_t;
+
+#define MUX_CTRL_OFS_SHIFT	0
+#define MUX_CTRL_OFS_MASK	((iomux_v3_cfg_t)0xfff << MUX_CTRL_OFS_SHIFT)
+#define MUX_PAD_CTRL_OFS_SHIFT	12
+#define MUX_PAD_CTRL_OFS_MASK	((iomux_v3_cfg_t)0xfff << MUX_PAD_CTRL_OFS_SHIFT)
+#define MUX_SEL_INPUT_OFS_SHIFT	24
+#define MUX_SEL_INPUT_OFS_MASK	((iomux_v3_cfg_t)0xfff << MUX_SEL_INPUT_OFS_SHIFT)
+
+#define MUX_MODE_SHIFT		36
+#define MUX_MODE_MASK		((iomux_v3_cfg_t)0x1f << MUX_MODE_SHIFT)
+#define MUX_PAD_CTRL_SHIFT	41
+#define MUX_PAD_CTRL_MASK	((iomux_v3_cfg_t)0x1ffff << MUX_PAD_CTRL_SHIFT)
+#define NO_PAD_CTRL		((iomux_v3_cfg_t)1 << (MUX_PAD_CTRL_SHIFT + 16))
+#define MUX_SEL_INPUT_SHIFT	58
+#define MUX_SEL_INPUT_MASK	((iomux_v3_cfg_t)0xf << MUX_SEL_INPUT_SHIFT)
+
+#define IOMUX_PAD(_pad_ctrl_ofs, _mux_ctrl_ofs, _mux_mode, _sel_input_ofs, \
+		_sel_input, _pad_ctrl)					\
+	(((iomux_v3_cfg_t)(_mux_ctrl_ofs) << MUX_CTRL_OFS_SHIFT) |	\
+		((iomux_v3_cfg_t)(_mux_mode) << MUX_MODE_SHIFT) |	\
+		((iomux_v3_cfg_t)(_pad_ctrl_ofs) << MUX_PAD_CTRL_OFS_SHIFT) | \
+		((iomux_v3_cfg_t)(_pad_ctrl) << MUX_PAD_CTRL_SHIFT) |	\
+		((iomux_v3_cfg_t)(_sel_input_ofs) << MUX_SEL_INPUT_OFS_SHIFT) | \
+		((iomux_v3_cfg_t)(_sel_input) << MUX_SEL_INPUT_SHIFT))
 
 /*
  * Use to set PAD control
@@ -137,7 +121,7 @@ static inline unsigned int MUX_PAD_CTRL(iomux_v3_cfg_t *pad)
 /*
  * setups a single pad in the iomuxer
  */
-int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t *pad);
+int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t pad);
 
 /*
  * setups mutliple pads
diff --git a/arch/arm/plat-mxc/iomux-v3.c b/arch/arm/plat-mxc/iomux-v3.c
index 4cbbf2c..99a9cdb 100644
--- a/arch/arm/plat-mxc/iomux-v3.c
+++ b/arch/arm/plat-mxc/iomux-v3.c
@@ -34,17 +34,24 @@ static void __iomem *base;
 /*
  * configures a single pad in the iomuxer
  */
-int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t *pad)
+int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t pad)
 {
-	if (MUX_CTRL_OFS(pad))
-		__raw_writel(MUX_MODE(pad), base + MUX_CTRL_OFS(pad));
+	u32 mux_ctrl_ofs = (pad & MUX_CTRL_OFS_MASK) >> MUX_CTRL_OFS_SHIFT;
+	u32 mux_mode = (pad & MUX_MODE_MASK) >> MUX_MODE_SHIFT;
+	u32 sel_input_ofs = (pad & MUX_SEL_INPUT_OFS_MASK) >> MUX_SEL_INPUT_OFS_SHIFT;
+	u32 sel_input = (pad & MUX_SEL_INPUT_MASK) >> MUX_SEL_INPUT_SHIFT;
+	u32 pad_ctrl_ofs = (pad & MUX_PAD_CTRL_OFS_MASK) >> MUX_PAD_CTRL_OFS_SHIFT;
+	u32 pad_ctrl = (pad & MUX_PAD_CTRL_MASK) >> MUX_PAD_CTRL_SHIFT;
 
-	if (MUX_SELECT_INPUT_OFS(pad))
-		__raw_writel(MUX_SELECT_INPUT(pad),
-			base + MUX_SELECT_INPUT_OFS(pad));
+	if (mux_ctrl_ofs)
+		__raw_writel(mux_mode, base + mux_ctrl_ofs);
+
+	if (sel_input_ofs)
+		__raw_writel(sel_input, base + sel_input_ofs);
+
+	if (!(pad_ctrl & NO_PAD_CTRL) && pad_ctrl_ofs)
+		__raw_writel(pad_ctrl, base + pad_ctrl_ofs);
 
-	if (!(MUX_PAD_CTRL(pad) & NO_PAD_CTRL) && MUX_PAD_CTRL_OFS(pad))
-		__raw_writel(MUX_PAD_CTRL(pad), base + MUX_PAD_CTRL_OFS(pad));
 	return 0;
 }
 EXPORT_SYMBOL(mxc_iomux_v3_setup_pad);
@@ -56,7 +63,7 @@ int mxc_iomux_v3_setup_multiple_pads(iomux_v3_cfg_t *pad_list, unsigned count)
 	int ret;
 
 	for (i = 0; i < count; i++) {
-		ret = mxc_iomux_v3_setup_pad(p);
+		ret = mxc_iomux_v3_setup_pad(*p);
 		if (ret)
 			return ret;
 		p++;
-- 
1.7.2.3
