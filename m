From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 May 2016 23:07:45 -0300
Subject: [PATCH] Revert "ARM: imx: add cpufreq device for imx6ul" 
Message-ID: <1463710065-2483-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The imx6q-cpufreq does not support mx6ul currently. After running 'reboot'
the following crash is seen:
...
[ 3857.667167] [<c01b2448>] (irq_work_sync) from [<c064ad44>]
(cpufreq_governor_dbs+0x170/0x580)
[ 3857.675713]  r4:00000004 r3:00000001
[ 3857.679384] [<c064abd4>] (cpufreq_governor_dbs) from [<c06480e4>]
(cpufreq_governor+0x64/0x120)
[ 3857.688103]  r10:00000000 r9:dde7a000 r8:c0108044 r7:c1556f80
r6:00000002 r5:ddcea000
[ 3857.696088]  r4:c0d4c5dc
[ 3857.698684] [<c0648080>] (cpufreq_governor) from [<c06493c4>]
(cpufreq_suspend+0x70/0x128)
[ 3857.706967]  r6:c0d4c328 r5:ddcea0dc r4:ddcea000 r3:ddd9c800
[ 3857.712777] [<c0649354>] (cpufreq_suspend) from [<c04da71c>]
(syscore_shutdown+0x4c/0x80)
...

Not registering the cpufreq driver fixes the issue.

This reverts commit 7f7308198f98700be82d123569ea59229a75d3c3.

Cc: <stable@vger.kernel.org> # 4.4.x
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/mach-imx/mach-imx6ul.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index a38b16b..57f174a 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -78,12 +78,6 @@ static void __init imx6ul_init_irq(void)
 	imx6_pm_ccm_init("fsl,imx6ul-ccm");
 }
 
-static void __init imx6ul_init_late(void)
-{
-	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
-		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
-}
-
 static const char * const imx6ul_dt_compat[] __initconst = {
 	"fsl,imx6ul",
 	NULL,
@@ -92,6 +86,5 @@ static const char * const imx6ul_dt_compat[] __initconst = {
 DT_MACHINE_START(IMX6UL, "Freescale i.MX6 Ultralite (Device Tree)")
 	.init_irq	= imx6ul_init_irq,
 	.init_machine	= imx6ul_init_machine,
-	.init_late	= imx6ul_init_late,
 	.dt_compat	= imx6ul_dt_compat,
 MACHINE_END
-- 
1.9.1
