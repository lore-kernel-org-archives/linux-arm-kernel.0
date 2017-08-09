From: Dave.Martin@arm.com (Dave Martin)
Date: Wed,  9 Aug 2017 13:05:09 +0100
Subject: [PATCH 03/27] arm64: efi: Add missing Kconfig dependency on
 KERNEL_MODE_NEON
In-Reply-To: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1502280338-23002-4-git-send-email-Dave.Martin@arm.com>
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
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dfd9086..fdc302e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1050,6 +1050,7 @@ config EFI_STUB
 config EFI
 	bool "UEFI runtime support"
 	depends on OF && !CPU_BIG_ENDIAN
+	depends on KERNEL_MODE_NEON
 	select LIBFDT
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
-- 
2.1.4
