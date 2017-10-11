From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 11 Oct 2017 17:23:12 +0200
Subject: [PATCH] ARM64: dts: meson-gxl: Add alternate ARM Trusted Firmware
 reserved memory zone
Message-ID: <1507735392-20005-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This year, Amlogic updated the ARM Trusted Firmware reserved memory mapping
for Meson GXL SoCs and products sold since May 2017 uses this alternate
reserved memory mapping.
But products had been sold using the previous mapping.

This issue has been explained in [1] and a dynamic solution is yet to be
found to avoid loosing another 3Mbytes of reservable memory.

In the meantime, this patch adds this alternate memory zone only for
the GXL and GXM SoCs since GXBB based new products stopped earlier.

[1] http://lists.infradead.org/pipermail/linux-amlogic/2017-October/004860.html

Fixes: bba8e3f42736 ("ARM64: dts: meson-gx: Add firmware reserved memory zones")
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index d8dd329..fb8d76a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -49,6 +49,14 @@
 
 / {
 	compatible = "amlogic,meson-gxl";
+
+	reserved-memory {
+		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
+		secmon_reserved_alt: secmon at 05000000 {
+			reg = <0x0 0x05000000 0x0 0x300000>;
+			no-map;
+		};
+	};
 };
 
 &ethmac {
-- 
2.7.4
