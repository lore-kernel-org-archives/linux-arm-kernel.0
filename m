From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 15 Nov 2017 13:34:14 -0800
Subject: [PATCH v2 04/18] arm64: use -mno-implicit-float instead of
 -mgeneral-regs-only
In-Reply-To: <20171115213428.22559-1-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
Message-ID: <20171115213428.22559-5-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Hackmann <ghackmann@google.com>

LLVM bug 30792 causes clang's AArch64 backend to crash compiling
arch/arm64/crypto/aes-ce-cipher.c.  Replacing -mgeneral-regs-only with
-mno-implicit-float is the suggested workaround.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
[added cc-ifversion to enable the workaround only for clang <6.0]
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b35788c909f1..ecd5ed11c764 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -49,7 +49,13 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
   endif
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
+ifeq ($(cc-name),clang)
+# This is a workaround for https://bugs.llvm.org/show_bug.cgi?id=30792.
+KBUILD_CFLAGS	+= $(call cc-ifversion, -lt, 0600, -mno-implicit-float, -mgeneral-regs-only)
+else
+KBUILD_CFLAGS	+= -mgeneral-regs-only
+endif
+KBUILD_CFLAGS	+= $(lseinstr) $(brokengasinst)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
 KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
-- 
2.15.0.448.gf294e3d99a-goog
