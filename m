From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 15 Nov 2017 13:34:25 -0800
Subject: [PATCH v2 15/18] efi/libstub: disable LTO
In-Reply-To: <20171115213428.22559-1-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
Message-ID: <20171115213428.22559-16-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_LTO_CLANG, we produce LLVM IR instead of object files. Since LTO
is not really needed here and the Makefile assumes we produce an object file,
disable LTO for libstub.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index adaa4a964f0c..69b3fbfb7f97 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
-				   $(call cc-option,-fno-stack-protector)
+				   $(call cc-option,-fno-stack-protector) \
+				   $(DISABLE_LTO)
 
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
-- 
2.15.0.448.gf294e3d99a-goog
