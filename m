From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 17 Sep 2012 18:38:55 +0100
Subject: [PATCH v5 09/17] xen: do not compile manage, balloon, pci, acpi,
 pcpu and cpu_hotplug on ARM
In-Reply-To: <alpine.DEB.2.02.1209171215490.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1209171215490.29232@kaball.uk.xensource.com>
Message-ID: <1347903543-2135-9-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v4:
- compile pcpu only on x86;
- use "+=" instead of ":=" for dom0- targets.

Changes in v2:

- make pci.o depend on CONFIG_PCI and acpi.o depend on CONFIG_ACPI.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/xen/Makefile |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index d80bea5..cd28aae 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,11 +1,18 @@
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
+dom0-$(CONFIG_PCI) += pci.o
+dom0-$(CONFIG_ACPI) += acpi.o
+dom0-$(CONFIG_X86) += pcpu.o
 obj-$(CONFIG_BLOCK)			+= biomerge.o
-obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
 obj-$(CONFIG_XEN_XENCOMM)		+= xencomm.o
 obj-$(CONFIG_XEN_BALLOON)		+= xen-balloon.o
 obj-$(CONFIG_XEN_SELFBALLOONING)	+= xen-selfballoon.o
@@ -17,8 +24,6 @@ obj-$(CONFIG_XEN_SYS_HYPERVISOR)	+= sys-hypervisor.o
 obj-$(CONFIG_XEN_PVHVM)			+= platform-pci.o
 obj-$(CONFIG_XEN_TMEM)			+= tmem.o
 obj-$(CONFIG_SWIOTLB_XEN)		+= swiotlb-xen.o
-obj-$(CONFIG_XEN_DOM0)			+= pcpu.o
-obj-$(CONFIG_XEN_DOM0)			+= pci.o acpi.o
 obj-$(CONFIG_XEN_MCE_LOG)		+= mcelog.o
 obj-$(CONFIG_XEN_PCIDEV_BACKEND)	+= xen-pciback/
 obj-$(CONFIG_XEN_PRIVCMD)		+= xen-privcmd.o
-- 
1.7.2.5
