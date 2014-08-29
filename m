From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Aug 2014 10:12:42 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <54002A7D.90402@redhat.com>
References: <20140826143550.GB3027@ulmo> <53FCE704.4030103@redhat.com>
 <20140827093121.GA23186@ulmo> <53FDB46C.5010609@redhat.com>
 <20140827125613.GF23186@ulmo> <53FDE0CE.5030807@redhat.com>
 <20140827141632.GB32243@ulmo> <53FF1D6C.6090205@redhat.com>
 <20140829070116.GC13106@ulmo> <54002A7D.90402@redhat.com>
Message-ID: <20140829081236.GA13371@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 09:23:41AM +0200, Hans de Goede wrote:
> On 08/29/2014 09:01 AM, Thierry Reding wrote:
> > On Thu, Aug 28, 2014 at 02:15:40PM +0200, Hans de Goede wrote:
[...]
> >> 2) Tie these resources to simplefb so that the kernel can know when they
> >> are no longer in use, and it may e.g. re-use the memory
> > 
> > For the memory there shouldn't be a problem because it's already in the
> > DT node anyway. It has to be there so that simplefb knows where to write
> > to.
> 
> The memory information currently in the dt node is not complete enough to
> reclaim memory, e.g. the sunxi driver always reserves 8M, but the simplefb
> reg entry only describes the part actually used for the framebuffer.

You can easily fix that.

> >> To me the most logical and also most "correct" way of modelling this is to
> >> put the resources inside the simplefb dt node.
> > 
> > Except that simplefb isn't a real device, so there's a hard time
> > justifying its existence in DT as it is. Claiming resources from a
> > virtual device doesn't sound correct to me at all.
> 
> Yet you want it to claim memory that does not seem consistent to me.

Because it needs to explicitly access that memory. It does not need to
explicitly access the clocks.

> >>>> The key word here is "the used resources" to me this is not about simlefb
> >>>> managing resources, but marking them as used as long as it needs them, like
> >>>> it will need to do for the reserved mem chunk.
> >>>
> >>> The difference between the clocks and the memory resource is that the
> >>> driver needs to directly access the memory (it needs to map it and
> >>> provide a userspace mapping for it) whereas it doesn't need to touch the
> >>> clocks (except to workaround a Linux-specific implementation detail).
> >>
> >> Erm, no, the need to map the memory and the memory being a resource
> >> which may be released are an orthogonal problem. E.g. a system with
> >> dedicated framebuffer memory won't need to use a reserved main-memory
> >> chunk, nor need to worry about returning that mem when simplefb is no
> >> longer in use.
> > 
> > I would think the memory should still be reserved anyway to make sure
> > nothing else is writing over it. And it's in the device tree anyway
> > because the driver needs to know where to put framebuffer content.
> 
> No, the address were to write framebuffer contents currently is in the
> simplefb node, not the actually backing memory info. I can fully see
> some crazy hardware where a chunk of main memory is reserved for some
> funky video engine, and then that chunk of memory gets accessed through
> io-mem addresses for framebuffer access (e.g. the hardware may need this
> to know when the fb is dirtied).

We're drifting off into the realm of hypotheses here. Of course if you
can't make the hardware work with these simple assumptions because it's
too whacky then that's just tough luck.

> > So
> > the point I was trying to make is that we can't treat the memory in the
> > same way as clocks because it needs to be explicitly managed. Whereas
> > clocks don't. The driver is simply too generic to know what to do with
> > the clocks. It doesn't know what frequency they should be running at or
> > what they're used for, so by any definition of what DT should describe
> > they're useless for this virtual device.
> 
> I don't see why you keep insisting that the memory is so special, it is
> just another resource which we need to claim,

It's the only resource which we need to claim. Because it is the only
resource that needs to be explicitly accessed. simplefb is useless if
you don't write to that memory.

>                                               and tie to the simplefb node
> so that it can be re-used (or disabled) when simplefb is no longer used
> (it could e.g. be unbound explicitly on headless systems).

On headless systems the firmware shouldn't be setting up a framebuffer
in the first place.

> > Furthermore it's fairly likely that as your kernel support progresses
> > you'll find that the driver all of a sudden needs to manage some other
> > type of resource that you just haven't needed until now because it may
> > default to being always on. Then you'll have a hard time keeping
> > backwards-compatibility and will have to resort to the kinds of hacks
> > that you don't want to see in the kernel.
> 
> kernel support? This is about u-boot's video code and the simplefb bindings.

And the kernel doesn't need to use the simplefb bindings? Why are we
even having this conversation, then?

> > So it really boils down to the DT needing to describe a complete device
> > with all the dependencies. And just clocks aren't the complete
> > description. But if you want the complete description then you're going
> > to need a complete driver as well and simplefb is out of the picture
> > anyway.
> 
> Yes we eventually need a full kernel driver, with its own bindings, that
> is not what this is about.

It is to some degree. The whole point of simplefb is to provide a useful
graphical output until a full driver is in place. The way to achieve
that is by taking advantage of the firmware setting things up for you.
Which is what I've been saying all along. If the firmware has already
set things up for you, you shouldn't need to do anything special like
enabling clocks because they are already on.

Oh, and let me restate that that's not actually what the patch is doing.
It isn't enabling clocks at all. It's merely a workaround to keep them
running.

> > Once again, the current, basic form of the binding allows for a
> > completely generic implementation of the driver because it makes
> > assumptions about firmware setting things up the right way so that the
> > driver doesn't have to.
> 
> Except that it does not work because it does not claim the necessary
> resources.

Wrong. The reason it doesn't work is because the clock framework
disables the clocks. That's a Linux-specific implementation detail and
therefore shouldn't influence the binding in any way.

> We seem to be at a point where this discussion is just going in circles,
> and since there seems to be no reasonable alternative to the proposed
> solution of adding the clocks to the simplefb node, can you please just
> stop blocking progress on this?

A couple of different solutions to the problem were proposed during the
discussion. It's just that nobody's been willing to take a step back and
look at this from a different perspective.

> Your objection to this has been duly noted,

Right. Ignored is how I would put it.

>                                             but no one is forcing you or
> other people to actually use the clocks property in your implementation
> of simplefb. So if your 101% certain that this is a bad idea, can you
> please just let us (the sunxi people) make our own mistakes and learn
> from those ?

Ugh... This isn't just about letting you make your own mistakes. This is
about solving things in a wrong way (and device specific way) and baking
something into an ABI that really doesn't need to be there. And more
specifically if we let clocks be "managed" by simplefb we can no longer
claim that it is simple and therefore can't block adding all other sorts
of device-specific hacks to it.

> As we actually plan to use the clocks property, we will be
> the ones which will have to deal with any issues.

Wrong. Everyone that potentially wants to use the driver will have to
deal with this.

Anyway, I am getting tired of this whole discussion and as you already
said we're not making any progress. You really should repost this series
to the devicetree mailing list and give people there a chance to look at
the proposed changes. If everybody else is fine with it my objections
will be overruled anyway. I'll just have to sort out/live with the mess
when I want to use simplefb for hand-off.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/50c0b7e1/attachment.sig>
