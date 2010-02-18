From: carsten.behling@garz-fricke.com (Carsten Behling)
Date: Thu, 18 Feb 2010 16:12:33 +0100
Subject: [PATCH 1/1] add mx3 cupid bsp
Message-ID: <D99582E5322435468A77E74BB0039E7B176E1F3BC1@SRV02.hamburg.garz-fricke.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I added board support for CUPID.

Carsten

Signed-off-by: Carsten Behling <carsten.behling@garz-fricke.com>
---
 arch/arm/mach-mx3/Kconfig                   |    7 +
 arch/arm/mach-mx3/Makefile                  |    1 +
 arch/arm/mach-mx3/mach-guf_cupid.c          |  181 +++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
 4 files changed, 190 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx3/mach-guf_cupid.c

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 3872af1..a7e40d7 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -114,4 +114,11 @@ config MACH_KZM_ARM11_01
          Include support for KZM-ARM11-01. This includes specific
          configurations for the board and its peripherals.

+config MACH_GUF_CUPID
+       bool "Support Garz & Fricke Cupid platform"
+       select ARCH_MX35
+       help
+         Include support for Cupid platform. This includes specific
+         configurations for the board and its peripherals.
+
 endif
diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 5d650fd..7f9ca81 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_MACH_PCM043)     += mach-pcm043.o
 obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
 obj-$(CONFIG_MACH_MX35_3DS)    += mach-mx35pdk.o
 obj-$(CONFIG_MACH_KZM_ARM11_01)        += mach-kzm_arm11_01.o
+obj-$(CONFIG_MACH_GUF_CUPID)   += mach-guf_cupid.o
diff --git a/arch/arm/mach-mx3/mach-guf_cupid.c b/arch/arm/mach-mx3/mach-guf_cupid.c
new file mode 100644
index 0000000..d12ac97
--- /dev/null
+++ b/arch/arm/mach-mx3/mach-guf_cupid.c
@@ -0,0 +1,181 @@
+/*
+ * Copyright 2010 Garz & Fricke GmbH All Rights Reserved.
+ *
+ * Author: Carsten Behling <carsten.behling@garz-fricke.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor Boston, MA 02110-1301 USA
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <linux/memory.h>
+#include <linux/interrupt.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+#include <mach/common.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx35.h>
+#include <mach/ipu.h>
+#include <mach/mx3fb.h>
+#include <mach/mxc_nand.h>
+
+#include "devices.h"
+
+static struct fb_videomode fb_modedb[] = {
+       {
+               /* 800x480 @ 70 Hz */
+               .name           = "CPT CLAA070LC0JCT",
+               .refresh        = 70,
+               .xres           = 800,
+               .yres           = 480,
+               .pixclock       = 7829,
+               .left_margin    = 24,
+               .right_margin   = 47,
+               .upper_margin   = 5,
+               .lower_margin   = 3,
+               .hsync_len      = 24,
+               .vsync_len      = 3,
+               .sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_SHARP_MODE |
+                                 FB_SYNC_CLK_INVERT | FB_SYNC_CLK_IDLE_EN,
+               .vmode          = FB_VMODE_NONINTERLACED,
+               .flag           = 0,
+       },
+};
+
+static struct ipu_platform_data mx3_ipu_data = {
+       .irq_base = MXC_IPU_IRQ_START,
+};
+
+static struct mx3fb_platform_data mx3fb_pdata = {
+       .dma_dev        = &mx3_ipu.dev,
+       .name           = "CPT CLAA070LC0JCT",
+       .mode           = fb_modedb,
+       .num_modes      = ARRAY_SIZE(fb_modedb),
+};
+
+static struct imxuart_platform_data uart_pdata = {
+       .flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct platform_device *devices[] __initdata = {
+       &mxc_fec_device,
+};
+
+static struct pad_desc cupid_pads[] = {
+       /* UART1 */
+       MX35_PAD_CTS1__UART1_CTS,
+       MX35_PAD_RTS1__UART1_RTS,
+       MX35_PAD_TXD1__UART1_TXD_MUX,
+       MX35_PAD_RXD1__UART1_RXD_MUX,
+       /* UART2 */
+       MX35_PAD_CTS2__UART2_CTS,
+       MX35_PAD_RTS2__UART2_RTS,
+       MX35_PAD_TXD2__UART2_TXD_MUX,
+       MX35_PAD_RXD2__UART2_RXD_MUX,
+       /* FEC */
+       MX35_PAD_FEC_TX_CLK__FEC_TX_CLK,
+       MX35_PAD_FEC_RX_CLK__FEC_RX_CLK,
+       MX35_PAD_FEC_RX_DV__FEC_RX_DV,
+       MX35_PAD_FEC_COL__FEC_COL,
+       MX35_PAD_FEC_RDATA0__FEC_RDATA_0,
+       MX35_PAD_FEC_TDATA0__FEC_TDATA_0,
+       MX35_PAD_FEC_TX_EN__FEC_TX_EN,
+       MX35_PAD_FEC_MDC__FEC_MDC,
+       MX35_PAD_FEC_MDIO__FEC_MDIO,
+       MX35_PAD_FEC_TX_ERR__FEC_TX_ERR,
+       MX35_PAD_FEC_RX_ERR__FEC_RX_ERR,
+       MX35_PAD_FEC_CRS__FEC_CRS,
+       MX35_PAD_FEC_RDATA1__FEC_RDATA_1,
+       MX35_PAD_FEC_TDATA1__FEC_TDATA_1,
+       MX35_PAD_FEC_RDATA2__FEC_RDATA_2,
+       MX35_PAD_FEC_TDATA2__FEC_TDATA_2,
+       MX35_PAD_FEC_RDATA3__FEC_RDATA_3,
+       MX35_PAD_FEC_TDATA3__FEC_TDATA_3,
+       /* Display */
+       MX35_PAD_LD0__IPU_DISPB_DAT_0,
+       MX35_PAD_LD1__IPU_DISPB_DAT_1,
+       MX35_PAD_LD2__IPU_DISPB_DAT_2,
+       MX35_PAD_LD3__IPU_DISPB_DAT_3,
+       MX35_PAD_LD4__IPU_DISPB_DAT_4,
+       MX35_PAD_LD5__IPU_DISPB_DAT_5,
+       MX35_PAD_LD6__IPU_DISPB_DAT_6,
+       MX35_PAD_LD7__IPU_DISPB_DAT_7,
+       MX35_PAD_LD8__IPU_DISPB_DAT_8,
+       MX35_PAD_LD9__IPU_DISPB_DAT_9,
+       MX35_PAD_LD10__IPU_DISPB_DAT_10,
+       MX35_PAD_LD11__IPU_DISPB_DAT_11,
+       MX35_PAD_LD12__IPU_DISPB_DAT_12,
+       MX35_PAD_LD13__IPU_DISPB_DAT_13,
+       MX35_PAD_LD14__IPU_DISPB_DAT_14,
+       MX35_PAD_LD15__IPU_DISPB_DAT_15,
+       MX35_PAD_LD16__IPU_DISPB_DAT_16,
+       MX35_PAD_LD17__IPU_DISPB_DAT_17,
+       MX35_PAD_D3_HSYNC__IPU_DISPB_D3_HSYNC,
+       MX35_PAD_D3_FPSHIFT__IPU_DISPB_D3_CLK,
+       MX35_PAD_D3_DRDY__IPU_DISPB_D3_DRDY,
+       MX35_PAD_D3_VSYNC__IPU_DISPB_D3_VSYNC,
+       MX35_PAD_LD18__GPIO3_24,                /* LCD enable */
+       MX35_PAD_CSPI1_SS1__PWM_PWMO,           /* LCD backligtht PWM */
+};
+
+static struct mxc_nand_platform_data nand_pdata = {
+       .width = 1,
+       .hw_ecc = 1,
+       .flash_bbt = 0,
+};
+
+/*
+ * Board specific initialization.
+ */
+static void __init mxc_board_init(void)
+{
+       mxc_iomux_v3_setup_multiple_pads(cupid_pads, ARRAY_SIZE(cupid_pads));
+
+       platform_add_devices(devices, ARRAY_SIZE(devices));
+
+       mxc_register_device(&mxc_uart_device0, &uart_pdata);
+       mxc_register_device(&mxc_nand_device, &nand_pdata);
+
+       mxc_register_device(&mx3_ipu, &mx3_ipu_data);
+       mxc_register_device(&mx3_fb, &mx3fb_pdata);
+}
+
+static void __init cupid_timer_init(void)
+{
+       mx35_clocks_init();
+}
+
+struct sys_timer cupid_timer = {
+       .init   = cupid_timer_init,
+};
+
+MACHINE_START(GUF_CUPID, "Garz & Fricke CUPID")
+       /* Maintainer: Garz & Fricke GmbH */
+       .phys_io        = MX35_AIPS1_BASE_ADDR,
+       .io_pg_offst    = ((MX35_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+       .boot_params    = MX3x_PHYS_OFFSET + 0x100,
+       .map_io         = mx35_map_io,
+       .init_irq       = mx35_init_irq,
+       .init_machine   = mxc_board_init,
+       .timer          = &cupid_timer,
+MACHINE_END
+
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index d189f00..1a0b311 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -94,6 +94,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
        case MACH_TYPE_MX35_3DS:
        case MACH_TYPE_PCM043:
        case MACH_TYPE_LILLY1131:
+       case MACH_TYPE_GUF_CUPID:
                uart_base = MX3X_UART1_BASE_ADDR;
                break;
        case MACH_TYPE_MAGX_ZN5:
--
1.6.0.2
