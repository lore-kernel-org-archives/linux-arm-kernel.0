From: rabin@rab.in (Rabin Vincent)
Date: Sun, 14 Feb 2010 01:18:31 +0530
Subject: [PATCH 03/10] ftrace: allow building without frame pointers
In-Reply-To: <1266090518-31120-1-git-send-email-rabin@rab.in>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
Message-ID: <1266090518-31120-4-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With current gcc, compiling with both -pg and -fomit-frame-pointer is
not allowed.  However, -pg can be used to build without actually
specying -fno-omit-frame-pointer, upon which the defaut behaviour for
the target will be used.

On ARM, it is not possible to build a Thumb-2 kernel with
-fno-omit-frame-pointer (FRAME_POINTERS depends on !THUMB2_KERNEL). In
order to support ftrace for Thumb-2, we need to be able to allow a
combination of FUNCTION_TRACER and !FRAME_POINTER.  We do this by
omitting -fomit-frame-pointer if ftrace is enabled.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 67d6cff..72d90de 100644
--- a/Makefile
+++ b/Makefile
@@ -546,8 +546,11 @@ endif
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else
+ifndef CONFIG_FUNCTION_TRACER
+# -fomit-frame-pointer is incompatible with -pg
 KBUILD_CFLAGS	+= -fomit-frame-pointer
 endif
+endif
 
 ifdef CONFIG_DEBUG_INFO
 KBUILD_CFLAGS	+= -g
-- 
1.6.6
