From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 17 Sep 2015 06:59:54 +0200
Subject: [PATCH v3 15/26] ARM: pxa: magician: Fix redundant GPIO request for
 pxaficp_ir
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Message-ID: <55FA48CA.6000807@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxaficp_ir driver requests a power GPIO for the transceiver internally,
so a global GPIO allocation in magician_init() is redundant.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 86d395d..91b5ed0 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -189,6 +189,7 @@ static unsigned long magician_pin_config[] __initdata = {
 static struct pxaficp_platform_data magician_ficp_info = {
 	.gpio_pwdown		= GPIO83_MAGICIAN_nIR_EN,
 	.transceiver_cap	= IR_SIRMODE | IR_OFF,
+	.gpio_pwdown_inverted	= 0,
 };
 
 /*
@@ -854,7 +855,6 @@ static struct gpio magician_global_gpios[] = {
 	{ GPIO106_MAGICIAN_LCD_DCDC_NRESET, GPIOF_OUT_INIT_LOW, "LCD DCDC nreset" },
 	{ GPIO104_MAGICIAN_LCD_VOFF_EN, GPIOF_OUT_INIT_LOW, "LCD VOFF enable" },
 	{ GPIO105_MAGICIAN_LCD_VON_EN, GPIOF_OUT_INIT_LOW, "LCD VON enable" },
-	{ GPIO83_MAGICIAN_nIR_EN, GPIOF_OUT_INIT_HIGH, "nIR_EN" },
 };
 
 static void __init magician_init(void)
-- 
1.7.12.1
