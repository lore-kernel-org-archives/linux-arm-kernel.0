From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 26 May 2015 20:49:14 +0800
Subject: [PATCH 01/11] ARM64 / PCI: introduce struct pci_controller for ACPI
In-Reply-To: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1432644564-24746-2-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 ACPI based PCI host bridge init needs a arch dependent
struct pci_controller to accommodate common PCI host bridge
code which is introduced later, or it will lead to compile
errors on ARM64.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Liviu Dudau <Liviu.Dudau@arm.com>
CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pci.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index b008a72..7088495 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -10,6 +10,16 @@
 #include <asm-generic/pci-bridge.h>
 #include <asm-generic/pci-dma-compat.h>
 
+struct acpi_device;
+
+struct pci_controller {
+#ifdef CONFIG_ACPI
+	struct acpi_device *companion;	/* ACPI companion device */
+#endif
+	int		segment;	/* PCI domain */
+	int		node;		/* NUMA node */
+};
+
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0
 
-- 
1.9.1
