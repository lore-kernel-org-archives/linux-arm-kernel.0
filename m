From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 24 Jun 2014 12:20:29 +0200
Subject: [PATCH] ARM: imx53: globally disable supervisor protect
Message-ID: <1403605229-29623-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most peripherals on the i.MX53 have an
	Off-Platform Peripheral Access Control Register (OPACR)
in which the access rights (together with the MPROT registers) can be declared.
However, this does not seem to work for example for SSI1+SDMA, because the
supervisor bit is not set for the SDMA unit.
It does work for SSI2, the QSB for example uses SSI2 for its audio. But SSI2 only
works because it does NOT have an OPACR.

The right solution would be to fix the access rights for the SDMA, but the unit
responsible for this is the Central Security Unit (CSU), which of course is NOT
documented. So, until documentation for this is openly available, turn of the
supervisor protection, because it cripples the hardware.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/mach-imx/mach-imx53.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 2bad387..4d3e750 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -29,6 +29,8 @@ static void __init imx53_dt_init(void)
 	mxc_arch_reset_init_dt();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	imx_set_aips(MX53_IO_ADDRESS(MX53_AIPS2_BASE_ADDR));
 }
 
 static const char *imx53_dt_board_compat[] __initconst = {
-- 
2.0.0
