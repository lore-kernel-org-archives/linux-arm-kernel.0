From: jon.mason@broadcom.com (Jon Mason)
Date: Tue,  7 Jun 2016 18:28:06 -0400
Subject: [PATCH 1/2] ARM: dts: NSP: Add XMC board support
In-Reply-To: <1465338487-14932-1-git-send-email-jon.mason@broadcom.com>
References: <1465338487-14932-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1465338487-14932-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Mason <jonmason@broadcom.com>

The BCM958525XMC board is a smaller form factor typically used as
controller boards for switches.  This smaller board has less devices
pinned out, so only a few need be populated in the device tree.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/bcm958525xmc.dts | 109 +++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm958525xmc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2afa97e..3626be8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -97,6 +97,7 @@ dtb-$(CONFIG_ARCH_BCM_MOBILE) += \
 	bcm28155-ap.dtb \
 	bcm21664-garnet.dtb
 dtb-$(CONFIG_ARCH_BCM_NSP) += \
+	bcm958525xmc.dtb \
 	bcm958625hr.dtb \
 	bcm958625k.dtb
 dtb-$(CONFIG_ARCH_BERLIN) += \
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
new file mode 100644
index 0000000..d257e83
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -0,0 +1,109 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2016 Broadcom.  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Broadcom Corporation nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/dts-v1/;
+
+#include "bcm-nsp.dtsi"
+
+/ {
+	model = "NorthStar Plus XMC (BCM958525xmc)";
+	compatible = "brcm,bcm58525", "brcm,nsp";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&nand {
+	nandcs at 0 {
+		compatible = "brcm,nandcs";
+		reg = <0>;
+		nand-on-flash-bbt;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		nand-ecc-strength = <24>;
+		nand-ecc-step-size = <1024>;
+
+		brcm,nand-oob-sector-size = <27>;
+
+		partition at 0 {
+			label = "nboot";
+			reg = <0x00000000 0x00200000>;
+			read-only;
+		};
+		partition at 200000 {
+			label = "nenv";
+			reg = <0x00200000 0x00400000>;
+		};
+		partition at 600000 {
+			label = "nsystem";
+			reg = <0x00600000 0x00a00000>;
+		};
+		partition at 1000000 {
+			label = "nrootfs";
+			reg = <0x01000000 0x03000000>;
+		};
+		partition at 4000000 {
+			label = "ncustfs";
+			reg = <0x04000000 0x3c000000>;
+		};
+	};
+};
+
+/* XHCI, SATA, MMC, and Ethernet support needed to be complete */
+
+&uart0 {
+	status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_sel>;
+	nand_sel: nand_sel {
+		function = "nand";
+		groups = "nand_grp";
+	};
+};
-- 
1.9.1
