From: robertcnelson@gmail.com (Robert Nelson)
Date: Wed, 13 May 2015 08:50:01 -0500
Subject: [PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
Message-ID: <1431525001-5747-1-git-send-email-robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes: http://bugs.elinux.org/issues/143

Commit 672e2b147 which introduced proper shutdown chose to let the PMIC go into sleep-state (aka "RTC-only mode") rather than off-state. This was fine for rev A5 on which that patch was tested, but since then two changes have been made to the power supply scheme:

(rev A6) enable of the 3v3b regulator moved from LDO2 to LDO4 (3v3a)
side-effect: 3v3b rail remains on in sleep-mode (also in off-mode when battery-powered)

(rev A6A) am335x vdds supply moved from LDO3 to LDO1
side-effect: vdds remains supplied in sleep-mode

As a result heavy leakage occurs from vdds (directly) and 3v3b (via i/o pins) to the 3v3a. The amount of current depends on external connections, but for example leaving a serial console cable connected in this state resulted in serious violation of am335x absolute maximum ratings, with potential for hardware damage.

Reported-by: Matthijs van Duin <matthijsvanduin@gmail.com>
Tested-by: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index c3255e0..7198b81 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -223,6 +223,8 @@
 /include/ "tps65217.dtsi"
 
 &tps {
+	ti,pmic-shutdown-controller;
+
 	regulators {
 		dcdc1_reg: regulator at 0 {
 			regulator-name = "vdds_dpr";
-- 
2.1.4
