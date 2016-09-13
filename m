From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Sep 2016 15:51:26 +0100
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <57D80B91.4020306@laposte.net>
References: <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net> <20160912135549.GA14165@leverpostej>
 <57D6D2A9.3010006@laposte.net> <20160912165637.GF14165@leverpostej>
 <57D7CF17.2050905@laposte.net> <20160913131208.GA23336@leverpostej>
 <57D80B91.4020306@laposte.net>
Message-ID: <20160913145126.GC23336@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 13, 2016 at 04:22:09PM +0200, Sebastian Frias wrote:
> On 09/13/2016 03:12 PM, Mark Rutland wrote:

[context was deleted, TL;DR: binding review is necessary, and takes
effort, regardless of presence/absence of a driver]

> >> Only for bindings for which there is a driver.
> > 
> > This is not true for all but the most trivial of hardware, as I stated
> > previously.
> > 
> > Go and take a look at all the effort that went into sorting out generic
> > IOMMU bindings, when driver support was written after a large amount of
> > review to sort out fundamental concepts. We had to sort out fundamentals
> > before prototype driver code could be written, and while we knew drivers
> > were coming, an awful lot of review effort came first.
> 
> Again, you are talking about drivers, but it is not the case at hand.

No, I am not. Please do not presume to put words in my mouth.

I explicitly described a case where binding review took effort, and the
presence or absence of drivers was irrelevant. We later had drivers,
yes, but we had to understand the hardware to get the binding right
first.

If there's data which has no consumer, it has no value being in the DT.
Placing data with no consumer in the DT comes with a number of issues,
e.g.

a) Some DTS authors will ignore it, and not place data according to it
   in DTs. Hence there's no gain in consistency.

b) Though some accident (perhaps a typo, perhaps a misunderstanding of
   the binding), a DT will come to have erroneous data, yet this will go
   unnoticed, as there is no consumer. When later a consumer appears, it
   can't trust existing DTs, and has to either ignore the binding
   entirely, or bodge around each and every broken DT.

c) When a consumer eventually appears, it turned out we didn't capture
   details of the hardware sufficiently, and the binding turns out to be
   useless. At worst, this boils down to (b), at best, we require
   additional properties. In this case absolutely nothing is gained.

In all cases, all we end up doing is enlarging DTBs, and risk causing
even more work.

If there *is* going to be a consumer, and if information regarding that
will be provided, then matters are different, and we can consider a
binding on its own merit. We need a specific example for that.

> If the "user of the binding" is not Linux, under what circumstances
> could "Linux" have the legitimacy of guaranteeing or enforcing any Linux-
> specific commitment?

To at least the extent that if someone says they're not going to bother,
we clearly have no reason to bother supporting them.

Note that *nothing* stops you from using the DT container format for
your own purposes, in violation of every binding and rule we have.
However, for those cases we clearly won't document them as the standard
mechanism.

There are other things build atop of the DTB format, e.g. FIT, which
aren't quite devicetree in the usual sense.

> > I understand that goal, and I've asked for a specific example, as this
> > is not clear-cut. e.g. there has been work on describing secure devices
> > for QEMU, but this isn't necessarily something we want to expose Linux
> > to in general.
> 
> Interesting, do you know where in QEMU's code should I look for that?

Documentation/devicetree/bindings/arm/secure.txt for the basics.

Generally, I'd expect that even if the secure OS were using DT in this
fashion, the non-secure general purpose OS would be handed a DT
containing only the non-secure world portions.

> > While a lot of that effort is taken by code, care must also be taken wit
> > the bindings themselves, and those considerations apply.
> 
> IMHO, they apply only when there's a Linux driver, or any other public
> user of such bindings. But if there's no user, it seems like an unnecessary
> constraint.

If there's no user, there's no need for the binding.

If there's some user somewhere, and that user wants the binding
rubber-stamped as an "official" binding, they need to follow the usual
rules for bindings.

If there is a user, and they don't want to follow the usual rules,
there's no point trying to get the binding rubber-stamped.

Thanks,
Mark.
