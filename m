From: jonmason@broadcom.com (Jon Mason)
Date: Thu,  5 May 2016 19:29:32 -0400
Subject: [PATCH 3/3] ARM: dts: NSP: Add new DT file for bcm958625hr
In-Reply-To: <1462490972-13566-1-git-send-email-jonmason@broadcom.com>
References: <1462490972-13566-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1462490972-13566-3-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a new device tree file for the Broadcom Northstar Plus HR SVK.
This SVK is a smaller form factor, and thus only has 2 PCI slots and 1
UART.  Also, it has the ability to reboot via GPIO (instead of the
processor reset).

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/bcm958625hr.dts | 107 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm958625hr.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 95c1923..17e185c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -97,6 +97,7 @@ dtb-$(CONFIG_ARCH_BCM_MOBILE) += \
 	bcm28155-ap.dtb \
 	bcm21664-garnet.dtb
 dtb-$(CONFIG_ARCH_BCM_NSP) += \
+	bcm958625hr.dtb \
 	bcm958625k.dtb
 dtb-$(CONFIG_ARCH_BERLIN) += \
 	berlin2-sony-nsz-gs7.dtb \
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
new file mode 100644
index 0000000..d82cc96
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -0,0 +1,107 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright (c) 2016 Broadcom.  All rights reserved.
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
+	model = "NorthStar Plus SVK (BCM958625HR)";
+	compatible = "brcm,bcm58625", "brcm,nsp";
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
