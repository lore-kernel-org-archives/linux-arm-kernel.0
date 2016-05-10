From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 10 May 2016 14:49:42 -0500
Subject: [PATCH 2/2] ARM: dts: dra7: Add ti,secure-ram node to ocmcram1 node
In-Reply-To: <1462909782-14639-1-git-send-email-d-gerlach@ti.com>
References: <1462909782-14639-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1462909782-14639-3-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Secure variants of DRA7xx and AM57xx SoCs may need to reserve a region
of the SRAM for use by secure software. To account for this, add a child
node to the ocmcram1 node that will act as a placeholder at the start
of the SRAM for the reserved region of memory that may be required
by secure services. The node is added with size 0 so that by default
parts will have the full space available but the bootloader or board dts
file is able to resize the node as needed depending on how much reserved
space is needed, if any, so end users of the ocmcram1 region on HS parts
must be aware that a smaller amount of SRAM than expected may be available.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index fd6f74856bd3..f46a265ce315 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -292,6 +292,21 @@
 			ranges = <0x0 0x40300000 0x80000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			/*
+			 * This is a placeholder for an optional reserved
+			 * region for use by secure software. The size
+			 * of this region is not known until runtime so it
+			 * is set as zero to either be updated to reserve
+			 * space or left unchanged to leave all SRAM for use.
+			 * On HS parts that that require the reserved region
+			 * either the bootloader can update the size to
+			 * the required amount or the node can be overridden
+			 * from the board dts file for the secure platform.
+			 */
+			sram-hs at 0 {
+				compatible = "ti,secure-ram";
+				reg = <0x0 0x0>;
+			};
 		};
 
 		/*
-- 
2.7.3
