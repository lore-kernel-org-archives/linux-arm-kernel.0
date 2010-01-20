From: olof@lixom.net (Olof Johansson)
Date: Wed, 20 Jan 2010 22:39:29 +0000
Subject: [PATCH] omap: Enable GPMC clock in gpmc_init
Message-ID: <mailman.157.1264039704.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't assume that gpmc_l3_clk is on, enable it before touching
configuration registers.

Note that the current code assumes that this clock is always
enabled. We are already setting smart idle and L3 autogating
for GPMC clock in gpmc_init.

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index bd8cb59..3f1334f 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -534,6 +534,8 @@ void __init gpmc_init(void)
 		BUG();
 	}
 
+	clk_enable(gpmc_l3_clk);
+
 	l = gpmc_read_reg(GPMC_REVISION);
 	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 	/* Set smart idle mode and automatic L3 clock gating */

--MfFXiAuoTsnnDAfZ--
