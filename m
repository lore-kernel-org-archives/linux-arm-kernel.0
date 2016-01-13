From: apinski@cavium.com (Andrew Pinski)
Date: Tue, 12 Jan 2016 23:08:17 -0800
Subject: [PATCH 3/5] ARM64: Add Needs software prefetching cap
In-Reply-To: <1452668899-3553-1-git-send-email-apinski@cavium.com>
References: <1452668899-3553-1-git-send-email-apinski@cavium.com>
Message-ID: <1452668899-3553-4-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ThunderX T88 pass 1 and pass 2 does not include
a hardware prefetching so the memory copying
functions are slower than necessary.  This adds
a cpu feature for this.
The next patch will add the use in both copy_page
and copy_from_user/copy_to_user.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/include/asm/cpufeature.h |    3 ++-
 arch/arm64/kernel/cpufeature.c      |    6 ++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 92aaac6..784bc63 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -32,8 +32,9 @@
 #define ARM64_WORKAROUND_CAVIUM_23154		6
 #define ARM64_WORKAROUND_834220			7
 #define ARM64_WORKAROUND_CAVIUM_27456		8
+#define ARM64_NEEDS_PREFETCH_128		9
 
-#define ARM64_NCAPS				9
+#define ARM64_NCAPS				10
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b0ee60e..13cda09 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -651,6 +651,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = 2,
 	},
 #endif /* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
+	{
+		.desc = "Needs prefetching (128 byte cache line) for copying: ThunderX T88 pass 1.x and 2.x",
+		.capability = ARM64_NEEDS_PREFETCH_128,
+		MIDR_RANGE(MIDR_THUNDERX, 0,
+			   (1 << MIDR_VARIANT_SHIFT) | MIDR_REVISION_MASK),
+	},
 	{},
 };
 
-- 
1.7.2.5
