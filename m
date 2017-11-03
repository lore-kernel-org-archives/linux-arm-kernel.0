From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri,  3 Nov 2017 10:11:51 -0700
Subject: [PATCH 06/15] efi/libstub: disable LTO
In-Reply-To: <20171103171203.107569-1-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
Message-ID: <20171103171203.107569-8-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_CLANG_LTO, we produce LLVM IR instead of object files. Since LTO
is not really needed here and the Makefile assumes we produce an object file,
disable LTO for libstub.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 2371a92808be..5146eee677ce 100644
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
2.15.0.403.gc27cc4dac6-goog
