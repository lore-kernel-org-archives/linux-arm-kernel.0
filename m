From: rogerq@ti.com (Roger Quadros)
Date: Tue, 18 Jun 2013 14:11:29 +0300
Subject: [PATCH 2/4] ARM: dts: omap4-panda: Fix DVI EDID reads
In-Reply-To: <1371553891-29364-1-git-send-email-rogerq@ti.com>
References: <1371553891-29364-1-git-send-email-rogerq@ti.com>
Message-ID: <1371553891-29364-3-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Panda the +5V supply for DVI EDID is supplied by the
same regulator that poweres the USB Hub. Currently, the
DSS/DVI subsystem doesn't know how to manage this regulator
and so DVI EDID reads will fail if USB Hub is not enabled.

As a temporary fix we keep this regulator permanently enabled
on boot. This fixes the DVI EDID read problem.

CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 7a21e8e..40df79e 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -80,6 +80,11 @@
 		gpio = <&gpio1 1 0>;	/* gpio_1 */
 		startup-delay-us = <70000>;
 		enable-active-high;
+		/*
+		 * FIXME: Remove boot-on when DSS can handle this regulator
+		 * for DVI EDID.
+		 */
+		regulator-boot-on;
 	};
 
 	/* HS USB Host PHY on PORT 1 */
-- 
1.7.4.1
