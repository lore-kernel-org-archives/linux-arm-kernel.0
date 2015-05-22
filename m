From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 22 May 2015 14:43:07 +0900
Subject: [PATCH] fixup! arm64: allow kernel Image to be loaded anywhere in
 physical memory
In-Reply-To: <1431328388-3051-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1431328388-3051-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1432273387-7385-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard,

In testing my kexec/dump code, I found that your patch doesn't work
with initrd. Since the virtual addresses of initrd are calc'ed earlier
than map_mem(), they have bogus values and unpack_to_rootfs() will fail.

This patch fixes the issue.
Please think of taking it in your next version.
---
 arch/arm64/mm/mmu.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7e3e6af..43c2317 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/initrd.h>
 #include <linux/libfdt.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
@@ -452,6 +453,13 @@ static void __init map_mem(void)
 	bootstrap_linear_mapping(new_va_offset);
 
 	kernel_va_offset = new_va_offset;
+
+	/* Recalculate virtual addresses of initrd region */
+	if (initrd_start) {
+		initrd_start += new_va_offset;
+		initrd_end += new_va_offset;
+	}
+
 	memstart_addr = new_memstart_addr;
 
 	/* map all the memory banks */
-- 
1.7.9.5
