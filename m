From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 25 Sep 2012 02:02:18 +0200
Subject: [PATCH 6/6] ARM: dove: Add crypto engine to DT
In-Reply-To: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1348531338-16624-7-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of DT support for the crypto engine on dove and remove
the obsolete init call.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi |    9 +++++++++
 arch/arm/mach-dove/common.c |    1 -
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index c59c529..5a00022 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -145,5 +145,14 @@
 			nr-ports = <1>;
 			status = "disabled";
 		};
+
+		crypto: crypto at 30000 {
+			compatible = "marvell,orion-crypto";
+			reg = <0x30000 0x10000>,
+			      <0xc8000000 0x800>;
+			reg-names = "regs", "sram";
+			interrupts = <31>;
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index ffec26f..f723fe1 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -416,7 +416,6 @@ static void __init dove_dt_init(void)
 	dove_ehci0_init();
 	dove_ehci1_init();
 	dove_pcie_init(1, 1);
-	dove_crypto_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     dove_auxdata_lookup, NULL);
-- 
1.7.10.4
