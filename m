From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Feb 2013 09:29:36 +0900
Subject: [PATCH 2/2 v3] [RFC] ARM: shmobile: r8a7779: Add TMU02 platform device
In-Reply-To: <1361147376-1228-1-git-send-email-horms+renesas@verge.net.au>
References: <1361147376-1228-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1361147376-1228-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is intended primarily to exercise the TMUO2 clock definition
in clock-r8a7779.c. I would appreciate review before I queue it up or
drop it.

With this patch and "ARM: shmobile: r8a7779: Correct TMU clock support
again" in place I see the following tmu related portions of the
bootlog on the Marzen board.

 sh_tmu.0: used for clock events
 sh_tmu.0: used for periodic clock events
 sh_tmu.1: used as clock source
Switching to clocksource sh_tmu.1
sh_tmu sh_tmu.0: kept as earlytimer
sh_tmu sh_tmu.1: kept as earlytimer
sh_tmu sh_tmu.2: used as clock source

Cc: Denis Oliver Kropp <dok@directfb.org>
Cc: Magnus Damm <damm@opensource.se>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 7b4c1eb..3cdb738 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -224,6 +224,36 @@ static struct platform_device tmu01_device = {
 	.num_resources	= ARRAY_SIZE(tmu01_resources),
 };
 
+static struct sh_timer_config tmu02_platform_data = {
+	.name = "TMU02",
+	.channel_offset = 0x1c,
+	.timer_bit = 1,
+	.clocksource_rating = 200,
+};
+
+static struct resource tmu02_resources[] = {
+	[0] = {
+		.name	= "TMU02",
+		.start	= 0xffd80020,
+		.end	= 0xffd81003,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(34),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu02_device = {
+	.name		= "sh_tmu",
+	.id		= 2,
+	.dev = {
+		.platform_data	= &tmu02_platform_data,
+	},
+	.resource	= tmu02_resources,
+	.num_resources	= ARRAY_SIZE(tmu02_resources),
+};
+
 /* I2C */
 static struct resource rcar_i2c0_res[] = {
 	{
@@ -306,6 +336,7 @@ static struct platform_device *r8a7779_early_devices_dt[] __initdata = {
 	&scif5_device,
 	&tmu00_device,
 	&tmu01_device,
+	&tmu02_device,
 };
 
 static struct platform_device *r8a7779_early_devices[] __initdata = {
-- 
1.7.10.4
