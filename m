From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Jul 2016 13:14:40 -0600
Subject: [PATCH 1/3] dt-bindings: add power domains to Tegra BPMP firmware
Message-ID: <20160719191442.15439-1-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Tegra186 BPMP is also a provider of power domains. Enhance the device
tree binding to describe this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
These patches all build on top of Joseph Lo's baseline BPMP binding patches[1]
and enhance them to represent a few more features of the firmware.

[1] https://lkml.org/lkml/2016/7/19/280
"[PATCH V3 01/10] Documentation: dt-bindings: mailbox: tegra: Add binding for HSP mailbox"

 .../bindings/firmware/nvidia,tegra186-bpmp.txt     | 10 ++++--
 include/dt-bindings/power/tegra186-powergate.h     | 39 ++++++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra186-powergate.h

diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
index 23782c84d093..9a3864f56955 100644
--- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
+++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
@@ -17,6 +17,7 @@ Required properties:
 - shmem : List of the phandle of the TX and RX shared memory area that
 	  the IPC between CPU and BPMP is based on.
 - #clock-cells : Should be 1.
+- #power-domain-cells : Should be 1.
 - #reset-cells : Should be 1.
 
 This node is a mailbox consumer. See the following files for details of
@@ -26,12 +27,14 @@ provider(s):
 - .../mailbox/mailbox.txt
 - .../mailbox/nvidia,tegra186-hsp.txt
 
-This node is a clock and reset provider. See the following files for
-general documentation of those features, and the specifiers implemented
-by this node:
+This node is a clock, power domain, and reset provider. See the following
+files for general documentation of those features, and the specifiers
+implemented by this node:
 
 - .../clock/clock-bindings.txt
 - <dt-bindings/clock/tegra186-clock.h>
+- ../power/power_domain.txt
+- <dt-bindings/power/tegra186-powergate.h>
 - .../reset/reset.txt
 - <dt-bindings/reset/tegra186-reset.h>
 
@@ -73,5 +76,6 @@ bpmp {
 	mboxes = <&hsp_top0 HSP_MBOX_TYPE_DB HSP_DB_MASTER_BPMP>;
 	shmem = <&cpu_bpmp_tx &cpu_bpmp_rx>;
 	#clock-cells = <1>;
+	#power-domain-cells = <1>;
 	#reset-cells = <1>;
 };
diff --git a/include/dt-bindings/power/tegra186-powergate.h b/include/dt-bindings/power/tegra186-powergate.h
new file mode 100644
index 000000000000..388d6e228dc8
--- /dev/null
+++ b/include/dt-bindings/power/tegra186-powergate.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) 2015-2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _DT_BINDINGS_POWER_TEGRA186_POWERGATE_H
+#define _DT_BINDINGS_POWER_TEGRA186_POWERGATE_H
+
+#define TEGRA186_POWER_DOMAIN_AUD	0
+#define TEGRA186_POWER_DOMAIN_DFD	1
+#define TEGRA186_POWER_DOMAIN_DISP	2
+#define TEGRA186_POWER_DOMAIN_DISPB	3
+#define TEGRA186_POWER_DOMAIN_DISPC	4
+#define TEGRA186_POWER_DOMAIN_ISPA	5
+#define TEGRA186_POWER_DOMAIN_NVDEC	6
+#define TEGRA186_POWER_DOMAIN_NVJPG	7
+#define TEGRA186_POWER_DOMAIN_MPE	8
+#define TEGRA186_POWER_DOMAIN_PCX	9
+#define TEGRA186_POWER_DOMAIN_SAX	10
+#define TEGRA186_POWER_DOMAIN_VE	11
+#define TEGRA186_POWER_DOMAIN_VIC	12
+#define TEGRA186_POWER_DOMAIN_XUSBA	13
+#define TEGRA186_POWER_DOMAIN_XUSBB	14
+#define TEGRA186_POWER_DOMAIN_XUSBC	15
+#define TEGRA186_POWER_DOMAIN_GPU	43
+#define TEGRA186_POWER_DOMAIN_MAX	44
+
+#endif
-- 
2.9.2
