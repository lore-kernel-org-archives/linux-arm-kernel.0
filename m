From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu,  8 Oct 2015 19:01:41 +0900
Subject: [PATCH v3 4/7] arm64: ftrace: allow for tracing leaf functions
In-Reply-To: <1444298504-10392-1-git-send-email-takahiro.akashi@linaro.org>
References: <1444298504-10392-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1444298504-10392-5-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_FRAME_POINTER is always enabled on arm64, adding
-fno-omit-frame-pointer, while ftrace, CONFIG_FUNCTION_TRACER, adds -pg
to KBUILD_CFLAGS.
The combination of these options, however, does not implicitly enables
-fno-omit-leaf-frame-pointer option, and no leaf functions are actually
traced under ftrace.

This patch allows for tracing leaf functions by adding
-fno-omit-leaf-frame-pointer option, but does it only when
CONFIG_STACK_TRACER is configured because it will increase the kernel
size and add extra instructions on runtime.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/Makefile |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index f9914d7..71cad91 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -28,6 +28,11 @@ endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr)
 KBUILD_AFLAGS	+= $(lseinstr)
+ifdef CONFIG_STACK_TRACER
+ifdef CONFIG_FRAME_POINTER
+KBUILD_CFLAGS	+= -mno-omit-leaf-frame-pointer
+endif
+endif
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
-- 
1.7.9.5
