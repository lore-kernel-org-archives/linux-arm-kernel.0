From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 07 Dec 2013 00:13:18 +0100
Subject: [PATCHv0 2/3] ARM: mvebu: Enable NAND controller in ReadyNAS 104 .dts
 file
In-Reply-To: <cover.1386370808.git.arno@natisbad.org>
References: <cover.1386370808.git.arno@natisbad.org>
Message-ID: <654ea0d84013c473797c0902c75d3ac5d9c01981.1386370808.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Now that NAND controller support is available for Armada 370
(cb28e2537a6f: ARM: mvebu: Add support for NAND controller in
Armada 370/XP), this patch enables support for ReadyNAS 104 and
defines default partition layout as delivered by NETGEAR.

As described in similar commits 2be2bc39c6f0 (ARM: mvebu: Enable
NAND controller in Armada XP GP board) and d8c552dddfbf (ARM:
mvebu: Enable NAND controller in Armada 370 Mirabox),
"marvell,keep-config" parameter is used as current support does
not allow for setting of timing parameters yet.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370-netgear-rn104.dts | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index e48e5fb..272e2e2 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -133,6 +133,42 @@
 					reg = <0x23>;
 				};
 			};
+
+			nand at d0000 {
+				status = "okay";
+				num-cs = <1>;
+				marvell,nand-keep-config;
+				marvell,nand-enable-arbiter;
+				nand-on-flash-bbt;
+
+				partition at 0 {
+					label = "u-boot";
+					reg = <0x0000000 0x180000>;  /* 1.5MB */
+					read-only;
+				};
+
+				partition at 180000 {
+					label = "u-boot-env";
+					reg = <0x180000 0x20000>;    /* 128KB */
+					read-only;
+				};
+
+				partition at 200000 {
+					label = "uImage";
+					reg = <0x0200000 0x600000>;    /* 6MB */
+				};
+
+				partition at 800000 {
+					label = "minirootfs";
+					reg = <0x0800000 0x400000>;    /* 4MB */
+				};
+
+				/* Last MB is for the BBT, i.e. not writable */
+				partition at c00000 {
+					label = "ubifs";
+					reg = <0x0c00000 0x7400000>; /* 116MB */
+				};
+			};
 		};
 	};
 
-- 
1.8.4.4
