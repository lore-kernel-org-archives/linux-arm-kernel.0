From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 29 May 2011 01:28:13 +0400
Subject: [PATCH] pxa: correct icip irq handling
Message-ID: <1306618093-6572-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ handling on PXA25x is broken if PXA_HAVE_ISA_IRQS is enabled (then
all PXA irqs are shifted to start from 16, but icip_handle_irq doesn't
work in this case. Use PXA_IRQ to correct IRQ numbers in icip_handle_irq.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 858e287..d9cab3b 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -141,7 +141,7 @@ asmlinkage void __exception_irq_entry icip_handle_irq(struct pt_regs *regs)
 		if (mask == 0)
 			break;
 
-		asm_do_IRQ(fls(mask) - 1, regs);
+		asm_do_IRQ(PXA_IRQ(fls(mask) - 1), regs);
 	} while (1);
 }
 
-- 
1.7.4.4
