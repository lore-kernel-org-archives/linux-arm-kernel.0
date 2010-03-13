From: rabin@rab.in (Rabin Vincent)
Date: Sat, 13 Mar 2010 12:19:40 +0530
Subject: [PATCH 03/10] ftrace: allow building without frame pointers
In-Reply-To: <1268462987-8271-1-git-send-email-rabin@rab.in>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
Message-ID: <1268462987-8271-4-git-send-email-rabin@rab.in>
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

Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
v2: Better comment.

 Makefile |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 08ff02d..61404e0 100644
--- a/Makefile
+++ b/Makefile
@@ -546,8 +546,15 @@ endif
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else
+# Some targets (ARM with Thumb2, for example), can't be built with frame
+# pointers.  For those, we don't have FUNCTION_TRACER automatically
+# select FRAME_POINTER.  However, FUNCTION_TRACER adds -pg, and this is
+# incompatible with -fomit-frame-pointer with current GCC, so we don't use
+# -fomit-frame-pointer with FUNCTION_TRACER.
+ifndef CONFIG_FUNCTION_TRACER
 KBUILD_CFLAGS	+= -fomit-frame-pointer
 endif
+endif
 
 ifdef CONFIG_DEBUG_INFO
 KBUILD_CFLAGS	+= -g
-- 
1.7.0
