From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jul 2012 19:35:39 +0200
Subject: [PATCH 4/16] ARM: Orion: Add arch support needed for I2C via DT.
In-Reply-To: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
Message-ID: <1342805751-18048-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MV64XXX I2C driver needs a clock in order to calculate the baud
rate factors. So add an clk to the clk tree. Also add the base DT
properties for kirkwood devices.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood.dtsi   |   10 ++++++++++
 arch/arm/mach-kirkwood/board-dt.c |    2 ++
 arch/arm/mach-kirkwood/common.c   |    2 ++
 arch/arm/plat-orion/common.c      |    1 +
 4 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index a3350fd..e13d746 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -82,5 +82,15 @@
 			/* set partition map and/or chip-delay in board dts */
 			status = "disabled";
 		};
+
+		i2c at 11000 {
+			compatible = "marvell,mv64xxx-i2c";
+			reg = <0x11000 0x20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <29>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 8f8da5d..24c8fdd 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -28,6 +28,8 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
 
 struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
+	OF_DEV_AUXDATA("marvell,mv64xxx-i2c", 0xf1011000, "mv64xxx_i2c.0",
+		       NULL),
 	{},
 };
 
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 3de2d6d..df8079e 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -17,6 +17,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/clk-provider.h>
 #include <linux/spinlock.h>
+#include <linux/mv643xx_i2c.h>
 #include <net/dsa.h>
 #include <asm/page.h>
 #include <asm/timex.h>
@@ -241,6 +242,7 @@ void __init kirkwood_clk_init(void)
 	orion_clkdev_add("0", "pcie", pex0);
 	orion_clkdev_add("1", "pcie", pex1);
 	orion_clkdev_add(NULL, "kirkwood-i2s", audio);
+	orion_clkdev_add(NULL, MV64XXX_I2C_CTLR_NAME ".0", runit);
 
 	/* Marvell says runit is used by SPI, UART, NAND, TWSI, ...,
 	 * so should never be gated.
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index c179378..d245a87 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -47,6 +47,7 @@ void __init orion_clkdev_init(struct clk *tclk)
 	orion_clkdev_add(NULL, MV643XX_ETH_NAME ".2", tclk);
 	orion_clkdev_add(NULL, MV643XX_ETH_NAME ".3", tclk);
 	orion_clkdev_add(NULL, "orion_wdt", tclk);
+	orion_clkdev_add(NULL, MV64XXX_I2C_CTLR_NAME ".0", tclk);
 }
 
 /* Fill in the resources structure and link it into the platform
-- 
1.7.10
