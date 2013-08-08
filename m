From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  8 Aug 2013 13:06:50 +0200
Subject: [RFC PATCH] types.h: use GCC supplied typedefs if appropriate
Message-ID: <1375960010-4214-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GCC supplies a set of builtin defines that are meant to be used in the typedefs
for types such as uint8_t, uint16_t etc. In fact, this is exactly what the
stdint.h header does (of which GCC supplies its own version for freestanding
builds). So in stdint.h, the types are defined as

typedef __UINT16_TYPE__ uint16_t
typedef __UINT32_TYPE__ uint32_t

However, types.h in the kernel contains its own type definitions for these
stdint.h types, and these do not depend on the GCC builtins.

In the ARM world, both bare metal and glibc targeted versions of GCC are
supported for building the kernel, and unfortunately, these do not agree on the
definition of __UINT32_TYPE__ (likewise for __INT32_TYPE__ and __UINTPTR_TYPE__)
- bare metal uses 'long unsigned int'
- glibc GCC uses 'unsigned int'

The result of this is that, while it is perfectly feasible in principle to
support code that includes 'stdint.h' by compiling with -ffreestanding, (such as
code using NEON intrinsics, whose header 'arm_neon.h' includes 'stdint.h'), in
practice this breaks because we may end up with conflicting type definitions for
uint32_t (and uintptr_t) depending on whether you are using bare metal GCC or
glibc GCC.

Arguably, this is a GCC issue because a) it does not pick up on the fact that
'typedef unsigned int uint32_t' and 'typedef long unsigned int uint32_t' are not
in fact conflicting or b) it maintains this trivial difference between bare
metal and glibc targeted build configs.

However, even if I am aware that stdint.h support or matters related to it may
be controversial subjects, fixing it in the kernel is not /that/ obtrusive, and
solves matters for older GCCs as well, hence this RFC patch.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/types.h | 55 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index 4d118ba..40c5925 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -33,7 +33,11 @@ typedef __kernel_gid32_t	gid_t;
 typedef __kernel_uid16_t        uid16_t;
 typedef __kernel_gid16_t        gid16_t;
 
-typedef unsigned long		uintptr_t;
+#ifndef __UINTPTR_TYPE__
+#define __UINTPTR_TYPE__	unsigned long
+#endif
+
+typedef __UINTPTR_TYPE__	uintptr_t;
 
 #ifdef CONFIG_UID16
 /* This is defined by include/asm-{arch}/posix_types.h */
@@ -91,26 +95,51 @@ typedef unsigned short		ushort;
 typedef unsigned int		uint;
 typedef unsigned long		ulong;
 
+#ifndef __UINT8_TYPE__
+#define __UINT8_TYPE__		__u8
+#endif
+#ifndef __INT8_TYPE__
+#define __INT8_TYPE__		__s8
+#endif
+#ifndef __UINT16_TYPE__
+#define __UINT16_TYPE__		__u16
+#endif
+#ifndef __INT16_TYPE__
+#define __INT16_TYPE__		__s16
+#endif
+#ifndef __UINT32_TYPE__
+#define __UINT32_TYPE__		__u32
+#endif
+#ifndef __INT32_TYPE__
+#define __INT32_TYPE__		__s32
+#endif
+#ifndef __UINT64_TYPE__
+#define __UINT64_TYPE__		__u64
+#endif
+#ifndef __INT64_TYPE__
+#define __INT64_TYPE__		__s64
+#endif
+
 #ifndef __BIT_TYPES_DEFINED__
 #define __BIT_TYPES_DEFINED__
 
-typedef		__u8		u_int8_t;
-typedef		__s8		int8_t;
-typedef		__u16		u_int16_t;
-typedef		__s16		int16_t;
-typedef		__u32		u_int32_t;
-typedef		__s32		int32_t;
+typedef		__UINT8_TYPE__	u_int8_t;
+typedef		__INT8_TYPE__	int8_t;
+typedef		__UINT16_TYPE__	u_int16_t;
+typedef		__INT16_TYPE__	int16_t;
+typedef		__UINT32_TYPE__	u_int32_t;
+typedef		__INT32_TYPE__	int32_t;
 
 #endif /* !(__BIT_TYPES_DEFINED__) */
 
-typedef		__u8		uint8_t;
-typedef		__u16		uint16_t;
-typedef		__u32		uint32_t;
+typedef		__UINT8_TYPE__	uint8_t;
+typedef		__UINT16_TYPE__	uint16_t;
+typedef		__UINT32_TYPE__	uint32_t;
 
 #if defined(__GNUC__)
-typedef		__u64		uint64_t;
-typedef		__u64		u_int64_t;
-typedef		__s64		int64_t;
+typedef		__UINT64_TYPE__	uint64_t;
+typedef		__UINT64_TYPE__	u_int64_t;
+typedef		__INT64_TYPE__	int64_t;
 #endif
 
 /* this is a special 64bit data type that is 8-byte aligned */
-- 
1.8.1.2
