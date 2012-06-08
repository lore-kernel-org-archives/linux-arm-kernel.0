From: andrew@lunn.ch (Andrew Lunn)
Date: Fri,  8 Jun 2012 16:09:42 +0200
Subject: [PATCH] ARM: Kirkwood: Fix crash when neither NAND nor SPI
Message-ID: <1339164583-11596-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both NAND and SPI make use of the RUNIT clk. However, if neither NAND
nor SPI is used in the system, RUNIT clock gets turned off, and the
SoC hard locks. It appears something else in the SoC, which is not
documented, is also using RUNIT. So prepare and enable RUNIT clock in
kirkwood_clk_init().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 25fb3fd..97f7d36 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -238,6 +238,10 @@ void __init kirkwood_clk_init(void)
 	orion_clkdev_add("0", "pcie", pex0);
 	orion_clkdev_add("1", "pcie", pex1);
 	orion_clkdev_add(NULL, "kirkwood-i2s", audio);
+
+	/* Something other than SPI and NAND needs runit, so make sure
+	   it never gets turned off. */
+	clk_prepare_enable(runit);
 }
 
 /*****************************************************************************
-- 
1.7.10
