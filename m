From: nm@ti.com (Nishanth Menon)
Date: Fri, 19 Aug 2016 15:47:48 -0500
Subject: [PATCH] ARM: dts: keystone-k2g: Add Message Manager node
Message-ID: <20160819204748.21529-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce the message manager node for the A15 queues on which Linux
runs. The Message Manager is primarily used for communication with
Power Management controller on K2G.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
based on: v4.8-rc1
Bootlog: http://pastebin.ubuntu.com/23071446/ (with CONFIG_MAILBOX,
   CONFIG_TI_MESSAGE_MANAGER enabled on top of keystone_defconfig)
Binding: Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
SoC Datasheet and relevant documentation: http://www.ti.com/product/66ak2g02
Communication Protocol: http://processors.wiki.ti.com/index.php/TISCI

 arch/arm/boot/dts/keystone-k2g.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 3372615b885c..25f5aaa05197 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -93,5 +93,17 @@
 			clock-frequency = <200000000>;
 			status = "disabled";
 		};
+
+		msgmgr: msgmgr at 02a00000 {
+			compatible = "ti,k2g-message-manager";
+			#mbox-cells = <2>;
+			reg-names = "queue_proxy_region",
+				    "queue_state_debug_region";
+			reg = <0x02a00000 0x400000>, <0x028c3400 0x400>;
+			interrupt-names = "rx_005",
+					  "rx_057";
+			interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.9.1.200.gb1ec08f
