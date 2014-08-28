From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Aug 2014 19:37:04 +0100
Subject: [PATCH] Doc: dt: arch_timer: discourage clock-frequency use
Message-ID: <1409251024-19103-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was previously posted inline in another thread [1]. This version has the
requested fixups and a few more CCs for others who might be interested.

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/282804.html

---->8----
The ARM Generic Timer (AKA the architected timer, arm_arch_timer)
features a CPU register (CNTFRQ) which firmware is intended to
initialize, and non-secure software can read to determine the frequency
of the timer. On CPUs with secure state, this register cannot be written
from non-secure states.

The firmware of early SoCs featuring the timer did not correctly
initialize CNTFRQ correctly on all CPUs, requiring the frequency to be
described in DT as a workaround. This workaround is not complete however
as it is exposed to all software in a privileged non-secure mode
(including guests running under a hypervisor). The firmware and DTs for
recent SoCs have followed the example set by these early SoCs.

This patch updates the arch timer binding documentation to make it
clearer that the use of the clock-frequency property is a poor
work-around. The MMIO generic timer binding is similarly updated, though
this is less of a concern as there is generally no need to expose the
MMIO timers to guest OSs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/devicetree/bindings/arm/arch_timer.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
index 37b2caf..620ac0c 100644
--- a/Documentation/devicetree/bindings/arm/arch_timer.txt
+++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
@@ -17,7 +17,10 @@ to deliver its interrupts via SPIs.
 - interrupts : Interrupt list for secure, non-secure, virtual and
   hypervisor timers, in that order.
 
-- clock-frequency : The frequency of the main counter, in Hz. Optional.
+- clock-frequency : The frequency of the main counter, in Hz. Should be present
+  only where necessary to work around broken firmware which does not configure
+  CNTFRQ on all CPUs to a uniform correct value. Use of this property is
+  strongly discouraged; fix your firmware unless absolutely impossible.
 
 - always-on : a boolean property. If present, the timer is powered through an
   always-on power domain, therefore it never loses context.
@@ -38,7 +41,8 @@ Example:
 
 - compatible : Should at least contain "arm,armv7-timer-mem".
 
-- clock-frequency : The frequency of the main counter, in Hz. Optional.
+- clock-frequency : The frequency of the main counter, in Hz. Should be present
+  only when firmware has not configured the MMIO CNTFRQ registers.
 
 - reg : The control frame base address.
 
-- 
1.9.1
