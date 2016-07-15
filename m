From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 15 Jul 2016 13:19:12 +0100
Subject: [PATCH 1/2] ARM: realview: Fix PBX-A9 cache description
Message-ID: <dbf8749c4af9aa5ffb85e961b7ae09ffeefa7f2a.1468583959.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
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
2.8.1.dirty
