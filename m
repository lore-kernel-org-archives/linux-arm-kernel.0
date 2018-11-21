From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Nov 2018 15:07:00 +0000
Subject: [PATCH] arm64: cpufeature: Fix mismerge of CONFIG_ARM64_SSBD block
Message-ID: <1542812820-24355-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When merging support for SSBD and the CRC32 instructions, the conflict
resolution for the new capability entries in arm64_features[]
inadvertedly predicated the availability of the CRC32 instructions on
CONFIG_ARM64_SSBD, despite the functionality being entirely unrelated.

Move the #ifdef CONFIG_ARM64_SSBD down so that it only covers the SSBD
capability.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index af50064dea51..aec5ecb85737 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1333,7 +1333,6 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_hw_dbm,
 	},
 #endif
-#ifdef CONFIG_ARM64_SSBD
 	{
 		.desc = "CRC32 instructions",
 		.capability = ARM64_HAS_CRC32,
@@ -1343,6 +1342,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64ISAR0_CRC32_SHIFT,
 		.min_field_value = 1,
 	},
+#ifdef CONFIG_ARM64_SSBD
 	{
 		.desc = "Speculative Store Bypassing Safe (SSBS)",
 		.capability = ARM64_SSBS,
-- 
2.1.4
