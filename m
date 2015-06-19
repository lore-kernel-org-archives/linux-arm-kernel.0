From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 18 Jun 2015 17:11:30 -0700
Subject: [PATCH 1/7] Documentation: dt: brcmstb: add system PM bindings
In-Reply-To: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1434672696-13632-2-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   | 142 ++++++++++++++++++++-
 1 file changed, 140 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
index 430608ec09f0..94429649687e 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
@@ -43,8 +43,7 @@ example:
         };
     };
 
-Lastly, nodes that allow for support of SMP initialization and reboot are
-required:
+Nodes that allow for support of SMP initialization and reboot are required:
 
 smpboot
 -------
@@ -95,3 +94,142 @@ example:
         compatible = "brcm,brcmstb-reboot";
         syscon = <&sun_top_ctrl 0x304 0x308>;
     };
+
+
+
+Power management
+----------------
+
+For power management (particularly, S2/S3/S5 system suspend), the following SoC
+components are needed:
+
+= Always-On control block (AON CTRL)
+
+This hardware provides control registers for the "always-on" (even in low-power
+modes) hardware, such as the Power Management State Machine (PMSM).
+
+Required properties:
+- compatible     : should contain "brcm,brcmstb-aon-ctrl"
+- reg            : the register start and length for the AON CTRL block
+
+Example:
+
+aon-ctrl at 410000 {
+	compatible = "brcm,brcmstb-aon-ctrl";
+	reg = <0x410000 0x400>;
+};
+
+= Memory controllers
+
+A Broadcom STB SoC typically has a number of independent memory controllers,
+each of which may have several associated hardware blocks, which are versioned
+independently (control registers, DDR PHYs, etc.). One might consider
+describing these controllers as a parent "memory controllers" block, which
+contains N sub-nodes (one for each controller in the system), each of which is
+associated with a number of hardware register resources (e.g., its PHY). See
+the example device tree snippet below.
+
+== MEMC (MEMory Controller)
+
+Represents a single memory controller instance.
+
+Required properties:
+- compatible     : should contain "brcm,brcmstb-memc" and "simple-bus"
+
+Should contain subnodes for any of the following relevant hardware resources:
+
+== DDR PHY control
+
+Control registers for this memory controller's DDR PHY.
+
+Required properties:
+- compatible     : should contain one of these
+	"brcm,brcmstb-ddr-phy-v225.1"
+	"brcm,brcmstb-ddr-phy-v240.1"
+	"brcm,brcmstb-ddr-phy-v240.2"
+
+- reg            : the DDR PHY register range
+
+== DDR SHIMPHY
+
+Control registers for this memory controller's DDR SHIMPHY.
+
+Required properties:
+- compatible     : should contain "brcm,brcmstb-ddr-shimphy-v1.0"
+- reg            : the DDR SHIMPHY register range
+
+== MEMC DDR control
+
+Sequencer DRAM parameters and control registers. Used for Self-Refresh
+Power-Down (SRPD), among other things.
+
+Required properties:
+- compatible     : should contain "brcm,brcmstb-memc-ddr"
+- reg            : the MEMC DDR register range
+
+Example:
+
+memory_controllers {
+	ranges;
+	compatible = "simple-bus";
+
+	memc at 0 {
+		compatible = "brcm,brcmstb-memc", "simple-bus";
+		ranges;
+
+		ddr-phy at f1106000 {
+			compatible = "brcm,brcmstb-ddr-phy-v240.1";
+			reg = <0xf1106000 0x21c>;
+		};
+
+		shimphy at f1108000 {
+			compatible = "brcm,brcmstb-ddr-shimphy-v1.0";
+			reg = <0xf1108000 0xe4>;
+		};
+
+		memc-ddr at f1102000 {
+			reg = <0xf1102000 0x800>;
+			compatible = "brcm,brcmstb-memc-ddr";
+		};
+	};
+
+	memc at 1 {
+		compatible = "brcm,brcmstb-memc", "simple-bus";
+		ranges;
+
+		ddr-phy at f1186000 {
+			compatible = "brcm,brcmstb-ddr-phy-v240.1";
+			reg = <0xf1186000 0x21c>;
+		};
+
+		shimphy at f1188000 {
+			compatible = "brcm,brcmstb-ddr-shimphy-v1.0";
+			reg = <0xf1188000 0xe4>;
+		};
+
+		memc-ddr at f1182000 {
+			reg = <0xf1182000 0x800>;
+			compatible = "brcm,brcmstb-memc-ddr";
+		};
+	};
+
+	memc at 2 {
+		compatible = "brcm,brcmstb-memc", "simple-bus";
+		ranges;
+
+		ddr-phy at f1206000 {
+			compatible = "brcm,brcmstb-ddr-phy-v240.1";
+			reg = <0xf1206000 0x21c>;
+		};
+
+		shimphy at f1208000 {
+			compatible = "brcm,brcmstb-ddr-shimphy-v1.0";
+			reg = <0xf1208000 0xe4>;
+		};
+
+		memc-ddr at f1202000 {
+			reg = <0xf1202000 0x800>;
+			compatible = "brcm,brcmstb-memc-ddr";
+		};
+	};
+};
-- 
1.9.1
