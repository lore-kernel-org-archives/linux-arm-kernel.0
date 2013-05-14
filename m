From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 14:04:43 +0100
Subject: [PATCH 7/8] ARM: mpu: Allow enabling of the MPU via kconfig
In-Reply-To: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
References: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368536684-13608-8-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows the user to select MPU support when compiling for ARM processors
that support the PMSAv7.

This ensures that CONFIG_SMP depends on the MPU in the case that no MMU
is present.

CONFIG_SMP_ON_UP is not implemented for nommu, so introduce an MMU
dependency there.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig       |    4 ++--
 arch/arm/Kconfig-nommu |   11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d423d58..e337618 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1413,7 +1413,7 @@ config SMP
 	depends on CPU_V6K || CPU_V7
 	depends on GENERIC_CLOCKEVENTS
 	depends on HAVE_SMP
-	depends on MMU
+	depends on MMU || ARM_MPU
 	select USE_GENERIC_SMP_HELPERS
 	help
 	  This enables support for systems with more than one CPU. If you have
@@ -1434,7 +1434,7 @@ config SMP
 
 config SMP_ON_UP
 	bool "Allow booting SMP kernel on uniprocessor systems (EXPERIMENTAL)"
-	depends on SMP && !XIP_KERNEL
+	depends on SMP && !XIP_KERNEL && MMU
 	default y
 	help
 	  SMP kernels contain instructions which fail on non-SMP processors.
diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index 2cef8e1..8ceed61 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -50,3 +50,14 @@ config REMAP_VECTORS_TO_RAM
 	  Otherwise, say 'y' here.  In this case, the kernel will require
 	  external support to redirect the hardware exception vectors to
 	  the writable versions located at DRAM_BASE.
+
+config ARM_MPU
+       bool 'Use the ARM v7 PMSA Compliant MPU'
+       default y
+       help
+         Some ARM systems without an MMU have instead a Memory Protection
+         Unit (MPU) that defines the type and permissions for regions of
+         memory.
+
+         If your CPU has an MPU then you should choose 'y' here unless you
+         know that you do not want to use the MPU.
-- 
1.7.9.5
