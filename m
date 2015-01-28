From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:10 +0100
Subject: [PATCH 03/15] ARM: disable branch profiling in uncompressor
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The branch profiling code cannot work outside of the main
kernel and just causes link errors if we try to use it in
the decompressor. Disabling it here matches what we do
for other architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/compressed/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 14965795bcca..2ed6a785b37e 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -119,6 +119,8 @@ extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern piggy.lz4 \
 		 lib1funcs.S ashldi3.S bswapsdi2.S $(libfdt) $(libfdt_hdrs) \
 		 hyp-stub.S
 
+KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
+
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
-- 
2.1.0.rc2
