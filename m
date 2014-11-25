From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Nov 2014 13:27:41 +0000
Subject: [PATCH 1/3] arm64: sanity checks: ignore ID_MMFR0.AuxReg
In-Reply-To: <1416922063-8693-1-git-send-email-mark.rutland@arm.com>
References: <1416922063-8693-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1416922063-8693-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems that Cortex-A53 r0p4 added support for AIFSR and ADFSR, and
ID_MMFR0.AuxReg has been updated accordingly to report this fact. As
Cortex-A53 could be paired with CPUs which do not implement these
registers (e.g. all current revisions of Cortex-A57), this may trigger a
sanity check failure at boot.

The AuxReg value describes the availability of the ACTLR, AIFSR, and
ADFSR registers, which are only of use to 32-bit guest OSs, and have
IMPLEMENTATION DEFINED contents. Given the nature of these registers it
is likely that KVM will need to trap accesses regardless of whether the
CPUs are heterogeneous.

This patch masks out the ID_MMFR0.AuxReg value from the sanity checks,
preventing spurious warnings at boot time.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 arch/arm64/kernel/cpuinfo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 504fdaa..a9ab5b0 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -143,7 +143,12 @@ static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
 	diff |= CHECK(id_isar3, boot, cur, cpu);
 	diff |= CHECK(id_isar4, boot, cur, cpu);
 	diff |= CHECK(id_isar5, boot, cur, cpu);
-	diff |= CHECK(id_mmfr0, boot, cur, cpu);
+	/*
+	 * Regardless of the value of the AuxReg field, the AIFSR, ADFSR, and
+	 * ACTLR formats could differ across CPUs and therefore would have to
+	 * be trapped for virtualization anyway.
+	 */
+	diff |= CHECK_MASK(id_mmfr0, 0xff0fffff, boot, cur, cpu);
 	diff |= CHECK(id_mmfr1, boot, cur, cpu);
 	diff |= CHECK(id_mmfr2, boot, cur, cpu);
 	diff |= CHECK(id_mmfr3, boot, cur, cpu);
-- 
1.9.1
