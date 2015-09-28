From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 28 Sep 2015 14:30:44 +0100
Subject: [PATCH] xen/pci: Don't build Xen pci code for ARM and ARM64
Message-ID: <1443447044-24985-1-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCI support for Xen doesn't compile on ARM/ARM64 when
CONFIG_PCI_MMCONFIG=y:

drivers/xen/pci.c:31:25: fatal error: asm/pci_x86.h: No such file or
directory
 #include <asm/pci_x86.h>

Although, Xen is not currently involved in PCI management for ARM/ARM64.
There is plan to support it, but it would require some changes in Linux
side.

For now, introduce a new config options XEN_PCI which will be turned off
for ARM platform.

Reported-by: Robert Richter <robert.richter@caviumnetworks.com>
Signed-off-by: Julien Grall <julien.grall@citrix.com>

---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
---
 drivers/xen/Kconfig  | 6 +++++-
 drivers/xen/Makefile | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 73708ac..6bcc8b0 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -168,7 +168,7 @@ config XEN_TMEM
 
 config XEN_PCIDEV_BACKEND
 	tristate "Xen PCI-device backend driver"
-	depends on PCI && X86 && XEN
+	depends on XEN_PCI
 	depends on XEN_BACKEND
 	default m
 	help
@@ -189,6 +189,10 @@ config XEN_PCIDEV_BACKEND
 
 	  If in doubt, say m.
 
+config XEN_PCI
+	def_bool y
+	depends on PCI && !ARM && !ARM64
+
 config XEN_SCSI_BACKEND
 	tristate "XEN SCSI backend driver"
 	depends on XEN && XEN_BACKEND && TARGET_CORE
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index e293bc5..c9f23b7 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -11,7 +11,7 @@ CFLAGS_features.o			:= $(nostackp)
 
 CFLAGS_efi.o				+= -fshort-wchar
 
-dom0-$(CONFIG_PCI) += pci.o
+dom0-$(CONFIG_XEN_PCI) += pci.o
 dom0-$(CONFIG_USB_SUPPORT) += dbgp.o
 dom0-$(CONFIG_XEN_ACPI) += acpi.o $(xen-pad-y)
 xen-pad-$(CONFIG_X86) += xen-acpi-pad.o
-- 
2.1.4
