From: r64343@freescale.com (Jason Liu)
Date: Mon, 16 Sep 2013 09:29:03 +0800
Subject: [PATCH v2 1/1] ARM: imx: i.mx6d/q: disable the double linefill
 feature of PL310
Message-ID: <1379294943-15664-1-git-send-email-r64343@freescale.com>
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

Signed-off-by: Jason Liu <r64343@freescale.com>

---
V2:
- disable the L2 doulbe linefill explicitly on i.MX6Q by using &= mask
- using the cpu_is_imx6q() instead of checking through DT
---
 arch/arm/mach-imx/system.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 64ff37e..80c177c 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -117,6 +117,17 @@ void __init imx_init_l2cache(void)
 	/* Configure the L2 PREFETCH and POWER registers */
 	val = readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
 	val |= 0x70800000;
+	/*
+	 * The L2 cache controller(PL310) version on the i.MX6D/Q is r3p1-50rel0
+	 * The L2 cache controller(PL310) version on the i.MX6DL/SOLO/SL is r3p2
+	 * But according to ARM PL310 errata: 752271
+	 * ID: 752271: Double linefill feature can cause data corruption
+	 * Fault Status: Present in: r3p0, r3p1, r3p1-50rel0. Fixed in r3p2
+	 * Workaround: The only workaround to this erratum is to disable the
+	 * double linefill feature. This is the default behavior.
+	 */
+	if (cpu_is_imx6q())
+		val &= ~(1 << 30 | 1 << 23);
 	writel_relaxed(val, l2x0_base + L2X0_PREFETCH_CTRL);
 	val = L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN;
 	writel_relaxed(val, l2x0_base + L2X0_POWER_CTRL);
-- 
1.7.10.4
