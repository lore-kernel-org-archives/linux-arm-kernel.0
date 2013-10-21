From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Oct 2013 12:04:07 +0200
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131021084854.GV25034@n2100.arm.linux.org.uk>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <20131021083242.GB30088@pengutronix.de>
 <20131021084854.GV25034@n2100.arm.linux.org.uk>
Message-ID: <20131021100406.GC21518@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 09:48:54AM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 21, 2013 at 10:32:42AM +0200, Sascha Hauer wrote:
> > On Mon, Oct 21, 2013 at 12:11:34AM +0100, Russell King - ARM Linux wrote:
> > > On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
> > > > The only thing we've really moved out of the kernel is the exact IDs of
> > > > which GPIOS, interrupts, I2C/SPI ports the devices are connected to; the
> > > > simple stuff not the hard stuff. The code hasn't really been simplified
> > > > by DT - if anything, it's more complicated since we now have to parse
> > > > those values from DT rather than putting them into simple data-structures.
> > > 
> > > Here's my random thoughts this evening on DT, orientated mostly on a
> > > problem area I've been paying attention to recently.
> > > 
> > > In some ways, DT has made things much harder.  I don't know whether
> > > you've taken a look at DRM and the various drivers we have under there,
> > > it's quite a mess of unreliable code which is trying to bend the DRM
> > > card based model to a DT based multi-device component based description
> > > with lots of sub-drivers.
> > > 
> > > What DRM currently expects is a certain initialisation order: the main
> > > drm_device structure is created by the DRM code, and then supplied to
> > > the DRM driver to populate all the different parts of the "DRM card".
> > > 
> > > Once all parts of the card have been setup (the CRTCs, encoders,
> > > connectors, etc) then some helpers can be initialised.  Once the
> > > helpers have been initialised, the "dimensions" of the "DRM card"
> > > become rather fixed until the helper is torn down.
> > > 
> > > The problem is this: if you have a multi-driver based card, there is
> > > no way to prevent any of those sub-drivers from being unbound from
> > > their drivers at any time.  module refcounts don't save you from this.
> > > Meanwhile, (at the moment) you can't half-tear down a "DRM card" and
> > > have it still in a usable state.  The internals just don't allow for
> > > it at present.
> > > 
> > > Yes, work can be put in to solve this problem, but it's being solved
> > > because of a desire to bend the subsystem to the DT way of doing things.
> > > That may or may not be the best idea.  However, what I do know is that
> > > there is now great pressure to "bend stuff so that it works with DT
> > > at all costs".  Evidence is the Exynos driver and the imx-drm driver.
> > 
> > In fact it was the other way round. We modeled the IPU devicetree
> > binding after the hardware and bended the driver around it. The DRM
> > single-card model is the limiting fator here, not the devicetree.
> 
> There are several points which I think you failed to understand:
> 
> 1. DRM vs device tree is an incompatibility.
> 2. Trying to bend DRM to DT with independent driver solutions such as
>    the abomination that is imx-drm creates its own set of problems.
> 
> If a subsystem doesn't work well with DT, then the choices are either:
> 
> (a) don't use DT with the subsystem
> (b) fix the subsystem
> 
> The choices do not include:
> 
> (c) creating an abomination that is fragile, and is trivially easy to
> oops the kernel.
> 
> This comes back to the root problem I'm trying to highlight: we are not
> trying to strive for DT forsaking everything else.  If moving to DT
> means we give up with proper code design, then we've quite literally
> lost the plot.

I'm honestly not sure if we have much of a choice right now. I've only
recently hit the stable ABI wall, which effectively keeps me from adding
new functionality. Even worse, the matter isn't that some patches would
need more work or anything, but the problem is that we can't merge code
until everybody and their cat has acked the patches, or more precisely,
the DT bindings. Typically this is a subsystem maintainer, the port
maintainer and now with DT also the device tree binding maintainers.
That's an awful lot of people you have to convince. In this particular
case these patches were even required to be acked by yet another group
of people.

Now, I can't blame anyone in particular and I certainly made my own set
of mistakes in the process, but the issue is systemic. If you need to
run a set of patches by three or four groups of people, each with their
own set of interests, it becomes very difficult to find any sort of
concensus. And not only that: it also means that every group needs to
find the time to at least look at the patches and to some degree
understand it.

So instead of requiring concensus on the binding from everyone involved,
I went to investigate alternative means to get the code out and provide
new features to our users with the goal to migrate to a proper device
tree binding incrementally. The problem is that we can't expose all the
device nodes in DT because their bindings haven't been acknowledged, but
without a device node there won't be a device for the driver to bind
against. So the obvious solution seemed to be to just create the device
programmatically. Naively I thought: "Well, this won't be pretty, but
it should be easy."

Far from it. It turns out to be very difficult to do. With all the
cross-referencing that DT allows to do so easily, the same is very
cumbersome to do with code. Not only do you need to look up device nodes
by path, but you also need to do things like fixing up phandles because
the DT doesn't contain them for all nodes, yet the kernel needs them to
look up the corresponding devices.

Once you've actually created a device node, you still need to inject it
into what the device tree core created from the DTB at boot time. Turns
out that there's actually some code to do that, but it requires the
OF_DYNAMIC option to be selected. Turning that on triggers a couple of
warnings because code doesn't take and drop references on device nodes
properly.

To round things off there's the problem on how to preserve compatibility
with future device trees where the nodes already exist because we've
finally agreed on a binding...

So unfortunately there is no easy way to mix DT with non-DT. So we can
decide to just merge code that's not supported on DT platforms, but what
good is that if the platform we want to run that code on supports only
DT?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131021/1058d7ca/attachment.sig>
