From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Oct 2018 13:58:39 +0100
Subject: [PATCH 04/26] arm64: Add a helper for PARange to physical shift
 conversion
In-Reply-To: <20181019125901.185478-1-marc.zyngier@arm.com>
References: <20181019125901.185478-1-marc.zyngier@arm.com>
Message-ID: <20181019125901.185478-5-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

On arm64, ID_AA64MMFR0_EL1.PARange encodes the maximum Physical
Address range supported by the CPU. Add a helper to decode this
to actual physical shift. If we hit an unallocated value, return
the maximum range supported by the kernel.
This will be used by KVM to set the VTCR_EL2.T0SZ, as it
is about to move its place. Having this helper keeps the code
movement cleaner.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1717ba1db35d..072cc1c970c2 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -530,6 +530,26 @@ void arm64_set_ssbd_mitigation(bool state);
 static inline void arm64_set_ssbd_mitigation(bool state) {}
 #endif
 
+static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
+{
+	switch (parange) {
+	case 0: return 32;
+	case 1: return 36;
+	case 2: return 40;
+	case 3: return 42;
+	case 4: return 44;
+	case 5: return 48;
+	case 6: return 52;
+	/*
+	 * A future PE could use a value unknown to the kernel.
+	 * However, by the "D10.1.4 Principles of the ID scheme
+	 * for fields in ID registers", ARM DDI 0487C.a, any new
+	 * value is guaranteed to be higher than what we know already.
+	 * As a safe limit, we return the limit supported by the kernel.
+	 */
+	default: return CONFIG_ARM64_PA_BITS;
+	}
+}
 #endif /* __ASSEMBLY__ */
 
 #endif
-- 
2.19.1
