From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2016 14:02:17 +0200
Subject: [PATCH] ARM: dts: realview: Fix PBX-A9 cache description
Message-ID: <1470830537-12307-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <robin.murphy@arm.com>

Clearly QEMU is very permissive in how its PL310 model may be set up,
but the real hardware turns out to be far more particular about things
actually being correct. Fix up the DT description so that the real
thing actually boots:

- The arm,data-latency and arm,tag-latency properties need 3 cells to
  be valid, otherwise we end up retaining the default 8-cycle latencies
  which leads pretty quickly to lockup.
- The arm,dirty-latency property is only relevant to L210/L220, so get
  rid of it.
- The cache geometry override also leads to lockup and/or general
  misbehaviour. Irritatingly, the manual doesn't state the actual PL310
  configuration, but based on the boardfile code and poking registers
  from the Boot Monitor, it would seem to be 8 sets of 16KB ways.

With that, we can successfully boot to enjoy the fun of mismatched FPUs...

Cc: stable at vger.kernel.org
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for fixes. I had
queued it for worries of clashing with other updates, but I think
it will be fine, and it needs to go in for v4.8.
---
 arch/arm/boot/dts/arm-realview-pbx-a9.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-pbx-a9.dts b/arch/arm/boot/dts/arm-realview-pbx-a9.dts
index db808f92dd79..90d00b407f85 100644
--- a/arch/arm/boot/dts/arm-realview-pbx-a9.dts
+++ b/arch/arm/boot/dts/arm-realview-pbx-a9.dts
@@ -70,13 +70,12 @@
 		 * associativity as these may be erroneously set
 		 * up by boot loader(s).
 		 */
-		cache-size = <1048576>; // 1MB
-		cache-sets = <4096>;
+		cache-size = <131072>; // 128KB
+		cache-sets = <512>;
 		cache-line-size = <32>;
 		arm,parity-disable;
-		arm,tag-latency = <1>;
-		arm,data-latency = <1 1>;
-		arm,dirty-latency = <1>;
+		arm,tag-latency = <1 1 1>;
+		arm,data-latency = <1 1 1>;
 	};
 
 	scu: scu at 1f000000 {
-- 
2.7.4
