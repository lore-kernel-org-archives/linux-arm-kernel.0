From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:07 +0800
Subject: [PATCH v3 08/62] arm/acpi: Add arm specific acpi header file
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-9-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Add architecture specific definitions and calls required for acpi in new
header file.

Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/arch/arm/setup.c       |  3 +++
 xen/include/asm-arm/acpi.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 xen/include/asm-arm/acpi.h

diff --git a/xen/arch/arm/setup.c b/xen/arch/arm/setup.c
index e95759d..3b29904 100644
--- a/xen/arch/arm/setup.c
+++ b/xen/arch/arm/setup.c
@@ -45,11 +45,14 @@
 #include <asm/procinfo.h>
 #include <asm/setup.h>
 #include <xsm/xsm.h>
+#include <asm/acpi.h>
 
 struct bootinfo __initdata bootinfo;
 
 struct cpuinfo_arm __read_mostly boot_cpu_data;
 
+bool_t __read_mostly acpi_disabled;
+
 #ifdef CONFIG_ARM_32
 static unsigned long opt_xenheap_megabytes __initdata;
 integer_param("xenheap_megabytes", opt_xenheap_megabytes);
diff --git a/xen/include/asm-arm/acpi.h b/xen/include/asm-arm/acpi.h
new file mode 100644
index 0000000..e41e03b
--- /dev/null
+++ b/xen/include/asm-arm/acpi.h
@@ -0,0 +1,38 @@
+/*
+ *  Copyright (C) 2015, Shannon Zhao <shannon.zhao@linaro.org>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#ifndef _ASM_ARM_ACPI_H
+#define _ASM_ARM_ACPI_H
+
+#include <xen/init.h>
+
+#define COMPILER_DEPENDENT_INT64   long long
+#define COMPILER_DEPENDENT_UINT64  unsigned long long
+
+extern bool_t acpi_disabled;
+/* Basic configuration for ACPI */
+static inline void disable_acpi(void)
+{
+    acpi_disabled = 1;
+}
+
+#endif /*_ASM_ARM_ACPI_H*/
-- 
2.1.0
