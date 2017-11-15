From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 15 Nov 2017 13:34:19 -0800
Subject: [PATCH v2 09/18] arm64: explicitly pass --no-fix-cortex-a53-843419 to
 GNU gold
In-Reply-To: <20171115213428.22559-1-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
Message-ID: <20171115213428.22559-10-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some versions of GNU gold are known to produce broken code with
--fix-cortex-a53-843419 as explained in this bug:

  https://sourceware.org/bugzilla/show_bug.cgi?id=21491

If ARM64_ERRATUM_843419 is disabled and we're using GNU gold, pass
--no-fix-cortex-a53-843419 to the linker to ensure the erratum fix is not
used even if the linker is configured to enable it by default.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6059c8169513..ca700b201736 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -30,6 +30,11 @@ LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
   endif
 endif
 
+ifeq ($(CONFIG_ARM64_ERRATUM_843419),)
+# https://sourceware.org/bugzilla/show_bug.cgi?id=21491
+LDFLAGS_GOLD	+= --no-fix-cortex-a53-843419
+endif
+
 KBUILD_DEFCONFIG := defconfig
 
 # Check for binutils support for specific extensions
-- 
2.15.0.448.gf294e3d99a-goog
