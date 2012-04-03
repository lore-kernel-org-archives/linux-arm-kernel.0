From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Apr 2012 09:17:21 +0100
Subject: [PATCH] Use arm_memblock_steal
Message-ID: <20120403081720.GP24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the provided function rather than re-coding this bit of code.
This also gets us protection against using these functions from
invalid contexts.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Please test this; I've not even compile tested this.  Thanks.

 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index f7b074f..c27058e 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -32,12 +32,12 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/leds.h>
-#include <linux/memblock.h>
 #include <media/soc_camera.h>
 #include <sound/tlv320aic32x4.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/memblock.h>
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
 
@@ -193,10 +193,8 @@ static void __init visstrim_camera_init(void)
 static void __init visstrim_reserve(void)
 {
 	/* reserve 4 MiB for mx2-camera */
-	mx2_camera_base = memblock_alloc(MX2_CAMERA_BUF_SIZE,
+	mx2_camera_base = arm_memblock_steal(MX2_CAMERA_BUF_SIZE,
 			MX2_CAMERA_BUF_SIZE);
-	memblock_free(mx2_camera_base, MX2_CAMERA_BUF_SIZE);
-	memblock_remove(mx2_camera_base, MX2_CAMERA_BUF_SIZE);
 }
 
 /* GPIOs used as events for applications */
