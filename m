From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 27 Feb 2012 16:07:14 +0000
Subject: [PATCH 2/2 v2] arm: kirkwood: convert uart0 to devicetree.
In-Reply-To: <cover.1330358323.git.jason@lakedaemon.net>
References: <cover.1330358323.git.jason@lakedaemon.net>
Message-ID: <dbc3c26c0a6f45a56cb96be29f9503c0b7714ef0.1330358323.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This uart is the primary console for the dreamplug.  Removed
kirkwood_uart0_init() call from board-dt.c.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Changes from v1

    - moved serial config from kirkwood.dtsi to kirkwood-dreamplug.dts as
      suggested by Arnd Bergman.

 arch/arm/boot/dts/kirkwood-dreamplug.dts |    7 +++++++
 arch/arm/mach-kirkwood/board-dt.c        |    2 --
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 0424d99..8a5dff8 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -15,4 +15,11 @@
 		bootargs = "console=ttyS0,115200n8 earlyprintk";
 	};
 
+	serial at f1012000 {
+		compatible = "ns16550a";
+		reg = <0xf1012000 0xff>;
+		reg-shift = <2>;
+		interrupts = <33>;
+		clock-frequency = <200000000>;
+	};
 };
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 76392af..fbe6405 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -140,8 +140,6 @@ static void __init dreamplug_init(void)
 	 */
 	kirkwood_mpp_conf(dreamplug_mpp_config);
 
-	kirkwood_uart0_init();
-
 	spi_register_board_info(dreamplug_spi_slave_info,
 				ARRAY_SIZE(dreamplug_spi_slave_info));
 	kirkwood_spi_init();
-- 
1.7.3.4
