From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 2 Sep 2015 17:00:37 +0300
Subject: [PATCH v2 1/2] arm64: cpufeature.h: resolve hidden header dependencies
In-Reply-To: <1441202438-27005-1-git-send-email-ynorov@caviumnetworks.com>
References: <1441202438-27005-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1441202438-27005-2-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Functions implemented in cpufeature.h depend on some headers, but
cpufeature.h does not include them. This may cause build failure if
cpufeature.h user does not include that headers by itself. (Like it
happens in next patch of this series.)

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/cpufeature.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c104421..f0e4017 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -19,7 +19,6 @@
  */
 
 #define MAX_CPU_FEATURES	(8 * sizeof(elf_hwcap))
-#define cpu_feature(x)		ilog2(HWCAP_ ## x)
 
 #define ARM64_WORKAROUND_CLEAN_CACHE		0
 #define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
@@ -30,6 +29,14 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bitmap.h>
+#include <linux/compiler.h>
+#include <linux/log2.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+#define cpu_feature(x)		ilog2(HWCAP_ ## x)
+
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
-- 
2.1.4
