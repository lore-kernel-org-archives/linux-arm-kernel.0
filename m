From: horms@verge.net.au (Simon Horman)
Date: Thu, 26 May 2016 11:31:32 +0900
Subject: [PATCH v3 1/3] arm64: dts: r8a7796: Add Renesas R8A7796 SoC
 support
In-Reply-To: <25947777-9871-ccc4-011b-0775c2b88d8b@de.bosch.com>
References: <1464054880-25843-1-git-send-email-horms+renesas@verge.net.au>
 <1464054880-25843-2-git-send-email-horms+renesas@verge.net.au>
 <25947777-9871-ccc4-011b-0775c2b88d8b@de.bosch.com>
Message-ID: <20160526023132.GF18393@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 09:38:23AM +0200, Dirk Behme wrote:
> On 24.05.2016 03:54, Simon Horman wrote:
> >Basic support for the Gen 3 R-Car M3-W SoC.
> >
> >Based on work for the r8a7795 and r8a7796 SoCs by
> >Takeshi Kihara, Dirk Behme and Geert Uytterhoeven.
> >
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >---
> >v3
> >* As suggested by Geert Uytterhoeven:
> >  - Drop 0x from unit address of gic
> >* As suggested by Khiem Nguyen:
> >  - Use psci-0.2
> >* Added Reviewed-by tag from Geert Uytterhoeven
> >
> >v2
> >* As suggested by Geert Uytterhoeven:
> >  - Move L2_CA57 node under cpus node and include reg property
> >  - Omit status = "disabled" from scif_clk node
> >---
> > Documentation/devicetree/bindings/arm/shmobile.txt |   4 +
> > arch/arm64/Kconfig.platforms                       |   6 ++
> > arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 120 +++++++++++++++++++++
> > 3 files changed, 130 insertions(+)
> > create mode 100644 arch/arm64/boot/dts/renesas/r8a7796.dtsi
> >
> >diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> >index 9cf67e48f222..d5ed554830d7 100644
> >--- a/Documentation/devicetree/bindings/arm/shmobile.txt
> >+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> >@@ -29,6 +29,8 @@ SoCs:
> >     compatible = "renesas,r8a7794"
> >   - R-Car H3 (R8A77950)
> >     compatible = "renesas,r8a7795"
> >+  - R-Car M3-W (R8A77960)
> >+    compatible = "renesas,r8a7796"
> >
> >
> > Boards:
> >@@ -61,5 +63,7 @@ Boards:
> >     compatible = "renesas,porter", "renesas,r8a7791"
> >   - Salvator-X (RTP0RC7795SIPB0010S)
> >     compatible = "renesas,salvator-x", "renesas,r8a7795";
> >+  - Salvator-X
> >+    compatible = "renesas,salvator-x", "renesas,r8a7796";
> >   - SILK (RTP0RC7794LCB00011S)
> >     compatible = "renesas,silk", "renesas,r8a7794"
> >diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> >index efa77c146415..16d8d26839ea 100644
> >--- a/arch/arm64/Kconfig.platforms
> >+++ b/arch/arm64/Kconfig.platforms
> >@@ -114,6 +114,12 @@ config ARCH_R8A7795
> > 	help
> > 	  This enables support for the Renesas R-Car H3 SoC.
> >
> >+config ARCH_R8A7796
> >+	bool "Renesas R-Car M3-W SoC Platform"
> >+	depends on ARCH_RENESAS
> >+	help
> >+	  This enables support for the Renesas R-Car M3-W SoC.
> >+
> > config ARCH_STRATIX10
> > 	bool "Altera's Stratix 10 SoCFPGA Family"
> > 	help
> >diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> >new file mode 100644
> >index 000000000000..178debf68318
> >--- /dev/null
> >+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> >@@ -0,0 +1,120 @@
> >+/*
> >+ * Device Tree Source for the r8a7796 SoC
> >+ *
> >+ * Copyright (C) 2016 Renesas Electronics Corp.
> >+ *
> >+ * This file is licensed under the terms of the GNU General Public License
> >+ * version 2.  This program is licensed "as is" without any warranty of any
> >+ * kind, whether express or implied.
> >+ */
> >+
> >+#include <dt-bindings/clock/r8a7796-cpg-mssr.h>
> >+#include <dt-bindings/interrupt-controller/arm-gic.h>
> >+
> >+/ {
> >+	compatible = "renesas,r8a7796";
> >+	#address-cells = <2>;
> >+	#size-cells = <2>;
> >+
> >+	psci {
> >+		compatible = "arm,psci-0.2";
> >+		method = "smc";
> >+	};
> >+
> >+	cpus {
> >+		#address-cells = <1>;
> >+		#size-cells = <0>;
> >+
> >+		/* 1 core only at this point */
> >+		a57_0: cpu at 0 {
> >+			compatible = "arm,cortex-a57", "arm,armv8";
> >+			reg = <0x0>;
> >+			device_type = "cpu";
> >+			next-level-cache = <&L2_CA57>;
> >+			enable-method = "psci";
> >+		};
> >+
> >+		L2_CA57: cache-controller at 0 {
> >+			compatible = "cache";
> >+			reg = <0>;
> >+			cache-unified;
> >+			cache-level = <2>;
> >+		};
> >+	};
> 
> 
> It looks to me that in the r8a7795.dtsi the cache-controller node is outside
> the cpus node? I'd think that we should keep is consistent.

As of c10cdf93a119 ("arm64: dts: r8a7795: Fix W=1 dtc warnings"),
which was recently added to the devel branch of the renesas tree,
the cache-controller is inside the cpu node on the r8a7795.dtsi.

This patch aims to be consistent with that change.
