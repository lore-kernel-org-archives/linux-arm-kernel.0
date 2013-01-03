From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  2 Jan 2013 22:55:18 -0700
Subject: [PATCH 3/6] ARM: bcm2835 rpi: remove hard-coded memreserve from DT
In-Reply-To: <1357192521-13025-1-git-send-email-swarren@wwwdotorg.org>
References: <1357192521-13025-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1357192521-13025-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi has either 256MB or 512MB of RAM. However, a portion is
reserved for use by the VideoCore co-processor. The RPi DT contained a
/memreserve/ statement to reserve that RAM. However, the exact amount of
RAM used by the VideoCore is dynamic at boot-time; a firmware config
file specifies the amount. As such, we can't hard-code the size in the
DT. Remove the /memreserve/ statement. The bootloader is expected to
adjust the /memory properties to reflect the RAM size the ARM CPU can
use. Upstream U-Boot certainly does this, although I'm not sure that the
basic firmware does if it boots the kernel directly; users may need to
manually adjust their DT if not using U-Boot.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/boot/dts/bcm2835-rpi-b.dts |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 9b72054..6ff26f9 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -1,5 +1,4 @@
 /dts-v1/;
-/memreserve/ 0x0c000000 0x04000000;
 /include/ "bcm2835.dtsi"
 
 / {
-- 
1.7.10.4
