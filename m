From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  7 Sep 2011 17:03:05 +0100
Subject: [PATCH] ARM: Documentation: Update the Booting document with SMP boot
	advice
Message-ID: <1315411385-17669-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, Booting doesn't say anything about booting on an SMP
system.

Although SMP boot varies somewhat from platform to platform, there
are some general requirements which will usually apply.  This patch
documents those likely requirements, which should help to encourage
some consistency between implementations.

There's also some minor rearrangement of the text to restore a
logical reading order after the other changes.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 Documentation/arm/Booting |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
index a341d87..dac6f02 100644
--- a/Documentation/arm/Booting
+++ b/Documentation/arm/Booting
@@ -146,22 +146,31 @@ In either case, the following conditions must be met:
   corrupted by bogus network packets or disk data. This will save
   you many hours of debug.
 
-- CPU register settings
+- Put the CPU(s) into the appropriate state.
+  On SMP systems, these requirements normally apply to all secondary
+  CPUs as well as the boot CPU.  However, the exact requirements for
+  secondary CPUs may be platform-specific.
+
+  - CPU mode
+    All forms of interrupts must be disabled (IRQs and FIQs)
+    The CPU must be in SVC mode.  (A special exception exists for Angel)
+
+  - Caches, MMUs
+    The MMU must be off.
+    Instruction cache may be on or off.
+    Data cache must be off.
+
+  - For SMP platforms, put the secondary CPUs in the appropriate state
+    (such as entering a wait loop).  The exact requirements depend on
+    the platform code.
+
+- Boot CPU register settings
   r0 = 0,
   r1 = machine type number discovered in (3) above.
   r2 = physical address of tagged list in system RAM, or
        physical address of device tree block (dtb) in system RAM
 
-- CPU mode
-  All forms of interrupts must be disabled (IRQs and FIQs)
-  The CPU must be in SVC mode.  (A special exception exists for Angel)
-
-- Caches, MMUs
-  The MMU must be off.
-  Instruction cache may be on or off.
-  Data cache must be off.
-
-- The boot loader is expected to call the kernel image by jumping
+- Finally, the boot loader is expected to call the kernel image by jumping
   directly to the first instruction of the kernel image.
 
   On CPUs supporting the ARM instruction set, the entry must be
-- 
1.7.4.1
