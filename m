From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 11:24:13 +0100
Subject: [PATCH 2/2] arm: bcm2835: properly use IOMEM() to define virtual
 address constants
In-Reply-To: <1351419853-25146-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351419853-25146-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1351419853-25146-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like we now do for all ARM platforms, use IOMEM() to define virtual
address constants, so that they get typed as 'void __iomem *'
pointers. It for now requires a cast when defining the map_desc entry,
but that cast should disappear once we switch map_desc to the usage of
'void __iomem *' pointers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-bcm2835/bcm2835.c |    2 +-
 arch/arm/mach-bcm2835/bcm2835.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c
index cb2f963..9366c8f 100644
--- a/arch/arm/mach-bcm2835/bcm2835.c
+++ b/arch/arm/mach-bcm2835/bcm2835.c
@@ -24,7 +24,7 @@
 #include "bcm2835.h"
 
 static struct map_desc io_map __initdata = {
-	.virtual = BCM2835_PERIPH_VIRT,
+	.virtual = (unsigned long) BCM2835_PERIPH_VIRT,
 	.pfn = __phys_to_pfn(BCM2835_PERIPH_PHYS),
 	.length = BCM2835_PERIPH_SIZE,
 	.type = MT_DEVICE
diff --git a/arch/arm/mach-bcm2835/bcm2835.h b/arch/arm/mach-bcm2835/bcm2835.h
index 8fbad3a..db9d51e 100644
--- a/arch/arm/mach-bcm2835/bcm2835.h
+++ b/arch/arm/mach-bcm2835/bcm2835.h
@@ -21,7 +21,7 @@
 #include <asm/sizes.h>
 
 #define BCM2835_PERIPH_PHYS	0x20000000
-#define BCM2835_PERIPH_VIRT	0xf0000000
+#define BCM2835_PERIPH_VIRT	IOMEM(0xf0000000)
 #define BCM2835_PERIPH_SIZE	SZ_16M
 
 #endif
-- 
1.7.9.5
