From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 28 Aug 2013 12:35:53 +0100
Subject: [RFC PATCH 01/14] arm64: kernel: add MPIDR_EL1 accessors macros
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1377689766-17642-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to simplify access to different affinity levels within the
MPIDR_EL1 register values, this patch implements some preprocessor
macros that allow to retrieve the MPIDR_EL1 affinity level value according
to the level passed as input parameter.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/cputype.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 5fe138e..2c9e295 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -30,6 +30,16 @@
 
 #define MPIDR_HWID_BITMASK	0xff00ffffff
 
+#define MPIDR_LEVEL_BITS 8
+#define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
+
+#define MPIDR_LEVEL_SHIFT(level) ({					\
+	(level == 3) ? 32 : MPIDR_LEVEL_BITS * level;			\
+})
+
+#define MPIDR_AFFINITY_LEVEL(mpidr, level)				\
+	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)	\
+
 #define read_cpuid(reg) ({						\
 	u64 __val;							\
 	asm("mrs	%0, " reg : "=r" (__val));			\
-- 
1.8.3.4
