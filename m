From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Feb 2016 15:23:51 +0100
Subject: [PATCH] firmware: qemu config needs I/O ports
Message-ID: <1455200650-4030091-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all machines have PCI style I/O port memory, or they do not allow
mapping it using the ioport_map() function, whcih results in a
build error with the newly added qemu firmware code:

drivers/firmware/built-in.o: In function `fw_cfg_io_cleanup':
qemu_fw_cfg.c:(.text+0x144): undefined reference to `ioport_unmap'
drivers/firmware/built-in.o: In function `fw_cfg_sysfs_probe':
qemu_fw_cfg.c:(.text+0xb18): undefined reference to `ioport_map'

This adds a Kconfig dependency to ensure the driver can only
be built on platforms that support it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 75f3e8e47f38 ("firmware: introduce sysfs driver for QEMU's fw_cfg device")
---
 drivers/firmware/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 5130f74ae3bd..6664f1108c7c 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -164,6 +164,7 @@ config RASPBERRYPI_FIRMWARE
 config FW_CFG_SYSFS
 	tristate "QEMU fw_cfg device support in sysfs"
 	depends on SYSFS && (ARM || ARM64 || PPC_PMAC || SPARC || X86)
+	depends on HAS_IOPORT_MAP
 	default n
 	help
 	  Say Y or M here to enable the exporting of the QEMU firmware
-- 
2.7.0
