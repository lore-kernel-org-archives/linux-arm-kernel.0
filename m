From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 10 Jun 2014 16:48:26 -0700
Subject: [RFC] irqchip: gic: always mask interrupts during suspend
In-Reply-To: <alpine.DEB.2.10.1406110129270.5170@nanos>
References: <1402442098-21093-1-git-send-email-computersforpeace@gmail.com>
 <alpine.DEB.2.10.1406110129270.5170@nanos>
Message-ID: <20140610234826.GK3599@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 01:34:39AM +0200, Thomas Gleixner wrote:
> On Tue, 10 Jun 2014, Brian Norris wrote:
> > Other random thought: it seems like any irqchip driver which does lazy IRQ
> > masking ought to use IRQCHIP_MASK_ON_SUSPEND. So maybe the IRQ core should just
> > do something like:
> > 
> > 	if (!chip->irq_disable)
> > 		chip->flags |= IRQCHIP_MASK_ON_SUSPEND;
> 
> No. Lazy irq disable and the suspend logic are different beasts.

OK, fair enough. Drop that random thought then. It's not in the patch
content anyway.

> That's up to the platform to decide this. Just for the record: there
> is a world outside of ARM...

OK. But GIC is ARM-specific, so we can still constrain this patch and
related topics to the world of ARM.

> But that brings me to a different question:
> 
>     Why are you not putting that customization into the device tree
>     instead of trying to add this to some random arch/arm/mach-foo
>     files?

I'm not adding customization to arch/arm/mach-foo files. I'm trying to
remove it.

This property could be added to device tree, if there was really a valid
use case for a GIC which leaves its interrupts unmasked for suspend. My
question in this patch is essentially: does such a use case exist?

Brian
