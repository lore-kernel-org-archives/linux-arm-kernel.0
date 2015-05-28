From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 May 2015 16:35:42 +0200
Subject: [PATCH] staging/wilc1000: fix Kconfig dependencies
Message-ID: <2619913.NOTkkZWJir@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added wilc1000 driver lacks several Kconfig dependencies,
resulting in a multitude of randconfig build errors, e.g.:

drivers/built-in.o: In function `WILC_WFI_mgmt_tx_cancel_wait':
binder.c:(.text+0x12bd28): undefined reference to `cfg80211_remain_on_channel_expired'
drivers/built-in.o: In function `WILC_WFI_CfgSetChannel':
binder.c:(.text+0x12c9d8): undefined reference to `ieee80211_frequency_to_channel'
drivers/built-in.o: In function `WILC_WFI_CfgAlloc':
binder.c:(.text+0x132530): undefined reference to `wiphy_new_nm'
drivers/built-in.o: In function `wilc_netdev_init':
binder.c:(.text+0x1356d0): undefined reference to `register_inetaddr_notifier'
drivers/built-in.o: In function `linux_spi_init':
binder.c:(.text+0x210a68): undefined reference to `spi_register_driver'

This change ensures that we always have at least one of SPI or MMC
enabled, and are only able to pick an interface that works. It also
adds all the missing dependencies for networking infrastructure
(cfg80211, wext, and ipv4).

In order to make it readable, I also took the liberty of re-indenting
the Kconfig file to the normal conventions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/staging/wilc1000/Kconfig b/drivers/staging/wilc1000/Kconfig
index 101f908bc9ed..02381521ff7f 100644
--- a/drivers/staging/wilc1000/Kconfig
+++ b/drivers/staging/wilc1000/Kconfig
@@ -1,55 +1,57 @@
 config WILC1000
 	tristate "WILC1000 support (WiFi only)"
+	depends on CFG80211 && WEXT_CORE && INET
+	depends on MMC || SPI
 	---help---
-		This module only support IEEE 802.11n WiFi.
+	  This module only support IEEE 802.11n WiFi.
 
 choice
         prompt "Memory Allocation"
         depends on WILC1000
         default WILC1000_PREALLOCATE_AT_LOADING_DRIVER
 
-        config WILC1000_PREALLOCATE_AT_LOADING_DRIVER
-                bool "Preallocate memory at loading driver"
-                ---help---
-                        This choice supports static allocation of the memory
-                        for the receive buffer. The driver will allocate the RX buffer 
-                        during initial time. The driver will also free the buffer
-                        by calling network device stop.
-
-        config WILC1000_DYNAMICALLY_ALLOCATE_MEMROY
-                bool "Dynamically allocate memory in real time"
-                ---help---
-                        This choice supports dynamic allocation of the memory
-                        for the receive buffer. The driver will allocate the RX buffer
-                        when it is required.
+config WILC1000_PREALLOCATE_AT_LOADING_DRIVER
+	bool "Preallocate memory at loading driver"
+	---help---
+	  This choice supports static allocation of the memory
+	  for the receive buffer. The driver will allocate the RX buffer
+	  during initial time. The driver will also free the buffer
+	  by calling network device stop.
+
+config WILC1000_DYNAMICALLY_ALLOCATE_MEMROY
+        bool "Dynamically allocate memory in real time"
+        ---help---
+	  This choice supports dynamic allocation of the memory
+	  for the receive buffer. The driver will allocate the RX buffer
+	  when it is required.
 endchoice
 
-
 choice
-    prompt "Bus Type"
-    depends on WILC1000 
-    default WILC1000_SDIO
-    
+	prompt "Bus Type"
+	depends on WILC1000
+	default WILC1000_SDIO
+
 	config WILC1000_SDIO
-	    bool "SDIO support"
-	    depends on MMC
-		---help---
-			This module adds support for the SDIO interface of adapters using
-			WILC chipset. Select this if your platform is using the SDIO bus. 
+	bool "SDIO support"
+	depends on MMC
+	---help---
+	  This module adds support for the SDIO interface
+	  of adapters using WILC chipset. Select this if
+	  your platform is using the SDIO bus.
 
 	config WILC1000_SPI
-	    bool "SPI support"
-		---help---
-			This module adds support for the SPI interface of adapters using
-			WILC chipset. Select this if your platform is using the SPI bus. 
+	depends on SPI
+	bool "SPI support"
+	---help---
+	  This module adds support for the SPI interface
+	  of adapters using WILC chipset. Select this if
+	  your platform is using the SPI bus.
 endchoice
 
-
 config WILC1000_HW_OOB_INTR
-    bool "Use out of band interrupt"
-    depends on WILC1000 && WILC1000_SDIO
-    default n
-    ---help---
-		If your platform don't recognize SDIO IRQ, connect chipset external IRQ pin
-		and check this option. Or, Use this to get all interrupts including SDIO interrupts.
-
+	bool "Use out of band interrupt"
+	depends on WILC1000 && WILC1000_SDIO
+	default n
+	---help---
+	  If your platform don't recognize SDIO IRQ, connect chipset external IRQ pin
+	  and check this option. Or, Use this to get all interrupts including SDIO interrupts.
