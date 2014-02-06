From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:19:03 +0900
Subject: [PATCH 11/21] ARM: shmobile: koelsch: Add SATA0 support
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <4fc0a0b93f178c0b077201ab70a53e1be6a69054.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This adds SATA0 support to Koelsch board.
SATA1 is not available since its pinmux
configuration is fixed to PCIe.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index de7cc64..2ab5c75 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -148,6 +148,21 @@ static const struct gpio_keys_platform_data koelsch_keys_pdata __initconst = {
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
 
+/* SATA0 */
+static const struct resource sata0_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee300000, 0x2000),
+	DEFINE_RES_IRQ(gic_spi(105)),
+};
+
+static const struct platform_device_info sata0_info __initconst = {
+	.parent		= &platform_bus,
+	.name		= "sata-r8a7791",
+	.id		= 0,
+	.res		= sata0_resources,
+	.num_res	= ARRAY_SIZE(sata0_resources),
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
 static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	/* DU */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7791", "pfc-r8a7791",
@@ -192,6 +207,8 @@ static void __init koelsch_add_standard_devices(void)
 				      sizeof(koelsch_keys_pdata));
 
 	koelsch_add_du_device();
+
+	platform_device_register_full(&sata0_info);
 }
 
 /*
-- 
1.8.5.2
