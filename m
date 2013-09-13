From: r64343@freescale.com (Jason Liu)
Date: Fri, 13 Sep 2013 15:48:52 +0800
Subject: [PATCH] ARM: imx: i.mx6d/q: disable the double linefill feature of
 PL310
Message-ID: <1379058532-19843-1-git-send-email-r64343@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L2 cache controller(PL310) version on the i.MX6D/Q is r3p1-50rel0
The L2 cache controller(PL310) version on the i.MX6DL/SOLO/SL is r3p2
But according to ARM PL310 errata: 752271
ID: 752271: Double linefill feature can cause data corruption
Fault Status: Present in: r3p0, r3p1, r3p1-50rel0. Fixed in r3p2
Workaround: The only workaround to this erratum is to disable the
double linefill feature. This is the default behavior.

without this patch, you will meet the following error when run the
memtester application at: http://pyropus.ca/software/memtester/

FAILURE: 0x00100000 != 0x00200000 at offset 0x01365664.
FAILURE: 0x00100000 != 0x00200000 at offset 0x01365668.
FAILURE: 0x00100000 != 0x00200000 at offset 0x0136566c.
FAILURE: 0x00100000 != 0x00200000 at offset 0x01365670.
FAILURE: 0x00100000 != 0x00200000 at offset 0x01365674.
FAILURE: 0x00100000 != 0x00200000 at offset 0x01365678.
FAILURE: 0x00100000 != 0x00200000 at offset 0x0136567c.

Signed-off-by: Jason Liu <r64343@freescale.com>
---
 arch/arm/mach-imx/system.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 64ff37e..0c3fa48 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -116,7 +116,18 @@ void __init imx_init_l2cache(void)
 
 	/* Configure the L2 PREFETCH and POWER registers */
 	val = readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
-	val |= 0x70800000;
+	val |= 0x30000000;
+	/*
+	 * The L2 cache controller(PL310) version on the i.MX6D/Q is r3p1-50rel0
+	 * The L2 cache controller(PL310) version on the i.MX6DL/SOLO/SL is r3p2
+	 * But according to ARM PL310 errata: 752271
+	 * ID: 752271: Double linefill feature can cause data corruption
+	 * Fault Status: Present in: r3p0, r3p1, r3p1-50rel0. Fixed in r3p2
+	 * Workaround: The only workaround to this erratum is to disable the
+	 * double linefill feature. This is the default behavior.
+	 */
+	if (!of_machine_is_compatible("fsl,imx6q"))
+		val |= 0x40800000;
 	writel_relaxed(val, l2x0_base + L2X0_PREFETCH_CTRL);
 	val = L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN;
 	writel_relaxed(val, l2x0_base + L2X0_POWER_CTRL);
-- 
1.7.10.4
