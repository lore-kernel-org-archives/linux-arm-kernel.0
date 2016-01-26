From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 26 Jan 2016 09:23:42 +0000
Subject: [PATCH 3/4] ARM: introduce cpu feature helper for unsigned values
In-Reply-To: <1453800223-18590-1-git-send-email-vladimir.murzin@arm.com>
References: <1453800223-18590-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1453800223-18590-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the CPU feature bits have unsigned values and need to be treated
accordingly to avoid errors. Add the new cpu feature helper for such
cases.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/cputype.h |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 1ee94c7..d93ced5 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -270,8 +270,15 @@ static inline int cpu_is_pj4(void)
 #define cpu_is_pj4()	0
 #endif
 
-static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
-								  int field)
+
+static inline unsigned int __attribute_const__
+cpuid_feature_extract_unsigned_field(u32 features, int field)
+{
+	return (features >> field) & 15;
+}
+
+static inline int __attribute_const__
+cpuid_feature_extract_field(u32 features, int field)
 {
 	int feature = (features >> field) & 15;
 
@@ -285,4 +292,7 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
 #define cpuid_feature_extract(reg, field) \
 	cpuid_feature_extract_field(read_cpuid_ext(reg), field)
 
+#define cpuid_feature_extract_unsigned(reg, field) \
+	cpuid_feature_extract_unsigned_field(read_cpuid_ext(reg), field)
+
 #endif
-- 
1.7.9.5
