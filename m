From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 20 Oct 2013 21:00:08 -0400 (EDT)
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <5264576F.6050307@wwwdotorg.org>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk> <5264576F.6050307@wwwdotorg.org>
Message-ID: <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Oct 2013, Stephen Warren wrote:

> On 10/20/2013 11:08 PM, Mark Brown wrote:
> > On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
> > 
> >> IIRC (and perhaps I don't; it was really slightly before my
> >> active involvement in kernel development) Linus triggered the
> >> whole ARM DT conversion in response to disliking the volume of
> >> changes, and conflicts, in board files. The idea of DT conversion
> >> being that all the board-specific details could be moved out of
> >> the kernel and into DT files, thus causing him not to have to see
> >> it.
> > 
> > A large part of this was to do with the needs of distros and their
> > users - they have a strong need to ship a device neutral kernel and
> > to have a reasonable ability to have their kernel deploy on
> > hardware unknown to them.  Allowing the device tree to be delivered
> > with the system rather than have the board configuration in the
> > kernel helps achieve that goal.
> 
> Yes.
> 
> I guess one thing I didn't make clear was my hope that whatever
> firmware API or VM host implementation exists would be pre-installed
> on the system so that distros never had to deal with it, or even know
> it existed. That would then transform the many different HW
> configurations into a single HW configuration as far as distros are
> concerned, since they only target running as firmware clients or VM
> guests. Essentially, we are creating a standard platform in SW, which
> perhaps is still possible, rather than in HW, which seems unlikely at
> present.

The idea of some firmware to abstract hardware differences in order to 
greatly simplify kernel development and maintenance comes up with some 
regularity.  In other words, you are far from being the first one to 
suggest that.

However this needs some reality check.

Every hardware system has its share of complexity that the software has 
to deal with.

If that complexity is not in the kernel, it has to be in the firmware.  
Given we already struggles to have proper and bug free hardware support 
in the kernel today, even with all the debugging aid and peer review 
available from the kernel community, I really don't see how you'd manage 
to make it any less complex in some firmware implementation.

If a firmware is involved, that implies a standard API you have to 
implement your firmware for.  And if that firmware API has to cater for 
different hardware variations and differences, it will have to be very 
generic and abstract.  And the more generic and remote from the hardware 
details the API is, the more complex the code making the bridge between 
the hardware and the API will have to be.

And if it is complex, it *will* have bugs.  Fixing those bugs implies 
firmware updates which is likely to be just as difficult as bootloaders, 
if not more, to update in the field.

And expecting the firmware implementation to be ready before the 
hardware ships is almost impossible.  Some tradeoff will need to be made 
in order to meet the shipping deadline which normally implies a lot of 
pressure from other departments in your company.  Most of the time that 
tradeoff translates into quality reduction in your firmware 
implementation.

There is simply no magic.  If some hardware driver needs a year to be 
top quality in the kernel, then the equivalent hardware abstraction in 
the firmware would require the same level of development effort. You're 
only moving the implementation complexity around.

And there will always come a case for which the firmware API doesn't 
cover the hardware needs well, and you'll start adding hardware specific 
quirks in the kernel directly anyway, or attempt to bypass the firmware 
entirely for performance reasons.

So in theory the firmware idea always looks great.  but that works only 
if the firmware is perfect in the first place and from the beginning.  
In practice that never works like that.

The hardware support in the kernel, on the other hand, can be improved 
incrementally with time.  It doesn't matter if it is not optimal at 
first. It can be revisited, optimized, reviewed, and sometimes even 
redesigned.  And only when it reaches maturity would be the time to use 
the experience from the kernel development and make some firmware out of 
it.  But what would be the point then?

IMHO the idea of simplifying our lives with firmware is an illusion.


Nicolas
