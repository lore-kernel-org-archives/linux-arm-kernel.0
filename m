From: klightspeed@killerwolves.net (klightspeed at killerwolves.net)
Date: Thu, 20 Feb 2014 06:02:37 +1000
Subject: [PATCH v7 4/4] ARM: Kirkwood: Add support for many Synology NAS
 devices
In-Reply-To: <1392840157-31072-1-git-send-email-klightspeed@killerwolves.net>
References: <1392840157-31072-1-git-send-email-klightspeed@killerwolves.net>
Message-ID: <1392840157-31072-5-git-send-email-klightspeed@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ben Peddell" <klightspeed@killerwolves.net>

Add device tree fragments and files to support many of the kirkwood
based Synology NAS devices. This is a modification of
Andrew Lunn's <andrew@lunn.ch> translation of the board setup file
maintained by Ben Peddell <klightspeed@killerwolves.net>

The Ricoh RS5C372 RTC was used in all 2009 units and some 2010 units.
All other Synology Kirkwood-based DiskStations and RackStations use
the Seiko S35390A RTC.

Most of the 1-bay and 2-bay units use the GPIOs that are multiplexed
with the built-in SATA interface activity/presence pins on mpp 20-23,
while the 4-bay units use ge01 and a PCIe SATA controller, and put the
software controlled HDD leds on mpp 36-43.

Most of the 6281 units with HDD power controls use mpp 29 and 31, while
most of the 6282 units with HDD power controls use mpp 30, 34, 44 and 45
and provide a model ID on mpp 28, 29, 46 and 47.  Pre-2012 units and
most 4-bay units didn't have a separate power control for HDD1.  These
power controls are presumably to limit startup current from the 12V
brick power supply.

Instead of using separate dtsi files in a synology directory, this
patch uses a single dtsi file containing all of the modules for
these boards, with all of the modules not common to all boards
disabled.  The board dts files then enable the appropriate modules for
their boards.

Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>
Tested-by: Ben Peddell <klightspeed@killerwolves.net> (ds211j)
---
v2:
Fix gpio's which should be gpo.
Rebase onto v3-14-rc1
Update RTC nodes with vendor name.
Update SPI flash node with vendor name.
Add a description of the lego
Use ricoy, i.e. the stock ticker

v3:
Merge Synology dtsi files into single dtsi file

v4:
Various minor fixes to synology dtsi file

v7:
Revert ricoh vendor prefix change from v2
---
 arch/arm/boot/dts/Makefile               |  15 +
 arch/arm/boot/dts/kirkwood-ds109.dts     |  41 ++
 arch/arm/boot/dts/kirkwood-ds110jv10.dts |  41 ++
 arch/arm/boot/dts/kirkwood-ds111.dts     |  44 ++
 arch/arm/boot/dts/kirkwood-ds112.dts     |  48 ++
 arch/arm/boot/dts/kirkwood-ds209.dts     |  44 ++
 arch/arm/boot/dts/kirkwood-ds210.dts     |  46 ++
 arch/arm/boot/dts/kirkwood-ds212.dts     |  47 ++
 arch/arm/boot/dts/kirkwood-ds212j.dts    |  41 ++
 arch/arm/boot/dts/kirkwood-ds409.dts     |  48 ++
 arch/arm/boot/dts/kirkwood-ds409slim.dts |  40 ++
 arch/arm/boot/dts/kirkwood-ds411.dts     |  52 ++
 arch/arm/boot/dts/kirkwood-ds411j.dts    |  48 ++
 arch/arm/boot/dts/kirkwood-ds411slim.dts |  48 ++
 arch/arm/boot/dts/kirkwood-rs212.dts     |  48 ++
 arch/arm/boot/dts/kirkwood-rs409.dts     |  44 ++
 arch/arm/boot/dts/kirkwood-rs411.dts     |  44 ++
 arch/arm/boot/dts/kirkwood-synology.dtsi | 871 +++++++++++++++++++++++++++++++
 18 files changed, 1610 insertions(+)
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
 create mode 100644 arch/arm/boot/dts/kirkwood-synology.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6d1e43d..e286abc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -90,6 +90,18 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
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
@@ -112,6 +124,9 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
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
index 0000000..772092c
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds109.dts
@@ -0,0 +1,41 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-150-32-35 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-21-1 {
+		status = "okay";
+	};
+};
+
+&rs5c372 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds110jv10.dts b/arch/arm/boot/dts/kirkwood-ds110jv10.dts
new file mode 100644
index 0000000..aabafbe
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds110jv10.dts
@@ -0,0 +1,41 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-150-32-35 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-21-1 {
+		status = "okay";
+	};
+};
+
+&s35390a {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds111.dts b/arch/arm/boot/dts/kirkwood-ds111.dts
new file mode 100644
index 0000000..16ec7fb
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds111.dts
@@ -0,0 +1,44 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-100-15-35-1 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-21-1 {
+		status = "okay";
+	};
+};
+
+&s35390a {
+	status = "okay";
+};
+
+&pcie2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds112.dts b/arch/arm/boot/dts/kirkwood-ds112.dts
new file mode 100644
index 0000000..cff1b23
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds112.dts
@@ -0,0 +1,48 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-100-15-35-1 {
+		status = "okay";
+	};
+
+	gpio-leds-21-2 {
+		status = "okay";
+	};
+
+	regulators-hdd-30 {
+		status = "okay";
+	};
+};
+
+&s35390a {
+	status = "okay";
+};
+
+&pcie2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds209.dts b/arch/arm/boot/dts/kirkwood-ds209.dts
new file mode 100644
index 0000000..3304119
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds209.dts
@@ -0,0 +1,44 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-150-32-35 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-21-2 {
+		status = "okay";
+	};
+
+	regulators-hdd-31 {
+		status = "okay";
+	};
+};
+
+&rs5c372 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds210.dts b/arch/arm/boot/dts/kirkwood-ds210.dts
new file mode 100644
index 0000000..6052eaa
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds210.dts
@@ -0,0 +1,46 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-150-32-35 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-21-2 {
+		status = "okay";
+	};
+
+	regulators-hdd-31 {
+		status = "okay";
+	};
+};
+
+&s35390a {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds212.dts b/arch/arm/boot/dts/kirkwood-ds212.dts
new file mode 100644
index 0000000..7f76cd3
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds212.dts
@@ -0,0 +1,47 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-100-15-35-1 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-21-2 {
+		status = "okay";
+	};
+};
+
+&s35390a {
+	status = "okay";
+};
+
+&pcie2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds212j.dts b/arch/arm/boot/dts/kirkwood-ds212j.dts
new file mode 100644
index 0000000..1f83a00
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds212j.dts
@@ -0,0 +1,41 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-100-32-35 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-21-2 {
+		status = "okay";
+	};
+};
+
+&s35390a {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds409.dts b/arch/arm/boot/dts/kirkwood-ds409.dts
new file mode 100644
index 0000000..0a573ad
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds409.dts
@@ -0,0 +1,48 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-150-15-18 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-36 {
+		status = "okay";
+	};
+
+	gpio-leds-alarm-12 {
+		status = "okay";
+	};
+};
+
+&eth1 {
+	status = "okay";
+};
+
+&rs5c372 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds409slim.dts b/arch/arm/boot/dts/kirkwood-ds409slim.dts
new file mode 100644
index 0000000..1848a62
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds409slim.dts
@@ -0,0 +1,40 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-150-32-35 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-20 {
+		status = "okay";
+	};
+};
+
+&rs5c372 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds411.dts b/arch/arm/boot/dts/kirkwood-ds411.dts
new file mode 100644
index 0000000..a1737b4
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds411.dts
@@ -0,0 +1,52 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-100-15-35-1 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-36 {
+		status = "okay";
+	};
+
+	regulators-hdd-34 {
+		status = "okay";
+	};
+};
+
+&eth1 {
+	status = "okay";
+};
+
+&s35390a {
+	status = "okay";
+};
+
+&pcie2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds411j.dts b/arch/arm/boot/dts/kirkwood-ds411j.dts
new file mode 100644
index 0000000..0cde914
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds411j.dts
@@ -0,0 +1,48 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-150-15-18 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-36 {
+		status = "okay";
+	};
+
+	gpio-leds-alarm-12 {
+		status = "okay";
+	};
+};
+
+&eth1 {
+	status = "okay";
+};
+
+&s35390a {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds411slim.dts b/arch/arm/boot/dts/kirkwood-ds411slim.dts
new file mode 100644
index 0000000..aef0cad
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-ds411slim.dts
@@ -0,0 +1,48 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-100-15-35-1 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-36 {
+		status = "okay";
+	};
+};
+
+&eth1 {
+	status = "okay";
+};
+
+&s35390a {
+	status = "okay";
+};
+
+&pcie2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-rs212.dts b/arch/arm/boot/dts/kirkwood-rs212.dts
new file mode 100644
index 0000000..93ec3d0
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-rs212.dts
@@ -0,0 +1,48 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-100-15-35-3 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-38 {
+		status = "okay";
+	};
+
+	regulators-hdd-30-2 {
+		status = "okay";
+	};
+};
+
+&s35390a {
+	status = "okay";
+};
+
+&pcie2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-rs409.dts b/arch/arm/boot/dts/kirkwood-rs409.dts
new file mode 100644
index 0000000..311df4e
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-rs409.dts
@@ -0,0 +1,44 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-150-15-18 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-36 {
+		status = "okay";
+	};
+};
+
+&eth1 {
+	status = "okay";
+};
+
+&rs5c372 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-rs411.dts b/arch/arm/boot/dts/kirkwood-rs411.dts
new file mode 100644
index 0000000..f90da85
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-rs411.dts
@@ -0,0 +1,44 @@
+/*
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
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
+#include "kirkwood-synology.dtsi"
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
+
+	gpio-fan-100-15-35-3 {
+		status = "okay";
+	};
+
+	gpio-leds-hdd-36 {
+		status = "okay";
+	};
+};
+
+&eth1 {
+	status = "okay";
+};
+
+&s35390a {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-synology.dtsi b/arch/arm/boot/dts/kirkwood-synology.dtsi
new file mode 100644
index 0000000..92b3177
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-synology.dtsi
@@ -0,0 +1,871 @@
+/*
+ * Nodes for Marvell 628x Synology devices
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ * Ben Peddell <klightspeed@killerwolves.net>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/ {
+	mbus {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+
+			pcie2: pcie at 2,0 {
+				status = "disabled";
+			};
+		};
+	};
+
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			pmx_alarmled_12: pmx-alarmled-12 {
+				marvell,pins = "mpp12";
+				marvell,function = "gpio";
+			};
+
+			pmx_fanctrl_15: pmx-fanctrl-15 {
+				marvell,pins = "mpp15";
+				marvell,function = "gpio";
+			};
+
+			pmx_fanctrl_16: pmx-fanctrl-16 {
+				marvell,pins = "mpp16";
+				marvell,function = "gpio";
+			};
+
+			pmx_fanctrl_17: pmx-fanctrl-17 {
+				marvell,pins = "mpp17";
+				marvell,function = "gpio";
+			};
+
+			pmx_fanalarm_18: pmx-fanalarm-18 {
+				marvell,pins = "mpp18";
+				marvell,function = "gpo";
+			};
+
+			pmx_hddled_20: pmx-hddled-20 {
+				marvell,pins = "mpp20";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_21: pmx-hddled-21 {
+				marvell,pins = "mpp21";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_22: pmx-hddled-22 {
+				marvell,pins = "mpp22";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_23: pmx-hddled-23 {
+				marvell,pins = "mpp23";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_24: pmx-hddled-24 {
+				marvell,pins = "mpp24";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_25: pmx-hddled-25 {
+				marvell,pins = "mpp25";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_26: pmx-hddled-26 {
+				marvell,pins = "mpp26";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_27: pmx-hddled-27 {
+				marvell,pins = "mpp27";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_28: pmx-hddled-28 {
+				marvell,pins = "mpp28";
+				marvell,function = "gpio";
+			};
+
+			pmx_hdd1_pwr_29: pmx-hdd1-pwr-29 {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+
+			pmx_hdd1_pwr_30: pmx-hdd-pwr-30 {
+				marvell,pins = "mpp30";
+				marvell,function = "gpio";
+			};
+
+			pmx_hdd2_pwr_31: pmx-hdd2-pwr-31 {
+				marvell,pins = "mpp31";
+				marvell,function = "gpio";
+			};
+
+			pmx_fanctrl_32: pmx-fanctrl-32 {
+				marvell,pins = "mpp32";
+				marvell,function = "gpio";
+			};
+
+			pmx_fanctrl_33: pmx-fanctrl-33 {
+				marvell,pins = "mpp33";
+				marvell,function = "gpo";
+			};
+
+			pmx_fanctrl_34: pmx-fanctrl-34 {
+				marvell,pins = "mpp34";
+				marvell,function = "gpio";
+			};
+
+			pmx_hdd2_pwr_34: pmx-hdd2-pwr-34 {
+				marvell,pins = "mpp34";
+				marvell,function = "gpio";
+			};
+
+			pmx_fanalarm_35: pmx-fanalarm-35 {
+				marvell,pins = "mpp35";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_36: pmx-hddled-36 {
+				marvell,pins = "mpp36";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_37: pmx-hddled-37 {
+				marvell,pins = "mpp37";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_38: pmx-hddled-38 {
+				marvell,pins = "mpp38";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_39: pmx-hddled-39 {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_40: pmx-hddled-40 {
+				marvell,pins = "mpp40";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_41: pmx-hddled-41 {
+				marvell,pins = "mpp41";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_42: pmx-hddled-42 {
+				marvell,pins = "mpp42";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_43: pmx-hddled-43 {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_44: pmx-hddled-44 {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+
+			pmx_hddled_45: pmx-hddled-45 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+
+			pmx_hdd3_pwr_44: pmx-hdd3-pwr-44 {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+
+			pmx_hdd4_pwr_45: pmx-hdd4-pwr-45 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+
+			pmx_fanalarm_44: pmx-fanalarm-44 {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+
+			pmx_fanalarm_45: pmx-fanalarm-45 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+		};
+
+		rtc at 10300 {
+			status = "disabled";
+		};
+
+		spi at 10600 {
+			status = "okay";
+			pinctrl-0 = <&pmx_spi>;
+			pinctrl-names = "default";
+
+			m25p80 at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "st,m25p80";
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
+
+				partition at 003c0000 {
+					reg = <0x003c0000 0x00010000>;
+					label = "vendor";
+				};
+
+				partition at 003d0000 {
+					reg = <0x003d0000 0x00020000>;
+					label = "RedBoot config";
+				};
+
+				partition at 003f0000 {
+					reg = <0x003f0000 0x00010000>;
+					label = "FIS directory";
+				};
+			};
+		};
+
+		i2c at 11000 {
+			status = "okay";
+			clock-frequency = <400000>;
+			pinctrl-0 = <&pmx_twsi0>;
+			pinctrl-names = "default";
+
+			rs5c372: rs5c372 at 32 {
+				status = "disabled";
+				compatible = "ricoh,rs5c372";
+				reg = <0x32>;
+			};
+
+			s35390a: s35390a at 30 {
+				status = "disabled";
+				compatible = "ssi,s35390a";
+				reg = <0x30>;
+			};
+		};
+
+		serial at 12000 {
+			status = "okay";
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
+		};
+
+		serial at 12100 {
+			status = "okay";
+			pinctrl-0 = <&pmx_uart1>;
+			pinctrl-names = "default";
+		};
+
+		poweroff at 12100 {
+			compatible = "synology,power-off";
+			reg = <0x12100 0x100>;
+			clocks = <&gate_clk 7>;
+		};
+
+		sata at 80000 {
+			pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
+			pinctrl-names = "default";
+			status = "okay";
+			nr-ports = <2>;
+		};
+	};
+
+	gpio-fan-150-32-35 {
+		status = "disabled";
+		compatible = "gpio-fan";
+		pinctrl-0 = <&pmx_fanctrl_32 &pmx_fanctrl_33 &pmx_fanctrl_34
+		             &pmx_fanalarm_35>;
+		pinctrl-names = "default";
+		gpios = <&gpio1 0 GPIO_ACTIVE_HIGH
+			 &gpio1 1 GPIO_ACTIVE_HIGH
+			 &gpio1 2 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <    0 0
+				       2200 1
+				       2500 2
+				       3000 4
+				       3300 3
+				       3700 5
+				       3800 6
+				       4200 7 >;
+	};
+
+	gpio-fan-150-15-18 {
+		status = "disabled";
+		compatible = "gpio-fan";
+		pinctrl-0 = <&pmx_fanctrl_15 &pmx_fanctrl_16 &pmx_fanctrl_17
+		             &pmx_fanalarm_18>;
+		pinctrl-names = "default";
+		gpios = <&gpio0 15 GPIO_ACTIVE_HIGH
+			 &gpio0 16 GPIO_ACTIVE_HIGH
+			 &gpio0 17 GPIO_ACTIVE_HIGH>;
+		alarm-gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <    0 0
+				       2200 1
+				       2500 2
+				       3000 4
+				       3300 3
+				       3700 5
+				       3800 6
+				       4200 7 >;
+	};
+
+	gpio-fan-100-32-35 {
+		status = "disabled";
+		compatible = "gpio-fan";
+		pinctrl-0 = <&pmx_fanctrl_32 &pmx_fanctrl_33 &pmx_fanctrl_34
+		             &pmx_fanalarm_35>;
+		pinctrl-names = "default";
+		gpios = <&gpio1 0 GPIO_ACTIVE_HIGH
+			 &gpio1 1 GPIO_ACTIVE_HIGH
+			 &gpio1 2 GPIO_ACTIVE_HIGH>;
+		alarm-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <    0 0
+				       2500 1
+				       3100 2
+				       3800 3
+				       4600 4
+				       4800 5
+				       4900 6
+				       5000 7 >;
+	};
+
+	gpio-fan-100-15-18 {
+		status = "disabled";
+		compatible = "gpio-fan";
+		pinctrl-0 = <&pmx_fanctrl_15 &pmx_fanctrl_16 &pmx_fanctrl_17
+		             &pmx_fanalarm_18>;
+		pinctrl-names = "default";
+		gpios = <&gpio0 15 GPIO_ACTIVE_HIGH
+			 &gpio0 16 GPIO_ACTIVE_HIGH
+			 &gpio0 17 GPIO_ACTIVE_HIGH>;
+		alarm-gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <    0 0
+				       2500 1
+				       3100 2
+				       3800 3
+				       4600 4
+				       4800 5
+				       4900 6
+				       5000 7 >;
+	};
+
+	gpio-fan-100-15-35-1 {
+		status = "disabled";
+		compatible = "gpio-fan";
+		pinctrl-0 = <&pmx_fanctrl_15 &pmx_fanctrl_16 &pmx_fanctrl_17
+		             &pmx_fanalarm_35>;
+		pinctrl-names = "default";
+		gpios = <&gpio0 15 GPIO_ACTIVE_HIGH
+			 &gpio0 16 GPIO_ACTIVE_HIGH
+			 &gpio0 17 GPIO_ACTIVE_HIGH>;
+		alarm-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <    0 0
+				       2500 1
+				       3100 2
+				       3800 3
+				       4600 4
+				       4800 5
+				       4900 6
+				       5000 7 >;
+	};
+
+	gpio-fan-100-15-35-3 {
+		status = "disabled";
+		compatible = "gpio-fan";
+		pinctrl-0 = <&pmx_fanctrl_15 &pmx_fanctrl_16 &pmx_fanctrl_17
+		             &pmx_fanalarm_35 &pmx_fanalarm_44 &pmx_fanalarm_45>;
+		pinctrl-names = "default";
+		gpios = <&gpio0 15 GPIO_ACTIVE_HIGH
+			 &gpio0 16 GPIO_ACTIVE_HIGH
+			 &gpio0 17 GPIO_ACTIVE_HIGH>;
+		alarm-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH
+			       &gpio1 12 GPIO_ACTIVE_HIGH
+			       &gpio1 13 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <    0 0
+				       2500 1
+				       3100 2
+				       3800 3
+				       4600 4
+				       4800 5
+				       4900 6
+				       5000 7 >;
+	};
+
+	gpio-leds-alarm-12 {
+		status = "disabled";
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_alarmled_12>;
+		pinctrl-names = "default";
+
+		hdd1-green {
+			label = "synology:alarm";
+			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds-hdd-20 {
+		status = "disabled";
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_hddled_20 &pmx_hddled_21 &pmx_hddled_22
+			     &pmx_hddled_23 &pmx_hddled_24 &pmx_hddled_25
+			     &pmx_hddled_26 &pmx_hddled_27>;
+		pinctrl-names = "default";
+
+		hdd1-green {
+			label = "synology:green:hdd1";
+			gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd1-amber {
+			label = "synology:amber:hdd1";
+			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd2-green {
+			label = "synology:green:hdd2";
+			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd2-amber {
+			label = "synology:amber:hdd2";
+			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd3-green {
+			label = "synology:green:hdd3";
+			gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd3-amber {
+			label = "synology:amber:hdd3";
+			gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd4-green {
+			label = "synology:green:hdd4";
+			gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd4-amber {
+			label = "synology:amber:hdd4";
+			gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds-hdd-21-1 {
+		status = "disabled";
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_hddled_21 &pmx_hddled_23>;
+		pinctrl-names = "default";
+
+		hdd1-green {
+			label = "synology:green:hdd1";
+			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd1-amber {
+			label = "synology:amber:hdd1";
+			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds-hdd-21-2 {
+		status = "disabled";
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_hddled_21 &pmx_hddled_23 &pmx_hddled_20 &pmx_hddled_22>;
+		pinctrl-names = "default";
+
+		hdd1-green {
+			label = "synology:green:hdd1";
+			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd1-amber {
+			label = "synology:amber:hdd1";
+			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd2-green {
+			label = "synology:green:hdd2";
+			gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd2-amber {
+			label = "synology:amber:hdd2";
+			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds-hdd-36 {
+		status = "disabled";
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_hddled_36 &pmx_hddled_37 &pmx_hddled_38
+			     &pmx_hddled_39 &pmx_hddled_40 &pmx_hddled_41
+			     &pmx_hddled_42 &pmx_hddled_43 &pmx_hddled_44
+			     &pmx_hddled_45>;
+		pinctrl-names = "default";
+
+		hdd1-green {
+			label = "synology:green:hdd1";
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd1-amber {
+			label = "synology:amber:hdd1";
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd2-green {
+			label = "synology:green:hdd2";
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd2-amber {
+			label = "synology:amber:hdd2";
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd3-green {
+			label = "synology:green:hdd3";
+			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd3-amber {
+			label = "synology:amber:hdd3";
+			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd4-green {
+			label = "synology:green:hdd4";
+			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd4-amber {
+			label = "synology:amber:hdd4";
+			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd5-green {
+			label = "synology:green:hdd5";
+			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd5-amber {
+			label = "synology:amber:hdd5";
+			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds-hdd-38 {
+		status = "disabled";
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_hddled_38 &pmx_hddled_39 &pmx_hddled_36 &pmx_hddled_37>;
+		pinctrl-names = "default";
+
+		hdd1-green {
+			label = "synology:green:hdd1";
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd1-amber {
+			label = "synology:amber:hdd1";
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd2-green {
+			label = "synology:green:hdd2";
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+		};
+
+		hdd2-amber {
+			label = "synology:amber:hdd2";
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	regulators-hdd-29 {
+		status = "disabled";
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_hdd1_pwr_29 &pmx_hdd2_pwr_31>;
+		pinctrl-names = "default";
+
+		regulator at 1 {
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
+
+		regulator at 2 {
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
+
+	regulators-hdd-30-1 {
+		status = "disabled";
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_hdd1_pwr_30>;
+		pinctrl-names = "default";
+
+		regulator at 1 {
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
+
+	regulators-hdd-30-2 {
+		status = "disabled";
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_hdd1_pwr_30 &pmx_hdd2_pwr_34>;
+		pinctrl-names = "default";
+
+		regulator at 1 {
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
+
+		regulator at 2 {
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
+
+	regulators-hdd-30-4 {
+		status = "disabled";
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_hdd1_pwr_30 &pmx_hdd2_pwr_34
+			     &pmx_hdd3_pwr_44 &pmx_hdd4_pwr_45>;
+		pinctrl-names = "default";
+
+		regulator at 1 {
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
+
+		regulator at 2 {
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
+
+		regulator at 3 {
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
+
+		regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "hdd4power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	regulators-hdd-31 {
+		status = "disabled";
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_hdd2_pwr_31>;
+		pinctrl-names = "default";
+
+		regulator at 1 {
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
+
+	regulators-hdd-34 {
+		status = "disabled";
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_hdd2_pwr_34 &pmx_hdd3_pwr_44
+			     &pmx_hdd4_pwr_45>;
+		pinctrl-names = "default";
+
+		regulator at 2 {
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
+
+		regulator at 3 {
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
+
+		regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "hdd4power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			startup-delay-us = <5000000>;
+			gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <8>;
+	};
+
+	ethphy1: ethernet-phy at 1 {
+		device_type = "ethernet-phy";
+		reg = <9>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+
+	ethernet0-port at 0 {
+		phy-handle = <&ethphy0>;
+	};
+};
+
+&eth1 {
+	status = "disabled";
+
+	ethernet1-port at 0 {
+		phy-handle = <&ethphy1>;
+	};
+};
-- 
1.8.3.2
