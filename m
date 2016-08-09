From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  9 Aug 2016 11:13:27 +0200
Subject: [PATCH 2/3] dt-bindings: clock: reset: Add GXBB AO Clock and Reset
 Bindings
In-Reply-To: <1470734008-18849-1-git-send-email-narmstrong@baylibre.com>
References: <1470734008-18849-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1470734008-18849-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentations and dt-bindings headers for the AO clock and reset
controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/clock/amlogic,gxbb-aoclkc.txt         | 45 +++++++++++++++
 include/dt-bindings/clock/gxbb-aoclkc.h            | 66 ++++++++++++++++++++++
 include/dt-bindings/reset/gxbb-aoclkc.h            | 66 ++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
 create mode 100644 include/dt-bindings/clock/gxbb-aoclkc.h
 create mode 100644 include/dt-bindings/reset/gxbb-aoclkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
new file mode 100644
index 0000000..a55d31b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
@@ -0,0 +1,45 @@
+* Amlogic GXBB AO Clock and Reset Unit
+
+The Amlogic GXBB AO clock controller generates and supplies clock to various
+controllers within the Always-On part of the SoC.
+
+Required Properties:
+
+- compatible: should be "amlogic,gxbb-aoclkc"
+- reg: physical base address of the clock controller and length of memory
+       mapped region.
+
+- #clock-cells: should be 1.
+
+Each clock is assigned an identifier and client nodes can use this identifier
+to specify the clock which they consume. All available clocks are defined as
+preprocessor macros in the dt-bindings/clock/gxbb-aoclkc.h header and can be
+used in device tree sources.
+
+- #reset-cells: should be 1.
+
+Each reset is assigned an identifier and client nodes can use this identifier
+to specify the reset which they consume. All available resets are defined as
+preprocessor macros in the dt-bindings/reset/gxbb-aoclkc.h header and can be
+used in device tree sources.
+
+Example: AO Clock controller node:
+
+	clkc_AO: clock-controller at 040 {
+		compatible = "amlogic,gxbb-aoclkc";
+		reg = <0x0 0x040 0x0 0x4>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+Example: UART controller node that consumes the clock and reset generated
+  by the clock controller:
+
+	uart_AO: serial at 4c0 {
+		compatible = "amlogic,meson-uart";
+		reg = <0x4c0 0x14>;
+		interrupts = <0 90 1>;
+		clocks = <&clkc_AO CLKID_AO_UART1>;
+		resets = <&clkc_AO RESET_AO_UART1>;
+		status = "disabled";
+	};
diff --git a/include/dt-bindings/clock/gxbb-aoclkc.h b/include/dt-bindings/clock/gxbb-aoclkc.h
new file mode 100644
index 0000000..3175148
--- /dev/null
+++ b/include/dt-bindings/clock/gxbb-aoclkc.h
@@ -0,0 +1,66 @@
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * The full GNU General Public License is included in this distribution
+ * in the file called COPYING.
+ *
+ * BSD LICENSE
+ *
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *   * Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in
+ *     the documentation and/or other materials provided with the
+ *     distribution.
+ *   * Neither the name of Intel Corporation nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_GXBB_AOCLK
+#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_GXBB_AOCLK
+
+#define CLKID_AO_REMOTE		0
+#define CLKID_AO_I2C_MASTER	1
+#define CLKID_AO_I2C_SLAVE	2
+#define CLKID_AO_UART1		3
+#define CLKID_AO_UART2		4
+#define CLKID_AO_IR_BLASTER	5
+
+#endif
diff --git a/include/dt-bindings/reset/gxbb-aoclkc.h b/include/dt-bindings/reset/gxbb-aoclkc.h
new file mode 100644
index 0000000..9e3fd60
--- /dev/null
+++ b/include/dt-bindings/reset/gxbb-aoclkc.h
@@ -0,0 +1,66 @@
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * The full GNU General Public License is included in this distribution
+ * in the file called COPYING.
+ *
+ * BSD LICENSE
+ *
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *   * Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in
+ *     the documentation and/or other materials provided with the
+ *     distribution.
+ *   * Neither the name of Intel Corporation nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef DT_BINDINGS_RESET_AMLOGIC_MESON_GXBB_AOCLK
+#define DT_BINDINGS_RESET_AMLOGIC_MESON_GXBB_AOCLK
+
+#define RESET_AO_REMOTE		0
+#define RESET_AO_I2C_MASTER	1
+#define RESET_AO_I2C_SLAVE	2
+#define RESET_AO_UART1		3
+#define RESET_AO_UART2		4
+#define RESET_AO_IR_BLASTER	5
+
+#endif
-- 
2.7.0
