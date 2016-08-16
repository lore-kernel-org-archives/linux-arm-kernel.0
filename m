From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 16 Aug 2016 11:46:55 +0100
Subject: [PATCH v2 4/7] ARM: update MPIDR accessors macro
In-Reply-To: <1471344418-19568-1-git-send-email-vladimir.murzin@arm.com>
References: <1471344418-19568-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1471344418-19568-5-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vgic-v3 driver queries CPU affinity level up to Aff3, which is valid for arm64.
However, for arm up to Aff2 levels are supported, so querying for 3rd level
ends with upper bits of MPIDR are treated as valid affinity level which
is not true. So, report zero for any affinity level above 2.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/cputype.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 1ee94c7..96cef49 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -55,9 +55,10 @@
 
 #define MPIDR_LEVEL_BITS 8
 #define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
+#define MPIDR_LEVEL_SHIFT(level) (MPIDR_LEVEL_BITS * level)
 
 #define MPIDR_AFFINITY_LEVEL(mpidr, level) \
-	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
+	((level < 3) ? ((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK) : 0)
 
 #define ARM_CPU_IMP_ARM			0x41
 #define ARM_CPU_IMP_INTEL		0x69
-- 
1.7.9.5
