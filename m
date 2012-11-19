From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 19 Nov 2012 12:07:07 -0200
Subject: [PATCH v3 3/3] ARM: mx27: Add VPU support
In-Reply-To: <1353334027-30009-1-git-send-email-fabio.estevam@freescale.com>
References: <1353334027-30009-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1353334027-30009-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx27 has a VPU (Video Processing Unit) block that allows doing H264/MPEG4
decoding and encoding in hardware.

Add support for it in a common SoC file instead of per board file.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Do not register VPU for mx27lite version
Changes since v1:
- Call imx27_add_coda() on a common mx27 location instead of pe
 arch/arm/mach-imx/iim.h                     |    2 ++
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    1 -
 arch/arm/mach-imx/mm-imx27.c                |   21 ++++++++++++++++++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/iim.h b/arch/arm/mach-imx/iim.h
index d1d6f35..afe4bc1 100644
--- a/arch/arm/mach-imx/iim.h
+++ b/arch/arm/mach-imx/iim.h
@@ -74,4 +74,6 @@
 #define MXC_IIMHWV2_BP_SDMA             (0x1 << 6)
 #define MXC_IIMHWV2_SCM_DCM             (0x1 << 5)
 
+#define MXC_IIM_CHIPANDMEDIA_DISABLE	(0x1 << 7)
+
 #endif /* __ASM_ARCH_MXC_IIM_H__ */
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 801b797..25303a8 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -531,7 +531,6 @@ static void __init visstrim_m10_board_init(void)
 	gpio_led_register_device(0, &visstrim_m10_led_data);
 	visstrim_deinterlace_init();
 	visstrim_camera_init();
-	imx27_add_coda();
 }
 
 static void __init visstrim_m10_timer_init(void)
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 4f1be65..0a8b9d4 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -25,9 +25,10 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
-#include "devices/devices-common.h"
+#include "devices-imx27.h"
 #include "hardware.h"
 #include "iomux-v1.h"
+#include "iim.h"
 
 /* MX27 memory map definition */
 static struct map_desc imx27_io_desc[] __initdata = {
@@ -80,6 +81,20 @@ static const struct resource imx27_audmux_res[] __initconst = {
 	DEFINE_RES_MEM(MX27_AUDMUX_BASE_ADDR, SZ_4K),
 };
 
+static int cpu_is_mx27l(void)
+{
+	int fuse;
+	fuse = __raw_readl(MX27_IO_ADDRESS(MX27_IIM_BASE_ADDR +
+							MXC_IIMWORD3_BANK0));
+
+	fuse &= MXC_IIM_CHIPANDMEDIA_DISABLE;
+
+	if (fuse)
+		return 1;
+	else
+		return 0;
+}
+
 void __init imx27_soc_init(void)
 {
 	mxc_device_init();
@@ -98,4 +113,8 @@ void __init imx27_soc_init(void)
 	/* imx27 has the imx21 type audmux */
 	platform_device_register_simple("imx21-audmux", 0, imx27_audmux_res,
 					ARRAY_SIZE(imx27_audmux_res));
+
+	/* MX27L variant does not have VPU, so do not register VPU for it */
+	if (!cpu_is_mx27l())
+		imx27_add_coda();
 }
-- 
1.7.9.5
