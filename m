From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 31 Aug 2017 18:00:35 +0100
Subject: [PATCH v2 03/28] arm64: efi: Add missing Kconfig dependency on
 KERNEL_MODE_NEON
In-Reply-To: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com>
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1504198860-12951-4-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EFI runtime services ABI permits calls to EFI to clobber
certain FPSIMD/NEON registers, as per the AArch64 procedure call
standard.

Saving/restoring the clobbered registers around such calls needs
KERNEL_MODE_NEON, but the dependency is missing from Kconfig.

This patch adds the missing dependency.

This will aid bisection of the patches implementing support for the
ARM Scalable Vector Extension (SVE).

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6..ca711ac 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1063,6 +1063,7 @@ config EFI_STUB
 config EFI
 	bool "UEFI runtime support"
 	depends on OF && !CPU_BIG_ENDIAN
+	depends on KERNEL_MODE_NEON
 	select LIBFDT
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
-- 
2.1.4
