From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 21 Jul 2017 12:25:42 +0530
Subject: [PATCH v2 7/7] arm64: dts: Add FlexRM DT nodes for Stingray
In-Reply-To: <1500620142-910-1-git-send-email-anup.patel@broadcom.com>
References: <1500620142-910-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1500620142-910-8-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have two instances of FlexRM on Stingray. One for SBA RAID
offload engine and another for SPU2 Crypto offload engine.

This patch adds FlexRM mailbox controller DT nodes for Stingray.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray-fs4.dtsi   | 54 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  2 +
 2 files changed, 56 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi
new file mode 100644
index 0000000..1f927c4
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi
@@ -0,0 +1,54 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2016-2017 Broadcom.  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Broadcom nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+	fs4: fs4 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x67000000 0x00800000>;
+
+		crypto_mbox: crypto_mbox at 00000000 {
+			compatible = "brcm,iproc-flexrm-mbox";
+			reg = <0x00000000 0x200000>;
+			msi-parent = <&gic_its 0x4100>;
+			#mbox-cells = <3>;
+			dma-coherent;
+		};
+
+		raid_mbox: raid_mbox at 00400000 {
+			compatible = "brcm,iproc-flexrm-mbox";
+			reg = <0x00400000 0x200000>;
+			dma-coherent;
+			msi-parent = <&gic_its 0x4300>;
+			#mbox-cells = <3>;
+		};
+	};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 49933cf..a98fbe9a 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -261,6 +261,8 @@
 		};
 	};
 
+	#include "stingray-fs4.dtsi"
+
 	hsls {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.7.4
