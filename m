From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Thu, 12 Jan 2017 16:35:43 -0600
Subject: [PATCH v2 15/18] drivers/fsi: Add documentation for GPIO based FSI
 master
Message-ID: <1484260543-80300-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Bostic <cbostic@us.ibm.com>

Define the device tree bindings for the GPIO master type.

Signed-off-by: Chris Bostic <cbostic@us.ibm.com>

---

V2 - Break out this documentation update from the code implementing
     The GPIO master function.

   - Move the documentation to an earlier patch than the code
     implementing the function.

   - Document all 'compatible' strings used in the series.

   - Write binding document in terms of hardware, not software.

   - Elaborate on what a GPIO based FSI master is versus a non
     GPIO based master.

   - Give a more detailed description of what each pin in the GPIO
     FSI master is to be used for.

   - Re-order compatible strings in example so that most specific
     comes first.

   - Indicate the proper order each pin should be initialized.

   - Fix an unmatched '>' bracket in the example for binding.

   - Bracket each element of the example list items individually.
---
 .../devicetree/bindings/fsi/fsi-master-gpio.txt    | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt

diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
new file mode 100644
index 0000000..5d589bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
@@ -0,0 +1,71 @@
+Device-tree bindings for FSI master implemented with GPIO
+---------------------------------------------------------
+
+Typically a FSI master is defined in hardware with output control
+lines designated for Enable, Data, Clock, etc..  In the case of
+a 'GPIO FSI master', however, it may be the case that there is no
+such master defined in hardware and must be implemented in standard
+GPIO to interact with its slaves.  In this 'virtual' FSI master
+case the GPIO pins representing clk and data are directly
+connected to the slaves.
+
+The GPIO FSI master node
+-------------------------
+This node describes a FSI master implmented with GPIO.
+Required property:
+	compatible = "ibm,fsi-master-gpio"
+
+The standard FSI master node
+----------------------------
+This node describes a FSI master implmemented fully in hardware
+with dedicated input/output pins required for its function (i.e.
+not using generic GPIO pins).
+Required property:
+	compatible = "ibm,fsi-master"
+
+
+GPIO FSI master property/pin descriptions
+------------------------------------------
+clk -	The master controlled clock line that indicates to the
+	slave when to read in or send out new data - required.
+data -	The serial data line containing information to be sent or
+	received by the master.  This line is bi-directional.  During
+	command phase the master controls the line and when a response
+	is required the slave takes control - required.
+enable - Controls power state of data line - optional.
+trans - Voltage translator control. In some applications the data line
+	must have its signal levels altered by a translator. If this is
+	necessary then control of signal direction is managed via this
+	line - optional.
+mux -	Multiplexor control.  This activates/deactivates the data line
+	in cases where it is one of many possible selections via mux -
+	optional.
+
+Required properties:
+	- compatible = "ibm,fsi-master-gpio";
+	- clk-gpios;
+	- data-gpios;
+
+Optional properties:
+	- enable-gpios;
+	- trans-gpios;
+	- mux-gpios;
+
+Order of property activation:
+1. clk
+2. data
+3. trans
+4. enable
+5. mux
+
+
+Example:
+
+fsi-master {
+	compatible = "ibm,fsi-master-gpio", "ibm,fsi-master";
+	clk-gpios = <&gpio 0>, <&gpio 6>;
+	data-gpios = <&gpio 1>, <&gpio 7>;
+	enable-gpios = <&gpio 2>, <&gpio 8>;
+	trans-gpios = <&gpio 3>, <&gpio 9>;
+	mux-gpios = <&gpio 4>, <&gpio 10>;
+}
-- 
1.8.2.2
