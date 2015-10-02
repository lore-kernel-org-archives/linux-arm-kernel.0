From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 2 Oct 2015 23:24:20 +0530
Subject: [PATCH 3/6] arm64: dts: Add syscon based reboot in DT for NS2
In-Reply-To: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
References: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1443808463-21120-4-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To reset NS2, we simply have to write '0' to BIT[1] at offset 0x90
of CRMU space.

The above can be easily achieved by writing 0xfffffffd at offset 0x90
using syscon-reboot driver. We don't need to have separate driver for
rebooting NS2.

This patch enables syscon-reboot driver for NS2 using DT.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index c5d90e4..5d2ac6b 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -144,6 +144,18 @@
 			mmu-masters;
 		};
 
+		crmu: crmu at 65024000 {
+			compatible = "syscon";
+			reg = <0x65024000 0x100>;
+		};
+
+		reboot at 65024000 {
+			compatible ="syscon-reboot";
+			regmap = <&crmu>;
+			offset = <0x90>;
+			mask = <0xfffffffd>;
+		};
+
 		gic: interrupt-controller at 65210000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
1.9.1
