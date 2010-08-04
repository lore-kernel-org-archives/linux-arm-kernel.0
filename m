From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Aug 2010 19:24:48 +0200
Subject: [PATCH 1/5] arm/versatile: move pci code to plat-versatile
In-Reply-To: <1280942692-32079-1-git-send-email-arnd@arndb.de>
References: <1280942692-32079-1-git-send-email-arnd@arndb.de>
Message-ID: <1280942692-32079-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Xilinx PCI macro is used on both versatile-pb and
realview-eb, so we should move the implementation to place
where it can be shared.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                                   |    5 +++++
 arch/arm/mach-versatile/Makefile                   |    1 -
 arch/arm/plat-versatile/Makefile                   |    1 +
 .../pci.c => plat-versatile/xilinx-pci.c}          |    0
 4 files changed, 6 insertions(+), 1 deletions(-)
 rename arch/arm/{mach-versatile/pci.c => plat-versatile/xilinx-pci.c} (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7b117b1..ddbcaf2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1086,6 +1086,11 @@ config PCI_HOST_ITE8152
 	default y
 	select DMABOUNCE
 
+config PCI_HOST_XILINX
+	bool
+	depends on PCI && (ARCH_VERSATILE_PB || MACH_REALVIEW_EB || MACH_REALVIEW_PB1176)
+	default y
+
 source "drivers/pci/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
diff --git a/arch/arm/mach-versatile/Makefile b/arch/arm/mach-versatile/Makefile
index 97cf4d8..191b65b 100644
--- a/arch/arm/mach-versatile/Makefile
+++ b/arch/arm/mach-versatile/Makefile
@@ -5,4 +5,3 @@
 obj-y					:= core.o
 obj-$(CONFIG_ARCH_VERSATILE_PB)		+= versatile_pb.o
 obj-$(CONFIG_MACH_VERSATILE_AB)		+= versatile_ab.o
-obj-$(CONFIG_PCI)			+= pci.o
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 5cf88e8..de870b7 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -6,3 +6,4 @@ ifeq ($(CONFIG_LEDS_CLASS),y)
 obj-$(CONFIG_ARCH_REALVIEW) += leds.o
 obj-$(CONFIG_ARCH_VERSATILE) += leds.o
 endif
+obj-$(CONFIG_PCI_HOST_XILINX) += xilinx-pci.o
diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/plat-versatile/xilinx-pci.c
similarity index 100%
rename from arch/arm/mach-versatile/pci.c
rename to arch/arm/plat-versatile/xilinx-pci.c
-- 
1.7.1
