From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:03:58 +0900
Subject: [PATCH 11/11] ARM: shmobile: genmai: Enable r7s72100-ether
In-Reply-To: <cover.1392276547.git.horms+renesas@verge.net.au>
References: <cover.1392276547.git.horms+renesas@verge.net.au>
Message-ID: <03fec7dee502d43114f384a1588ce84a3c9bf38d.1392276547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-genmai.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
index c406461..e240980 100644
--- a/arch/arm/mach-shmobile/board-genmai.c
+++ b/arch/arm/mach-shmobile/board-genmai.c
@@ -20,6 +20,7 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/sh_eth.h>
 #include <linux/spi/rspi.h>
 #include <linux/spi/spi.h>
 #include <mach/common.h>
@@ -28,6 +29,20 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* Ether */
+static const struct sh_eth_plat_data ether_pdata __initconst = {
+	.phy			= 0x00, /* PD60610 */
+	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
+	.phy_interface		= PHY_INTERFACE_MODE_MII,
+	.no_ether_link		= 1
+};
+
+static const struct resource ether_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe8203000, 0x800),
+	DEFINE_RES_MEM(0xe8204800, 0x200),
+	DEFINE_RES_IRQ(gic_iid(359)),
+};
+
 /* RSPI */
 #define RSPI_RESOURCE(idx, baseaddr, irq)				\
 static const struct resource rspi##idx##_resources[] __initconst = {	\
@@ -67,6 +82,11 @@ static void __init genmai_add_standard_devices(void)
 	r7s72100_clock_init();
 	r7s72100_add_dt_devices();
 
+	platform_device_register_resndata(&platform_bus, "r7s72100-ether", -1,
+					  ether_resources,
+					  ARRAY_SIZE(ether_resources),
+					  &ether_pdata, sizeof(ether_pdata));
+
 	r7s72100_register_rspi(0);
 	r7s72100_register_rspi(1);
 	r7s72100_register_rspi(2);
-- 
1.8.5.2
