From: stefan@agner.ch (Stefan Agner)
Date: Wed, 28 Nov 2018 14:25:54 +0100
Subject: [PATCH] pci: imx6: support kernels built in Thumb-2 mode
Message-ID: <20181128132554.28139-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a fault handler which handles reads in Thumb-2 mode. Install
the appropriate handler depending on which mode the kernel has
been built. This avoids an "Unhandled fault: external abort on
non-linefetch (0x1008) at 0xf0a80000" during boot on a device
with a PCIe switch connected.

Link: https://lore.kernel.org/linux-pci/20181126161645.8177-1-stefan at agner.ch/
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
FWIW, I found this manual helpful to write the code below:
http://hermes.wings.cs.wisc.edu/files/Thumb-2SupplementReferenceManual.pdf#page=43&zoom=100,0,66

--
Stefan

 drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 69f86234f7c0..683deb74d69f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -29,6 +29,7 @@
 #include <linux/reset.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <asm/opcodes.h>
 
 #include "pcie-designware.h"
 
@@ -299,6 +300,37 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 	return 1;
 }
 
+static int imx6q_pcie_abort_handler_thumb2(unsigned long addr,
+		unsigned int fsr, struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+	unsigned long instr = *(unsigned long *)pc;
+	unsigned long thumb2_instr = __mem_to_opcode_thumb16(instr);
+	int reg = thumb2_instr & 7;
+
+	if (!__opcode_is_thumb16(instr & 0x0000ffffUL))
+		return 1;
+
+	/* Load word/byte and halfword immediate offset */
+	if (((thumb2_instr & 0xe800) == 0x6800) ||
+	    ((thumb2_instr & 0xf800) == 0x8800)) {
+		unsigned long val;
+
+		if (thumb2_instr & 0x1000)
+			val = 0xff;
+		else if (thumb2_instr & 0x8000)
+			val = 0xffff;
+		else
+			val = 0xffffffffUL;
+
+		regs->uregs[reg] = val;
+		regs->ARM_pc += 2;
+		return 0;
+	}
+
+	return 1;
+}
+
 static int imx6_pcie_attach_pd(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
@@ -1069,6 +1101,8 @@ static struct platform_driver imx6_pcie_driver = {
 
 static int __init imx6_pcie_init(void)
 {
+	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);
+
 	/*
 	 * Since probe() can be deferred we need to make sure that
 	 * hook_fault_code is not called after __init memory is freed
@@ -1076,7 +1110,8 @@ static int __init imx6_pcie_init(void)
 	 * we can install the handler here without risking it
 	 * accessing some uninitialized driver state.
 	 */
-	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
+	hook_fault_code(8, thumb2 ? imx6q_pcie_abort_handler_thumb2 :
+			imx6q_pcie_abort_handler, SIGBUS, 0,
 			"external abort on non-linefetch");
 
 	return platform_driver_register(&imx6_pcie_driver);
-- 
2.19.1
