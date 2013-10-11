From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:07 +0100
Subject: [PATCH 01/14] Docs: arm64: booting: clarify boot requirements
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-2-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

There are a few points in the arm64 booting document which are unclear
(such as the initial state of secondary CPUs), and/or have not been
documented (PSCI is a supported mechanism for booting secondary CPUs).

This patch amends the arm64 boot document to better express the
(existing) requirements, and to describe PSCI as a supported booting
mechanism.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Fu Wei <tekkamanninja@gmail.com>
---
 Documentation/arm64/booting.txt |   45 +++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 98df4a0..a9691cc 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -115,9 +115,10 @@ Before jumping into the kernel, the following conditions must be met:
   External caches (if present) must be configured and disabled.
 
 - Architected timers
-  CNTFRQ must be programmed with the timer frequency.
-  If entering the kernel at EL1, CNTHCTL_EL2 must have EL1PCTEN (bit 0)
-  set where available.
+  CNTFRQ must be programmed with the timer frequency and CNTVOFF must
+  be programmed with a consistent value on all CPUs.  If entering the
+  kernel at EL1, CNTHCTL_EL2 must have EL1PCTEN (bit 0) set where
+  available.
 
 - Coherency
   All CPUs to be booted by the kernel must be part of the same coherency
@@ -130,30 +131,46 @@ Before jumping into the kernel, the following conditions must be met:
   the kernel image will be entered must be initialised by software at a
   higher exception level to prevent execution in an UNKNOWN state.
 
+The requirements described above for CPU mode, caches, MMUs, architected
+timers, coherency and system registers apply to all CPUs.  All CPUs must
+enter the kernel in the same exception level.
+
 The boot loader is expected to enter the kernel on each CPU in the
 following manner:
 
 - The primary CPU must jump directly to the first instruction of the
   kernel image.  The device tree blob passed by this CPU must contain
-  for each CPU node:
-
-    1. An 'enable-method' property. Currently, the only supported value
-       for this field is the string "spin-table".
-
-    2. A 'cpu-release-addr' property identifying a 64-bit,
-       zero-initialised memory location.
+  an 'enable-method' property for each cpu node.  The supported
+  enable-methods are described below.
 
   It is expected that the bootloader will generate these device tree
   properties and insert them into the blob prior to kernel entry.
 
-- Any secondary CPUs must spin outside of the kernel in a reserved area
-  of memory (communicated to the kernel by a /memreserve/ region in the
+- CPUs with a "spin-table" enable-method must have a 'cpu-release-addr'
+  property in their cpu node.  This property identifies a
+  naturally-aligned 64-bit zero-initalised memory location.
+
+  These CPUs should spin outside of the kernel in a reserved area of
+  memory (communicated to the kernel by a /memreserve/ region in the
   device tree) polling their cpu-release-addr location, which must be
   contained in the reserved region.  A wfe instruction may be inserted
   to reduce the overhead of the busy-loop and a sev will be issued by
   the primary CPU.  When a read of the location pointed to by the
-  cpu-release-addr returns a non-zero value, the CPU must jump directly
-  to this value.
+  cpu-release-addr returns a non-zero value, the CPU must jump to this
+  value.  The value will be written as a single 64-bit little-endian
+  value, so CPUs must convert the read value to their native endianness
+  before jumping to it.
+
+- CPUs with a "psci" enable method should remain outside of
+  the kernel (i.e. outside of the regions of memory described to the
+  kernel in the memory node, or in a reserved area of memory described
+  to the kernel by a /memreserve/ region in the device tree).  The
+  kernel will issue CPU_ON calls as described in ARM document number ARM
+  DEN 0022A ("Power State Coordination Interface System Software on ARM
+  processors") to bring CPUs into the kernel.
+
+  The device tree should contain a 'psci' node, as described in
+  Documentation/devicetree/bindings/arm/psci.txt.
 
 - Secondary CPU general-purpose register settings
   x0 = 0 (reserved for future use)
-- 
1.7.9.5
