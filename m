From: horms@verge.net.au (Simon Horman)
Date: Wed,  5 Sep 2012 17:20:44 +0900
Subject: [PATCH 5/5] ARM: shmobile: marzen: enable thermal sensor
In-Reply-To: <1346833244-30432-1-git-send-email-horms@verge.net.au>
References: <1346833244-30432-1-git-send-email-horms@verge.net.au>
Message-ID: <1346833244-30432-6-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Marzen board can measure its thermal by this patch.
	cat /sys/class/thermal/thermal_zoneX/temp

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/marzen_defconfig     |    2 ++
 arch/arm/mach-shmobile/board-marzen.c |   16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index cd2dc21..b46914f 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -71,6 +71,8 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_RCAR_THERMAL=y
 CONFIG_SSB=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index cbf9f25..2e884b6 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -111,9 +111,25 @@ static struct platform_device sdhi0_device = {
 	}
 };
 
+/* Thermal */
+static struct resource thermal_resources[] = {
+	[0] = {
+		.start		= 0xFFC48000,
+		.end		= 0xFFC48038 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device thermal_device = {
+	.name		= "rcar_thermal",
+	.resource	= thermal_resources,
+	.num_resources	= ARRAY_SIZE(thermal_resources),
+};
+
 static struct platform_device *marzen_devices[] __initdata = {
 	&eth_device,
 	&sdhi0_device,
+	&thermal_device,
 };
 
 static void __init marzen_init(void)
-- 
1.7.10.4
