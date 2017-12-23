From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Sat, 23 Dec 2017 01:43:23 +0100
Subject: [PATCH] arm64: support __int128 with clang
Message-ID: <20171223004323.1986-1-Jason@zx2c4.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit fb8722735f50 ("arm64: support __int128 on gcc 5+") added support
for arm64 __int128 with gcc with a version-conditional, but neglected to
enable this for clang, which in fact appears to support aarch64 __int128.
This commit therefore enables it if the compiler is clang, using the
same type of makefile conditional used elsewhere in the tree.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b481b4a7c011..16c2e8b58546 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -57,7 +57,11 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
+ifeq ($(cc-name),clang)
+KBUILD_CFLAGS	+= -DCONFIG_ARCH_SUPPORTS_INT128
+else
 KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
+endif
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
-- 
2.15.1
