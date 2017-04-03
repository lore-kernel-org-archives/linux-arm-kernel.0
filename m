From: martin@kaiser.cx (Martin Kaiser)
Date: Mon,  3 Apr 2017 21:47:05 +0200
Subject: [PATCH 2/2 v2] ARM: i.MX25: globally disable supervisor protect
In-Reply-To: <1491248825-23041-1-git-send-email-martin@kaiser.cx>
References: <1485890402-22974-1-git-send-email-martin@kaiser.cx>
 <1491248825-23041-1-git-send-email-martin@kaiser.cx>
Message-ID: <1491248825-23041-2-git-send-email-martin@kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The problem described in 6befda9a272b98bfb1dc772efc3564644cbfb270
for the i.MX53 platform applies to i.MX25 as well.

E.g. CSPI1+SDMA and SSI1+SDMA are not working with the default AIPS
configuration. Modifiy the AIPS configuration to allow access to the bus
by SDMA and peripherals.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
   rebased against latest linux-next
   re-sending both patches, it seems they got lost along the way

 arch/arm/mach-imx/mach-imx25.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx25.c b/arch/arm/mach-imx/mach-imx25.c
index 32dcb5e..353b86e 100644
--- a/arch/arm/mach-imx/mach-imx25.c
+++ b/arch/arm/mach-imx/mach-imx25.c
@@ -23,6 +23,11 @@ static void __init imx25_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX25);
 }
 
+static void __init imx25_dt_init(void)
+{
+	imx_aips_allow_unprivileged_access("fsl,imx25-aips");
+}
+
 static void __init mx25_init_irq(void)
 {
 	struct device_node *np;
@@ -41,6 +46,7 @@ static const char * const imx25_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
 	.init_early	= imx25_init_early,
+	.init_machine	= imx25_dt_init,
 	.init_late      = imx25_pm_init,
 	.init_irq	= mx25_init_irq,
 	.dt_compat	= imx25_dt_board_compat,
-- 
2.1.4
