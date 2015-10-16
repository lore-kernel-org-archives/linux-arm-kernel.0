From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Oct 2015 00:35:19 +0200
Subject: [PATCH] stm: add configfs dependency
Message-ID: <5578991.YxAbTTycJA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are three new stm modules, all of which use configfs for configuration.
If configfs is not part of the kernel, or is a loadable module while
the stm driver is builtin, we get a link error like:

drivers/built-in.o: In function `stp_policy_node_drop':
drivers/hwtracing/stm/policy.c:232: undefined reference to `config_item_put'
drivers/built-in.o: In function `stp_policies_make':
drivers/hwtracing/stm/policy.c:352: undefined reference to `config_group_init_type_name'
drivers/built-in.o: In function `stp_policy_node_make':
drivers/hwtracing/stm/policy.c:215: undefined reference to `config_group_init_type_name'

This adds explicit Kconfig dependencies to ensure configfs is present.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The patches are currently in Greg's char-misc tree, we should have
this one in the same branch.

diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index 5a59a28cc3da..6df294fff1eb 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -1,5 +1,6 @@
 config STM
 	tristate "System Trace Module devices"
+	depends on CONFIGFS_FS
 	help
 	  A System Trace Module (STM) is a device exporting data in System
 	  Trace Protocol (STP) format as defined by MIPI STP standards.
@@ -9,6 +10,7 @@ config STM
 
 config STM_DUMMY
 	tristate "Dummy STM driver"
+	depends on CONFIGFS_FS
 	help
 	  This is a simple dummy device that pretends to be an stm device
 	  and discards your data. Use for stm class testing.
@@ -17,6 +19,7 @@ config STM_DUMMY
 
 config STM_SOURCE_CONSOLE
 	tristate "Kernel console over STM devices"
+	depends on CONFIGFS_FS
 	help
 	  This is a kernel space trace source that sends kernel log
 	  messages to trace hosts over STM devices.
