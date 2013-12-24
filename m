From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:06:54 +0900
Subject: [PATCH 02/13] ARM: shmobile: r8a7790: add I2C support
In-Reply-To: <cover.1387857168.git.horms+renesas@verge.net.au>
References: <cover.1387857168.git.horms+renesas@verge.net.au>
Message-ID: <b448c904f5058b6cd35bf1a43ca219dcfeca4da6.1387857168.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
 arch/arm/mach-shmobile/setup-r8a7790.c | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 36c8917..b6ecea3 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -292,9 +292,13 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
 	CLKDEV_DEV_ID("e6508000.i2c", &mstp_clks[MSTP931]),
+	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP931]),
 	CLKDEV_DEV_ID("e6518000.i2c", &mstp_clks[MSTP930]),
+	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP930]),
 	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP929]),
+	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP929]),
 	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP928]),
+	CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP928]),
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index c47bcebb..1a11e26 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -63,6 +63,27 @@ R8A7790_GPIO(5);
 		&r8a7790_gpio##idx##_platform_data,			\
 		sizeof(r8a7790_gpio##idx##_platform_data))
 
+static struct resource i2c_resources[] __initdata = {
+	/* I2C0 */
+	DEFINE_RES_MEM(0xE6508000, 0x40),
+	DEFINE_RES_IRQ(gic_spi(287)),
+	/* I2C1 */
+	DEFINE_RES_MEM(0xE6518000, 0x40),
+	DEFINE_RES_IRQ(gic_spi(288)),
+	/* I2C2 */
+	DEFINE_RES_MEM(0xE6530000, 0x40),
+	DEFINE_RES_IRQ(gic_spi(286)),
+	/* I2C3 */
+	DEFINE_RES_MEM(0xE6540000, 0x40),
+	DEFINE_RES_IRQ(gic_spi(290)),
+
+};
+
+#define r8a7790_register_i2c(idx)		\
+	platform_device_register_simple(	\
+		"i2c-rcar", idx,		\
+		i2c_resources + (2 * idx), 2);	\
+
 void __init r8a7790_pinmux_init(void)
 {
 	platform_device_register_simple("pfc-r8a7790", -1, pfc_resources,
@@ -73,6 +94,10 @@ void __init r8a7790_pinmux_init(void)
 	r8a7790_register_gpio(3);
 	r8a7790_register_gpio(4);
 	r8a7790_register_gpio(5);
+	r8a7790_register_i2c(0);
+	r8a7790_register_i2c(1);
+	r8a7790_register_i2c(2);
+	r8a7790_register_i2c(3);
 }
 
 #define SCIF_COMMON(scif_type, baseaddr, irq)			\
-- 
1.8.4
