From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 Jul 2014 18:43:46 +0530
Subject: [PATCH v2] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Message-ID: <d081bdbeebec0e7f2a292a11513f96375aa35bd4.1405343188.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On OMAP SOCs using PL310 controllers, power_ctrl register is not
accessible from non-secure software even on PL310 versions which
support it. The secure code takes care of setting it up correctly
and power transitions are proven on these devices.

For example, AM437x has L2C-310 version r3p3 and ROM code on that
device does not support writing to L2C-310 power control register.
The L2C driver, however, tries writing to this register for all
revisions >= r3p0.

This leads to a warning dump on boot which leads most users to believe
that L2 cache is non-functional.

Since the problem is understood, and cannot be addressed through
software, replace the warning with a pr_info() while maintaining the
WARN_ON() for other truly unexpected scenarios.

Reported-by: Nishanth Menon <nm@ti.com>
Tested-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
Only description updated since v1

 arch/arm/mach-omap2/omap4-common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 326cd98..9139729 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -188,6 +188,10 @@ static void omap4_l2c310_write_sec(unsigned long val, unsigned reg)
 		smc_op = OMAP4_MON_L2X0_PREFETCH_INDEX;
 		break;
 
+	case L310_POWER_CTRL:
+		pr_info_once("OMAP L2C310: ROM does not support power control setting\n");
+		return;
+
 	default:
 		WARN_ONCE(1, "OMAP L2C310: ignoring write to reg 0x%x\n", reg);
 		return;
-- 
1.7.10.1
