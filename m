From: anurupvasu@gmail.com (Anurup M)
Date: Wed,  3 Aug 2016 02:34:30 -0400
Subject: [RFC PATCH v1 01/10] Documentation: arm64: Add Hisilicon HiP05/06/07
 Sysctrl and Djtag dts bindings
In-Reply-To: <1470206079-73280-1-git-send-email-anurup.m@huawei.com>
References: <1470206079-73280-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1470206079-73280-2-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tan Xiaojun <tanxiaojun@huawei.com>

First, add Hisilicon HiP05/06/07 CPU and ALGSUB system controller dts
bindings. Then, add Hisilicon Djtag dts binding.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
Signed-off-by: Anurup M <anurup.m@huawei.com>
---
 .../bindings/arm/hisilicon/hisilicon.txt           | 97 ++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 83fe816..67256e7 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -249,3 +249,100 @@ Required Properties:
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
+manage some important components (such as clock, reset, soft reset, secure
+debugger, etc.). We can also configure some functions of the peripheral
+devices and query their status by it.
+
+The Hisilicon Djtag in CPU die is an independent component which connects with
+some other components in the SoC by Debug Bus. This driver can be configured
+to access the registers of connecting components (like L3 cache) during real
+time debugging by sysctrl.
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
+	/* for Hisilicon HiP05 L3 cache maybe set like below */
+	l3c0: l3c {
+		compatible = "hisilicon,hip05-l3c";
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
+in CPU die and it manage different components, like RSA, etc.
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
-- 
2.1.4
