From: geoff@infradead.org (Geoff Levand)
Date: Thu, 17 Apr 2014 11:17:03 -0700
Subject: [PATCH] arm64: Fix PSCI part of booting.txt
Message-ID: <1397758623.30572.53.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct the PSCI booting text to match the requirements
of the PSCI spec.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Hi Will,

Based on the PSCI doc (DEN 0022B.b), to use CPU_ON the
cpu can only be powered down with CPU_OFF, and it seems
from the doc that the code that calls CPU_OFF could be
anywhere in memory, since once the CPU_OFF call is made
the cpu is powered off and never executes any more 
instructions from memory.  CPU_ON is given an
entry_point_address parameter, which would be specific
to the code calling CPU_ON.

Did I misunderstand something, or should we change this
text as below?

-Geoff

 Documentation/arm64/booting.txt | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index beb754e..8f9074f 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -167,13 +167,12 @@ following manner:
   value, so CPUs must convert the read value to their native endianness
   before jumping to it.
 
-- CPUs with a "psci" enable method should remain outside of
-  the kernel (i.e. outside of the regions of memory described to the
-  kernel in the memory node, or in a reserved area of memory described
-  to the kernel by a /memreserve/ region in the device tree).  The
-  kernel will issue CPU_ON calls as described in ARM document number ARM
-  DEN 0022A ("Power State Coordination Interface System Software on ARM
-  processors") to bring CPUs into the kernel.
+- CPUs with a "psci" enable method should use the PSCI CPU control
+  functions described in ARM document number ARM DEN 0022A or newer
+  ("Power State Coordination Interface System Software on ARM
+  processors").  The boot loader must power off these CPU's using the
+  PSCI CPU_OFF function.  The kernel will issue CPU_ON calls to bring
+  CPUs into the kernel.
 
   The device tree should contain a 'psci' node, as described in
   Documentation/devicetree/bindings/arm/psci.txt.
-- 
1.9.1
