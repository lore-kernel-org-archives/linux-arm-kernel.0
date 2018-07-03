From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue,  3 Jul 2018 17:04:10 +1000
Subject: [RFC PATCH 1/4] dts: misc: Add bindings documentation for
 bmc-misc-ctrl
In-Reply-To: <20180703070413.28756-1-andrew@aj.id.au>
References: <20180703070413.28756-1-andrew@aj.id.au>
Message-ID: <20180703070413.28756-2-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 .../bindings/misc/bmc-misc-ctrl.txt           | 252 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 258 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt

diff --git a/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
new file mode 100644
index 000000000000..4661926030e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
@@ -0,0 +1,252 @@
+BMC Miscellaneous Control Interfaces
+====================================
+
+Baseboard Management Controllers (BMCs) often have an array of hardware
+features that need to be described but are awkward to sensibly expose.
+
+This bindings document provides a generic mechanism for describing such
+features, covering read-only (RO), read-modify-write (RMW) and
+write-1-set/write-1-clear (W1SC) semantics.
+
+All uses of bmc-misc-ctrl must be documented under Valid Uses below.
+
+The bindings are similar in nature to register-bit-led.
+
+Required Properties
+-------------------
+
+compatible: 	Must be "bmc-misc-ctrl"
+offset:		A one or three cell property describing the registers
+		associated with the field.
+
+		If the optional property 'set-clear' is not present then the
+		node describes a register with read-modify-write semantics. The
+		offset property has one cell describing the register of
+		interest.
+
+		If the optional property 'set-clear' is present then the node
+		describes a register set that together implement read,
+		write-1-set and write-1-clear semantics. The offset property
+		must be three cells, the first is the address of the register
+		to read from, the second the write-1-set register and the third
+		write-1-clear.
+
+mask: 		A mask whose set bits represent the bits of the field.
+label:		The name of the field
+
+Optional Properties
+-------------------
+
+read-only:	Define a read-only field (RMW/W1SC irrelevant).
+set-clear:	Define whether the field exists in a RMW or W1SC register set
+default-value:	Single cell applicable to RMW. The field will be updated to the
+		cell's value.
+default-set:	For W1SC, set all bits in the field
+default-clear:	For W1SC, clear all bits in the field
+
+Valid Uses
+----------
+
+Description:	Control bit for switching the video display DAC mux between
+		host VGA and BMC CRT mode
+Machines:	aspeed,ast2500
+Parent:		compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
+Node:
+		field at 2c.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x2c>;
+			mask = <0x00030000>;
+			label = "dac-mux";
+		};
+
+Description:	Host VGA scratch registers
+Machines:	aspeed,ast2500
+Parent:		compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
+Node:
+		field at 50.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x50>;
+			mask = <0xffffffff>;
+			label = "vga0";
+			read-only;
+		};
+
+		field at 54.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x54>;
+			mask = <0xffffffff>;
+			label = "vga1";
+			read-only;
+		};
+
+		field at 58.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x58>;
+			mask = <0xffffffff>;
+			label = "vga2";
+			read-only;
+		};
+
+		field at 5c.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x5c>;
+			mask = <0xffffffff>;
+			label = "vga3";
+			read-only;
+		};
+
+		field at 60.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x60>;
+			mask = <0xffffffff>;
+			label = "vga4";
+			read-only;
+		};
+
+		field at 64.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x64>;
+			mask = <0xffffffff>;
+			label = "vga5";
+			read-only;
+		};
+
+		field at 68.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x68>;
+			mask = <0xffffffff>;
+			label = "vga6";
+			read-only;
+		};
+
+		field at 6c.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0x6c>;
+			mask = <0xffffffff>;
+			label = "vga7";
+			read-only;
+		};
+
+Description:	Super I/O device scratch registers for host/BMC communication
+Machines:	aspeed,ast2500
+Parent:		compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
+		field at f0.24 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf0 24 8>;
+			mask = <0xff000000>;
+			label = "sio-2b";
+		};
+
+		field at f0.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf0>;
+			mask = <0x00ff0000>;
+			label = "sio-2a";
+		};
+
+		field at f0.8 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf0>;
+			mask = <0x0000ff00>;
+			bit-shift = <8>;
+			label = "sio-29";
+		};
+
+		field at f0.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf0>;
+			mask = <0x000000ff>;
+			label = "sio-28";
+		};
+
+		field at f4.24 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf4>;
+			mask = <0xff000000>;
+			label = "sio-2f";
+		};
+
+		field at f4.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf4>;
+			mask = <0x00ff0000>;
+			label = "sio-2e";
+		};
+
+		field at f4.8 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf4>;
+			mask = <0x0000ff00>;
+			label = "sio-2d";
+		};
+
+		field at f4.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf4>;
+			mask = <0x000000ff>;
+			label = "sio-2c";
+		};
+
+		field at f8.24 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf8>;
+			mask = <0xff000000>;
+			read-only;
+			label = "sio-23";
+		};
+
+		field at f8.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf8>;
+			mask = <0x00ff0000>;
+			read-only;
+			label = "sio-22";
+		};
+
+		field at f8.8 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf8>;
+			mask = <0x0000ff00>;
+			read-only;
+			label = "sio-21";
+		};
+
+		field at f8.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xf8>;
+			mask = <0x000000ff>;
+			read-only;
+			label = "sio-20";
+		};
+
+		field at fc.24 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xfc>;
+			mask = <0xff000000>;
+			read-only;
+			label = "sio-27";
+		};
+
+		field at fc.16 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xfc>;
+			mask = <0x00ff0000>;
+			read-only;
+			label = "sio-26";
+		};
+
+		field at fc.8 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xfc>;
+			mask = <0x0000ff00>;
+			read-only;
+			label = "sio-25";
+		};
+
+		field at fc.0 {
+			compatible = "bmc-misc-ctrl";
+			offset = <0xfc>;
+			mask = <0x000000ff>;
+			read-only;
+			label = "sio-24";
+		};
diff --git a/MAINTAINERS b/MAINTAINERS
index 07d1576fc766..9766d7832d8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2736,6 +2736,12 @@ S:	Supported
 F:	drivers/net/bonding/
 F:	include/uapi/linux/if_bonding.h
 
+BMC MISCELLANEOUS CONTROL
+R:	Andrew Jeffery <andrew@aj.id.au>
+L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
+
 BPF (Safe dynamic programs and tools)
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
-- 
2.17.1
