From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Wed, 13 Apr 2011 11:12:01 +0100
Subject: [PATCH] arm: cputype.h uses __attribute_const__ which requires
	including kernel.h
Message-ID: <1302689521-10210-1-git-send-email-jic23@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
Issue manifests as:

a  CC [M]  drivers/staging/iio/gyro/adis16080_core.o
In file included from arch/arm/mach-pxa/include/mach/hardware.h:62,
                 from arch/arm/mach-pxa/include/mach/gpio.h:28,
                 from /home/jic23/src/kernel/temp-remove/arch/arm/include/asm/gpio.h:5,
                 from include/linux/gpio.h:7,
                 from drivers/staging/iio/gyro/adis16080_core.c:8:
/home/jic23/src/kernel/temp-remove/arch/arm/include/asm/cputype.h:57: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'read_cpuid_id'
/home/jic23/src/kernel/temp-remove/arch/arm/include/asm/cputype.h:62: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'read_cpuid_cachetype'
/home/jic23/src/kernel/temp-remove/arch/arm/include/asm/cputype.h:67: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'read_cpuid_tcmstatus'
In file included from /home/jic23/src/kernel/temp-remove/arch/arm/include/asm/gpio.h:5,
                 from include/linux/gpio.h:7,
                 from drivers/staging/iio/gyro/adis16080_core.c:8:

With current mainline.  Could trivially work around this by reordering
headers in the driver, but should probably be fixed at the source of
the problem as done here.

 arch/arm/include/asm/cputype.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index ed5bc9e..cd4458f 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -2,6 +2,7 @@
 #define __ASM_ARM_CPUTYPE_H
 
 #include <linux/stringify.h>
+#include <linux/kernel.h>
 
 #define CPUID_ID	0
 #define CPUID_CACHETYPE	1
-- 
1.7.3.4
