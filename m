From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 May 2017 10:09:52 +0100
Subject: [PATCH 2/3] efi/libstub: arm64: force 'hidden' visibility for section
 markers
In-Reply-To: <20170518090953.32628-1-ard.biesheuvel@linaro.org>
References: <20170518090953.32628-1-ard.biesheuvel@linaro.org>
Message-ID: <20170518090953.32628-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prevent the compiler from emitting absolute references to the section
markers when running in PIC mode, override the visibility to 'hidden' for
all contents of asm/sections.h

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index b4c2589d7c91..f7a6970e9abc 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -9,9 +9,17 @@
  * published by the Free Software Foundation.
  *
  */
+
+/*
+ * To prevent the compiler from emitting GOT-indirected (and thus absolute)
+ * references to the section markers, override their visibility as 'hidden'
+ */
+#pragma GCC visibility push(hidden)
+#include <asm/sections.h>
+#pragma GCC visibility pop
+
 #include <linux/efi.h>
 #include <asm/efi.h>
-#include <asm/sections.h>
 #include <asm/sysreg.h>
 
 #include "efistub.h"
-- 
2.9.3
