From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Dec 2015 07:39:56 +0000
Subject: [PATCH 2/2] irqchip/gic: Identify and report any reserved SGI IDs
In-Reply-To: <20151217192610.GA16577@wychelm.lan>
References: <1450285686-844-1-git-send-email-daniel.thompson@linaro.org>
 <1450285686-844-3-git-send-email-daniel.thompson@linaro.org>
 <5671A39D.9000500@arm.com> <20151217192610.GA16577@wychelm.lan>
Message-ID: <20151218073956.0622f8bf@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Dec 2015 19:26:10 +0000
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> On Wed, Dec 16, 2015 at 05:47:09PM +0000, Marc Zyngier wrote:
> > Hi Daniel,
> 
> Hi Marc
> 
> Thanks for the review.
> 
> 
> > On 16/12/15 17:08, Daniel Thompson wrote:
> > > It is possible for the secure world to reserve certain SGI IDs for itself.
> > > Currently we have limited visibility of which IDs are safe to use for IPIs.
> > > 
> > > Modify the GIC initialization code to actively search for reserved SGI IDs
> > > and report if any are found. Warn even more loudly if the reserved SGIs
> > > overlap with the normal IPI range.
> > > 
> > > When run on an Inforce IFC6410 (Snapdragon 600) this code produces the
> > > following messages:
> > > ~~~ cut here ~~~
> > > CPU0: Detected reserved SGI IDs: 14-15
> > > CPU1: Detected reserved SGI IDs: 15
> > > CPU2: Detected reserved SGI IDs: 15
> > > CPU3: Detected reserved SGI IDs: 15
> > > ~~~ cut here ~~~
> > > 
> > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> BTW you *didn't* say "this code is pointless and I hate it"...

Well, this was obviously used to detect another issue (patch #1), so I
can't see any harm in trying to sanitize things, as long as it doesn't
break anything else. I imagine this patch will also trigger on my
sunxi platforms, which use a SGI to implement PSCI in secure mode.

> Does that mean I should be looking at adding similar code for GICv3+? I 
> wanted to guage reactions to this sort of diagnostics before getting
> carried away!

Could be useful as well.

> 
> 
> > > +
> > > +		/*
> > > +		 * Fiddle with the SGI set/clear registers to try identify
> > > +		 * any IPIs that are reserved for secure world.
> > > +		 */
> > > +		bitmap_fill(sgi_mask, 16);
> > > +
> > > +		for (i = 0; i < 16; i++) {
> > > +			void __iomem *set_reg =
> > > +			    dist_base + GIC_DIST_SGI_PENDING_SET + (i & ~3);
> > > +			void __iomem *clear_reg =
> > > +			    dist_base + GIC_DIST_SGI_PENDING_CLEAR + (i & ~3);
> > > +			unsigned long mask = cpu_mask << (8*(i%4));
> > > +			unsigned long flags, pending, after_clear, after_set;
> > 
> > Please make these u32, as unsigned long is 64bit on arm64. Another thing
> > to note is that GICD_CPEND{S,C}SGIRn are byte accessible, so you can
> > save yourself some this hassle shifting things around and just write a
> > single byte. You're already writing 16 times anyway...
> 
> Will do both.
> 
> 
> > Another thing to consider is that these locations are only defined on
> > GICv2 and not GICv1, so this patch is likely to cause trouble on older HW.
> 
> As presented the code relies on the RAZ/WI property of reserved
> registers to avoid issues on GICv1; it does not report anything if there
> appear to be know working SGIs on the assumption we are actually running
> on a GICv1.
> 
> You'd prefer an explicit version check?

I'd rather be cautious and check for the architecture version,
specially if you settle for the byte access mentioned above (a GICv1
may not support byte access and explode unexpectedly). ICPIDR2.ArchRev
should be the right thing to check.

> 
> 
> > > +
> > > +			local_irq_save(flags);
> > 
> > Why do you need to do this? The CPU interface is not enabled yet, so I
> > can't see how you could get an interrupt on this CPU.
> 
> Agreed. Can get rid of these.
> 
> 
> > > +
> > > +			/* record original value */
> > > +			pending = readl_relaxed(set_reg);
> > > +
> > > +			/* clear, test, set, and test again */
> > > +			writel_relaxed(mask, clear_reg);
> > > +			after_clear = readl_relaxed(set_reg);
> > > +			writel_relaxed(mask, set_reg);
> > > +			after_set = readl_relaxed(set_reg);
> > 
> > It should be enough to write to the SET register, and read back, as the
> > bit is RAZ/WI when the interrupt is Group-0.
> 
> Good point. Will simplify.

I'd also suggest moving the whole thing to a separate function that'd
get called from gic_cpu_init().

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
