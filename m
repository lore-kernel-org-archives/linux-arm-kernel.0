From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 15:08:50 +0100
Subject: [PATCH 3/3] ARM: Kirkwood: Convert NSA310 I2C to device tree
In-Reply-To: <1356703730-4926-1-git-send-email-andrew@lunn.ch>
References: <1356703730-4926-1-git-send-email-andrew@lunn.ch>
Message-ID: <1356703730-4926-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a sub-node into the I2C node to represent the adt7476 device.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-nsa310.dts |    5 +++++
 arch/arm/mach-kirkwood/board-nsa310.c |    6 ------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 85cce36..dbb3551 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -29,6 +29,11 @@
 
 		i2c at 11000 {
 			status = "okay";
+
+			adt7476: adt7476a at 2e {
+				compatible = "adt7476";
+				reg = <0x2e>;
+			};
 		};
 
 		nand at 3000000 {
diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
index 7a56273..1bd328d 100644
--- a/arch/arm/mach-kirkwood/board-nsa310.c
+++ b/arch/arm/mach-kirkwood/board-nsa310.c
@@ -38,10 +38,6 @@ static unsigned int nsa310_mpp_config[] __initdata = {
 	0
 };
 
-static struct i2c_board_info __initdata nsa310_i2c_info[] = {
-	{ I2C_BOARD_INFO("adt7476", 0x2e) },
-};
-
 void __init nsa310_init(void)
 {
 	u32 dev, rev;
@@ -49,8 +45,6 @@ void __init nsa310_init(void)
 	kirkwood_mpp_conf(nsa310_mpp_config);
 
 	kirkwood_pcie_id(&dev, &rev);
-
-	i2c_register_board_info(0, ARRAY_AND_SIZE(nsa310_i2c_info));
 }
 
 static int __init nsa310_pci_init(void)
-- 
1.7.10.4
