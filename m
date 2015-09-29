From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Sep 2015 01:14:02 +0300
Subject: [PATCH v5 05/23] arm64:ilp32: expose 'kernel_long' as 'long long' for
 ILP32
In-Reply-To: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1443564860-31208-6-git-send-email-ynorov@caviumnetworks.com>
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
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

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
2.1.4
