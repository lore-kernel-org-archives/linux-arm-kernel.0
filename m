From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 19 May 2017 16:42:02 +0100
Subject: [PATCH] ARM: make configuration of userspace Thumb support an expert
 option
Message-ID: <E1dBk2U-0000eE-Ai@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Mosberger reports random segfaults and other problems when running
his buildroot userspace.  It turns out that his kernel did not have
support for Thumb userspace, nor did his application, but glibc made use
of Thumb instructions in glibc.

The kernel Thumb support option already recommends being enabled, and
is also so biased, but clearly this is not enough of a recommendation.

So, hide this behind CONFIG_EXPERT as well, and include a note to
indicate the potential issues if it's turned off and userspace Thumb
mode is made use of.

Reported-by: David Mosberger <davidm@egauge.net>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c6c4c9c8824b..4f68659abe6c 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -679,7 +679,7 @@ config ARCH_DMA_ADDR_T_64BIT
 	bool
 
 config ARM_THUMB
-	bool "Support Thumb user binaries" if !CPU_THUMBONLY
+	bool "Support Thumb user binaries" if !CPU_THUMBONLY && EXPERT
 	depends on CPU_THUMB_CAPABLE
 	default y
 	help
@@ -690,6 +690,10 @@ config ARM_THUMB
 	  instruction set resulting in smaller binaries at the expense of
 	  slightly less efficient code.
 
+	  If this option is disabled, and you run userspace that switches to
+	  Thumb mode, signal handling will not work correctly, resulting in
+	  segmentation faults or illegal instruction aborts.
+
 	  If you don't know what this all is, saying Y is a safe choice.
 
 config ARM_THUMBEE
-- 
2.7.4
