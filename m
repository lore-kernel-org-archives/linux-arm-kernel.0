From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Jun 2013 17:22:08 +0900
Subject: [PATCH 10/11] ARM: shmobile: bockw: add SDHI0 support
In-Reply-To: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
References: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370593329-27559-11-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch is directly accessing to PUPR4 register which can
control SDHI0 CD/WP pin pull-up setting.
It should be replaced in the future.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 4d65715..2b6103e 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -18,6 +18,8 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/host.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
@@ -54,16 +56,28 @@ static struct resource smsc911x_resources[] = {
 	DEFINE_RES_IRQ(irq_pin(0)), /* IRQ 0 */
 };
 
+/* SDHI */
+static struct sh_mobile_sdhi_info sdhi0_info = {
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
+	.tmio_ocr_mask	= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
+};
+
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* SCIF0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
 				  "scif0_data_a", "scif0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
 				  "scif0_ctrl", "scif0"),
+	/* SDHI0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
+				  "sdhi0", "sdhi0"),
 };
 
 #define FPGA	0x18200000
 #define IRQ0MR	0x30
+#define PFC	0xfffc0000
+#define PUPR4	0x110
 static void __init bockw_init(void)
 {
 	void __iomem *base;
@@ -76,6 +90,7 @@ static void __init bockw_init(void)
 				  ARRAY_SIZE(bockw_pinctrl_map));
 	r8a7778_pinmux_init();
 
+	/* for SMSC */
 	base = ioremap_nocache(FPGA, SZ_1M);
 	if (base) {
 		/*
@@ -98,6 +113,20 @@ static void __init bockw_init(void)
 			smsc911x_resources, ARRAY_SIZE(smsc911x_resources),
 			&smsc911x_data, sizeof(smsc911x_data));
 	}
+
+	/* for SDHI */
+	base = ioremap_nocache(PFC, 0x200);
+	if (base) {
+		/*
+		 * FIXME
+		 *
+		 * SDHI CD/WP pin needs pull-up
+		 */
+		iowrite32(ioread32(base + PUPR4) | (3 << 26), base + PUPR4);
+		iounmap(base);
+
+		r8a7778_sdhi_init(0, &sdhi0_info);
+	}
 }
 
 static const char *bockw_boards_compat_dt[] __initdata = {
-- 
1.8.2.1
