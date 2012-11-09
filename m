From: horms@verge.net.au (Simon Horman)
Date: Fri,  9 Nov 2012 16:31:40 +0900
Subject: [PATCH 1/7] ARM: shmobile: marzen: add USB phy support
In-Reply-To: <1352446306-19945-1-git-send-email-horms@verge.net.au>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
Message-ID: <1352446306-19945-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/marzen_defconfig     |    3 ++-
 arch/arm/mach-shmobile/board-marzen.c |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 5b8215f..8a861b7 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -78,7 +78,8 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_SSB=y
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB=y
+CONFIG_USB_RCAR_PHY=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
 CONFIG_UIO=y
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 69f7f46..74c7f0b 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -144,11 +144,32 @@ static struct platform_device hspi_device = {
 	.num_resources	= ARRAY_SIZE(hspi_resources),
 };
 
+/* USB PHY */
+static struct resource usb_phy_resources[] = {
+	[0] = {
+		.start		= 0xffe70000,
+		.end		= 0xffe70900 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= 0xfff70000,
+		.end		= 0xfff70900 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device usb_phy_device = {
+	.name		= "rcar_usb_phy",
+	.resource	= usb_phy_resources,
+	.num_resources	= ARRAY_SIZE(usb_phy_resources),
+};
+
 static struct platform_device *marzen_devices[] __initdata = {
 	&eth_device,
 	&sdhi0_device,
 	&thermal_device,
 	&hspi_device,
+	&usb_phy_device,
 };
 
 static void __init marzen_init(void)
-- 
1.7.10.4
