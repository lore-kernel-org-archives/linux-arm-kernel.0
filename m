From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Oct 2013 18:03:13 +0200
Subject: [PATCH 2/6] ARM: integrator: print the Linux IRQ in LL_DEBUG code
Message-ID: <1380816193-3086-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The static HW irqs have no meaning in the interrupt handler
and does not correlate to the /proc/interrupts IRQ numbers
anymore, print the Linux IRQ number instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/pci_v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index bef1005..2d10793 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -605,7 +605,7 @@ v3_pci_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	return 1;
 }
 
-static irqreturn_t v3_irq(int dummy, void *devid)
+static irqreturn_t v3_irq(int irq, void *devid)
 {
 #ifdef CONFIG_DEBUG_LL
 	struct pt_regs *regs = get_irq_regs();
@@ -615,7 +615,7 @@ static irqreturn_t v3_irq(int dummy, void *devid)
 	extern void printascii(const char *);
 
 	sprintf(buf, "V3 int %d: pc=0x%08lx [%08lx] LBFADDR=%08x LBFCODE=%02x "
-		"ISTAT=%02x\n", IRQ_AP_V3INT, pc, instr,
+		"ISTAT=%02x\n", irq, pc, instr,
 		__raw_readl(ap_syscon_base + INTEGRATOR_SC_LBFADDR_OFFSET),
 		__raw_readl(ap_syscon_base + INTEGRATOR_SC_LBFCODE_OFFSET) & 255,
 		v3_readb(V3_LB_ISTAT));
-- 
1.8.3.1
