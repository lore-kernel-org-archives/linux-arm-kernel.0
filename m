From: anup.patel@linaro.org (Anup Patel)
Date: Wed, 27 Aug 2014 11:25:42 +0530
Subject: [PATCH] arm64: Fix GIC addresses for APM X-Gene
Message-ID: <1409118942-7290-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The APM X-Gene CPU does not implement security extensions but uses
GIC-400 which has security extensions implemented. To take care of
this situation APM HW designers provided two sets of GIC addresses
for accessing secured and non-secured GIC registers seperately.

Currently, the APM X-Gene DTS file points to secured GIC registers
and uses GIC Group0 for all irqs. This works fine in most cases
but does not work when routing host irqs to guest or VM using the
GICH_LRn.HW bit. It happens because if Guest or VM EOIs routed irqs
using GICV_EOI register then GIC-400 treats that Guest or VM is
trying to EOI a Group0 irq (i.e. secured irq) from non-secured mode
hence GIC-400 does not deactivate the routed irq.

To take care of the above issue, we initialize secured GIC registers
from bootloader such that all host irqs are treated as Group1 irqs
(i.e. non-secured irqs) and we only access non-secured GIC registers
from Linux, Xen and other hypervisors. The bootloader GIC initialization
part is already taken care and is available to all APM Mustang users
in latest APM SW release. This patch updates Linux DTS files to use
non-secured GIC registers for Linux and Xen.

Folks who want to try this patch, please update your APM Mustang
u-boot from any APM SW release after 7th July 2014.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm64/boot/dts/apm-storm.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index c0aceef..2b162f1 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -81,10 +81,10 @@
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x0 0x78010000 0x0 0x1000>,	/* GIC Dist */
-		      <0x0 0x78020000 0x0 0x1000>,	/* GIC CPU */
-		      <0x0 0x78040000 0x0 0x2000>,	/* GIC VCPU Control */
-		      <0x0 0x78060000 0x0 0x2000>;	/* GIC VCPU */
+		reg = <0x0 0x78090000 0x0 0x1000>,	/* GIC Dist */
+		      <0x0 0x780A0000 0x0 0x1000>,	/* GIC CPU */
+		      <0x0 0x780C0000 0x0 0x2000>,	/* GIC VCPU Control */
+		      <0x0 0x780E0000 0x0 0x2000>;	/* GIC VCPU */
 		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
 	};
 
-- 
1.7.9.5
