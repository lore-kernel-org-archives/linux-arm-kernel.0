From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Jul 2013 05:10:23 -0700
Subject: [PATCH] irqchip: gic: Don't complain in gic_get_cpumask() if
 UP system
In-Reply-To: <20130712111322.GC3213@e102654-lin.cambridge.arm.com>
References: <1373067573-29946-1-git-send-email-sboyd@codeaurora.org>
 <20130712111322.GC3213@e102654-lin.cambridge.arm.com>
Message-ID: <20130712121023.GB27430@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12, Javi Merino wrote:
> On Sat, Jul 06, 2013 at 12:39:33AM +0100, Stephen Boyd wrote:
> > In a uniprocessor implementation the interrupt processor targets
> > registers are read-as-zero/write-ignored (RAZ/WI). Unfortunately
> > gic_get_cpumask() will print a critical message saying
> > 
> >  GIC CPU mask not found - kernel will fail to boot.
> > 
> > if these registers all read as zero, but there won't actually be
> > a problem on uniprocessor systems and the kernel will boot just
> > fine. Skip this check if we're running a UP kernel or if we
> > detect that the hardware only supports a single processor.
> > 
> > Cc: Nicolas Pitre <nico@linaro.org>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > 
> > Maybe we should just drop the check entirely? It looks like it may
> > just be debug code that won't ever trigger in practice, even on the
> > 11MPCore that caused this code to be introduced.
> 
> I agree, we should drop the check.  It's annoying in uniprocessors and
> unlikely to be found in the real world unless your gic entry in the dt
> is wrong.
> 

Ok. How about this?

----8<-----
Subject: [PATCH v2] irqchip: gic: Don't complain in gic_get_cpumask()

In a uniprocessor implementation the interrupt processor targets
registers are read-as-zero/write-ignored (RAZ/WI). Unfortunately
gic_get_cpumask() will print a critical message saying

 GIC CPU mask not found - kernel will fail to boot.

if these registers all read as zero, but there won't actually be
a problem on uniprocessor systems and the kernel will boot just
fine. Remove this check because if you're on a multiprocessor
system it's unlikely to be printed unless your DT is wrong or
your hardware is broken.

Cc: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Javi Merino <javi.merino@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/irqchip/irq-gic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 19ceaa60..4fbcea9 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -368,9 +368,6 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
 			break;
 	}
 
-	if (!mask)
-		pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
-
 	return mask;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
