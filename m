From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 11 May 2011 14:07:40 +0300
Subject: [GIT PULL 3/3] ARM: tegra: trimslice: enable USB ports
In-Reply-To: <cover.1305105580.git.mike@compulab.co.il>
References: <cover.1305105580.git.mike@compulab.co.il>
Message-ID: <ca6270fc5c324f8442be215d9e76db01246fb604.1305105580.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-tegra/board-trimslice-pinmux.c |    2 +-
 arch/arm/mach-tegra/board-trimslice.c        |   40 ++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
index 13534fa..301af22 100644
--- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
+++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
@@ -126,7 +126,7 @@ static __initdata struct tegra_pingroup_config trimslice_pinmux[] = {
 	{TEGRA_PINGROUP_SPIH,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_UAA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_UAB,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UAC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UAC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_UAD,   TEGRA_MUX_IRDA,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_UCA,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_UCB,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index a19e90b..827f98b 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/i2c-tegra.h>
+#include <linux/platform_data/tegra_usb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -32,6 +33,8 @@
 
 #include <mach/iomap.h>
 #include <mach/sdhci.h>
+#include <mach/usb_phy.h>
+#include <mach/gpio.h>
 
 #include "board.h"
 #include "clock.h"
@@ -123,6 +126,42 @@ static void trimslice_i2c_init(void)
 				ARRAY_SIZE(trimslice_i2c3_board_info));
 }
 
+struct tegra_ulpi_config ehci2_phy_config = {
+	.reset_gpio = TEGRA_GPIO_PV0,
+	.clk = "cdev2",
+};
+
+static struct tegra_ehci_platform_data ehci_ulpi_data = {
+	.operating_mode = TEGRA_USB_HOST,
+	.phy_config = &ehci2_phy_config,
+};
+
+static struct tegra_ehci_platform_data ehci_utmi_data = {
+	.operating_mode = TEGRA_USB_HOST,
+};
+
+static void trimslice_usb_init(void)
+{
+	int err;
+
+	tegra_ehci3_device.dev.platform_data = &ehci_utmi_data;
+	platform_device_register(&tegra_ehci3_device);
+
+	tegra_gpio_enable(TEGRA_GPIO_PV0);
+	tegra_ehci2_device.dev.platform_data = &ehci_ulpi_data;
+	platform_device_register(&tegra_ehci2_device);
+
+	err = gpio_request_one(TEGRA_GPIO_PV2, GPIOF_OUT_INIT_HIGH, "usb1mode");
+	if (err) {
+		pr_err("TrimSlice: failed to obtain USB1 mode gpio: %d\n", err);
+		return;
+	}
+
+	tegra_gpio_enable(TEGRA_GPIO_PV2);
+	tegra_ehci1_device.dev.platform_data = &ehci_utmi_data;
+	platform_device_register(&tegra_ehci1_device);
+}
+
 static void __init tegra_trimslice_fixup(struct machine_desc *desc,
 	struct tag *tags, char **cmdline, struct meminfo *mi)
 {
@@ -164,6 +203,7 @@ static void __init tegra_trimslice_init(void)
 	platform_add_devices(trimslice_devices, ARRAY_SIZE(trimslice_devices));
 
 	trimslice_i2c_init();
+	trimslice_usb_init();
 }
 
 MACHINE_START(TRIMSLICE, "trimslice")
-- 
1.7.3.1
