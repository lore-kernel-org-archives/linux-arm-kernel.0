From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 25 Jun 2016 08:26:15 +0300
Subject: [PATCH] ARM: i.MX: Disable supervisor protect for i.MX51
Message-ID: <1466832375-32071-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most peripherals on the i.MX51 have an Off-Platform Peripheral Access
Control Register (OPACR) in which the access rights (together with the
MPROT registers) can be declared.
However, this does not seem to work for example for SSI1+SDMA, because the
supervisor bit is not set for the SDMA unit.
A similar problem was described in the patch for i.MX53 CPU
(ARM: i.MX53: globally disable supervisor protect), and the same solution
is applicable for i.MX51 CPU.
Patch has tested on custom board based on Digi CCMX-51 module (i.MX51).

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
DTS-part of this patch, I'll send a bit later.
Another mention of this problem: https://community.nxp.com/thread/333710
---
 arch/arm/mach-imx/mach-imx51.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index 10a82a4..1e91740 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -54,6 +54,8 @@ static void __init imx51_dt_init(void)
 	imx_src_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	imx_aips_allow_unprivileged_access("fsl,imx51-aipstz");
 }
 
 static void __init imx51_init_late(void)
-- 
2.4.9
