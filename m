From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 26 Jun 2017 15:32:45 -0700
Subject: [PATCH v2 3/4] dt-bindings: Document MIPS Broadcom STB power
 management nodes
In-Reply-To: <20170626223248.14199-1-f.fainelli@gmail.com>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
Message-ID: <20170626223248.14199-6-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the different nodes required for supporting S2/S3/S5 suspend
states on MIPS-based Broadcom STB SoCs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/mips/brcm/soc.txt          | 153 +++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
index e4e1cd91fb1f..6bfe217668d6 100644
--- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -11,3 +11,156 @@ Required properties:
 
 The experimental -viper variants are for running Linux on the 3384's
 BMIPS4355 cable modem CPU instead of the BMIPS5000 application processor.
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
+- compatible     : should be one of
+		   "brcm,bcm7425-aon-ctrl"
+		   "brcm,bcm7429-aon-ctrl"
+		   "brcm,bcm7435-aon-ctrl" and
+		   "brcm,brcmstb-aon-ctrl"
+- reg            : the register start and length for the AON CTRL block
+
+Example:
+
+syscon at 410000 {
+	compatible = "brcm,bcm7425-aon-ctrl", "brcm,brcmstb-aon-ctrl";
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
+associated with a number of hardware register resources (e.g., its PHY.
+
+== MEMC (MEMory Controller)
+
+Represents a single memory controller instance.
+
+Required properties:
+- compatible     : should contain "brcm,brcmstb-memc" and "simple-bus"
+- ranges	 : should contain the child address in the parent address
+		   space, must be 0 here, and the register start and length of
+		   the entire memory controller (including all sub nodes: DDR PHY,
+		   arbiter, etc.)
+- #address-cells : must be 1
+- #size-cells	 : must be 1
+
+Example:
+
+	memory-controller: memc at 0 {
+		compatible = "brcm,brcmstb-memc", "simple-bus";
+		ranges = <0x0 0x0 0xa000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		memc-arb at 1000 {
+			...
+		};
+
+		memc-ddr at 2000 {
+			...
+		};
+
+		ddr-phy at 6000 {
+			...
+		};
+	};
+
+Should contain subnodes for any of the following relevant hardware resources:
+
+== DDR PHY control
+
+Control registers for this memory controller's DDR PHY.
+
+Required properties:
+- compatible     : should contain one of these
+		   "brcm,brcmstb-ddr-phy-v64.5"
+		   "brcm,brcmstb-ddr-phy"
+
+- reg            : the DDR PHY register range and length
+
+Example:
+
+	ddr-phy at 6000 {
+		compatible = "brcm,brcmstb-ddr-phy-v64.5";
+		reg = <0x6000 0xc8>;
+	};
+
+== DDR memory controller sequencer
+
+Control registers for this memory controller's DDR memory sequencer
+
+Required properties:
+- compatible     : should contain one of these
+		   "brcm,bcm7425-memc-ddr"
+		   "brcm,bcm7429-memc-ddr"
+		   "brcm,bcm7435-memc-ddr" and
+		   "brcm,brcmstb-memc-ddr"
+
+- reg            : the DDR sequencer register range and length
+
+Example:
+
+	memc-ddr at 2000 {
+		compatible = "brcm,bcm7425-memc-ddr", "brcm,brcmstb-memc-ddr";
+		reg = <0x2000 0x300>;
+	};
+
+== MEMC Arbiter
+
+The memory controller arbiter is responsible for memory clients allocation
+(bandwidth, priorities etc.) and needs to have its contents restored during
+deep sleep states (S3).
+
+Required properties:
+
+- compatible	: should contain one of these
+		  "brcm,brcmstb-memc-arb-v10.0.0.0"
+		  "brcm,brcmstb-memc-arb"
+
+- reg		: the DDR Arbiter register range and length
+
+Example:
+
+	memc-arb at 1000 {
+		compatible = "brcm,brcmstb-memc-arb-v10.0.0.0";
+		reg = <0x1000 0x248>;
+	};
+
+== Timers
+
+The Broadcom STB chips contain a timer block with several general purpose
+timers that can be used.
+
+Required properties:
+
+- compatible	: should contain one of:
+		  "brcm,bcm7425-timers"
+		  "brcm,bcm7429-timers"
+		  "brcm,bcm7435-timers and
+		  "brcm,brcmstb-timers"
+- reg		: the timers register range
+- interrupts	: the interrupt line for this timer block
+
+Example:
+
+	timers: timers at 4067c0 {
+		compatible = "brcm,bcm7425-timers", "brcm,brcmstb-timers";
+		reg = <0x4067c0 0x40>;
+		interrupts = <&periph_intc 19>;
+	};
-- 
2.9.3
