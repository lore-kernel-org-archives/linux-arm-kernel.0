From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 14 Jun 2012 12:43:31 +0100
Subject: [PATCH v2] ARM: vexpress: Enable SPARSE_IRQ
In-Reply-To: <1339673581.3044.10.camel@linaro1.home>
References: <1339607602-3846-1-git-send-email-tixy@linaro.org>
 <20120614085553.GB28714@n2100.arm.linux.org.uk>
 <1339673581.3044.10.camel@linaro1.home>
Message-ID: <1339674211.3044.14.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable vexpress to be included in multiplatform kernels containing
boards which require SPARSE_IRQ, we need to also support this option.
This turns out to be very simple...

We remove NR_IRQS from mach/irq.h as that is unused with SPARSE_IRQ
and include this header directly in ct-ca9x4.c as it will no longer
be included via asm/irq.h.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 arch/arm/mach-vexpress/include/mach/irqs.h |    2 --
 arch/arm/mach-vexpress/ct-ca9x4.c          |    1 +
 arch/arm/Kconfig                           |    1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/include/mach/irqs.h b/arch/arm/mach-vexpress/include/mach/irqs.h
index 4b10ee7..b64611d 100644
--- a/arch/arm/mach-vexpress/include/mach/irqs.h
+++ b/arch/arm/mach-vexpress/include/mach/irqs.h
@@ -1,4 +1,2 @@
 #define IRQ_LOCALTIMER		29
 #define IRQ_LOCALWDOG		30
-
-#define NR_IRQS	256
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 3ef3fda..0f477a5 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -26,6 +26,7 @@
 
 #include "core.h"
 
+#include <mach/irqs.h>
 #include <mach/motherboard.h>
 
 #include <plat/clcd.h>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6f3370e..9dd9701 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -314,6 +314,7 @@ config ARCH_VEXPRESS
 	select NO_IOPORT
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
+	select SPARSE_IRQ
 	help
 	  This enables support for the ARM Ltd Versatile Express boards.
 
-- 
1.7.10
