From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed, 30 Sep 2015 17:56:41 +0200
Subject: [PATCH] ARM: fix vdsomunge depends on glibc specific byteswap.h
In-Reply-To: <cover.1443628457.git.hns@goldelico.com>
References: <cover.1443628457.git.hns@goldelico.com>
Message-ID: <2039A9BE-ADA4-4D28-84F4-C8B9D76834AD@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the host toolchain is not glibc based then the arm kernel build
fails with

 HOSTCC  arch/arm/vdso/vdsomunge
 arch/arm/vdso/vdsomunge.c:48:22: fatal error: byteswap.h: No such file or directory

Observed with omap2plus_defconfig and compile on Mac OS X with arm ELF
cross-compiler.

Reason: byteswap.h is a glibc only header.

Changed to detect the host and include the right file as described at:

 https://bugs.freedesktop.org/show_bug.cgi?id=8882

Tested to compile on Mac OS X 10.9.5 host.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
arch/arm/vdso/vdsomunge.c | 18 ++++++++++++++++++
1 file changed, 18 insertions(+)

diff --git a/arch/arm/vdso/vdsomunge.c b/arch/arm/vdso/vdsomunge.c
index aedec81..5364cea 100644
--- a/arch/arm/vdso/vdsomunge.c
+++ b/arch/arm/vdso/vdsomunge.c
@@ -45,7 +45,25 @@
 * it does.
 */

+#if defined(__linux__)
#include <byteswap.h>
+#elif defined(__OpenBSD__)
+#include <sys/endian.h>
+#define bswap_16 __swap16
+#define bswap_32 __swap32
+#define bswap_64 __swap64
+#elif defined(__APPLE__)
+#include <libkern/OSByteOrder.h>
+#define bswap_16 OSSwapInt16
+#define bswap_32 OSSwapInt32
+#define bswap_64 OSSwapInt64
+#else
+#include <sys/endian.h>
+#define bswap_16 bswap16
+#define bswap_32 bswap32
+#define bswap_64 bswap64
+#endif
+
#include <elf.h>
#include <errno.h>
#include <fcntl.h>
-- 
2.5.1
