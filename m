From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 27 Aug 2014 16:30:23 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140827135609.GW15297@lukather>
References: <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com> <20140827125613.GF23186@ulmo>
 <20140827135609.GW15297@lukather>
Message-ID: <20140827143022.GC32243@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 03:56:09PM +0200, Maxime Ripard wrote:
> On Wed, Aug 27, 2014 at 02:56:14PM +0200, Thierry Reding wrote:
> > > >> So second of all, Thierry, what exactly is the technical argument against
> > > >> adding support for dealing with clocks to simplefb ?
> > > > 
> > > > I've already stated technical arguments against it. You could just go
> > > > back and read the thread again, or would you rather want me to repeat
> > > > them for your convenience?
> > > 
> > > It is a long thread, IIRC your main arguments against this are:
> > > 
> > > 1) You don't want this kind of platform-specific knowledge in simplefb
> > > 2) That simplefb is supposed to be simple, and this is not simple
> > > 
> > > As for 1. several people have already argued that clocks as such are
> > > an abstract concept, found one many platforms and as such are not
> > > platform specific.
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
> Which is not an issue in our case, since the firmware enabled them
> already.

Exactly, so why do you need them at all? You shouldn't have to.

> > So there's a couple of SoCs and boards that actually are generic enough
> > to work with a generic driver. And then there's a whole bunch of other
> > drivers for hardware that's compliant with the same standard yet needs
> > different drivers. To me that's a clear indication that there isn't
> > enough genericity to warrant a generic driver in the first place.
> > 
> > The commonality is in the functionality and defined by the standard
> > registers. But there's little to no commonality in how that interface is
> > glued into the SoC. Luckily the above subsystems implement the standard
> > hardware programming in a library, so that non-generic drivers can still
> > make use of most of the generic code.
> 
> To be fair, these additions are a couple of release old, and are quite
> recent. You can't really make any judgement based on barely 2 releases
> of history.

Okay, fair enough. Time will tell. It's still kind of odd to declare a
driver to be generic without attempting to make the majority of existing
drivers work with it.

> > > If you look at how almost all dt bindings work, then the dt node for
> > > a device specifies the resources needed, I don't see why simplefb would
> > > be so special that it should be different here. I agree that it is
> > > important to get the abstractions right here, but to me it seems that
> > > the right abstraction is to be consistent with how all other devices
> > > are abstracted and to add needed resources to the dt node for the
> > > simplefb.
> > 
> > But simplefb is fundamentally different from other devices. It isn't a
> > physical device at all. It's a virtual device that reuses resources as
> > set up by some other piece of code (firmware). It implies that there's
> > nothing that needs to be managed. It should only create a framebuffer
> > with the given parameters and allow the kernel (and userspace) to render
> > into it.
> 
> Nothing should be managed, but everything should stay as is. Again,
> this is something that we all seem to agree on, yet differ completely
> on how to implement that.

I'm arguing that if everything should stay as is, then nobody should
have to do anything.

> > The only way you can deal with such virtual, completely generic devices
> > is by being very explicit about the requirements. For simplefb the
> > assumptions are that firmware set everything up and passes information
> > about what it set up to the kernel so that it can be reused. None of the
> > resources need to be explicitly managed because they have all been
> > properly configured. For that reason, again, I think the right way is
> > for the kernel not to switch off any of the used resources.
> 
> So, you're saying that the firmware should inform the kernel about
> what clocks it has set up?

Yes. The problem is that even if we tell the kernel that clocks have
been set up it may still decide to disable them when they are unused.
That's the whole purpose of clk_disable_unused() as I understand it.
Whatever mechanism we introduce needs to specifically imply that the
clock must stay enabled.

> > If you want to equate simplefb to other drivers then it is fundamentally
> > broken anyway. Given only what's in the DTB the simplefb driver won't be
> > able to do anything useful. Consider what would happen if the firmware
> > didn't set up all the resources. Then the DT is missing resets, power
> > supplies and all that to make it work.
> 
> That would mean that the framebuffer wasn't working in the first
> place, which breaks the initial assumption, doesn't it?

Exactly. simplefb gets away with an incomplete description of the
hardware in DT because of these assumptions. So you can't draw parallels
to other drivers since they don't make these assumptions and need to be
described completely.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/114481a1/attachment.sig>
