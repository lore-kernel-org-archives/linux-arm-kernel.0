From: ecc@cmu.edu (Eric Cooper)
Date: Wed,  2 Feb 2011 17:16:10 -0500
Subject: [PATCH v2 2/3] Kirkwood: enable PCIe before reading device ID register
In-Reply-To: <1296684971-10577-1-git-send-email-ecc@cmu.edu>
References: <1296684971-10577-1-git-send-email-ecc@cmu.edu>
Message-ID: <1296684971-10577-2-git-send-email-ecc@cmu.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIe may have been disabled (by kirkwood_clock_gate)
if this kernel was started by kexec.  Make sure PCIe
is enabled before attempting to access the device ID
register, otherwise the system will hang.

Signed-off-by: Eric Cooper <ecc@cmu.edu>
---
 arch/arm/mach-kirkwood/common.h |    1 +
 arch/arm/mach-kirkwood/pcie.c   |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 95bb0a7..a35b862 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -32,6 +32,7 @@ void kirkwood_init_irq(void);
 extern struct mbus_dram_target_info kirkwood_mbus_dram_info;
 void kirkwood_setup_cpu_mbus(void);
 
+void kirkwood_enable_pcie(void);
 void kirkwood_pcie_id(u32 *dev, u32 *rev);
 
 void kirkwood_ehci_init(void);
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index 513ad31..ca294ff 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -18,8 +18,16 @@
 #include <mach/bridge-regs.h>
 #include "common.h"
 
+void kirkwood_enable_pcie(void)
+{
+	u32 curr = readl(CLOCK_GATING_CTRL);
+	if (!(curr & CGC_PEX0))
+		writel(curr | CGC_PEX0, CLOCK_GATING_CTRL);
+}
+
 void __init kirkwood_pcie_id(u32 *dev, u32 *rev)
 {
+	kirkwood_enable_pcie();
 	*dev = orion_pcie_dev_id((void __iomem *)PCIE_VIRT_BASE);
 	*rev = orion_pcie_rev((void __iomem *)PCIE_VIRT_BASE);
 }
-- 
1.7.2.3
