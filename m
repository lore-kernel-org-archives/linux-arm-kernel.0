From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 07 Mar 2012 19:38:40 -0700
Subject: [PATCH 11/12] ARM: OMAP3: hwmod data: add IVA hard reset lines,
 main clock, clockdomain
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Message-ID: <20120308023839.8205.19425.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IVA hwmod data is missing some fields that cause the following
warning on boot:

[    0.118011] omap_hwmod: iva: cannot be enabled for reset (3)

Fix by encoding the IP block's main functional clock, reset lines, and
clockdomain.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c05a445..1bf1888 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -98,9 +98,19 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
 };
 
 /* IVA2 (IVA2) */
+static struct omap_hwmod_rst_info omap3xxx_iva_resets[] = {
+	{ .name = "logic", .rst_shift = 0 },
+	{ .name = "seq0", .rst_shift = 1 },
+	{ .name = "seq1", .rst_shift = 2 },
+};
+
 static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.name		= "iva",
 	.class		= &iva_hwmod_class,
+	.clkdm_name	= "iva2_clkdm",
+	.rst_lines	= omap3xxx_iva_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_iva_resets),
+	.main_clk	= "iva2_ck",
 };
 
 /* timer class */
