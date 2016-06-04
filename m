From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 4 Jun 2016 14:53:56 +0000
Subject: [PATCH v2 RESEND] irqchip: bcm2835: Avoid arch/arm-specific
 handle_IRQ
In-Reply-To: <1464728727-16300-1-git-send-email-eric@anholt.net>
References: <1464728727-16300-1-git-send-email-eric@anholt.net>
Message-ID: <20160604145356.GW24391@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric,

On Tue, May 31, 2016 at 02:05:27PM -0700, Eric Anholt wrote:
> This is equivalent and works for arm64 as well.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> 
> Patch 1 of the arm64 series was left out of the 4.7 pull request.
> Would it be possible to merge this through the SOC tree?  Otherwise I
> would need a stable branch to merge from you, so that I can land the
> Makefile changes to start building it.
> 
>  drivers/irqchip/irq-bcm2835.c | 3 +--
>  drivers/irqchip/irq-bcm2836.c | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)

Sorry for the delay.  I reworded the commit message to make up for it
;-)  I've merged this into irqchip/bcm for you to base off of.  Final
version is appended.

thx,

Jason.

--------------------->8--------------------------
commit d7e3528eed85b51ddca2f281d2d4e7d687f28d60
Author: Eric Anholt <eric@anholt.net>
Date:   Tue May 31 14:05:27 2016 -0700

    irqchip: bcm2835: Avoid arch/arm-specific handle_IRQ
    
    With commit
    
      76ba59f8366f genirq: Add irq_domain-aware core IRQ handler
    
    architecture-specific irq handlers are no longer necessary.  Update the bcm2835
    irq driver to use the core irq handler.  As a bonus, this allows the driver to
    support arm64 as well.
    
    Signed-off-by: Eric Anholt <eric@anholt.net>
    Acked-by: Stephen Warren <swarren@wwwdotorg.org>
    Link: https://lkml.kernel.org/r/1464728727-16300-1-git-send-email-eric at anholt.net
    [jac reworded commit message for clarity]
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index bf9cc5f2e839..44d7c38dde47 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -52,7 +52,6 @@
 #include <linux/irqdomain.h>
 
 #include <asm/exception.h>
-#include <asm/mach/irq.h>
 
 /* Put the bank and irq (32 bits) into the hwirq */
 #define MAKE_HWIRQ(b, n)	((b << 5) | (n))
@@ -242,7 +241,7 @@ static void __exception_irq_entry bcm2835_handle_irq(
 	u32 hwirq;
 
 	while ((hwirq = get_next_armctrl_hwirq()) != ~0)
-		handle_IRQ(irq_linear_revmap(intc.domain, hwirq), regs);
+		handle_domain_irq(intc.domain, hwirq, regs);
 }
 
 static void bcm2836_chained_handle_irq(struct irq_desc *desc)
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 72ff1d5c5de6..27875982657e 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -180,7 +180,7 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
 	} else if (stat) {
 		u32 hwirq = ffs(stat) - 1;
 
-		handle_IRQ(irq_linear_revmap(intc.domain, hwirq), regs);
+		handle_domain_irq(intc.domain, hwirq, regs);
 	}
 }
 
