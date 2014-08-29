From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Aug 2014 09:01:17 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <53FF1D6C.6090205@redhat.com>
References: <20140826080432.GD17263@ulmo> <20140826135341.GM15297@lukather>
 <20140826143550.GB3027@ulmo> <53FCE704.4030103@redhat.com>
 <20140827093121.GA23186@ulmo> <53FDB46C.5010609@redhat.com>
 <20140827125613.GF23186@ulmo> <53FDE0CE.5030807@redhat.com>
 <20140827141632.GB32243@ulmo> <53FF1D6C.6090205@redhat.com>
Message-ID: <20140829070116.GC13106@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 02:15:40PM +0200, Hans de Goede wrote:
> On 08/27/2014 04:16 PM, Thierry Reding wrote:
[...]
> >> Hmm I see, in my mind the problem is not that the clk framework disables
> >> unused clocks, but that no one is marking the clocks in question as used.
> >> Someone should mark these clocks as used so that they do not get disabled.
> >>
> >> We could add a clk_mark_in_use function and have the simplefb patch call
> >> that instead of clk_prepare_and_enable, or maybe even better just only
> >> claim the clks and teach the clk framework to not disable claimed clk
> >> in its cleanup run. That would make it clear that simplefb is not enabling
> >> anything, just claiming resource its need to avoid them getting removed
> >> from underneath simplefb, would that work for you ?
> > 
> > That would be more accurate, but it boils down to the same problem where
> > we still need a driver to claim the resources in some way whereas the
> > problem is fundamentally one where the bootloader should be telling the
> > kernel not to disable it. It's in fact the bootloader that's claiming
> > the resources.
> 
> Yes, but those resources do not belong to the bootloader in a sense
> that traditional bootloader / firmware claimed resources (e.g. acpi
> reserved resources) do. These traditional resources are claimed for ever.

I thought that at least on x86 there was a way for the kernel to reclaim
memory set apart for an early framebuffer.

> Where as these resources are claimed by the bootloader to keep the simplefb
> it provides working, as soon as the simplefb is no longer used, they become
> unused.

Right. And when simplefb goes away it is because a real driver is taking
over, in which case it will claim the resources explicitly.

> > The copy and paste is for code that's platform specific. The clocks have
> > different names, resets are different, supplies are different. The fact
> > that many can currently use the same driver is likely just coincidence
> > rather than design and it's entirely possible that at some point they'll
> > add support for a more advanced feature that makes them incompatible
> > with the rest of the generic drivers. And then you have a big mess
> > because you need to add quirks all over the place.
> > 
> > And this isn't all that far off-topic, since simplefb also needs to deal
> > with this kind of situation. And what I've been arguing is that in order
> > to really be generic it has to make assumptions, one of which is that it
> > uses only resources that it doesn't need to explicitly handle.
> 
> I can understand that you're worried about generic ?hci drivers dealing with
> clocks / resets / etc. As there may be strict ordering requirements there,
> but for simplefb that is not the case.
> 
> All we're asking for is for a way to communicate 2 things to the kernel:
> 
> 1) These resources are in use (we are not asking the kernel to do anything
> with them, rather the opposite, we're asking to leave them alone so no
> ordering issues)

Right. That's the issue that needs to be solved. We still only disagree
on how it should be solved.

> 2) Tie these resources to simplefb so that the kernel can know when they
> are no longer in use, and it may e.g. re-use the memory

For the memory there shouldn't be a problem because it's already in the
DT node anyway. It has to be there so that simplefb knows where to write
to.

For all the other resources, if 1) is solved properly then 2) becomes a
non-issue.

> To me the most logical and also most "correct" way of modelling this is to
> put the resources inside the simplefb dt node.

Except that simplefb isn't a real device, so there's a hard time
justifying its existence in DT as it is. Claiming resources from a
virtual device doesn't sound correct to me at all.

> >> The key word here is "the used resources" to me this is not about simlefb
> >> managing resources, but marking them as used as long as it needs them, like
> >> it will need to do for the reserved mem chunk.
> > 
> > The difference between the clocks and the memory resource is that the
> > driver needs to directly access the memory (it needs to map it and
> > provide a userspace mapping for it) whereas it doesn't need to touch the
> > clocks (except to workaround a Linux-specific implementation detail).
> 
> Erm, no, the need to map the memory and the memory being a resource
> which may be released are an orthogonal problem. E.g. a system with
> dedicated framebuffer memory won't need to use a reserved main-memory
> chunk, nor need to worry about returning that mem when simplefb is no
> longer in use.

I would think the memory should still be reserved anyway to make sure
nothing else is writing over it. And it's in the device tree anyway
because the driver needs to know where to put framebuffer content. So
the point I was trying to make is that we can't treat the memory in the
same way as clocks because it needs to be explicitly managed. Whereas
clocks don't. The driver is simply too generic to know what to do with
the clocks. It doesn't know what frequency they should be running at or
what they're used for, so by any definition of what DT should describe
they're useless for this virtual device.

Furthermore it's fairly likely that as your kernel support progresses
you'll find that the driver all of a sudden needs to manage some other
type of resource that you just haven't needed until now because it may
default to being always on. Then you'll have a hard time keeping
backwards-compatibility and will have to resort to the kinds of hacks
that you don't want to see in the kernel.

So it really boils down to the DT needing to describe a complete device
with all the dependencies. And just clocks aren't the complete
description. But if you want the complete description then you're going
to need a complete driver as well and simplefb is out of the picture
anyway. Once again, the current, basic form of the binding allows for a
completely generic implementation of the driver because it makes
assumptions about firmware setting things up the right way so that the
driver doesn't have to.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/29e057cd/attachment-0001.sig>
