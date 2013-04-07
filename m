From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sun,  7 Apr 2013 22:22:50 +0200
Subject: [PATCH] ARM: S3C24XX: Correct NR_IRQS definition for s3c2440
Message-ID: <1365366170-9682-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to NR_IRQS being incorrectly defined not all IRQ domains can
be registered for S3C2440. It causes following errors on a s3c2440
SoC based board:

NR_IRQS:89
S3C2440: IRQ Support
irq: clearing pending status 00000002
------------[ cut here ]------------
WARNING: at kernel/irq/irqdomain.c:234 0xc0056ed0()
...
irq: could not create irq-domain
...
s3c2410-wdt s3c2410-wdt: failed to install irq (-22)
s3c2410-wdt: probe of s3c2410-wdt failed with error -22
...
samsung-uart s3c2440-uart.0: cannot get irq 74

Fix this by increasing NR_IRQS to at least (IRQ_S3C2443_AC97 + 1)
if CPU_S3C2440 is selected, so the subintc IRQ domain gets properly
registered.

Cc: Heiko St?bner <heiko@sntech.de>
Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-s3c24xx/include/mach/irqs.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/irqs.h b/arch/arm/mach-s3c24xx/include/mach/irqs.h
index 43cada8..b6dd4cb 100644
--- a/arch/arm/mach-s3c24xx/include/mach/irqs.h
+++ b/arch/arm/mach-s3c24xx/include/mach/irqs.h
@@ -192,10 +192,8 @@
 
 #if defined(CONFIG_CPU_S3C2416)
 #define NR_IRQS (IRQ_S3C2416_I2S1 + 1)
-#elif defined(CONFIG_CPU_S3C2443)
-#define NR_IRQS (IRQ_S3C2443_AC97+1)
 #else
-#define NR_IRQS (IRQ_S3C2440_AC97+1)
+#define NR_IRQS (IRQ_S3C2443_AC97 + 1)
 #endif
 
 /* compatibility define. */
-- 
1.7.4.1
