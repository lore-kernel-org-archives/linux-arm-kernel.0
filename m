From: w.f@huawei.com (Fei Wang)
Date: Wed, 30 Sep 2015 19:05:04 +0800
Subject: [PATCH 1/8] dt-bindings: pmic: Document Hi655x pmic driver
In-Reply-To: <1443611111-3196-1-git-send-email-w.f@huawei.com>
References: <1443611111-3196-1-git-send-email-w.f@huawei.com>
Message-ID: <1443611111-3196-2-git-send-email-w.f@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the new compatible for Hisilicon Hi655x pmic driver.

Signed-off-by: Fei Wang <w.f@huawei.com>
---
 .../devicetree/bindings/mfd/hisilicon,hi655x.txt   |   80 ++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt

diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt b/Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt
new file mode 100644
index 0000000..17bd8ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi655x.txt
@@ -0,0 +1,80 @@
+Hisilicon hi655x Power Management Integrated Circuit (PMIC)
+
+hi655x consists of a large and varied group of sub-devices:
+
+Device			 Supply Names	 Description
+------			 ------------	 -----------
+hi655x-powerkey		:		: Powerkey
+hi655x-regulator-pmic	:		: Regulators
+hi655x-usbvbus		:		: USB plug detection
+hi655x-pmu-rtc		:		: RTC
+hi655x-coul		:		: Coulomb
+
+Required properties:
+- compatible : Should be "hisilicon,hi655x-pmic-driver"
+- reg: Base address of PMIC on hi6220 soc
+- #interrupt-cells: Should be 2, is the local IRQ number for hi655x.
+- interrupt-controller: hi655x has internal IRQs (has own IRQ domain).
+- pmu_irq_gpio: should be &gpio_pmu_irq_n, is the IRQ gpio of hi655x.
+
+Example:
+	pmic: pmic at F8000000 {
+                compatible = "hisilicon,hi655x-pmic-driver";
+                reg = <0x0 0xF8000000 0x0 0x1000>;
+                #interrupt-cells = <2>;
+                interrupt-controller;
+                pmu_irq_gpio = <&gpio_pmu_irq_n>;
+                status = "ok";
+
+                ponkey:ponkey at b1{
+                        compatible = "hisilicon,hi655x-powerkey";
+                        interrupt-parent = <&pmic>;
+                        interrupts = <6 0>, <5 0>, <4 0>;
+                        interrupt-names = "down", "up", "hold 1s";
+                };
+
+                coul: coul at 1 {
+                        compatible = "hisilicon,hi655x-coul";
+                        interrupt-parent = <&pmic>;
+                        interrupts = <24 0>, <25 0>, <26 0>, <27 0>;
+                        interrupt-names = "cl_int_i", "cl_out_i", "cl_in_i", "vbat_int_i";
+                        battery_product_index = <0>;
+                        status = "ok";
+                };
+
+                rtc: rtc at 1 {
+                        compatible = "hisilicon,hi655x-pmu-rtc";
+                        interrupt-parent = <&pmic>;
+                        interrupts = <20 0>;
+                        interrupt-names = "hi655x_pmu_rtc";
+                        board_id = <1>;
+                };
+
+                usbvbus:usbvbus at b2{
+                        compatible = "hisilicon,hi655x-usbvbus";
+                        interrupt-parent = <&pmic>;
+                        interrupts = <9 0>, <8 0>;
+                        interrupt-names = "connect", "disconnect";
+                };
+
+		ldo2: regulator at a21 {
+                        compatible = "hisilicon,hi655x-regulator-pmic";
+                        regulator-name = "ldo2";
+                        regulator-min-microvolt = <2500000>;
+                        regulator-max-microvolt = <3200000>;
+                        hisilicon,valid-modes-mask = <0x02>;
+                        hisilicon,valid-ops-mask = <0x01d>;
+                        hisilicon,initial-mode = <0x02>;
+                        hisilicon,regulator-type = <0x01>;
+
+                        hisilicon,off-on-delay = <120>;
+                        hisilicon,ctrl-regs = <0x029 0x02a 0x02b>;
+                        hisilicon,ctrl-data = <0x1 0x1>;
+                        hisilicon,vset-regs = <0x072>;
+                        hisilicon,vset-data = <0 0x3>;
+                        hisilicon,regulator-n-vol = <8>;
+                        hisilicon,vset-table = <2500000>,<2600000>,<2700000>,<2800000>,<2900000>,<3000000>,<3100000>,<3200000>;
+                        hisilicon,num_consumer_supplies = <1>;
+                        hisilicon,consumer-supplies = "sensor_analog";
+                };
+	};
-- 
1.7.9.5
