From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 22:14:35 +0100
Subject: [PATCH] stm: select CONFIG_SRCU
Message-ID: <12747713.N26XusNZpW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added STM code uses SRCU, but does not ensure that
this code is part of the kernel:

drivers/built-in.o: In function `stm_source_link_show':
include/linux/srcu.h:221: undefined reference to `__srcu_read_lock'
include/linux/srcu.h:238: undefined reference to `__srcu_read_unlock'
drivers/built-in.o: In function `stm_source_link_drop':
include/linux/srcu.h:221: undefined reference to `__srcu_read_lock'
include/linux/srcu.h:238: undefined reference to `__srcu_read_unlock'

This adds a Kconfig 'select' statement like all the other SRCU using
drivers have.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
---

diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index 83e9f591a54b..e7a348807f0c 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -1,6 +1,7 @@
 config STM
 	tristate "System Trace Module devices"
 	select CONFIGFS_FS
+	select SRCU
 	help
 	  A System Trace Module (STM) is a device exporting data in System
 	  Trace Protocol (STP) format as defined by MIPI STP standards.
