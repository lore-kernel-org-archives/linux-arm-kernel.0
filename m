From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 6 Aug 2012 15:27:14 +0100
Subject: [PATCH v2 11/23] xen: do not compile manage, balloon, pci,
 acpi and cpu_hotplug on ARM
In-Reply-To: <alpine.DEB.2.02.1208061428060.4645@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1208061428060.4645@kaball.uk.xensource.com>
Message-ID: <1344263246-28036-11-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:

- make pci.o depend on CONFIG_PCI and acpi.o depend on CONFIG_ACPI.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/Makefile |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index fc34886..bee02b2 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,11 +1,17 @@
-obj-y	+= grant-table.o features.o events.o manage.o balloon.o
+ifneq ($(CONFIG_ARM),y)
+obj-y	+= manage.o balloon.o
+obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
+endif
+obj-y	+= grant-table.o features.o events.o
 obj-y	+= xenbus/
 
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_features.o			:= $(nostackp)
 
+obj-$(CONFIG_XEN_DOM0)			+= $(dom0-y)
+dom0-$(CONFIG_PCI) := pci.o
+dom0-$(CONFIG_ACPI) := acpi.o
 obj-$(CONFIG_BLOCK)			+= biomerge.o
-obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
 obj-$(CONFIG_XEN_XENCOMM)		+= xencomm.o
 obj-$(CONFIG_XEN_BALLOON)		+= xen-balloon.o
 obj-$(CONFIG_XEN_SELFBALLOONING)	+= xen-selfballoon.o
@@ -17,7 +23,6 @@ obj-$(CONFIG_XEN_SYS_HYPERVISOR)	+= sys-hypervisor.o
 obj-$(CONFIG_XEN_PVHVM)			+= platform-pci.o
 obj-$(CONFIG_XEN_TMEM)			+= tmem.o
 obj-$(CONFIG_SWIOTLB_XEN)		+= swiotlb-xen.o
-obj-$(CONFIG_XEN_DOM0)			+= pci.o acpi.o
 obj-$(CONFIG_XEN_PCIDEV_BACKEND)	+= xen-pciback/
 obj-$(CONFIG_XEN_PRIVCMD)		+= xen-privcmd.o
 obj-$(CONFIG_XEN_ACPI_PROCESSOR)	+= xen-acpi-processor.o
-- 
1.7.2.5
