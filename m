From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Mar 2018 13:52:54 +0100
Subject: [PATCH 85/85] arm64: Add temporary ERRATA_MIDR_ALL_VERSIONS
 compatibility macro
In-Reply-To: <20180328125254.31380-1-marc.zyngier@arm.com>
References: <20180328125254.31380-1-marc.zyngier@arm.com>
Message-ID: <20180328125254.31380-86-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MIDR_ALL_VERSIONS is changing, and won't have the same meaning
in 4.17, and the right thing to use will be ERRATA_MIDR_ALL_VERSIONS.

In order to cope with the merge window, let's add a compatibility
macro that will allow a relatively smooth transition, and that
can be removed post 4.17-rc1.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index aacdc118c4c9..7369ad552700 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -241,6 +241,10 @@ static int qcom_enable_link_stack_sanitization(void *data)
 	.midr_range_min = 0, \
 	.midr_range_max = (MIDR_VARIANT_MASK | MIDR_REVISION_MASK)
 
+#ifndef ERRATA_MIDR_ALL_VERSIONS
+#define	ERRATA_MIDR_ALL_VERSIONS(x)	MIDR_ALL_VERSIONS(x)
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
@@ -429,12 +433,12 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "Cortex-A57 EL2 vector hardening",
 		.capability = ARM64_HARDEN_EL2_VECTORS,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
 	},
 	{
 		.desc = "Cortex-A72 EL2 vector hardening",
 		.capability = ARM64_HARDEN_EL2_VECTORS,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
 	},
 #endif
 	{
-- 
2.14.2
