From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 13 Apr 2015 21:44:15 +0200
Subject: [PATCH v4 05/24] arm64:ilp32: expose 'kernel_long' as 'long long' for
 ILP32
In-Reply-To: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
Message-ID: <0e9c7a8542dbd411cbf5af432f9c96c399bd8c3a.1428953303.git.philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Since we want time_t and some other userland types to be the same
between ILP32 and LP64, we define __kernel_long_t to be long long.

To reuse the bulk of LP64 system calls (and data structures), the LP64
kernel data types ('kernel_long', 'kernel_ulong') are exposed as their
ILP32 'long long' and 'unsigned long long' equivalents to allow glibc
to correctly interpret most data-structures used in the kernel ABI
(i.el with the exception of those, that include pointers).

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 arch/arm64/include/uapi/asm/posix_types.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/posix_types.h b/arch/arm64/include/uapi/asm/posix_types.h
index 7985ff6..d6a7cb5 100644
--- a/arch/arm64/include/uapi/asm/posix_types.h
+++ b/arch/arm64/include/uapi/asm/posix_types.h
@@ -5,6 +5,16 @@ typedef unsigned short __kernel_old_uid_t;
 typedef unsigned short __kernel_old_gid_t;
 #define __kernel_old_uid_t __kernel_old_uid_t
 
+#if defined(__ILP32__)
+/* The ILP32 kernel ABI reuses LP64 system calls where possible; to
+   this end, the equivalent ILP32 type definitions are used (a 64bit
+   'long'-type in LP64 corresponds to a 'long long' in LP64).  */
+
+typedef long long           __kernel_long_t;
+typedef unsigned long long  __kernel_ulong_t;
+#define __kernel_long_t     __kernel_long_t
+#endif /* defined(__ILP32__) */
+
 #include <asm-generic/posix_types.h>
 
-#endif /*  __ASM_POSIX_TYPES_H */
+#endif /* __ASM_POSIX_TYPES_H */
-- 
1.9.1
