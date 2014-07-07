From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon,  7 Jul 2014 11:41:27 +0200
Subject: [PATCH v4 2/2] ARM: i.MX53: globally disable supervisor protect
In-Reply-To: <1404726087-2069-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1404726087-2069-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1404726087-2069-2-git-send-email-s.trumtrar@pengutronix.de>
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
documented. So, until documentation for this is openly available, turn off the
supervisor protection because it cripples the hardware.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/mach-imx/mach-imx53.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 2bad387..1fbd77d 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -26,9 +26,13 @@
 
 static void __init imx53_dt_init(void)
 {
+	const char *aips_compatible = "fsl,imx53-aipstz";
+
 	mxc_arch_reset_init_dt();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	imx_aips_allow_unprivileged_access(aips_compatible);
 }
 
 static const char *imx53_dt_board_compat[] __initconst = {
-- 
2.0.0
