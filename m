From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 15 Jul 2014 08:39:06 +0100
Subject: [PATCH] arm64: Move struct stat64 to uapi.
Message-ID: <1405409946-1790-1-git-send-email-ijc@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This struct is part of the user API for compat tasks so I think it belongs in
uapi and should use the __uFOO types.

This was exposed by the Debian kernel's application of the aufs patches which
led to:

In file included from /?PKGBUILDDIR?/include/linux/mm.h:23:0,
                 from /?PKGBUILDDIR?/include/linux/pid_namespace.h:6,
                 from /?PKGBUILDDIR?/include/linux/ptrace.h:9,
                 from /?PKGBUILDDIR?/arch/arm64/include/asm/compat.h:26,
                 from /?PKGBUILDDIR?/arch/arm64/include/asm/stat.h:23,
                 from /?PKGBUILDDIR?/include/linux/stat.h:5,
                 from /?PKGBUILDDIR?/include/linux/module.h:10,
                 from /?PKGBUILDDIR?/init/main.c:15:
/?PKGBUILDDIR?/include/linux/fs.h:1575:64: warning: 'struct kstat' declared inside parameter list [enabled by default]
  int (*getattr) (struct vfsmount *mnt, struct dentry *, struct kstat *);
                                                                ^
/?PKGBUILDDIR?/include/linux/fs.h:1575:64: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

This is due to an extra fs.h include added to mm.h. arm64 was the only arch built by
Debian which had an issue with this, so I think it is an issue with the arm64
headers rather than the aufs patches.

Full logs in http://buildd.debian-ports.org/status/fetch.php?pkg=linux&arch=arm64&ver=3.14.12-1&stamp=1405234443

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/include/asm/stat.h      | 61 --------------------------------------
 arch/arm64/include/uapi/asm/stat.h | 42 ++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 61 deletions(-)
 delete mode 100644 arch/arm64/include/asm/stat.h

diff --git a/arch/arm64/include/asm/stat.h b/arch/arm64/include/asm/stat.h
deleted file mode 100644
index 15e3559..0000000
--- a/arch/arm64/include/asm/stat.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_STAT_H
-#define __ASM_STAT_H
-
-#include <uapi/asm/stat.h>
-
-#ifdef CONFIG_COMPAT
-
-#include <asm/compat.h>
-
-/*
- * struct stat64 is needed for compat tasks only. Its definition is different
- * from the generic struct stat64.
- */
-struct stat64 {
-	compat_u64	st_dev;
-	unsigned char   __pad0[4];
-
-#define STAT64_HAS_BROKEN_ST_INO	1
-	compat_ulong_t	__st_ino;
-	compat_uint_t	st_mode;
-	compat_uint_t	st_nlink;
-
-	compat_ulong_t	st_uid;
-	compat_ulong_t	st_gid;
-
-	compat_u64	st_rdev;
-	unsigned char   __pad3[4];
-
-	compat_s64	st_size;
-	compat_ulong_t	st_blksize;
-	compat_u64	st_blocks;	/* Number of 512-byte blocks allocated. */
-
-	compat_ulong_t	st_atime;
-	compat_ulong_t	st_atime_nsec;
-
-	compat_ulong_t	st_mtime;
-	compat_ulong_t	st_mtime_nsec;
-
-	compat_ulong_t	st_ctime;
-	compat_ulong_t	st_ctime_nsec;
-
-	compat_u64	st_ino;
-};
-
-#endif
-#endif
diff --git a/arch/arm64/include/uapi/asm/stat.h b/arch/arm64/include/uapi/asm/stat.h
index eeb702e..4bc1f59 100644
--- a/arch/arm64/include/uapi/asm/stat.h
+++ b/arch/arm64/include/uapi/asm/stat.h
@@ -13,4 +13,46 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#ifndef __ASM_STAT_H
+#define __ASM_STAT_H
+
+#include <asm/types.h>
+
 #include <asm-generic/stat.h>
+
+/*
+ * struct stat64 is needed for compat tasks only. Its definition is different
+ * from the generic struct stat64.
+ */
+struct stat64 {
+	__u64		st_dev;
+	__u8		__pad0[4];
+
+#define STAT64_HAS_BROKEN_ST_INO	1
+	__u32		__st_ino;
+	__u32		st_mode;
+	__u32		st_nlink;
+
+	__u32		st_uid;
+	__u32		st_gid;
+
+	__u64		st_rdev;
+	__u8		__pad3[4];
+
+	__s64		st_size;
+	__u32		st_blksize;
+	__u64		st_blocks;	/* Number of 512-byte blocks allocated. */
+
+	__u32		st_atime;
+	__u32		st_atime_nsec;
+
+	__u32		st_mtime;
+	__u32		st_mtime_nsec;
+
+	__u32		st_ctime;
+	__u32		st_ctime_nsec;
+
+	__u64		st_ino;
+};
+
+#endif
-- 
2.0.1
