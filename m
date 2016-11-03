From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Nov 2016 18:46:25 +0000
Subject: arm64 build failure with CONFIG_ARM64_LSE_ATOMICS=y
In-Reply-To: <20161103111238.GC24243@shodan.usersys.redhat.com>
References: <20161102164427.GB24243@shodan.usersys.redhat.com>
 <20161102232854.GO22791@arm.com>
 <1efb101a-a8ab-5ad9-f2bd-e7d485c71904@arm.com>
 <20161103111238.GC24243@shodan.usersys.redhat.com>
Message-ID: <20161103184624.GA695@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 12:12:38PM +0100, Artem Savkov wrote:
> On Thu, Nov 03, 2016 at 10:39:43AM +0000, Suzuki K Poulose wrote:
> > On 02/11/16 23:28, Will Deacon wrote:
> > > On Wed, Nov 02, 2016 at 05:44:27PM +0100, Artem Savkov wrote:
> > > > Looks like your patch "efd9e03 arm64: Use static keys for CPU features"
> > > > breaks arm64 build with "CONFIG_ARM64_LSE_ATOMICS=y" because it creates a
> > > > circular dependency for asm/lse.h through jump_label.h:
[...]
> Apparently it fails with an older gcc (4.8.5), but doesn't with 6.2.0.
> The different bit is that with 4.8.5 I don't have CC_HAVE_ASM_GOTO set.
> It is reproducible with 6.2.0 if you manually remove CC_HAVE_ASM_GOTO.

-----------8<----------------
>From e27eb40cd5af38f1a5e64553a367220f00a1b5d8 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 3 Nov 2016 18:34:34 +0000
Subject: [PATCH] arm64: Fix circular include of asm/lse.h through
 linux/jump_label.h

Commit efd9e03facd0 ("arm64: Use static keys for CPU features")
introduced support for static keys in asm/cpufeature.h, including
linux/jump_label.h. When CC_HAVE_ASM_GOTO is not defined, this causes a
circular dependency via linux/atomic.h, asm/lse.h and asm/cpufeature.h.

This patch moves the capability macros out out of asm/cpufeature.h into
a separate asm/cpucaps.h and modifies some of the #includes accordingly.

Fixes: efd9e03facd0 ("arm64: Use static keys for CPU features")
Reported-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/alternative.h |  2 +-
 arch/arm64/include/asm/cpucaps.h     | 40 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cpufeature.h  | 20 +-----------------
 arch/arm64/include/asm/lse.h         |  1 -
 4 files changed, 42 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm64/include/asm/cpucaps.h

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 39feb85a6931..6e1cb8c5af4d 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_ALTERNATIVE_H
 #define __ASM_ALTERNATIVE_H
 
-#include <asm/cpufeature.h>
+#include <asm/cpucaps.h>
 #include <asm/insn.h>
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
new file mode 100644
index 000000000000..87b446535185
--- /dev/null
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -0,0 +1,40 @@
+/*
+ * arch/arm64/include/asm/cpucaps.h
+ *
+ * Copyright (C) 2016 ARM Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_CPUCAPS_H
+#define __ASM_CPUCAPS_H
+
+#define ARM64_WORKAROUND_CLEAN_CACHE		0
+#define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
+#define ARM64_WORKAROUND_845719			2
+#define ARM64_HAS_SYSREG_GIC_CPUIF		3
+#define ARM64_HAS_PAN				4
+#define ARM64_HAS_LSE_ATOMICS			5
+#define ARM64_WORKAROUND_CAVIUM_23154		6
+#define ARM64_WORKAROUND_834220			7
+#define ARM64_HAS_NO_HW_PREFETCH		8
+#define ARM64_HAS_UAO				9
+#define ARM64_ALT_PAN_NOT_UAO			10
+#define ARM64_HAS_VIRT_HOST_EXTN		11
+#define ARM64_WORKAROUND_CAVIUM_27456		12
+#define ARM64_HAS_32BIT_EL0			13
+#define ARM64_HYP_OFFSET_LOW			14
+#define ARM64_MISMATCHED_CACHE_LINE_SIZE	15
+
+#define ARM64_NCAPS				16
+
+#endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index a27c3245ba21..0bc0b1de90c4 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -11,6 +11,7 @@
 
 #include <linux/jump_label.h>
 
+#include <asm/cpucaps.h>
 #include <asm/hwcap.h>
 #include <asm/sysreg.h>
 
@@ -24,25 +25,6 @@
 #define MAX_CPU_FEATURES	(8 * sizeof(elf_hwcap))
 #define cpu_feature(x)		ilog2(HWCAP_ ## x)
 
-#define ARM64_WORKAROUND_CLEAN_CACHE		0
-#define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
-#define ARM64_WORKAROUND_845719			2
-#define ARM64_HAS_SYSREG_GIC_CPUIF		3
-#define ARM64_HAS_PAN				4
-#define ARM64_HAS_LSE_ATOMICS			5
-#define ARM64_WORKAROUND_CAVIUM_23154		6
-#define ARM64_WORKAROUND_834220			7
-#define ARM64_HAS_NO_HW_PREFETCH		8
-#define ARM64_HAS_UAO				9
-#define ARM64_ALT_PAN_NOT_UAO			10
-#define ARM64_HAS_VIRT_HOST_EXTN		11
-#define ARM64_WORKAROUND_CAVIUM_27456		12
-#define ARM64_HAS_32BIT_EL0			13
-#define ARM64_HYP_OFFSET_LOW			14
-#define ARM64_MISMATCHED_CACHE_LINE_SIZE	15
-
-#define ARM64_NCAPS				16
-
 #ifndef __ASSEMBLY__
 
 #include <linux/kernel.h>
diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index 23acc00be32d..fc756e22c84c 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -5,7 +5,6 @@
 
 #include <linux/stringify.h>
 #include <asm/alternative.h>
-#include <asm/cpufeature.h>
 
 #ifdef __ASSEMBLER__
 

-- 
Catalin
