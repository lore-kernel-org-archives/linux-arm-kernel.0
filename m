From: rjui@broadcom.com (Ray Jui)
Date: Mon, 21 Sep 2015 15:12:49 -0700
Subject: [PATCH v3 8/9] ARM: dts: enable touchscreen support on Cygnus
In-Reply-To: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
References: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442873570-20947-9-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables touchscreen support on bcm958300k and bcm958305k.
Touchscreen is connected to these boards through the bcm9hmidc daughter
card, and therefore also adding bcm9hmidc.dtsi that describes the
daughter card

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 10 ++++++++++
 arch/arm/boot/dts/bcm958300k.dts  |  1 +
 arch/arm/boot/dts/bcm958305k.dts  |  1 +
 arch/arm/boot/dts/bcm9hmidc.dtsi  | 42 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm9hmidc.dtsi

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 33ec6a5..24e058c 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -32,6 +32,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/bcm-cygnus.h>
 
 #include "skeleton.dtsi"
 
@@ -257,5 +258,14 @@
 			interrupt-controller;
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		touchscreen: tsc at 180a6000 {
+			compatible = "brcm,iproc-touchscreen";
+			reg = <0x180a6000 0x40>;
+			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
+			clock-names = "tsc_clk";
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/bcm958300k.dts b/arch/arm/boot/dts/bcm958300k.dts
index d8dc9f0..2e31581 100644
--- a/arch/arm/boot/dts/bcm958300k.dts
+++ b/arch/arm/boot/dts/bcm958300k.dts
@@ -33,6 +33,7 @@
 /dts-v1/;
 
 #include "bcm-cygnus.dtsi"
+#include "bcm9hmidc.dtsi"
 
 / {
 	model = "Cygnus SVK (BCM958300K)";
diff --git a/arch/arm/boot/dts/bcm958305k.dts b/arch/arm/boot/dts/bcm958305k.dts
index 9863a19..288a637 100644
--- a/arch/arm/boot/dts/bcm958305k.dts
+++ b/arch/arm/boot/dts/bcm958305k.dts
@@ -33,6 +33,7 @@
 /dts-v1/;
 
 #include "bcm-cygnus.dtsi"
+#include "bcm9hmidc.dtsi"
 
 / {
 	model = "Cygnus Wireless Audio (BCM958305K)";
diff --git a/arch/arm/boot/dts/bcm9hmidc.dtsi b/arch/arm/boot/dts/bcm9hmidc.dtsi
new file mode 100644
index 0000000..65397c0
--- /dev/null
+++ b/arch/arm/boot/dts/bcm9hmidc.dtsi
@@ -0,0 +1,42 @@
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
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/*
+ * Broadcom human machine interface daughter card (bcm9hmidc) installed on
+ * bcm958300k/bcm958305k boards
+ */
+
+&touchscreen {
+	touchscreen-inverted-x;
+	touchscreen-inverted-y;
+	status = "okay";
+};
-- 
1.9.1
