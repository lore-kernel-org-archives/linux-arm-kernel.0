From: jason77.wang@gmail.com (Jason Wang)
Date: Wed, 14 Jul 2010 21:24:53 +0800
Subject: [PATCH V2 2/3] mx51: add imx_keypad device definition for mx51
	platforms
In-Reply-To: <1279113894-10316-2-git-send-email-jason77.wang@gmail.com>
References: <1279113894-10316-1-git-send-email-jason77.wang@gmail.com>
	<1279113894-10316-2-git-send-email-jason77.wang@gmail.com>
Message-ID: <1279113894-10316-3-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add imx_keypad platform device definition and clocks for mx51
platforms.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/mach-mx5/clock-mx51.c |    5 +++++
 arch/arm/mach-mx5/devices.c    |   19 +++++++++++++++++++
 arch/arm/mach-mx5/devices.h    |    1 +
 3 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index d9f612d..60fced6 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -758,6 +758,10 @@ static struct clk gpt_32k_clk = {
 	.parent = &ckil_clk,
 };
 
+static struct clk kpp_clk = {
+	.id = 0,
+};
+
 #define DEFINE_CLOCK(name, i, er, es, gr, sr, p, s)	\
 	static struct clk name = {			\
 		.id		= i,			\
@@ -821,6 +825,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
+	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 7130449..2aa4ea0 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -168,6 +168,25 @@ struct platform_device mxc_wdt = {
 	.resource = mxc_wdt_resources,
 };
 
+static struct resource mxc_kpp_resources[] = {
+	{
+		.start = MX51_MXC_INT_KPP,
+		.end = MX51_MXC_INT_KPP,
+		.flags = IORESOURCE_IRQ,
+	} , {
+		.start = MX51_KPP_BASE_ADDR,
+		.end = MX51_KPP_BASE_ADDR + 0x8 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device mxc_keypad_device = {
+	.name = "imx-keypad",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(mxc_kpp_resources),
+	.resource = mxc_kpp_resources,
+};
+
 static struct mxc_gpio_port mxc_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index a853933..e509cfa 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -9,3 +9,4 @@ extern struct platform_device mxc_wdt;
 extern struct platform_device mxc_i2c_device0;
 extern struct platform_device mxc_i2c_device1;
 extern struct platform_device mxc_hsi2c_device;
+extern struct platform_device mxc_keypad_device;
-- 
1.5.6.5
