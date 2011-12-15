From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 13:55:04 +0800
Subject: [PATCH 3/9] irq: convert generic-chip to use irq_domain
In-Reply-To: <20111215052512.GB21815@S2101-09.ap.freescale.net>
References: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
 <1323876538-20406-4-git-send-email-robherring2@gmail.com>
 <20111215052512.GB21815@S2101-09.ap.freescale.net>
Message-ID: <20111215055501.GC21815@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 01:25:20PM +0800, Shawn Guo wrote:
> On Wed, Dec 14, 2011 at 09:28:52AM -0600, Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > Add irq domain support to irq generic-chip. This enables users of
> > generic-chip to support dynamic irq assignment needed for DT interrupt
> > binding. Users must be converted to use irq_data.hwirq for determining
> > local interrupt numbers rather than using the Linux irq number.
> > 
> > irq_base is kept for now as there are a few users of it. Once they
> > are converted to use the irq domain, it can be removed.
> > 
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> 
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
> 
Sorry, I have to take that tag back after I correct my test setup.
It does not work for imx5 TZIC case, because the following change
I suggested before is missed.

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index eb763f7..2a2aac1 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -39,7 +39,7 @@ void irq_domain_add(struct irq_domain *domain)
                        return;
                }
                d->domain = domain;
-               d->hwirq = hwirq;
+               d->hwirq = hwirq - domain->hwirq_base;
        }

        mutex_lock(&irq_domain_mutex);

-- 
Regards,
Shawn
