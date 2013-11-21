From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 21 Nov 2013 11:24:08 +0000
Subject: [PATCH RFC v3 01/12] arm64: kernel: add MPIDR_EL1 accessors macros
In-Reply-To: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1385033059-25896-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to simplify access to different affinity levels within the
MPIDR_EL1 register values, this patch implements some preprocessor
macros that allow to retrieve the MPIDR_EL1 affinity level value according
to the level passed as input parameter.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/cputype.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 5fe138e..e371936 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -30,6 +30,16 @@
 
 #define MPIDR_HWID_BITMASK	0xff00ffffff
 
+#define MPIDR_LEVEL_BITS_SHIFT	3
+#define MPIDR_LEVEL_BITS	(1 << MPIDR_LEVEL_BITS_SHIFT)
+#define MPIDR_LEVEL_MASK	((1 << MPIDR_LEVEL_BITS) - 1)
+
+#define MPIDR_LEVEL_SHIFT(level) \
+	(((1 << level) >> 1) << MPIDR_LEVEL_BITS_SHIFT)
+
+#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
+	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
+
 #define read_cpuid(reg) ({						\
 	u64 __val;							\
 	asm("mrs	%0, " reg : "=r" (__val));			\
-- 
1.8.4
