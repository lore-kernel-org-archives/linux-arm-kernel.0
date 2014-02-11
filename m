From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Feb 2014 11:37:06 +0000
Subject: [PATCH 1/7] Documentation: devicetree: fix up pl011 clocks
In-Reply-To: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1392118632-11312-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "arm,pl011" device tree binding only describes the apb_pclk clock
input, which is not sufficient to use the device. Knowledge of the
uartclk clock input is required to be able to change the baud rate, as
the baud rate is derived from the reference uartclk input. On systems
where the uartclk input is not initially enabled, it is also required to
use the device in any fashion.

This patch adds the uartclk input to the pl011 device tree binding. The
clock-names property is also described, as it is an implied requirement
of the primecell binding the pl011 binding is derived from.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 Documentation/devicetree/bindings/serial/pl011.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/pl011.txt b/Documentation/devicetree/bindings/serial/pl011.txt
index 5d2e840..f0a9e77 100644
--- a/Documentation/devicetree/bindings/serial/pl011.txt
+++ b/Documentation/devicetree/bindings/serial/pl011.txt
@@ -8,8 +8,10 @@ Required properties:
 Optional properties:
 - pinctrl: When present, must have one state named "sleep"
 	   and one state named "default"
-- clocks:  When present, must refer to exactly one clock named
-	   "apb_pclk"
+- clocks:  When present, must refer to a clock named
+           "apb_pclk", and optionally "uartclk".
+- clock-names: When present, should include "apb_pclk" and
+	   "uartclk", matching the clocks property.
 - dmas:	   When present, may have one or two dma channels.
 	   The first one must be named "rx", the second one
 	   must be named "tx".
-- 
1.8.1.1
