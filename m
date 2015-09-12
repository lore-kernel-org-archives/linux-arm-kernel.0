From: udknight@gmail.com (Wang YanQing)
Date: Sat, 12 Sep 2015 14:04:30 +0800
Subject: [PATCH] ARM: mm: avoid unneeded page protection fault for memory
 range with (VM_PFNMAP|VM_PFNWRITE)
Message-ID: <20150912060430.GA16768@udknight>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add L_PTE_DIRTY to PTEs for memory range with (VM_PFNMAP|VM_PFNWRITE),
then we could avoid unneeded page protection fault in write access
first time due to L_PTE_RDONLY.

There are no valid struct pages behind VM_PFNMAP range, so it make no
sense to set L_PTE_DIRTY in page fault handler.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 arch/arm/include/asm/mman.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 arch/arm/include/asm/mman.h

diff --git a/arch/arm/include/asm/mman.h b/arch/arm/include/asm/mman.h
new file mode 100644
index 0000000..f59bbf3
--- /dev/null
+++ b/arch/arm/include/asm/mman.h
@@ -0,0 +1,21 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef __ASM_ARM_MMAN_H
+#define __ASM_ARM_MMAN_H
+
+#include <uapi/asm/mman.h>
+
+static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
+{
+	if ((vm_flags & (VM_PFNMAP|VM_WRITE)) == (VM_PFNMAP|VM_WRITE))
+		return __pgprot(L_PTE_DIRTY);
+	else
+		return __pgprot(0);
+}
+#define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
+
+#endif	/* __ASM_ARM_MMAN_H */
-- 
1.8.5.6.2.g3d8a54e.dirty
