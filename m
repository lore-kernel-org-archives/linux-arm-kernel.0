From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Jun 2018 15:53:27 +0100
Subject: [PATCH v3] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is
 observed before enabling
In-Reply-To: <e606924b-04e2-82df-0813-21c548259ff2@arm.com>
References: <1521683929-15644-1-git-send-email-shankerd@codeaurora.org>
 <d1161c2d-e16d-14e6-5450-be26d348100d@arm.com>
 <8087e009-4eca-ab92-cbca-23ccfb3fafac@codeaurora.org>
 <86o9jf174o.wl-marc.zyngier@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69F37935@G01JPEXMBKW03>
 <86tvpy7s1g.wl-marc.zyngier@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69F3B4A4@G01JPEXMBKW03>
 <e606924b-04e2-82df-0813-21c548259ff2@arm.com>
Message-ID: <86fu197g60.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lei,

On Thu, 21 Jun 2018 13:02:11 +0100,
Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> Hi Lei,
> 
> On 21/06/18 11:57, Zhang, Lei wrote:
> > Hi Marc
> > 
> >> - If EnableLPI is already set to 1, your redistributors are already
> >>   potentially corrupting the memory by writing to the pending
> >>   tables. Your system is now potentially unstable (single bit
> >>   corruption, depending on what the ITS outputs).
> >>
> >> - If EnableLPI has become RES1, you cannot even turn it off to
> >>   reprogram things so that the property and pending tables are under
> >>   your control.
> > Thanks for you reply.
> > 
> > One more question.
> > If EnableLPIs bit becomes RES1 after EnableLPIs has been written to
> > 1, DKUMP/KEXEC case will enter kernel with GICR_CTLR.EnableLPIs=1. In
> > this case I do not think DKUMP/KEXEC can work well even use
> > irqchip.gicv3_nolpi, if secondary kernel need to use LPI such as the
> > disk is nvme. Am I right?
> 
> Absolutely. If you can only signal interrupts using LPIs, there isn't
> much you can do if you cannot disable LPIs the first place to
> reconfigure the interrupts. Your NVME device is pretty useless in that case.
> 
> What we could potentially do in the kdump case (and only in that case)
> would be to try to reuse the programmed tables and IDbits settings if
> EnableLPIs is RES1. This is absolutely awful, but it could get you
> going. Maybe.

For what it is worth, I've prototyped this solution, and it is less
horrible than I though:

https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gicv3-kdump

It should allow a system that reboots into a kdump kernel to use LPIs
with the same limitations (IDbits setting and memory) as the previous
one. It doesn't help for kexec though, as the whole memory map is
relinquished to the new kernel (and by the time we find out, it could
be too late to avoid fatal damage).

It could also be used to build in an hypothetical world where the
firmware allocates tables for the kernel, excluding them from the
memory map.

The whole thing, of course, requires careful thoughts, reviewing and
testing. I'd appreciate your feedback on the matter.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
