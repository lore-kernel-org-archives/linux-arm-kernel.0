From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Jan 2013 15:34:17 +0000
Subject: [PATCH 6/6] ARM: virt: hide CONFIG_ARM_VIRT_EXT from user
In-Reply-To: <1357918457-20469-1-git-send-email-will.deacon@arm.com>
References: <1357918457-20469-1-git-send-email-will.deacon@arm.com>
Message-ID: <1357918457-20469-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM_VIRT_EXT is a property of CPU_V7, but does not adversely affect
other CPUs that can be built into the same kernel image (i.e. ARMv6+).

This patch defaults ARM_VIRT_EXT to y if CPU_V7, allowing hypervisors
such as KVM to make better use of the option and being able to rely
on hyp-mode boot support.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/Kconfig | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 3fd629d..025d173 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -629,8 +629,9 @@ config ARM_THUMBEE
 	  make use of it. Say N for code that can run on CPUs without ThumbEE.
 
 config ARM_VIRT_EXT
-	bool "Native support for the ARM Virtualization Extensions"
-	depends on MMU && CPU_V7
+	bool
+	depends on MMU
+	default y if CPU_V7
 	help
 	  Enable the kernel to make use of the ARM Virtualization
 	  Extensions to install hypervisors without run-time firmware
@@ -640,11 +641,6 @@ config ARM_VIRT_EXT
 	  use of this feature.  Refer to Documentation/arm/Booting for
 	  details.
 
-	  It is safe to enable this option even if the kernel may not be
-	  booted in HYP mode, may not have support for the
-	  virtualization extensions, or may be booted with a
-	  non-compliant bootloader.
-
 config SWP_EMULATE
 	bool "Emulate SWP/SWPB instructions"
 	depends on !CPU_USE_DOMAINS && CPU_V7
-- 
1.8.0
