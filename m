From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 14 Nov 2014 15:54:07 +0000
Subject: [PATCH 1/6] arm64: add cpu_capabilities bitmap
In-Reply-To: <1415980452-20366-1-git-send-email-andre.przywara@arm.com>
References: <1415980452-20366-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1415980452-20366-2-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For taking note if at least one CPU in the system needs a bug
workaround or would benefit from a code optimization, we create a new
bitmap to hold (artificial) feature bits.
Since elf_hwcap is part of the userland ABI, we keep it alone and
introduce a new data structure for that (along with some accessors).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |   20 ++++++++++++++++++++
 arch/arm64/kernel/setup.c           |    3 +++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index cd4ac05..20b2b3d6 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -21,9 +21,29 @@
 #define MAX_CPU_FEATURES	(8 * sizeof(elf_hwcap))
 #define cpu_feature(x)		ilog2(HWCAP_ ## x)
 
+#define NCAPS			0
+
+extern DECLARE_BITMAP(cpu_hwcaps, NCAPS);
+
 static inline bool cpu_have_feature(unsigned int num)
 {
 	return elf_hwcap & (1UL << num);
 }
 
+static inline bool cpus_have_cap(unsigned int num)
+{
+	if (num >= NCAPS)
+		return false;
+	return test_bit(num, cpu_hwcaps);
+}
+
+static inline void cpus_set_cap(unsigned int num)
+{
+	if (num >= NCAPS)
+		pr_warn("Attempt to set an illegal CPU capability (%d >= %d)\n",
+			num, NCAPS);
+	else
+		__set_bit(num, cpu_hwcaps);
+}
+
 #endif
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 2437196..453acd6 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -49,6 +49,7 @@
 #include <asm/cputype.h>
 #include <asm/elf.h>
 #include <asm/cputable.h>
+#include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
@@ -77,6 +78,8 @@ unsigned int compat_elf_hwcap __read_mostly = COMPAT_ELF_HWCAP_DEFAULT;
 unsigned int compat_elf_hwcap2 __read_mostly;
 #endif
 
+DECLARE_BITMAP(cpu_hwcaps, NCAPS);
+
 static const char *cpu_name;
 static const char *machine_name;
 phys_addr_t __fdt_pointer __initdata;
-- 
1.7.9.5
