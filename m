From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 01 Jul 2014 23:17:22 -0400 (EDT)
Subject: [PATCH] ARM: convert all "mov.* pc, reg" to "bx reg" for ARMv6+
 (part1)
In-Reply-To: <20140701173547.GW28164@arm.com>
References: <E1X20mL-00083I-Sv@rmk-PC.arm.linux.org.uk>
 <yw1x4mz1f2t9.fsf@unicorn.mansr.com>
 <20140701171346.GP3705@n2100.arm.linux.org.uk>
 <yw1xzjgtdmas.fsf@unicorn.mansr.com> <20140701173547.GW28164@arm.com>
Message-ID: <alpine.LFD.2.11.1407012314100.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Jul 2014, Will Deacon wrote:

> Hi Mans,
> 
> On Tue, Jul 01, 2014 at 06:24:43PM +0100, M?ns Rullg?rd wrote:
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > > As you point out, "bx lr" /may/ be treated specially (I've actually been
> > 
> > Most, if not all, Cortex-A cores do this according the public TRMs.
> > They also do the same thing for "mov pc, lr" so there will probably be
> > no performance gain from this change.  It's still a good idea though,
> > since we don't know what future cores will do.
> 
> Funnily enough, that's not actually true (and is more or less what prompted
> this patch after discussion with Russell). There are cores out there that
> don't predict mov pc, lr at all (let alone do anything with the return
> stack).
> 
> > > discussing this with Will Deacon over the last couple of days, who has
> > > also been talking to the hardware people in ARM, and Will is happy with
> > > this patch as in its current form.)  This is why I've changed all
> > > "mov pc, reg" instructions which return in some way to use this macro,
> > > and left others (those which are used to call some function and return
> > > back to the same point) alone.
> > 
> > In that case the patch should be fine.  Your patch description didn't
> > make it clear that only actual returns were being changed.
> 
> I'm led to believe that some predictors require lr in order to update the
> return stack, whilst others don't. That part is all horribly
> micro-architectural, so the current patch is doing the right thing by
> sticking to the ARM ARM but enabling us to hook into other registers later
> on if we choose.

May I suggest to have a patch with only the macro definition in it and 
all this discussion in the commit log please?  The usage sites should be 
done in a separate patch to make it clearer.


Nicolas
