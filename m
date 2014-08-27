From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 27 Aug 2014 16:16:34 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <53FDE0CE.5030807@redhat.com>
References: <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
 <53FDE0CE.5030807@redhat.com>
Message-ID: <20140827141632.GB32243@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 03:44:46PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 08/27/2014 02:56 PM, Thierry Reding wrote:
> > On Wed, Aug 27, 2014 at 12:35:24PM +0200, Hans de Goede wrote:
> 
> <snip>
> 
> >>>> So second of all, Thierry, what exactly is the technical argument against
> >>>> adding support for dealing with clocks to simplefb ?
> >>>
> >>> I've already stated technical arguments against it. You could just go
> >>> back and read the thread again, or would you rather want me to repeat
> >>> them for your convenience?
> >>
> >> It is a long thread, IIRC your main arguments against this are:
> >>
> >> 1) You don't want this kind of platform-specific knowledge in simplefb
> >> 2) That simplefb is supposed to be simple, and this is not simple
> >>
> >> As for 1. several people have already argued that clocks as such are
> >> an abstract concept, found one many platforms and as such are not
> >> platform specific.
> > 
> > That alone doesn't justify this patch. SoCs often have a requirement to
> > enable clocks in a specific order, for example. Other systems may need
> > to coordinate clocks with resets in a specific order or enable power
> > domains and such. All that is very SoC specific and if we don't make it
> > very clear what this driver assumes about the state of the system, then
> > we can't object to anybody adding support for those later on either. The
> > result of that is going to be a driver that needs to handle all kinds of
> > combinations of resources.
> 
> The problems your talking about here all have to do with ordering how
> things are enabled, but what we're talking about here is keeping things
> enabled which are already enabled by the bootloader, so there is no
> ordering problem.

See what I did there? I tricked you into saying what I've been saying
all along. =) It's about keeping things enabled which have been enabled
by the bootloader. That's the root of the problem.

> > So while clocks themselves are fairly generic the way in which they need
> > to be used is highly platform-specific.
> > 
> > Let me also reiterate what I've said a couple of times already. The
> > issue here isn't that simplefb needs to manage these clocks in any way.
> > Firmware has already set them up so that display works. The reason why
> > you need this patch is so that the clock framework doesn't automatically
> > turn them off. With the proposed patch the driver enables these clocks,
> > but that's not what it needs to do, they are already on. It's a work
> > around to prevent the clock framework into not disabling them.
> > 
> > So as far as I'm concerned this points to a fundamental issue with how
> > the clock framework handles unused clocks. Therefore that is the problem
> > that should be solved, not worked around.
> 
> Hmm I see, in my mind the problem is not that the clk framework disables
> unused clocks, but that no one is marking the clocks in question as used.
> Someone should mark these clocks as used so that they do not get disabled.
> 
> We could add a clk_mark_in_use function and have the simplefb patch call
> that instead of clk_prepare_and_enable, or maybe even better just only
> claim the clks and teach the clk framework to not disable claimed clk
> in its cleanup run. That would make it clear that simplefb is not enabling
> anything, just claiming resource its need to avoid them getting removed
> from underneath simplefb, would that work for you ?

That would be more accurate, but it boils down to the same problem where
we still need a driver to claim the resources in some way whereas the
problem is fundamentally one where the bootloader should be telling the
kernel not to disable it. It's in fact the bootloader that's claiming
the resources.

> >> Any generic hw driver dealing with embedded platforms, be it ahci, ohci,
> >> ehci, etc. has ended up adding abstract support for things like clocks
> >> (and other resources). I say abstract support here, since to all these
> >> drivers the support was added in a way that no platform specific knowledge
> >> is necessary, they just deal with clocks not caring about the specific
> >> underlying clock implementation, clock names, etc.
> > 
> > Yes, I know that. You and I both had a very similar discussion not so
> > long ago. But the above aren't quite the same as simplefb. The devices
> > follow at least a well-known standard (EHCI, OHCI, AHCI), so there's
> > bound to be more commonalities between them than between the various
> > display devices that simplefb potentially can support.
> > 
> > Interestingly though, if you look at what hardware really is supported
> > by the generic drivers that deal with embedded platforms, there isn't
> > all that much diversity (I've manually stripped out non-DTS occurrences
> > since they aren't relevant for this discussion):
> 
> That is because the generic platform drivers were only added recently
> to stop the insanity where each new soc got its own ohci-soc.c /
> ehci-soc.c file.

Insanity is subjective.

> > 	arch/arm/boot/dts/rk3288.dtsi:199:              compatible = "generic-ehci";
> > 	arch/arm/boot/dts/rk3288.dtsi:210:              compatible = "generic-ehci";
> 
> (offtopic) And I see that despite the recent addition, we actually already have our
> first non sunxi user, good, I didn't even know the rockchip guys were using this :)

FWIW, the rk3288 entry is broken. It should really contain an SoC
specific compatible string as well.

> And I know that there are quite a few more in the pipeline (waiting for their
> usb phy and dt patches to get merged).

As far as I'm concerned that's all a mistake (and catastrophy waiting to
happen), but hey, there's only so many hours in a day so I've got to
pick my battles.

> > So there's a couple of SoCs and boards that actually are generic enough
> > to work with a generic driver. And then there's a whole bunch of other
> > drivers for hardware that's compliant with the same standard yet needs
> > different drivers.
> 
> No, there are a lot of other drivers which were written before someone
> decided that having 10-20 drivers which were 90% copy and paste of each
> other was a bad idea, but we're really going offtopic here.

The copy and paste is for code that's platform specific. The clocks have
different names, resets are different, supplies are different. The fact
that many can currently use the same driver is likely just coincidence
rather than design and it's entirely possible that at some point they'll
add support for a more advanced feature that makes them incompatible
with the rest of the generic drivers. And then you have a big mess
because you need to add quirks all over the place.

And this isn't all that far off-topic, since simplefb also needs to deal
with this kind of situation. And what I've been arguing is that in order
to really be generic it has to make assumptions, one of which is that it
uses only resources that it doesn't need to explicitly handle.

> >> If you look at how almost all dt bindings work, then the dt node for
> >> a device specifies the resources needed, I don't see why simplefb would
> >> be so special that it should be different here. I agree that it is
> >> important to get the abstractions right here, but to me it seems that
> >> the right abstraction is to be consistent with how all other devices
> >> are abstracted and to add needed resources to the dt node for the
> >> simplefb.
> > 
> > But simplefb is fundamentally different from other devices. It isn't a
> > physical device at all. It's a virtual device that reuses resources as
> > set up by some other piece of code (firmware). It implies that there's
> > nothing that needs to be managed. It should only create a framebuffer
> > with the given parameters and allow the kernel (and userspace) to render
> > into it.
> > 
> > The only way you can deal with such virtual, completely generic devices
> > is by being very explicit about the requirements. For simplefb the
> > assumptions are that firmware set everything up and passes information
> > about what it set up to the kernel so that it can be reused.
> 
> > None of the resources need to be explicitly managed because they have all
> > been properly configured. For that reason, again, I think the right way is
> > for the kernel not to switch off any of the used resources.
> 
> The key word here is "the used resources" to me this is not about simlefb
> managing resources, but marking them as used as long as it needs them, like
> it will need to do for the reserved mem chunk.

The difference between the clocks and the memory resource is that the
driver needs to directly access the memory (it needs to map it and
provide a userspace mapping for it) whereas it doesn't need to touch the
clocks (except to workaround a Linux-specific implementation detail).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/d30e8512/attachment-0001.sig>
