From: jonmason@broadcom.com (Jon Mason)
Date: Wed, 26 Aug 2015 18:35:27 -0400
Subject: [PATCH v2 2/5] ARM: NSP: add minimal Northstar Plus device tree
In-Reply-To: <1440628530-6137-1-git-send-email-jonmason@broadcom.com>
References: <1440628530-6137-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1440628530-6137-3-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a very minimalistic set of Northstar Plus Device Tree files which
describes the SoC and the BCM958625 implementation.  The perpherials
described are:

ARM Cortex A9 CPU
2 8250 UARTs
ARM GIC
PL310 L2 Cache
ARM A9 Global timer

Signed-off-by: Kapil Hali <kapilh@broadcom.com>
Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/Makefile       |   2 +
 arch/arm/boot/dts/bcm-nsp.dtsi   | 105 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958625k.dts |  57 +++++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm-nsp.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958625k.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 246473a..adb5732 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -82,6 +82,8 @@ dtb-$(CONFIG_ARCH_BCM_CYGNUS) += \
 dtb-$(CONFIG_ARCH_BCM_MOBILE) += \
 	bcm28155-ap.dtb \
 	bcm21664-garnet.dtb
+dtb-$(CONFIG_ARCH_BCM_NSP) += \
+	bcm958625k.dtb
 dtb-$(CONFIG_ARCH_BERLIN) += \
 	berlin2-sony-nsz-gs7.dtb \
 	berlin2cd-google-chromecast.dtb \
diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
new file mode 100644
index 0000000..77f9bfc
--- /dev/null
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -0,0 +1,105 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
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
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#include "skeleton.dtsi"
+
+/ {
+	compatible = "brcm,nsp";
+	model = "Broadcom Northstar Plus SoC";
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0x0>;
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		periph_clk: periph_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <500000000>;
+		};
+	};
+
+	uart0: serial at 18000300 {
+		compatible = "ns16550a";
+		reg = <0x18000300 0x100>;
+		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <62499840>;
+		status = "disabled";
+	};
+
+	uart1: serial at 18000400 {
+		compatible = "ns16550a";
+		reg = <0x18000400 0x100>;
+		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <62499840>;
+		status = "disabled";
+	};
+
+	gic: interrupt-controller at 19021000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x19021000 0x1000>,
+		      <0x19020100 0x100>;
+	};
+
+	L2: l2-cache {
+		compatible = "arm,pl310-cache";
+		reg = <0x19022000 0x1000>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
+	timer at 19020200 {
+		compatible = "arm,cortex-a9-global-timer";
+		reg = <0x19020200 0x100>;
+		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&periph_clk>;
+	};
+};
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
new file mode 100644
index 0000000..16303db
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -0,0 +1,57 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
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
+	model = "NorthStar Plus SVK (BCM958625K)";
+	compatible = "brcm,bcm58625", "brcm,nsp";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
-- 
1.9.1
