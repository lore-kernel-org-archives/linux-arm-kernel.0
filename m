From: jon.mason@broadcom.com (Jon Mason)
Date: Wed,  3 Aug 2016 14:39:05 -0400
Subject: [PATCH 10/11] ARM: dts: NSP: Add new DT file for bcm958623hr
In-Reply-To: <1470249546-12440-1-git-send-email-jon.mason@broadcom.com>
References: <1470249546-12440-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1470249546-12440-11-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a new device tree file for the Broadcom Northstar Plus
bcm958623hr SVK.  This SVK has 2GB RAM, 5 ports Ethernet, SATA, 2 PCI
slots, and 1 UART.  Also, it has the ability to reboot via GPIO.  To be
added in the future are support for the USB and SLIC audio.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/bcm958623hr.dts | 178 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm958623hr.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 190528d..6e41b49 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -102,6 +102,7 @@ dtb-$(CONFIG_ARCH_BCM_NSP) += \
 	bcm958522er.dtb \
 	bcm958525er.dtb \
 	bcm958525xmc.dtb \
+	bcm958623hr.dtb \
 	bcm958625hr.dtb \
 	bcm988312hr.dtb \
 	bcm958625k.dtb
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
new file mode 100644
index 0000000..4ceb8fe
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -0,0 +1,178 @@
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
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "NorthStar Plus SVK (BCM958623HR)";
+	compatible = "brcm,bcm58623", "brcm,nsp";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x80000000>;
+	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&gpioa 15 GPIO_ACTIVE_LOW>;
+		priority = <200>;
+	};
+};
+
+/* USB 2/3 and SLIC support needed to be complete */
+
+&amac0 {
+	status = "okay";
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
+
+&srab {
+	compatible = "brcm,bcm58623-srab", "brcm,nsp-srab";
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			label = "port0";
+			reg = <0>;
+		};
+
+		port at 1 {
+			label = "port1";
+			reg = <1>;
+		};
+
+		port at 2 {
+			label = "port2";
+			reg = <2>;
+		};
+
+		port at 3 {
+			label = "port3";
+			reg = <3>;
+		};
+
+		port at 4 {
+			label = "port4";
+			reg = <4>;
+		};
+
+		port at 5 {
+			ethernet = <&amac0>;
+			label = "cpu";
+			reg = <5>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+	};
+};
+
+&sata_phy0 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.7.4
