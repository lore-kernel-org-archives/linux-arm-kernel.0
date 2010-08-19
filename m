From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 18 Aug 2010 17:54:36 -0700 (PDT)
Subject: [PATCH] mx51_babbage: Add FEC support
Message-ID: <620138.80679.qm@web51004.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add FEC support on MX51 Babbage board.

Tested it by booting a rootfs via NFS.

 Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

---
 arch/arm/mach-mx5/board-mx51_babbage.c      |   39 ++++++++++++++++++++++++++-
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |   25 +++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 6e384d9..e3963e5 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/fsl_devices.h>
+#include <linux/fec.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -35,7 +36,8 @@
 
 #define BABBAGE_USB_HUB_RESET	(0*32 + 7)	/* GPIO_1_7 */
 #define BABBAGE_USBH1_STP	(0*32 + 27)	/* GPIO_1_27 */
-#define BABBAGE_PHY_RESET (1*32 +5)	/* GPIO_2_5 */
+#define BABBAGE_PHY_RESET 	(1*32 + 5)	/* GPIO_2_5 */
+#define BABBAGE_FEC_PHY_RESET	(1*32 + 14)	/* GPIO_2_14 */
 
 /* USB_CTRL_1 */
 #define MX51_USB_CTRL_1_OFFSET			0x10
@@ -93,6 +95,25 @@ static struct pad_desc mx51babbage_pads[] = {
 
 	/* USB HUB reset line*/
 	MX51_PAD_GPIO_1_7__GPIO_1_7,
+
+	/* FEC */
+	MX51_PAD_EIM_EB2__FEC_MDIO,
+	MX51_PAD_EIM_EB3__FEC_RDAT1,
+	MX51_PAD_EIM_CS2__FEC_RDAT2,
+	MX51_PAD_EIM_CS3__FEC_RDAT3,
+	MX51_PAD_EIM_CS4__FEC_RX_ER,
+	MX51_PAD_EIM_CS5__FEC_CRS,
+	MX51_PAD_NANDF_RB2__FEC_COL,
+	MX51_PAD_NANDF_RB3__FEC_RXCLK,
+	MX51_PAD_NANDF_RB6__FEC_RDAT0,
+	MX51_PAD_NANDF_RB7__FEC_TDAT0,
+	MX51_PAD_NANDF_CS2__FEC_TX_ER,
+	MX51_PAD_NANDF_CS3__FEC_MDC,
+	MX51_PAD_NANDF_CS4__FEC_TDAT1,
+	MX51_PAD_NANDF_CS5__FEC_TDAT2,
+	MX51_PAD_NANDF_CS6__FEC_TDAT3,
+	MX51_PAD_NANDF_CS7__FEC_TX_EN,
+	MX51_PAD_NANDF_RDY_INT__FEC_TX_CLK,
 };
 
 /* Serial ports */
@@ -171,6 +192,21 @@ static inline void babbage_usbhub_reset(void)
 	gpio_set_value(BABBAGE_USB_HUB_RESET, 1);
 }
 
+static inline void babbage_fec_reset(void)
+{
+	int ret;
+
+	/* reset FEC PHY */
+	ret = gpio_request(BABBAGE_FEC_PHY_RESET, "fec-phy-reset");
+	if (ret) {
+		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
+		return;
+	}
+	gpio_direction_output(BABBAGE_FEC_PHY_RESET, 0);
+	udelay(200);
+	gpio_set_value(BABBAGE_FEC_PHY_RESET, 1);
+}
+
 /* This function is board specific as the bit mask for the plldiv will also
 be different for other Freescale SoCs, thus a common bitmask is not
 possible and cannot get place in /plat-mxc/ehci.c.*/
@@ -250,6 +286,7 @@ static void __init mxc_board_init(void)
 	mxc_iomux_v3_setup_multiple_pads(mx51babbage_pads,
 					ARRAY_SIZE(mx51babbage_pads));
 	mxc_init_imx_uart();
+	babbage_fec_reset();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	mxc_register_device(&mxc_i2c_device0, &babbage_i2c_data);
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index 21bfa46..5275713 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -46,6 +46,13 @@ typedef enum iomux_config {
 #define MX51_GPIO_PAD_CTRL		(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | \
 				PAD_CTL_SRE_FAST)
 
+#define MX51_PAD_CTRL_1	(PAD_CTL_SRE_FAST | PAD_CTL_DSE_HIGH | \
+					PAD_CTL_PUE | PAD_CTL_PKE | PAD_CTL_HYS)
+#define MX51_PAD_CTRL_2	(PAD_CTL_HYS | PAD_CTL_PKE)
+#define MX51_PAD_CTRL_3	(PAD_CTL_PKE | PAD_CTL_PUS_100K_UP)
+#define MX51_PAD_CTRL_4	(PAD_CTL_DVS | PAD_CTL_HYS | PAD_CTL_PKE)
+#define MX51_PAD_CTRL_5	(PAD_CTL_DVS | PAD_CTL_DSE_HIGH)
+
 /*
  * The naming convention for the pad modes is MX51_PAD_<padname>__<padmode>
  * If <padname> or <padmode> refers to a GPIO, it is named GPIO_<unit>_<num>
@@ -322,4 +329,22 @@ typedef enum iomux_config {
 #define MX51_PAD_GPIO_1_8__GPIO_1_8		IOMUX_PAD(0x814, 0x3E8, 0, 0x0,   1, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_9__GPIO_1_9		IOMUX_PAD(0x818, 0x3EC, 0, 0x0,   0, NO_PAD_CTRL)
 
+#define MX51_PAD_EIM_EB2__FEC_MDIO		IOMUX_PAD(0x468, 0x0d4, 3, 0x0,   0, MX51_PAD_CTRL_1 | PAD_CTL_PUS_22K_UP)
+#define MX51_PAD_EIM_EB3__FEC_RDAT1		IOMUX_PAD(0x46c, 0x0d8, 3, 0x0,   0, MX51_PAD_CTRL_2)
+#define MX51_PAD_EIM_CS2__FEC_RDAT2		IOMUX_PAD(0x47c, 0x0e8, 3, 0x0,   0, MX51_PAD_CTRL_2)
+#define MX51_PAD_EIM_CS3__FEC_RDAT3		IOMUX_PAD(0x480, 0x0ec, 3, 0x0,   0, MX51_PAD_CTRL_2)
+#define MX51_PAD_EIM_CS4__FEC_RX_ER		IOMUX_PAD(0x484, 0x0f0, 3, 0x0,   0, MX51_PAD_CTRL_2)
+#define MX51_PAD_EIM_CS5__FEC_CRS		IOMUX_PAD(0x488, 0x0f4, 3, 0x0,   0, MX51_PAD_CTRL_2)
+#define MX51_PAD_NANDF_RB2__FEC_COL		IOMUX_PAD(0x500, 0x124, 1, 0x0, 0, MX51_PAD_CTRL_2)
+#define MX51_PAD_NANDF_RB3__FEC_RXCLK		IOMUX_PAD(0x504, 0x128, 1, 0x0, 0, MX51_PAD_CTRL_2)
+#define MX51_PAD_NANDF_RB7__FEC_TDAT0		IOMUX_PAD(0x5E0, 0x138, 1, 0x0, 0, MX51_PAD_CTRL_5)
+#define MX51_PAD_NANDF_RB6__FEC_RDAT0		IOMUX_PAD(0x5DC, 0x134, 1, 0x0, 0, MX51_PAD_CTRL_4)
+#define MX51_PAD_NANDF_CS2__FEC_TX_ER		IOMUX_PAD(0x520, 0x138, 2, 0x0, 0, MX51_PAD_CTRL_5)
+#define MX51_PAD_NANDF_CS3__FEC_MDC		IOMUX_PAD(0x524, 0x13C, 2, 0x0, 0, MX51_PAD_CTRL_5)
+#define MX51_PAD_NANDF_CS4__FEC_TDAT1		IOMUX_PAD(0x528, 0x140, 2, 0x0, 0, MX51_PAD_CTRL_5)
+#define MX51_PAD_NANDF_CS5__FEC_TDAT2		IOMUX_PAD(0x52C, 0x144, 2, 0x0, 0, MX51_PAD_CTRL_5)
+#define MX51_PAD_NANDF_CS6__FEC_TDAT3		IOMUX_PAD(0x530, 0x148, 2, 0x0, 0, MX51_PAD_CTRL_5)
+#define MX51_PAD_NANDF_CS7__FEC_TX_EN		IOMUX_PAD(0x534, 0x14C, 1, 0x0, 0, MX51_PAD_CTRL_5)
+#define MX51_PAD_NANDF_RDY_INT__FEC_TX_CLK	IOMUX_PAD(0x538, 0x150, 1, 0x0, 0, MX51_PAD_CTRL_4)
+
 #endif /* __MACH_IOMUX_MX51_H__ */
-- 
1.6.0.4


      
