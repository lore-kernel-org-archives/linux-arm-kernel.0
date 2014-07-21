From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Jul 2014 17:16:25 +0200
Subject: [RFC PATCH 10/10] arm64: Kconfig: enable UEFI on BE kernels
In-Reply-To: <1405955785-13477-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1405955785-13477-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1405955785-13477-11-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes the Kconfig logic to allow EFI to be enabled on a BE kernel build.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9d8af2fc389..9fa1383acbd3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -301,16 +301,20 @@ config CMDLINE_FORCE
 config EFI_STUB
 	bool
 
+config EFI_LE_STUB
+	bool
+
 config EFI
 	bool "UEFI runtime support"
-	depends on OF && !CPU_BIG_ENDIAN
+	depends on OF
 	select LIBFDT
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
 	select EFI_RUNTIME_WRAPPERS
-	select EFI_STUB
+	select EFI_STUB if !CPU_BIG_ENDIAN
+	select EFI_LE_STUB if CPU_BIG_ENDIAN
 	select EFI_ARMSTUB
-	default y
+	default y if !CPU_BIG_ENDIAN
 	help
 	  This option provides support for runtime services provided
 	  by UEFI firmware (such as non-volatile variables, realtime
-- 
1.8.3.2
