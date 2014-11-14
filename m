From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 14 Nov 2014 16:21:32 +0100
Subject: [PATCHv2 12/16] ARM: mvebu: make sure MMU is disabled in
 armada_370_xp_cpu_resume
In-Reply-To: <1415978496-9334-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1415978496-9334-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1415978496-9334-13-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armada_370_xp_cpu_resume() until now was used only as the function
called by the SoC when returning from a deep idle state (as used in
cpuidle, or when the CPU is brought offline using CPU hotplug).

However, it is now also used when exiting the suspend to RAM state. In
this case, it is the bootloader that calls back into this function,
with the MMU left enabled by the BootROM. Having the MMU enabled when
entering this function confuses the kerrnel because we are not using
the kernel page tables at this point, but in other mvebu functions we
use the information on whether the MMU is enabled or not to find out
whether we should talk to the coherency fabric using a physical
address or a virtual address. To fix that, we simply disable the MMU
when entering this function, so that the kernel is in an expected
situation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu_ll.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
index a945756..ae7e6b0 100644
--- a/arch/arm/mach-mvebu/pmsu_ll.S
+++ b/arch/arm/mach-mvebu/pmsu_ll.S
@@ -18,6 +18,14 @@
  */
 ENTRY(armada_370_xp_cpu_resume)
 ARM_BE8(setend	be )			@ go BE8 if entered LE
+	/*
+	 * Disable the MMU that might have been enabled in BootROM if
+	 * this code is used in the resume path of a suspend/resume
+	 * cycle.
+	 */
+	mrc	p15, 0, r1, c1, c0, 0
+	bic	r1, #1
+	mcr	p15, 0, r1, c1, c0, 0
 	bl	ll_add_cpu_to_smp_group
 	bl	ll_enable_coherency
 	b	cpu_resume
-- 
2.1.0
