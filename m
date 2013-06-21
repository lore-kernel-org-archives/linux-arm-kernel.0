From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 21 Jun 2013 11:39:41 +0100
Subject: [PATCH v4 6/7] ARM:stih41x: Add B2000 board support
In-Reply-To: <1371811076-27168-1-git-send-email-srinivas.kandagatla@st.com>
References: <1371811076-27168-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1371811182-27454-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

B2000 board is reference board for STIH415/416 SOCs, it has
2 x UART, 4x USB, 2 x Ethernet, 1 x SATA, 1 x PCIe, and 1GB RAM.

This patch add initial support to b2000 with STiH415/416 with UART2 as
console and a heard beat LED.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
CC: Stephen Gallimore <stephen.gallimore@st.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/Makefile           |    2 +
 arch/arm/boot/dts/stih415-b2000.dts  |   15 ++++++++++++
 arch/arm/boot/dts/stih416-b2000.dts  |   16 +++++++++++++
 arch/arm/boot/dts/stih41x-b2000.dtsi |   41 ++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/stih415-b2000.dts
 create mode 100644 arch/arm/boot/dts/stih416-b2000.dts
 create mode 100644 arch/arm/boot/dts/stih41x-b2000.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f0895c5..d4615fd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -177,6 +177,8 @@ dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
 	spear320-evb.dtb \
 	spear320-hmi.dtb
 dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
+dtb-$(CONFIG_ARCH_STIXXXX)+= stih415-b2000.dtb \
+	stih416-b2000.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += \
 	sun4i-a10-cubieboard.dtb \
 	sun4i-a10-mini-xplus.dtb \
diff --git a/arch/arm/boot/dts/stih415-b2000.dts b/arch/arm/boot/dts/stih415-b2000.dts
new file mode 100644
index 0000000..d4af531
--- /dev/null
+++ b/arch/arm/boot/dts/stih415-b2000.dts
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ * Author: Srinivas Kandagatla <srinivas.kandagatla@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+/dts-v1/;
+#include "stih415.dtsi"
+#include "stih41x-b2000.dtsi"
+/ {
+	model = "STiH415 B2000 Board";
+	compatible = "st,stih415", "st,stih415-b2000";
+};
diff --git a/arch/arm/boot/dts/stih416-b2000.dts b/arch/arm/boot/dts/stih416-b2000.dts
new file mode 100644
index 0000000..a5eb6ee
--- /dev/null
+++ b/arch/arm/boot/dts/stih416-b2000.dts
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ * Author: Srinivas Kandagatla <srinivas.kandagatla@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+/dts-v1/;
+#include "stih416.dtsi"
+#include "stih41x-b2000.dtsi"
+
+/ {
+	compatible = "st,stih416", "st,stih416-b2000";
+	model = "STiH416 B2000";
+};
diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts/stih41x-b2000.dtsi
new file mode 100644
index 0000000..8e694d2
--- /dev/null
+++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
+ * Author: Srinivas Kandagatla <srinivas.kandagatla@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+/ {
+
+	memory{
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyAS0,115200";
+		linux,stdout-path = &serial2;
+	};
+
+	aliases {
+		ttyAS0 = &serial2;
+	};
+
+	soc {
+		serial2: serial at fed32000 {
+			status = "okay";
+		};
+
+		leds {
+			compatible	= "gpio-leds";
+			fp_led {
+				#gpio-cells = <1>;
+				label	= "Front Panel LED";
+				gpios	= <&PIO105 7>;
+				linux,default-trigger	= "heartbeat";
+			};
+		};
+
+	};
+};
-- 
1.7.6.5
