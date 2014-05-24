From: apinski@cavium.com (Andrew Pinski)
Date: Sat, 24 May 2014 00:01:59 -0700
Subject: [PATCH 04/24] ARM64:ILP32: Set kernel_long to long long so we can
 reuse most of the same syscalls as LP64.
In-Reply-To: <1400914939-9708-1-git-send-email-apinski@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
Message-ID: <1400914939-9708-5-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we want time_t and some other userland types to be the same between ILP32 and LP64, we define __kernel_long_t to be long long. 

Thanks,
Andrew Pinski


Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/include/asm/Kbuild             |    1 -
 arch/arm64/include/uapi/asm/posix_types.h |   12 ++++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm64/include/uapi/asm/posix_types.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 83f71b3..f06a9c2 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -30,7 +30,6 @@ generic-y += msgbuf.h
 generic-y += mutex.h
 generic-y += pci.h
 generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
 generic-y += resource.h
 generic-y += rwsem.h
diff --git a/arch/arm64/include/uapi/asm/posix_types.h b/arch/arm64/include/uapi/asm/posix_types.h
new file mode 100644
index 0000000..53b15e6
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/posix_types.h
@@ -0,0 +1,12 @@
+#ifndef __ASM_POSIX_TYPES_H
+#define __ASM_POSIX_TYPES_H
+
+#ifndef __LP64__	/* ILP32 */
+typedef long long __kernel_long_t;
+typedef unsigned long long __kernel_ulong_t;
+#define __kernel_long_t __kernel_long_t
+#endif
+
+#include <asm-generic/posix_types.h>
+
+#endif /* __ASM_POSIX_TYPES_H */
-- 
1.7.2.5
