From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Jul 2018 06:45:11 +0100
Subject: [PATCH] checkpatch: Add exceptions for dsb keyword usage
In-Reply-To: <f3ce3ca8741f774b63e8a67a278384747b1de522.camel@perches.com>
References: <1530814776-16988-1-git-send-email-pheragu@codeaurora.org>
 <f3ce3ca8741f774b63e8a67a278384747b1de522.camel@perches.com>
Message-ID: <20180706054510.puli24y6i6ylghxt@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2018 at 02:14:28PM -0700, Joe Perches wrote:
> On Thu, 2018-07-05 at 11:19 -0700, Prakruthi Deepak Heragu wrote:
> > mb() API can relpace the dsb() API in the kernel code. So, dsb() usage
> > is discouraged. However, there are exceptions when dsb is used in a
> > variable or a function name. Exceptions are when 'dsb' is prefixed with
> > class [-_>*\.] and/or suffixed with class [-_\.;].

This is a really confusing way of describing the match behaviour, and doesn't
explain why this is a big problem.

In C it's either:

	dsb()
	dsb(scope)	// e.g. dsb(ish)

... where scope is [a-z]*.

... which can be matched as something like 'dsb([a-z]*)' if necessary.

> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -5372,6 +5372,12 @@ sub process {
> >  			     "Avoid line continuations in quoted strings\n" . $herecurr);
> >  		}
> >  
> > +# dsb is too ARMish, and should usually be mb.
> > +        if ($line =~ /[^-_>*\.]\bdsb\b[^-_\.;]/) {
> > +            WARN("ARM_BARRIER",
> > +                 "Use of dsb is discouranged: prefer mb.\n" .
> > +                 $herecurr);
> > +		}
> 
> This patch is whitespace damaged with a spelling error.
> 
> Also, if this is reasonable test, and I don't know
> that it is, it should be cc'd to the linux-arm list
> linux-arm-kernel at lists.infradead.org
> 
> Also, I suggest 2 tests, one for .S files and
> another for .[ch] files, and this be made specific
> to arch/arm... files
> 
> Something like:
> 
> 	if ($realfile =~ @^arch/arm@ &&
> 	    ($realfile =~ /\.S$/ && $line =~ /\bdsb\b/) ||
> 	    ($realfile =~ /\.[ch]$/ && $line =~ /\bdsb\s*\(/)) {
> 		WARN("ARM_DSB",
> 		     "Prefer mb over dsb as an ARM memory barrier\n" . $herecurr);
> 	}
> 
> ARM people, is this reasonable?

I don't think this is a big deal today. 

For code under arch/{arm,arm64}, it's perfectly reasonable to use dsb.

For code *ouside* of arch/{arm,arm64}, there are a number of cases where we
want to use dsb(), e.g. when dealing with architectural drivers that require
special barriers, or for common code shared across arm and arm64.

It doesn't look like this is a big problem today, anyhow:

[mark at salmiak:~/src/linux]% git grep -w 'dsb(.*)' -- ^arch          
drivers/irqchip/irq-armada-370-xp.c:    dsb();
drivers/irqchip/irq-gic-v3-its.c:               dsb(ishst);
drivers/irqchip/irq-gic-v3-its.c:               dsb(ishst);
drivers/irqchip/irq-gic-v3-its.c:       dsb(sy);
drivers/irqchip/irq-gic-v3-its.c:               dsb(sy);
drivers/irqchip/irq-gic-v3-its.c:       dsb(sy);
drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
drivers/perf/arm_spe_pmu.c:     dsb(nsh);
drivers/perf/arm_spe_pmu.c:     dsb(nsh);
drivers/power/reset/arm-versatile-reboot.c:     dsb();
drivers/soc/rockchip/pm_domains.c:      dsb(sy);
drivers/soc/rockchip/pm_domains.c:      dsb(sy);
drivers/staging/mt7621-mmc/sd.c:        //dsb(); /* --- by chhung */
drivers/staging/mt7621-mmc/sd.c:        //dsb(); /* --- by chhung */
drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h:#define dsb(a)
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:     dsb(sy);         /* data barrier operation */
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:         dsb(sy);
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h: do { debug_ptr[DEBUG_ ## d] = __LINE__; dsb(sy); } while (0)
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h: do { debug_ptr[DEBUG_ ## d] = (v); dsb(sy); } while (0)
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h: do { debug_ptr[DEBUG_ ## d]++; dsb(sy); } while (0)
virt/kvm/arm/hyp/vgic-v3-sr.c:                  dsb(sy);
virt/kvm/arm/hyp/vgic-v3-sr.c:                  dsb(sy);
virt/kvm/arm/hyp/vgic-v3-sr.c:                  dsb(sy);

Thanks,
Mark.
