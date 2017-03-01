From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  1 Mar 2017 23:50:19 +0100
Subject: [PATCH 2/2] staging/vc04_services: add CONFIG_OF dependency
In-Reply-To: <20170301225050.1298349-1-arnd@arndb.de>
References: <20170301225050.1298349-1-arnd@arndb.de>
Message-ID: <20170301225050.1298349-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After several hours of debugging this obviously bogus but elaborate
gcc-7.0.1 warning,

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c: In function 'vchiq_complete_bulk':
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:603:4: error: argument 2 null where non-null expected [-Werror=nonnull]
    memcpy((char *)page_address(pages[0]) +
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     pagelist->offset,
     ~~~~~~~~~~~~~~~~~
     fragments,
     ~~~~~~~~~~
     head_bytes);
     ~~~~~~~~~~~
In file included from include/linux/string.h:18:0,
                 from include/linux/bitmap.h:8,
                 from include/linux/cpumask.h:11,
                 from include/linux/interrupt.h:9,
                 from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:37:
arch/arm/include/asm/string.h:16:15: note: in a call to function 'memcpy' declared here
 extern void * memcpy(void *, const void *, __kernel_size_t) __nocapture(2);
               ^~~~~~

I have concluded that gcc was technically right in the first place:

vchiq_complete_bulk is an externally visible function that calls
free_pagelist(), which in turn derives a pointer from the global
g_fragments_base variable.

g_fragments_base is initialized in vchiq_platform_init(), but
we only get there if of_property_read_u32() successfully reads the
cache line size. When CONFIG_OF is disabled, this always fails, and
g_fragments_base is guaranteed to be NULL when vchiq_complete_bulk()
gets called.

This adds a CONFIG_OF Kconfig dependency, which is also technically correct
but nonobvious, and thus seems like a good fit for the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/vc04_services/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index e61e4ca064a8..74094fff4367 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -1,6 +1,7 @@
 config BCM2835_VCHIQ
 	tristate "Videocore VCHIQ"
 	depends on HAS_DMA
+	depends on OF
 	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
 	default y
 	help
-- 
2.9.0
