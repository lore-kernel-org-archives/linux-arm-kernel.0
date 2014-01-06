From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  7 Jan 2014 00:47:07 +0100
Subject: [PATCH RFC RFT 2/2] ARM: Kirkwood: Add support for many Synology NAS
 devices
In-Reply-To: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
References: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
Message-ID: <1389052027-16819-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree fragments and files to support many of the kirkwood
based Synology NAS devices. This is a translation of the board setup
file maintained by Ben Peddell <klightspeed@killerwolves.net>

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
cc: Ben Peddell <klightspeed@killerwolves.net>
---
 arch/arm/boot/dts/Makefile                     |   15 ++++
 arch/arm/boot/dts/kirkwood-ds109.dts           |   33 +++++++
 arch/arm/boot/dts/kirkwood-ds110jv10.dts       |   33 +++++++
 arch/arm/boot/dts/kirkwood-ds111.dts           |   33 +++++++
 arch/arm/boot/dts/kirkwood-ds112.dts           |   34 +++++++
 arch/arm/boot/dts/kirkwood-ds209.dts           |   33 +++++++
 arch/arm/boot/dts/kirkwood-ds210.dts           |   35 ++++++++
 arch/arm/boot/dts/kirkwood-ds212.dts           |   37 ++++++++
 arch/arm/boot/dts/kirkwood-ds212j.dts          |   34 +++++++
 arch/arm/boot/dts/kirkwood-ds409.dts           |   34 +++++++
 arch/arm/boot/dts/kirkwood-ds409slim.dts       |   32 +++++++
 arch/arm/boot/dts/kirkwood-ds411.dts           |   35 ++++++++
 arch/arm/boot/dts/kirkwood-ds411j.dts          |   34 +++++++
 arch/arm/boot/dts/kirkwood-ds411slim.dts       |   34 +++++++
 arch/arm/boot/dts/kirkwood-rs212.dts           |   34 +++++++
 arch/arm/boot/dts/kirkwood-rs409.dts           |   33 +++++++
 arch/arm/boot/dts/kirkwood-rs411.dts           |   34 +++++++
 arch/arm/boot/dts/synology/alarm-led-12.dtsi   |   28 ++++++
 arch/arm/boot/dts/synology/common.dtsi         |  112 ++++++++++++++++++++++++
 arch/arm/boot/dts/synology/ethernet-1.dtsi     |   15 ++++
 arch/arm/boot/dts/synology/fan-alarm-18.dtsi   |   22 +++++
 arch/arm/boot/dts/synology/fan-alarm-35-1.dtsi |   22 +++++
 arch/arm/boot/dts/synology/fan-alarm-35-3.dtsi |   32 +++++++
 arch/arm/boot/dts/synology/fan-gpios-15.dtsi   |   34 +++++++
 arch/arm/boot/dts/synology/fan-gpios-32.dtsi   |   34 +++++++
 arch/arm/boot/dts/synology/fan-speed-100.dtsi  |   20 +++++
 arch/arm/boot/dts/synology/fan-speed-120.dtsi  |   20 +++++
 arch/arm/boot/dts/synology/fan-speed-150.dtsi  |   20 +++++
 arch/arm/boot/dts/synology/hdd-leds-20.dtsi    |   90 +++++++++++++++++++
 arch/arm/boot/dts/synology/hdd-leds-21-1.dtsi  |   36 ++++++++
 arch/arm/boot/dts/synology/hdd-leds-21-2.dtsi  |   52 +++++++++++
 arch/arm/boot/dts/synology/hdd-leds-36.dtsi    |  103 ++++++++++++++++++++++
 arch/arm/boot/dts/synology/hdd-leds-38.dtsi    |   52 +++++++++++
 arch/arm/boot/dts/synology/hdd-power-29.dtsi   |   56 ++++++++++++
 arch/arm/boot/dts/synology/hdd-power-30-1.dtsi |   40 +++++++++
 arch/arm/boot/dts/synology/hdd-power-30-2.dtsi |   56 ++++++++++++
 arch/arm/boot/dts/synology/hdd-power-30-4.dtsi |   89 +++++++++++++++++++
 arch/arm/boot/dts/synology/hdd-power-31.dtsi   |   40 +++++++++
 arch/arm/boot/dts/synology/hdd-power-34.dtsi   |   73 +++++++++++++++
 arch/arm/boot/dts/synology/i2c-rtc-ricoh.dtsi  |   18 ++++
 arch/arm/boot/dts/synology/i2c-rtc-seiko.dtsi  |   18 ++++
 arch/arm/boot/dts/synology/pcie-2.dtsi         |   19 ++++
 42 files changed, 1658 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-ds109.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds110jv10.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds111.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds112.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds209.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds210.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds212.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds212j.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds409.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds409slim.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds411.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds411j.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ds411slim.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rs212.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rs409.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rs411.dts
 create mode 100644 arch/arm/boot/dts/synology/alarm-led-12.dtsi
 create mode 100644 arch/arm/boot/dts/synology/common.dtsi
 create mode 100644 arch/arm/boot/dts/synology/ethernet-1.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-alarm-18.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-alarm-35-1.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-alarm-35-3.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-gpios-15.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-gpios-32.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-speed-100.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-speed-120.dtsi
 create mode 100644 arch/arm/boot/dts/synology/fan-speed-150.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-leds-20.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-leds-21-1.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-leds-21-2.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-leds-36.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-leds-38.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-power-29.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-power-30-1.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-power-30-2.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-power-30-4.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-power-31.dtsi
 create mode 100644 arch/arm/boot/dts/synology/hdd-power-34.dtsi
 create mode 100644 arch/arm/boot/dts/synology/i2c-rtc-ricoh.dtsi
 create mode 100644 arch/arm/boot/dts/synology/i2c-rtc-seiko.dtsi
 create mode 100644 arch/arm/boot/dts/synology/pcie-2.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d57c1a65b24f..dc5ec1c57b43 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -78,6 +78,18 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-dns325.dtb \
 	kirkwood-dockstar.dtb \
 	kirkwood-dreamplug.dtb \
+	kirkwood-ds109.dtb \
+	kirkwood-ds110jv10.dtb \
+	kirkwood-ds111.dtb \
+	kirkwood-ds209.dtb \
+	kirkwood-ds210.dtb \
+	kirkwood-ds212.dtb \
+	kirkwood-ds212j.dtb \
+	kirkwood-ds409.dtb \
+	kirkwood-ds409slim.dtb \
+	kirkwood-ds411.dtb \
+	kirkwood-ds411j.dtb \
+	kirkwood-ds411slim.dtb \
 	kirkwood-goflexnet.dtb \
 	kirkwood-guruplug-server-plus.dtb \
 	kirkwood-ib62x0.dtb \
@@ -98,6 +110,9 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-nsa310a.dtb \
 	kirkwood-openblocks_a6.dtb \
 	kirkwood-openblocks_a7.dtb \
+	kirkwood-rs212.dtb \
+	kirkwood-rs409.dtb \
+	kirkwood-rs411.dtb \
 	kirkwood-sheevaplug.dtb \
 	kirkwood-sheevaplug-esata.dtb \
 	kirkwood-topkick.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-ds109.dts b/arch/arm/boot/dts/kirkwood-ds109.dts
new file mode 100644
index 000000000000..bea085ad540a
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds109.dts
@@ -0,0 +1,33 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-ricoh.dtsi"
+#include "synology/fan-speed-150.dtsi"
+#include "synology/fan-gpios-32.dtsi"
+#include "synology/fan-alarm-35-1.dtsi"
+#include "synology/hdd-leds-21-1.dtsi"
+
+/ {
+	model = "Synology DS109, DS110, DS110jv20";
+	compatible = "synology,ds109", "synology,ds110jv20",
+		     "synology,ds110", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ds110jv10.dts b/arch/arm/boot/dts/kirkwood-ds110jv10.dts
new file mode 100644
index 000000000000..d6b746952947
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds110jv10.dts
@@ -0,0 +1,33 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-seiko.dtsi"
+#include "synology/fan-speed-150.dtsi"
+#include "synology/fan-gpios-32.dtsi"
+#include "synology/fan-alarm-35-1.dtsi"
+#include "synology/hdd-leds-21-1.dtsi"
+
+/ {
+	model = "Synology DS110j v10 and v30";
+	compatible = "synology,ds110jv10", "synology,ds110jv30",
+		     "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ds111.dts b/arch/arm/boot/dts/kirkwood-ds111.dts
new file mode 100644
index 000000000000..5f51e088903f
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds111.dts
@@ -0,0 +1,33 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
+#include "synology/pcie-2.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-seiko.dtsi"
+#include "synology/fan-speed-100.dtsi"
+#include "synology/fan-gpios-15.dtsi"
+#include "synology/fan-alarm-35-1.dtsi"
+#include "synology/hdd-leds-21-1.dtsi"
+
+/ {
+	model = "Synology DS111";
+	compatible = "synology,ds111", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ds112.dts b/arch/arm/boot/dts/kirkwood-ds112.dts
new file mode 100644
index 000000000000..cda3203a0824
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds112.dts
@@ -0,0 +1,34 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
+#include "synology/pcie-2.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-seiko.dtsi"
+#include "synology/fan-speed-100.dtsi"
+#include "synology/fan-gpios-15.dtsi"
+#include "synology/fan-alarm-35.dtsi"
+#include "synology/hdd-leds-21-2.dtsi"
+#include "synology/hdd-power-30.dtsi"
+
+/ {
+	model = "Synology DS111";
+	compatible = "synology,ds111", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ds209.dts b/arch/arm/boot/dts/kirkwood-ds209.dts
new file mode 100644
index 000000000000..b2ebb423e129
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds209.dts
@@ -0,0 +1,33 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-ricoh.dtsi"
+#include "synology/fan-speed-150.dtsi"
+#include "synology/fan-gpios-32.dtsi"
+#include "synology/fan-alarm-35-1.dtsi"
+#include "synology/hdd-leds-21-2.dtsi"
+#include "synology/hdd-power-31.dtsi"
+
+/ {
+	model = "Synology DS209";
+	compatible = "synology,ds209", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ds210.dts b/arch/arm/boot/dts/kirkwood-ds210.dts
new file mode 100644
index 000000000000..8623dd63f44d
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds210.dts
@@ -0,0 +1,35 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-seiko.dtsi"
+#include "synology/fan-speed-150.dtsi"
+#include "synology/fan-gpios-32.dtsi"
+#include "synology/fan-alarm-35-1.dtsi"
+#include "synology/hdd-leds-21-2.dtsi"
+#include "synology/hdd-power-31.dtsi"
+
+/ {
+	model = "Synology DS210 v10, v20, v30, DS211j";
+	compatible = "synology,ds210jv10", "synology,ds210jv20",
+		     "synology,ds210jv30", "synology,ds211j",
+		     "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ds212.dts b/arch/arm/boot/dts/kirkwood-ds212.dts
new file mode 100644
index 000000000000..89e091ce2174
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds212.dts
@@ -0,0 +1,37 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
+#include "synology/pcie-2.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-seiko.dtsi"
+#include "synology/fan-speed-100.dtsi"
+#include "synology/fan-gpios-15.dtsi"
+#include "synology/fan-alarm-35-1.dtsi"
+#include "synology/hdd-leds-21-2.dtsi"
+#include "synology/hdd-power-30-2.dtsi"
+
+/ {
+	model = "Synology DS212, DS212p v10, v20, DS213air v10, DS213 v10";
+	compatible = "synology,ds212", "synology,ds212pv10",
+		     "synology,ds212pv10", "synology,ds212pv20",
+		     "synology,ds213airv10", "synology,ds213v10",
+		     "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ds212j.dts b/arch/arm/boot/dts/kirkwood-ds212j.dts
new file mode 100644
index 000000000000..ed14b7bb695e
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds212j.dts
@@ -0,0 +1,34 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-seiko.dtsi"
+#include "synology/fan-speed-100.dtsi"
+#include "synology/fan-gpios-32.dtsi"
+#include "synology/fan-alarm-35-1.dtsi"
+#include "synology/hdd-leds-21-2.dtsi"
+#include "synology/hdd-power-29.dtsi"
+
+/ {
+	model = "Synology DS212j v10, v20";
+	compatible = "synology,ds212jv10", "synology,ds212jv20",
+		     "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ds409.dts b/arch/arm/boot/dts/kirkwood-ds409.dts
new file mode 100644
index 000000000000..7000de1add08
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds409.dts
@@ -0,0 +1,34 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-ricoh.dtsi"
+#include "synology/ethernet-1.dtsi"
+#include "synology/fan-speed-120.dtsi"
+#include "synology/fan-gpios-15.dtsi"
+#include "synology/fan-alarm-18.dtsi"
+#include "synology/hdd-leds-36.dtsi"
+#include "synology/alarm-led-12.dtsi"
+
+/ {
+	model = "Synology DS409, DS410j";
+	compatible = "synology,ds409", "synology,ds410j", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ds409slim.dts b/arch/arm/boot/dts/kirkwood-ds409slim.dts
new file mode 100644
index 000000000000..0ba525a594f7
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds409slim.dts
@@ -0,0 +1,32 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-ricoh.dtsi"
+#include "synology/fan-speed-120.dtsi"
+#include "synology/fan-gpios-32.dtsi"
+#include "synology/fan-alarm-35-1.dtsi"
+#include "synology/hdd-leds-20.dtsi"
+
+/ {
+	model = "Synology 409slim";
+	compatible = "synology,ds409slim", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ds411.dts b/arch/arm/boot/dts/kirkwood-ds411.dts
new file mode 100644
index 000000000000..4c1ca8e85559
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds411.dts
@@ -0,0 +1,35 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
+#include "synology/pcie-2.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-seiko.dtsi"
+#include "synology/ethernet-1.dtsi"
+#include "synology/fan-speed-100.dtsi"
+#include "synology/fan-gpios-15.dtsi"
+#include "synology/fan-alarm-35-1.dtsi"
+#include "synology/hdd-leds-36.dtsi"
+#include "synology/hdd-power-34.dtsi"
+
+/ {
+	model = "Synology DS411, DS413jv10";
+	compatible = "synology,ds411", "synology,ds413jv10", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ds411j.dts b/arch/arm/boot/dts/kirkwood-ds411j.dts
new file mode 100644
index 000000000000..7f08a46ddabb
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds411j.dts
@@ -0,0 +1,34 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-seiko.dtsi"
+#include "synology/ethernet-1.dtsi"
+#include "synology/fan-speed-120.dtsi"
+#include "synology/fan-gpios-15.dtsi"
+#include "synology/fan-alarm-18.dtsi"
+#include "synology/hdd-leds-36.dtsi"
+#include "synology/alarm-led-12.dtsi"
+
+/ {
+	model = "Synology DS411j";
+	compatible = "synology,ds411j", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-ds411slim.dts b/arch/arm/boot/dts/kirkwood-ds411slim.dts
new file mode 100644
index 000000000000..2e6d66f37002
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds411slim.dts
@@ -0,0 +1,34 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
+#include "synology/pcie-2.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-seiko.dtsi"
+#include "synology/ethernet-1.dtsi"
+#include "synology/fan-speed-100.dtsi"
+#include "synology/fan-gpios-15.dtsi"
+#include "synology/fan-alarm-35-1.dtsi"
+#include "synology/hdd-leds-36.dtsi"
+
+/ {
+	model = "Synology DS411slim";
+	compatible = "synology,ds411slim", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-rs212.dts b/arch/arm/boot/dts/kirkwood-rs212.dts
new file mode 100644
index 000000000000..edc797464983
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-rs212.dts
@@ -0,0 +1,34 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
+#include "synology/pcie-2.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-seiko.dtsi"
+#include "synology/fan-speed-100.dtsi"
+#include "synology/fan-gpios-15.dtsi"
+#include "synology/fan-alarm-35-3.dtsi"
+#include "synology/hdd-leds-38.dtsi"
+#include "synology/hdd-power-30-2.dtsi"
+
+/ {
+	model = "Synology RS212";
+	compatible = "synology,rs212", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-rs409.dts b/arch/arm/boot/dts/kirkwood-rs409.dts
new file mode 100644
index 000000000000..906664a99602
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-rs409.dts
@@ -0,0 +1,33 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-ricoh.dtsi"
+#include "synology/ethernet-1.dtsi"
+#include "synology/fan-speed-120.dtsi"
+#include "synology/fan-gpios-15.dtsi"
+#include "synology/fan-alarm-18.dtsi"
+#include "synology/hdd-leds-36.dtsi"
+
+/ {
+	model = "Synology RS409";
+	compatible = "synology,rs409", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/kirkwood-rs411.dts b/arch/arm/boot/dts/kirkwood-rs411.dts
new file mode 100644
index 000000000000..75c806ea0dc9
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-rs411.dts
@@ -0,0 +1,34 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
+#include "synology/pcie-2.dtsi"
+#include "synology/common.dtsi"
+#include "synology/i2c-rtc-seiko.dtsi"
+#include "synology/ethernet-1.dtsi"
+#include "synology/fan-speed-100.dtsi"
+#include "synology/fan-gpios-15.dtsi"
+#include "synology/fan-alarm-35-3.dtsi"
+#include "synology/hdd-leds-36.dtsi"
+
+/ {
+	model = "Synology RS411 RS812";
+	compatible = "synology,rs411", "synology,rs812", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/alarm-led-12.dtsi b/arch/arm/boot/dts/synology/alarm-led-12.dtsi
new file mode 100644
index 000000000000..e6ea8f07d1a5
--- /dev/null
+++ b/arch/arm/boot/dts/synology/alarm-led-12.dtsi
@@ -0,0 +1,28 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_led_12: pmx-led-12 {
+				marvell,pins = "mpp12";
+				marvell,function = "gpio";
+			};
+		};
+	};
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_12>;
+		pinctrl-names = "default";
+		hdd1-green {
+			label = "synology:alarm";
+			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/common.dtsi b/arch/arm/boot/dts/synology/common.dtsi
new file mode 100644
index 000000000000..386074f3b6a2
--- /dev/null
+++ b/arch/arm/boot/dts/synology/common.dtsi
@@ -0,0 +1,112 @@
+/*
+ * Nodes which are common to all Synology devices
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	mbus {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+	ocp at f1000000 {
+		i2c at 11000 {
+			status = "okay";
+			clock-frequency = <400000>;
+			pinctrl-0 = <&pmx_twsi0>;
+			pinctrl-names = "default";
+		};
+		serial at 12000 {
+			status = "okay";
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
+		};
+		serial at 12100 {
+			status = "okay";
+			pinctrl-0 = <&pmx_uart1>;
+			pinctrl-names = "default";
+		};
+		poweroff at 12100 {
+			compatible = "synology,power-off";
+			reg = <0x12000 0x100>;
+			clocks = <&gate_clk 7>;
+		};
+		spi at 10600 {
+			status = "okay";
+			pinctrl-0 = <&pmx_spi>;
+			pinctrl-names = "default";
+
+			m25p80 at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "m25p80";
+				reg = <0>;
+				spi-max-frequency = <20000000>;
+				mode = <0>;
+
+				partition at 00000000 {
+					reg = <0x00000000 0x00080000>;
+					label = "RedBoot";
+				};
+
+				partition at 00080000 {
+					reg = <0x00080000 0x00200000>;
+					label = "zImage";
+				};
+
+				partition at 00280000 {
+					reg = <0x00280000 0x00140000>;
+					label = "rd.gz";
+				};
+				partition at 003c0000 {
+					reg = <0x003c0000 0x00010000>;
+					label = "vendor";
+				};
+				partition at 003d0000 {
+					reg = <0x003d0000 0x00020000>;
+					label = "RedBoot config";
+				};
+				partition at 003f0000 {
+					reg = <0x003f0000 0x00010000>;
+					label = "FIS directory";
+				};
+			};
+		};
+		sata at 80000 {
+			pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
+			pinctrl-names = "default";
+			status = "okay";
+			nr-ports = <2>;
+		};
+	};
+	gpio_fan {
+		compatible = "gpio-fan";
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy {
+		device_type = "ethernet-phy";
+		reg = <8>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+	ethernet0-port at 0 {
+		phy-handle = <&ethphy0>;
+	};
+};
diff --git a/arch/arm/boot/dts/synology/ethernet-1.dtsi b/arch/arm/boot/dts/synology/ethernet-1.dtsi
new file mode 100644
index 000000000000..bf00eff53bbc
--- /dev/null
+++ b/arch/arm/boot/dts/synology/ethernet-1.dtsi
@@ -0,0 +1,15 @@
+&mdio {
+	status = "okay";
+
+	ethphy1: ethernet-phy {
+		device_type = "ethernet-phy";
+		reg = <9>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+	ethernet1-port at 0 {
+		phy-handle = <&ethphy1>;
+	};
+};
diff --git a/arch/arm/boot/dts/synology/fan-alarm-18.dtsi b/arch/arm/boot/dts/synology/fan-alarm-18.dtsi
new file mode 100644
index 000000000000..af9efc076808
--- /dev/null
+++ b/arch/arm/boot/dts/synology/fan-alarm-18.dtsi
@@ -0,0 +1,22 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_fan_18: pmx-fan-18 {
+				marvell,pins = "mpp18";
+				marvell,function = "gpio";
+			};
+		};
+	};
+	gpio_fan {
+		alarm-gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/arch/arm/boot/dts/synology/fan-alarm-35-1.dtsi b/arch/arm/boot/dts/synology/fan-alarm-35-1.dtsi
new file mode 100644
index 000000000000..12e52fdae870
--- /dev/null
+++ b/arch/arm/boot/dts/synology/fan-alarm-35-1.dtsi
@@ -0,0 +1,22 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_fan_35: pmx-fan-35 {
+				marvell,pins = "mpp35";
+				marvell,function = "gpio";
+			};
+		};
+	};
+	gpio_fan {
+		alarm-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/arch/arm/boot/dts/synology/fan-alarm-35-3.dtsi b/arch/arm/boot/dts/synology/fan-alarm-35-3.dtsi
new file mode 100644
index 000000000000..e2a44f402bf0
--- /dev/null
+++ b/arch/arm/boot/dts/synology/fan-alarm-35-3.dtsi
@@ -0,0 +1,32 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_fan_35: pmx-fan-35 {
+				marvell,pins = "mpp35";
+				marvell,function = "gpio";
+			};
+			pmx_fan_44: pmx-fan-44 {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+			pmx_fan_45: pmx-fan-45 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+		};
+	};
+	gpio_fan {
+		alarm-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH
+			       &gpio1 12 GPIO_ACTIVE_HIGH
+			       &gpio1 13 GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/arch/arm/boot/dts/synology/fan-gpios-15.dtsi b/arch/arm/boot/dts/synology/fan-gpios-15.dtsi
new file mode 100644
index 000000000000..e27cba942eed
--- /dev/null
+++ b/arch/arm/boot/dts/synology/fan-gpios-15.dtsi
@@ -0,0 +1,34 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_fan_15: pmx-fan-15 {
+				marvell,pins = "mpp15";
+				marvell,function = "gpio";
+			};
+			pmx_fan_16: pmx-fan-16 {
+				marvell,pins = "mpp16";
+				marvell,function = "gpio";
+			};
+			pmx_fan_17: pmx-fan-17 {
+				marvell,pins = "mpp17";
+				marvell,function = "gpio";
+			};
+		};
+	};
+	gpio_fan {
+		pinctrl-0 = <&pmx_fan_15 &pmx_fan_16 &pmx_fan_17>;
+		pinctrl-names = "default";
+		gpios = <&gpio0 15 GPIO_ACTIVE_HIGH
+			 &gpio0 16 GPIO_ACTIVE_HIGH
+			 &gpio0 17 GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/arch/arm/boot/dts/synology/fan-gpios-32.dtsi b/arch/arm/boot/dts/synology/fan-gpios-32.dtsi
new file mode 100644
index 000000000000..aea1a0dce906
--- /dev/null
+++ b/arch/arm/boot/dts/synology/fan-gpios-32.dtsi
@@ -0,0 +1,34 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_fan_32: pmx-fan-32 {
+				marvell,pins = "mpp32";
+				marvell,function = "gpio";
+			};
+			pmx_fan_33: pmx-fan-33 {
+				marvell,pins = "mpp33";
+				marvell,function = "gpio";
+			};
+			pmx_fan_34: pmx-fan-34 {
+				marvell,pins = "mpp34";
+				marvell,function = "gpio";
+			};
+		};
+	};
+	gpio_fan {
+		pinctrl-0 = <&pmx_fan_32 &pmx_fan_33 &pmx_fan_34>;
+		pinctrl-names = "default";
+		gpios = <&gpio1 0 GPIO_ACTIVE_HIGH
+			 &gpio1 1 GPIO_ACTIVE_HIGH
+			 &gpio1 2 GPIO_ACTIVE_HIGH>;
+	};
+};
diff --git a/arch/arm/boot/dts/synology/fan-speed-100.dtsi b/arch/arm/boot/dts/synology/fan-speed-100.dtsi
new file mode 100644
index 000000000000..5188ba59a9b2
--- /dev/null
+++ b/arch/arm/boot/dts/synology/fan-speed-100.dtsi
@@ -0,0 +1,20 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	gpio_fan {
+		gpio-fan,speed-map = <    0 0
+				       2500 1
+				       3100 2
+				       3800 3
+				       4600 4
+				       4800 5
+				       4900 6
+				       5000 7 >;
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/fan-speed-120.dtsi b/arch/arm/boot/dts/synology/fan-speed-120.dtsi
new file mode 100644
index 000000000000..90157070492c
--- /dev/null
+++ b/arch/arm/boot/dts/synology/fan-speed-120.dtsi
@@ -0,0 +1,20 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	gpio_fan {
+		gpio-fan,speed-map = <    0 0
+				       2500 1
+				       2700 2
+				       3000 4
+				       3600 3
+				       3800 5
+				       3900 6
+				       4300 7 >;
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/fan-speed-150.dtsi b/arch/arm/boot/dts/synology/fan-speed-150.dtsi
new file mode 100644
index 000000000000..6abc36915886
--- /dev/null
+++ b/arch/arm/boot/dts/synology/fan-speed-150.dtsi
@@ -0,0 +1,20 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	gpio_fan {
+		gpio-fan,speed-map = <    0 0
+				       2200 1
+				       2500 2
+				       3000 4
+				       3300 3
+				       3700 5
+				       3800 6
+				       4200 7 >;
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/hdd-leds-20.dtsi b/arch/arm/boot/dts/synology/hdd-leds-20.dtsi
new file mode 100644
index 000000000000..e6663ea7014c
--- /dev/null
+++ b/arch/arm/boot/dts/synology/hdd-leds-20.dtsi
@@ -0,0 +1,90 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_led_20: pmx-led-20 {
+				marvell,pins = "mpp20";
+				marvell,function = "gpio";
+			};
+			pmx_led_21: pmx-led-21 {
+				marvell,pins = "mpp21";
+				marvell,function = "gpio";
+			};
+			pmx_led_22: pmx-led-22 {
+				marvell,pins = "mpp22";
+				marvell,function = "gpio";
+			};
+			pmx_led_23: pmx-led-23 {
+				marvell,pins = "mpp23";
+				marvell,function = "gpio";
+			};
+			pmx_led_24: pmx-led-24 {
+				marvell,pins = "mpp24";
+				marvell,function = "gpio";
+			};
+			pmx_led_25: pmx-led-25 {
+				marvell,pins = "mpp25";
+				marvell,function = "gpio";
+			};
+			pmx_led_26: pmx-led-26 {
+				marvell,pins = "mpp26";
+				marvell,function = "gpio";
+			};
+			pmx_led_27: pmx-led-27 {
+				marvell,pins = "mpp27";
+				marvell,function = "gpio";
+			};
+			pmx_led_28: pmx-led-28 {
+				marvell,pins = "mpp28";
+				marvell,function = "gpio";
+			};
+		};
+	};
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_20 &pmx_led_21 &pmx_led_22
+			     &pmx_led_23 &pmx_led_24 &pmx_led_25
+			     &pmx_led_26 &pmx_led_27>;
+		pinctrl-names = "default";
+		hdd1-green {
+			label = "synology:green:hdd1";
+			gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
+		};
+		hdd1-amber {
+			label = "synology:amber:hdd1";
+			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
+		};
+		hdd2-green {
+			label = "synology:green:hdd2";
+			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
+		};
+		hdd2-amber {
+			label = "synology:amber:hdd2";
+			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
+		};
+		hdd3-green {
+			label = "synology:green:hdd3";
+			gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
+		};
+		hdd3-amber {
+			label = "synology:amber:hdd3";
+			gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
+		};
+		hdd4-green {
+			label = "synology:green:hdd4";
+			gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
+		};
+		hdd4-amber {
+			label = "synology:amber:hdd4";
+			gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/hdd-leds-21-1.dtsi b/arch/arm/boot/dts/synology/hdd-leds-21-1.dtsi
new file mode 100644
index 000000000000..034323f9ffb0
--- /dev/null
+++ b/arch/arm/boot/dts/synology/hdd-leds-21-1.dtsi
@@ -0,0 +1,36 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_led_21: pmx-led-21 {
+				marvell,pins = "mpp21";
+				marvell,function = "gpio";
+			};
+			pmx_led_23: pmx-led-23 {
+				marvell,pins = "mpp23";
+				marvell,function = "gpio";
+			};
+		};
+	};
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_21 &pmx_led_23>;
+		pinctrl-names = "default";
+		hdd1-green {
+			label = "synology:green:hdd1";
+			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
+		};
+		hdd1-amber {
+			label = "synology:amber:hdd1";
+			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/hdd-leds-21-2.dtsi b/arch/arm/boot/dts/synology/hdd-leds-21-2.dtsi
new file mode 100644
index 000000000000..446a28f2200b
--- /dev/null
+++ b/arch/arm/boot/dts/synology/hdd-leds-21-2.dtsi
@@ -0,0 +1,52 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_led_20: pmx-led-20 {
+				marvell,pins = "mpp20";
+				marvell,function = "gpio";
+			};
+			pmx_led_21: pmx-led-21 {
+				marvell,pins = "mpp21";
+				marvell,function = "gpio";
+			};
+			pmx_led_22: pmx-led-22 {
+				marvell,pins = "mpp22";
+				marvell,function = "gpio";
+			};
+			pmx_led_23: pmx-led-23 {
+				marvell,pins = "mpp23";
+				marvell,function = "gpio";
+			};
+		};
+	};
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_21 &pmx_led_23 &pmx_led_20 &pmx_led_22>;
+		pinctrl-names = "default";
+		hdd1-green {
+			label = "synology:green:hdd1";
+			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
+		};
+		hdd1-amber {
+			label = "synology:amber:hdd1";
+			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
+		};
+		hdd2-green {
+			label = "synology:green:hdd2";
+			gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
+		};
+		hdd2-amber {
+			label = "synology:amber:hdd2";
+			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/hdd-leds-36.dtsi b/arch/arm/boot/dts/synology/hdd-leds-36.dtsi
new file mode 100644
index 000000000000..9541c0c943e6
--- /dev/null
+++ b/arch/arm/boot/dts/synology/hdd-leds-36.dtsi
@@ -0,0 +1,103 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_led_36: pmx-led-36 {
+				marvell,pins = "mpp36";
+				marvell,function = "gpio";
+			};
+			pmx_led_37: pmx-led-37 {
+				marvell,pins = "mpp37";
+				marvell,function = "gpio";
+			};
+			pmx_led_38: pmx-led-38 {
+				marvell,pins = "mpp38";
+				marvell,function = "gpio";
+			};
+			pmx_led_39: pmx-led-39 {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+			pmx_led_40: pmx-led-40 {
+				marvell,pins = "mpp40";
+				marvell,function = "gpio";
+			};
+			pmx_led_41: pmx-led-41 {
+				marvell,pins = "mpp41";
+				marvell,function = "gpio";
+			};
+			pmx_led_42: pmx-led-42 {
+				marvell,pins = "mpp42";
+				marvell,function = "gpio";
+			};
+			pmx_led_43: pmx-led-43 {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+			pmx_led_44: pmx-led-44 {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+			pmx_led_45: pmx-led-45 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+		};
+	};
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_36 &pmx_led_37 &pmx_led_38
+			     &pmx_led_39 &pmx_led_40 &pmx_led_41
+			     &pmx_led_42 &pmx_led_43 &pmx_led_44
+			     &pmx_led_45>;
+		pinctrl-names = "default";
+		hdd1-green {
+			label = "synology:green:hdd1";
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+		};
+		hdd1-amber {
+			label = "synology:amber:hdd1";
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+		};
+		hdd2-green {
+			label = "synology:green:hdd2";
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+		};
+		hdd2-amber {
+			label = "synology:amber:hdd2";
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+		};
+		hdd3-green {
+			label = "synology:green:hdd3";
+			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		};
+		hdd3-amber {
+			label = "synology:amber:hdd3";
+			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+		};
+		hdd4-green {
+			label = "synology:green:hdd4";
+			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+		};
+		hdd4-amber {
+			label = "synology:amber:hdd4";
+			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		};
+		hdd5-green {
+			label = "synology:green:hdd5";
+			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+		};
+		hdd5-amber {
+			label = "synology:amber:hdd5";
+			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/hdd-leds-38.dtsi b/arch/arm/boot/dts/synology/hdd-leds-38.dtsi
new file mode 100644
index 000000000000..d2fe351a0808
--- /dev/null
+++ b/arch/arm/boot/dts/synology/hdd-leds-38.dtsi
@@ -0,0 +1,52 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_led_38: pmx-led-38 {
+				marvell,pins = "mpp38";
+				marvell,function = "gpio";
+			};
+			pmx_led_39: pmx-led-39 {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+			pmx_led_36: pmx-led-36 {
+				marvell,pins = "mpp36";
+				marvell,function = "gpio";
+			};
+			pmx_led_37: pmx-led-37 {
+				marvell,pins = "mpp37";
+				marvell,function = "gpio";
+			};
+		};
+	};
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_38 &pmx_led_39 &pmx_led_36 &pmx_led_37>;
+		pinctrl-names = "default";
+		hdd1-green {
+			label = "synology:green:hdd1";
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+		};
+		hdd1-amber {
+			label = "synology:amber:hdd1";
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+		};
+		hdd2-green {
+			label = "synology:green:hdd2";
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+		};
+		hdd2-amber {
+			label = "synology:amber:hdd2";
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/hdd-power-29.dtsi b/arch/arm/boot/dts/synology/hdd-power-29.dtsi
new file mode 100644
index 000000000000..8b08c86ab942
--- /dev/null
+++ b/arch/arm/boot/dts/synology/hdd-power-29.dtsi
@@ -0,0 +1,56 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_hdd1_pwr_29: pmx-hdd1-pwr-29 {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+			pmx_hdd2_pwr_31: pmx-hdd2-pwr-31 {
+				marvell,pins = "mpp31";
+				marvell,function = "gpio";
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_hdd1_pwr_29 &pmx_hdd2_pwr_31>;
+		pinctrl-names = "default";
+
+		hdd1_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "hdd1power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
+		};
+		hdd2_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "hdd2power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio0 31 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/hdd-power-30-1.dtsi b/arch/arm/boot/dts/synology/hdd-power-30-1.dtsi
new file mode 100644
index 000000000000..b0998d4e231f
--- /dev/null
+++ b/arch/arm/boot/dts/synology/hdd-power-30-1.dtsi
@@ -0,0 +1,40 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_hdd1_pwr_30: pmx-hdd-pwr-30 {
+				marvell,pins = "mpp30";
+				marvell,function = "gpio";
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_hdd1_pwr_30>;
+		pinctrl-names = "default";
+
+		hdd1_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "hdd1power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio0 30 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/hdd-power-30-2.dtsi b/arch/arm/boot/dts/synology/hdd-power-30-2.dtsi
new file mode 100644
index 000000000000..766e6352d5af
--- /dev/null
+++ b/arch/arm/boot/dts/synology/hdd-power-30-2.dtsi
@@ -0,0 +1,56 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_hdd1_pwr_30: pmx-hdd-pwr-30 {
+				marvell,pins = "mpp30";
+				marvell,function = "gpio";
+			};
+			pmx_hdd2_pwr_34: pmx-hdd2-pwr-34 {
+				marvell,pins = "mpp34";
+				marvell,function = "gpio";
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_hdd1_pwr_30 &pmx_hdd2_pwr_34>;
+		pinctrl-names = "default";
+
+		hdd1_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "hdd1power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio0 30 GPIO_ACTIVE_HIGH>;
+		};
+		hdd2_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "hdd2power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/hdd-power-30-4.dtsi b/arch/arm/boot/dts/synology/hdd-power-30-4.dtsi
new file mode 100644
index 000000000000..5bbced207965
--- /dev/null
+++ b/arch/arm/boot/dts/synology/hdd-power-30-4.dtsi
@@ -0,0 +1,89 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_hdd1_pwr_30: pmx-hdd-pwr-30 {
+				marvell,pins = "mpp30";
+				marvell,function = "gpio";
+			};
+			pmx_hdd2_pwr_34: pmx-hdd2-pwr-34 {
+				marvell,pins = "mpp34";
+				marvell,function = "gpio";
+			};
+			pmx_hdd3_pwr_44: pmx-hdd3-pwr-44 {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+			pmx_hdd4_pwr_45: pmx-hdd4-pwr-45 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_hdd1_pwr_30 &pmx_hdd2_pwr_34
+			     &pmx_hdd3_pwr_44 &pmx_hdd4_pwr_45>;
+		pinctrl-names = "default";
+
+		hdd1_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "hdd1power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio0 30 GPIO_ACTIVE_HIGH>;
+		};
+		hdd2_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "hdd2power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		};
+		hdd3_power: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "hdd3power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		};
+		hdd4_power: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "hdd3power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio1 32 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/hdd-power-31.dtsi b/arch/arm/boot/dts/synology/hdd-power-31.dtsi
new file mode 100644
index 000000000000..0774ecdcaf64
--- /dev/null
+++ b/arch/arm/boot/dts/synology/hdd-power-31.dtsi
@@ -0,0 +1,40 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_hdd2_pwr_31: pmx-hdd2-pwr-31 {
+				marvell,pins = "mpp31";
+				marvell,function = "gpio";
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_hdd2_pwr_31>;
+		pinctrl-names = "default";
+
+		hdd2_power: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "hdd2power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio0 31 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/hdd-power-34.dtsi b/arch/arm/boot/dts/synology/hdd-power-34.dtsi
new file mode 100644
index 000000000000..d90becf582f1
--- /dev/null
+++ b/arch/arm/boot/dts/synology/hdd-power-34.dtsi
@@ -0,0 +1,73 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pmx_hdd2_pwr_34: pmx-hdd2-pwr-34 {
+				marvell,pins = "mpp34";
+				marvell,function = "gpio";
+			};
+			pmx_hdd3_pwr_44: pmx-hdd3-pwr-44 {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+			pmx_hdd4_pwr_45: pmx-hdd4-pwr-45 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_hdd2_pwr_34 &pmx_hdd3_pwr_44
+			     &pmx_hdd4_pwr_45>;
+		pinctrl-names = "default";
+
+		hdd2_power: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "hdd2power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		};
+		hdd3_power: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "hdd3power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		};
+		hdd4_power: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "hdd3power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio1 32 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/i2c-rtc-ricoh.dtsi b/arch/arm/boot/dts/synology/i2c-rtc-ricoh.dtsi
new file mode 100644
index 000000000000..98a23588ee62
--- /dev/null
+++ b/arch/arm/boot/dts/synology/i2c-rtc-ricoh.dtsi
@@ -0,0 +1,18 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		i2c at 11000 {
+			rs5c372: rs5c372 at 32 {
+				compatible = "rs5c372";
+				reg = <0x32>;
+			};
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/i2c-rtc-seiko.dtsi b/arch/arm/boot/dts/synology/i2c-rtc-seiko.dtsi
new file mode 100644
index 000000000000..3dd0d554ac66
--- /dev/null
+++ b/arch/arm/boot/dts/synology/i2c-rtc-seiko.dtsi
@@ -0,0 +1,18 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	ocp at f1000000 {
+		i2c at 11000 {
+			s35390a: s35390a at 30 {
+				compatible = "s35390a";
+				reg = <0x30>;
+			};
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/synology/pcie-2.dtsi b/arch/arm/boot/dts/synology/pcie-2.dtsi
new file mode 100644
index 000000000000..e34ebb5515c2
--- /dev/null
+++ b/arch/arm/boot/dts/synology/pcie-2.dtsi
@@ -0,0 +1,19 @@
+/*
+ * Nodes which are common to all Synology devices
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	mbus {
+		pcie-controller {
+			pcie at 2,0 {
+				status = "okay";
+			};
+		};
+	};
+};
\ No newline at end of file
-- 
1.7.10.4
