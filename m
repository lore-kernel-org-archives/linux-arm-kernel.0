From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 11 Aug 2012 12:04:34 +0100
Subject: [PATCH 4/7] ARM: virt: Update documentation for hyp mode entry support
In-Reply-To: <1344683077-12841-1-git-send-email-marc.zyngier@arm.com>
References: <1344683077-12841-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1344683077-12841-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

Document the possibility of the kernel being entered in HYP mode.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm/Booting |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
index a341d87..0c1f475 100644
--- a/Documentation/arm/Booting
+++ b/Documentation/arm/Booting
@@ -154,13 +154,33 @@ In either case, the following conditions must be met:
 
 - CPU mode
   All forms of interrupts must be disabled (IRQs and FIQs)
-  The CPU must be in SVC mode.  (A special exception exists for Angel)
+
+  For CPUs which do not include the ARM virtualization extensions, the
+  CPU must be in SVC mode.  (A special exception exists for Angel)
+
+  CPUs which include support for the virtualization extensions can be
+  entered in HYP mode in order to enable the kernel to make full use of
+  these extensions.  This is the recommended boot method for such CPUs,
+  unless the virtualisations are already in use by a pre-installed
+  hypervisor.
+
+  If the kernel is not entered in HYP mode for any reason, it must be
+  entered in SVC mode.
 
 - Caches, MMUs
   The MMU must be off.
   Instruction cache may be on or off.
   Data cache must be off.
 
+  If the kernel is entered in HYP mode, the above requirements apply to
+  the HYP mode configuration in addition to the ordinary PL1 (privileged
+  kernel modes) configuration.  In addition, all traps into the
+  hypervisor must be disabled, and PL1 access must be granted for all
+  peripherals and CPU resources for which this is architecturally
+  possible.  Except for entering in HYP mode, the system configuration
+  should be such that a kernel which does not include support for the
+  virtualization extensions can boot correctly without extra help.
+
 - The boot loader is expected to call the kernel image by jumping
   directly to the first instruction of the kernel image.
 
-- 
1.7.8.6
