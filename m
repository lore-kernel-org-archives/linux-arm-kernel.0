From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 24 Mar 2015 22:02:52 +0800
Subject: [patch v11 19/23] XEN / ACPI: Make XEN ACPI depend on X86
In-Reply-To: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1427205776-5060-20-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When ACPI is enabled on ARM64, XEN ACPI will also compiled
into the kernel, but XEN ACPI is x86 dependent, so introduce
CONFIG_XEN_ACPI to make it depend on x86 before XEN ACPI is
functional on ARM64.

CC: 'Stefano Stabellini' <stefano.stabellini@eu.citrix.com>
CC: Julien Grall <julien.grall@linaro.org>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/xen/Kconfig  | 4 ++++
 drivers/xen/Makefile | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index b812462..a31cd29 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -253,4 +253,8 @@ config XEN_EFI
 	def_bool y
 	depends on X86_64 && EFI
 
+config XEN_ACPI
+	def_bool y
+	depends on X86 && ACPI
+
 endmenu
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 2ccd359..f4622ab 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -13,7 +13,7 @@ CFLAGS_efi.o				+= -fshort-wchar
 
 dom0-$(CONFIG_PCI) += pci.o
 dom0-$(CONFIG_USB_SUPPORT) += dbgp.o
-dom0-$(CONFIG_ACPI) += acpi.o $(xen-pad-y)
+dom0-$(CONFIG_XEN_ACPI) += acpi.o $(xen-pad-y)
 xen-pad-$(CONFIG_X86) += xen-acpi-pad.o
 dom0-$(CONFIG_X86) += pcpu.o
 obj-$(CONFIG_XEN_DOM0)			+= $(dom0-y)
-- 
1.9.1
