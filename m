From: tanxiaojun@huawei.com (Tan Xiaojun)
Date: Fri, 22 Jul 2016 16:48:51 +0800
Subject: [RFC PATCH v1 1/2] Documentation: arm64: Add Hisilicon HiP05/06/07
 Sysctrl and Djtag dts bindings
In-Reply-To: <1469177332-72156-1-git-send-email-tanxiaojun@huawei.com>
References: <1469177332-72156-1-git-send-email-tanxiaojun@huawei.com>
Message-ID: <1469177332-72156-2-git-send-email-tanxiaojun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First, add Hisilicon HiP05/06/07 CPU and ALGSUB system controller dts
bindings. Then, add Hisilicon Djtag dts binding.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 .../bindings/arm/hisilicon/hisilicon.txt           |   98 ++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 83fe816..82a22ed 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -249,3 +249,101 @@ Required Properties:
   [1]: bootwrapper size
   [2]: relocation physical address
   [3]: relocation size
+
+-----------------------------------------------------------------------
+Hisilicon HiP05 CPU system controller
+Required properties:
+- compatible : "hisilicon,hip05-sysctrl", "syscon", "simple-mfd";
+- reg : Register address and size
+- djtag :
+  - compatible : "hisilicon,hip05-cpu-djtag-v1"
+  - syscon : which sysctrl node
+
+Hisilicon HiP06 CPU system controller
+Required properties:
+- compatible : "hisilicon,hip06-sysctrl", "syscon", "simple-mfd";
+- reg : Register address and size
+- djtag :
+  - compatible : "hisilicon,hip06-cpu-djtag-v1"
+  - syscon : which sysctrl node
+
+Hisilicon HiP07 CPU system controller
+Required properties:
+- compatible : "hisilicon,hip07-sysctrl", "syscon", "simple-mfd";
+- reg : Register address and size
+- djtag :
+  - compatible : "hisilicon,hip07-cpu-djtag-v2"
+  - syscon : which sysctrl node
+
+The Hisilicon HiP05/06/07 CPU system controller is in CPU die of SoC. It is 
+used to control system operation mode, control system operating status and
+manage some important modules (such as clock, reset, soft reset, secure
+debugger, etc.). We can also configure some functions of the peripheral
+devices and query their status by it.
+
+The Hisilicon Djtag in CPU die is an independent module which connects with
+some modules in the SoC by Debug Bus. This module can be configured to access
+the registers of connecting modules (like L3 cache) during real time debugging
+by sysctrl.
+
+Example:
+	/* for Hisilicon HiP05 sysctrl */
+	hip05-sysctrl: hip05-sysctrl at 80010000 {
+		compatible = "hisilicon,hip05-sysctrl", "syscon", "simple-mfd";
+		reg = <0x80010000 0x10000>;
+		
+		djtag0: djtag at 0 {
+		       compatible = "hisilicon,hip05-cpu-djtag-v1";
+		       syscon = <&hip05-sysctrl>;
+		};
+	};
+
+	/* for Hisilicon HiP05 l3 cache maybe set like below */
+	llc0: llc at 0 {
+		compatible = "hisilicon,hip05-llc";
+		djtag = <&djtag0>;
+	};
+
+-----------------------------------------------------------------------
+Hisilicon HiP05 ALGSUB system controller
+Required properties:
+- compatible : "hisilicon,hip05-alg-sysctrl", "syscon", "simple-mfd";
+- reg : Register address and size
+- djtag :
+  - compatible : "hisilicon,hip05-io-djtag-v1"
+  - syscon : which sysctrl node
+
+Hisilicon HiP06 ALGSUB system controller
+Required properties:
+- compatible : "hisilicon,hip06-alg-sysctrl", "syscon", "simple-mfd";
+- reg : Register address and size
+- djtag :
+  - compatible : "hisilicon,hip06-io-djtag-v2"
+  - syscon : which sysctrl node
+
+Hisilicon HiP07 ALGSUB system controller
+Required properties:
+- compatible : "hisilicon,hip07-alg-sysctrl", "syscon", "simple-mfd";
+- reg : Register address and size
+- djtag :
+  - compatible : "hisilicon,hip07-io-djtag-v2"
+  - syscon : which sysctrl node
+
+The Hisilicon HiP05/06/07 ALGSUB system controller is in IO die of SoC. It
+has a similar function as the Hisilicon HiP05/06/07 CPU system controller
+in CPU die and it manage default modules, like RSA, etc.
+
+The Hisilicon Djtag in IO die has a similar function as the one in CPU die.
+
+Example:
+	/* for Hisilicon HiP05 alg subctrl */
+	hip05-alg-sysctrl: hip05-alg-sysctrl at d0000000 {
+		compatible = "hisilicon,hip05-alg-sysctrl", "syscon", "simple-mfd";
+		reg = <0xd0000000 0x10000>;
+		
+		djtag0: djtag at 0 {
+		       compatible = "hisilicon,hip05-io-djtag-v1";
+		       syscon = <&hip05-alg-sysctrl>;
+		};
+	};
+
-- 
1.7.9.5
