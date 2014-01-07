From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 7 Jan 2014 09:47:08 -0600
Subject: [PATCH] ARM: socfpga: Optimize L2 cache settings
Message-ID: <1389109628-29868-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The L2 cache settings the SOCFPGA platform should have data and
instruction prefetch, along with the share override bits set.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/mach-socfpga/socfpga.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index e8fb821..87164f8 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -169,7 +169,11 @@ static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
 
 static void __init socfpga_cyclone5_init(void)
 {
-	l2x0_of_init(0, ~0UL);
+	u32 aux_ctrl = 0;
+	aux_ctrl |= (1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
+			(1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
+			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT);
+	l2x0_of_init(aux_ctrl, ~0UL);
 	of_platform_populate(NULL, of_default_bus_match_table,
 		socfpga_auxdata_lookup, NULL);
 }
-- 
1.7.9.5
