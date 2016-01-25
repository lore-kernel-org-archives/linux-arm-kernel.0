From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 16:59:30 +0100
Subject: [PATCH] stm: add proper dependencies on the subsystem
Message-ID: <1453737579-1960217-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As several people have pointed out, the Kconfig dependencies for
stm are confusing, because you can enable the individual features
even when the subsystem itself is disabled.

It turns out that randconfig tests even show the a build-time
bug because of this:

drivers/hwtracing/stm/built-in.o: In function `dummy_stm_init':
drivers/hwtracing/stm/dummy_stm.c:53: undefined reference to `stm_register_device'
drivers/hwtracing/stm/built-in.o: In function `dummy_stm_exit':
drivers/hwtracing/stm/dummy_stm.c:58: undefined reference to `stm_unregister_device'
drivers/hwtracing/stm/built-in.o:(.debug_addr+0x14): undefined reference to `stm_register_device'
drivers/hwtracing/stm/built-in.o:(.debug_addr+0x1c): undefined reference to `stm_unregister_device'

This adds the missing 'depends on STM' lines.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 2c41538191e1 ("stm class: dummy_stm: Add dummy driver for testing stm class")
---
 drivers/hwtracing/stm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index 83e9f591a54b..7780be86d913 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -10,6 +10,7 @@ config STM
 
 config STM_DUMMY
 	tristate "Dummy STM driver"
+	depends on STM
 	help
 	  This is a simple dummy device that pretends to be an stm device
 	  and discards your data. Use for stm class testing.
@@ -18,6 +19,7 @@ config STM_DUMMY
 
 config STM_SOURCE_CONSOLE
 	tristate "Kernel console over STM devices"
+	depends on STM
 	help
 	  This is a kernel space trace source that sends kernel log
 	  messages to trace hosts over STM devices.
-- 
2.7.0
