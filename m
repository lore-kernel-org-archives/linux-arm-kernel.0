From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  2 Oct 2015 17:37:54 +0100
Subject: [PATCH 5/5] arm64: Update booting requirements for GICv3 in GICv2 mode
In-Reply-To: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
References: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443803874-9566-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current requirements do not describe the case where a GICv3
system gets booted with system register access disabled, and
expect the kernel to drive GICv3 in GICv2 mode.

Describe the expected settings for that particular case.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/booting.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 7d9d3c2..369a4f4 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -173,13 +173,22 @@ Before jumping into the kernel, the following conditions must be met:
   the kernel image will be entered must be initialised by software at a
   higher exception level to prevent execution in an UNKNOWN state.
 
-  For systems with a GICv3 interrupt controller:
+  For systems with a GICv3 interrupt controller to be used in v3 mode:
   - If EL3 is present:
     ICC_SRE_EL3.Enable (bit 3) must be initialiased to 0b1.
     ICC_SRE_EL3.SRE (bit 0) must be initialised to 0b1.
   - If the kernel is entered at EL1:
     ICC.SRE_EL2.Enable (bit 3) must be initialised to 0b1
     ICC_SRE_EL2.SRE (bit 0) must be initialised to 0b1.
+  - The DT or ACPI tables must describe a GICv3 interrupt controller.
+
+  For systems with a GICv3 interrupt controller to be used in
+  compatibility (v2) mode:
+  - If EL3 is present:
+    ICC_SRE_EL3.SRE (bit 0) must be initialised to 0b0.
+  - If the kernel is entered at EL1:
+    ICC_SRE_EL2.SRE (bit 0) must be initialised to 0b0.
+  - The DT or ACPI tables must describe a GICv2 interrupt controller.
 
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
-- 
2.1.4
