From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 17 Jun 2014 16:04:51 +0530
Subject: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Message-ID: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ROM code on AM437x does not support writing to L2C-310 power control
register. The L2C driver, however, tries writing to this register for
all revisions >= r3p0.

This leads to a warning dump on boot which leads most users to believe
that L2 cache is non-functional.

Since the problem is understood, and cannot be addressed through software,
replace the warning with a pr_info() while maintaining the WARN_ON() for
other truly unexpected scenarios.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
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
