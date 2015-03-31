From: byan@nvidia.com (Bo Yan)
Date: Tue, 31 Mar 2015 13:30:48 -0700
Subject: [PATCH] arm64: fix midr range for Cortex-A57 erratum 832075
Message-ID: <1427833848-12188-1-git-send-email-byan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register MIDR_EL1 is masked to get variant and revision fields, then
compared against midr_range_min and midr_range_max when checking
whether CPU is affected by any particular erratum. However, variant
and revision fields in MIDR_EL1 are separated by 16 bits, so the min
and max of midr range should be constructed accordingly, otherwise
the patch will not be applied when variant field is non-0.

Signed-off-by: Bo Yan <byan@nvidia.com>
---
 arch/arm64/kernel/cpu_errata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index fa62637e63a8..7838f1578019 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -88,7 +88,7 @@ struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A57 r0p0 - r1p2 */
 		.desc = "ARM erratum 832075",
 		.capability = ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE,
-		MIDR_RANGE(MIDR_CORTEX_A57, 0x00, 0x12),
+		MIDR_RANGE(MIDR_CORTEX_A57, 0x00, 0x100002),
 	},
 #endif
 	{
-- 
2.1.4
