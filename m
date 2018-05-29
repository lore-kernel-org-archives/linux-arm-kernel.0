From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 May 2018 13:11:10 +0100
Subject: [PATCH v2 06/17] arm64: ssbd: Add global mitigation state accessor
In-Reply-To: <20180529121121.24927-1-marc.zyngier@arm.com>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
Message-ID: <20180529121121.24927-7-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're about to need the mitigation state in various parts of the
kernel in order to do the right thing for userspace and guests.

Let's expose an accessor that will let other subsystems know
about the state.

Reviewed-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b50650f3e496..b0fc3224ce8a 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -543,6 +543,16 @@ static inline u64 read_zcr_features(void)
 #define ARM64_SSBD_FORCE_ENABLE		2
 #define ARM64_SSBD_MITIGATED		3
 
+static inline int arm64_get_ssbd_state(void)
+{
+#ifdef CONFIG_ARM64_SSBD
+	extern int ssbd_state;
+	return ssbd_state;
+#else
+	return ARM64_SSBD_UNKNOWN;
+#endif
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
-- 
2.14.2
