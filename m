From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 06 Sep 2016 17:38:09 +0100
Subject: [PATCH 8/8] ARM: pxa/lubbock: add pcmcia clock
In-Reply-To: <20160906163711.GB1041@n2100.armlinux.org.uk>
References: <20160906163711.GB1041@n2100.armlinux.org.uk>
Message-ID: <E1bhJNx-0008DR-2l@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the required PCMCIA clock for the SA1111 "1800" device.  This clock
is used to compute timing information for the PCMCIA interface in the
SoC device, rather than the SA1111.  Hence, the provision of this clock
is a convenience for the driver and does not reflect the hardware, so
this must not be copied into DT.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-pxa/lubbock.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 7245f3359564..d6159f8ef0c2 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -137,6 +137,18 @@ static struct pxa2xx_udc_mach_info udc_info __initdata = {
 	// no D+ pullup; lubbock can't connect/disconnect in software
 };
 
+static void lubbock_init_pcmcia(void)
+{
+	struct clk *clk;
+
+	/* Add an alias for the SA1111 PCMCIA clock */
+	clk = clk_get_sys("pxa2xx-pcmcia", NULL);
+	if (!IS_ERR(clk)) {
+		clkdev_create(clk, NULL, "1800");
+		clk_put(clk);
+	}
+}
+
 static struct resource sa1111_resources[] = {
 	[0] = {
 		.start	= 0x10000000,
@@ -467,6 +479,8 @@ static void __init lubbock_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
+	lubbock_init_pcmcia();
+
 	clk_add_alias("SA1111_CLK", NULL, "GPIO11_CLK", NULL);
 	pxa_set_udc_info(&udc_info);
 	pxa_set_fb_info(NULL, &sharp_lm8v31);
-- 
2.1.0
