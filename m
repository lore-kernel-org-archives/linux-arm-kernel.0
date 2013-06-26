From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Jun 2013 17:40:39 +0900
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7790: add thermal driver support
In-Reply-To: <1372236040-16737-1-git-send-email-horms+renesas@verge.net.au>
References: <1372236040-16737-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1372236040-16737-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You can get current thermal by
> cat /sys/class/thermal/thermal_zone?/temp

Based on similar work for the r8a73a4 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 28f9475..06c720f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -149,6 +149,17 @@ static struct resource irqc0_resources[] __initdata = {
 					  &irqc##idx##_data,		\
 					  sizeof(struct renesas_irqc_config))
 
+static struct resource thermal_resources[] __initdata = {
+	DEFINE_RES_MEM(0xe61f0000, 0x14),
+	DEFINE_RES_MEM(0xe61f0100, 0x38),
+	DEFINE_RES_IRQ(gic_spi(69)),
+};
+
+#define r8a7790_register_thermal()					\
+	platform_device_register_simple("rcar_thermal", -1,		\
+					thermal_resources,		\
+					ARRAY_SIZE(thermal_resources))
+
 void __init r8a7790_add_standard_devices(void)
 {
 	r8a7790_register_scif(SCIFA0);
@@ -162,6 +173,7 @@ void __init r8a7790_add_standard_devices(void)
 	r8a7790_register_scif(HSCIF0);
 	r8a7790_register_scif(HSCIF1);
 	r8a7790_register_irqc(0);
+	r8a7790_register_thermal();
 }
 
 void __init r8a7790_timer_init(void)
-- 
1.8.2.1
