From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:19:02 +0900
Subject: [PATCH 10/21] ARM: shmobile: lager: Add SATA support
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <1e0d2c495316862fa3da73150ee86ba30c9faf0c.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This adds SATA support to Lager board. Only SATA1 port is available.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Acked-by: Magnus Damm <damm@opensource.se>
[horms+renesas at verge.net.au: resolved trivial conflicts]
[horms+renesas at verge.net.au: capitalised "ARM" in subject]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index aa8f1d9..8dde446 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -349,6 +349,21 @@ static void __init lager_add_camera1_device(void)
 	lager_add_vin_device(1, &vin1_pdata);
 }
 
+/* SATA1 */
+static const struct resource sata1_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee500000, 0x2000),
+	DEFINE_RES_IRQ(gic_spi(106)),
+};
+
+static const struct platform_device_info sata1_info __initconst = {
+	.parent		= &platform_bus,
+	.name		= "sata-r8a7790",
+	.id		= 1,
+	.res		= sata1_resources,
+	.num_res	= ARRAY_SIZE(sata1_resources),
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* DU (CN10: ARGB0, CN13: LVDS) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
@@ -444,6 +459,8 @@ static void __init lager_add_standard_devices(void)
 				      &vccq_sdhi2_info, sizeof(struct gpio_regulator_config));
 
 	lager_add_camera1_device();
+
+	platform_device_register_full(&sata1_info);
 }
 
 /*
-- 
1.8.5.2
