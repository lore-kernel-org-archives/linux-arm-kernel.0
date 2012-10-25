From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Oct 2012 14:18:57 +0000
Subject: [PATCH] arm: mvebu: move irq controller driver in drivers/irqchip/
In-Reply-To: <20121025160657.57a52658@skate>
References: <1351168500-11129-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <50894346.60507@gmail.com> <20121025160657.57a52658@skate>
Message-ID: <201210251418.57761.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 October 2012, Thomas Petazzoni wrote:
> On Thu, 25 Oct 2012 08:48:54 -0500, Rob Herring wrote:
> 
> > I don't mean to pick on this specific patch, but this is a common
> > problem of moving various low-level pieces like irqchips, cpuidle,
> > timers, etc. to drivers/*. If we, just moving the code as is over, we
> > still need some hooks between arch/arm and drivers. I think if we keep
> > adding ARM SOC specific headers to include/linux, that will be the
> > next thing we get yelled at for and will have to clean-up.
> > 
> > For irqchips, the way I see this working is we would have a single
> > call to of_irq_init with a match list of all irqchips in
> > drivers/irqchips. This contains the init function within
> > drivers/irqchips. Then all the machines can just call a generic
> > irqchip_init.
> 
> Sounds doable indeed.

Agreed. I had the same idea some time ago, but didn't want to be the
one who starts that discussion.

> > The handle_irq ptr would also need to be plugged in at runtime.
> 
> However, do you have a more specific idea here? In setup_arch(), the
> value of mdesc->handle_irq gets picked up way before the ->init_irq
> machine hook is being called.

The variouos *_of_init functions to initialize each IRQ controller already
get a pointer to the irq parent.

Maybe we can just change those functions so that any irqchip that can
be a top-level chip and has a NULL parent can also assign the
handle_arch_irq pointer like in the snippet below.

	Arnd

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index aa52699..ec7e00b 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -777,6 +777,8 @@ int __init gic_of_init(struct device_node *node, struct device_node *parent)
 	if (parent) {
 		irq = irq_of_parse_and_map(node, 0);
 		gic_cascade_irq(gic_cnt, irq);
+	} else {
+		handle_arch_irq = gic_handle_irq;
 	}
 	gic_cnt++;
 	return 0;
