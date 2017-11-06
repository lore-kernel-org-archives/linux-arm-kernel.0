From: Dave.Martin@arm.com (Dave Martin)
Date: Mon,  6 Nov 2017 18:07:11 +0000
Subject: [PATCH] arm64: Make ARMV8_DEPRECATED depend on SYSCTL
Message-ID: <1509991631-7938-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_SYSCTL=n and CONFIG_ARMV8_DEPRECATED=y, the deprecated
instruction emulation code currently leaks some memory at boot
time, and won't have any runtime control interface.  This does
not feel like useful or intended behaviour...

This patch adds a dependency on CONFIG_SYSCTL, so that such a
kernel can't be built in the first place.

It's probably not worth adding the error-handling / cleanup code
that would be needed to deal with this otherwise: people who
desperately need the emulation can still enable SYSCTL.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1046074..df296b7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -807,6 +807,7 @@ config FORCE_MAX_ZONEORDER
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
+	depends on SYSCTL
 	help
 	  Legacy software support may require certain instructions
 	  that have been deprecated or obsoleted in the architecture.
-- 
2.1.4
