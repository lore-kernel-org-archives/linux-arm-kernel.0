From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  5 Jul 2011 17:08:31 +0400
Subject: [PATCH 05/15] ARM: pxa/lubbock: switch to using lubbock_usb_xceiv
	transceiver
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309871321-11305-6-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/lubbock.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index e10ddb8..4dcc687 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -198,16 +198,6 @@ device_initcall(lubbock_irq_device_init);
 
 #endif
 
-static int lubbock_udc_is_connected(void)
-{
-	return (LUB_MISC_RD & (1 << 9)) == 0;
-}
-
-static struct pxa2xx_udc_mach_info udc_info __initdata = {
-	.udc_is_connected	= lubbock_udc_is_connected,
-	// no D+ pullup; lubbock can't connect/disconnect in software
-};
-
 static struct resource sa1111_resources[] = {
 	[0] = {
 		.start	= 0x10000000,
@@ -379,11 +369,17 @@ static struct platform_device lubbock_flash_device[2] = {
 	},
 };
 
+static struct platform_device lubbock_usb_xceiv = {
+	.name	= "lubbock_usb_xceiv",
+	.id	= -1,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&sa1111_device,
 	&smc91x_device,
 	&lubbock_flash_device[0],
 	&lubbock_flash_device[1],
+	&lubbock_usb_xceiv,
 };
 
 static struct pxafb_mode_info sharp_lm8v31_mode = {
@@ -511,7 +507,6 @@ static void __init lubbock_init(void)
 	pxa_set_stuart_info(NULL);
 
 	clk_add_alias("SA1111_CLK", NULL, "GPIO11_CLK", NULL);
-	pxa_set_udc_info(&udc_info);
 	pxa_set_fb_info(NULL, &sharp_lm8v31);
 	pxa_set_mci_info(&lubbock_mci_platform_data);
 	pxa_set_ficp_info(&lubbock_ficp_platform_data);
-- 
1.7.5.4
