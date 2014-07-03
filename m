From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Jul 2014 19:40:17 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <6860270.v9z8a8Se80@wuerfel>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <20140703170558.GZ32514@n2100.arm.linux.org.uk>
 <20140703173226.GC17372@arm.com> <6860270.v9z8a8Se80@wuerfel>
Message-ID: <20140703184017.GB21086@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 07:23:41PM +0100, Arnd Bergmann wrote:
> On Thursday 03 July 2014 18:32:26 Will Deacon wrote:
> > On Thu, Jul 03, 2014 at 06:05:58PM +0100, Russell King - ARM Linux wrote:
> > > On Thu, Jul 03, 2014 at 05:22:30PM +0100, Grant Likely wrote:
> > > > So, no. I completely reject any notion that breaking existing apps is
> > > > okay. If we're going to say that v8 still supports 32-bit apps, then
> > > > it has to be all of v7, not just the 'good' bits. Nor do I think
> > > > saying "it's just a bunch of games" justifies anything. We're kernel
> > > > engineers. Applications are applications and we don't break userspace.
> > > > Period.
> > > 
> > > +1 on all points above.  I'd go further - if we're going to say that v8
> > > still supports 32-bit apps, that covers at least v6 *as well*.
> > 
> > We've never pretended to support anything other than ARMv8 in the compat
> > layer. uname even reports this in the machine name.
> > 
> > If people are suddenly so concerned about *full* compatibility with an ARMv7
> > kernel, that needs a lot more than just SWP emulation:
> > 
> >   - Alignment fixups for ldm/stm
> >   - SETEND
> >   - CP15 barriers
> >   - SWI breakpoints + branch through zero syscalls
> >   (- SWP)
> 
> Thanks for the list. Of course we would only have to support the ones
> that anybody is using on ARMv8. We know about SWP and I suppose SETEND
> as well, cp15 barriers are likely to be needed by someone, and I have
> no idea about the others.
> 
> Do you know if it's actually technically possible to emulate all of
> them? E.g. does ARMv8 allow implementations that cannot switch endianess
> at all?

You can set SCTLR.E0E on exception return to change the endianness of
userspace, but there could be some `gotchas' with SETEND and the CPSR. I
need to think more about it.

> > By the arguments presented so far, I can't see why we wouldn't also need
> > OABI too. In other words, where do we draw the line? If we're not completely
> > compatible, then the compatibility argument suddenly becomes subjective.
> 
> As I just said in the other thread, OABI is pretty clearly on the other
> side of the line. Same for NWFPE and BINFMT_AOUT (you removed the latter
> on ARM32 already).
>  
> > It seems that people really want us to implement the subset of the ABI which
> > is needed by the Google Play store and are trying to dress that up as the
> > ARMv7 kernel ABI. The latter is a lot more work and conflating the two isn't
> > especially helpful.
> 
> Right. This should be about keeping users from getting mad at us (or at
> people using our kernel, who then get mad at us), not about strict adherence
> an ABI if nobody cares about it.

Agreed. I just got a bit annoyed that people were trying to use the `never
break ABI' argument. We've already chosen to break the ABI in a bunch of
places, and I think that at least some of those decisions are reasonable.

Will
