From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 21 Oct 2013 12:18:49 +0100
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution,
 or is there something	better?
In-Reply-To: <20131020231134.GR25034@n2100.arm.linux.org.uk>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
Message-ID: <52650D99.80602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2013 12:11 AM, Russell King - ARM Linux wrote:
> On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
>> The only thing we've really moved out of the kernel is the exact IDs of
>> which GPIOS, interrupts, I2C/SPI ports the devices are connected to; the
>> simple stuff not the hard stuff. The code hasn't really been simplified
>> by DT - if anything, it's more complicated since we now have to parse
>> those values from DT rather than putting them into simple data-structures.
>
> Here's my random thoughts this evening on DT, orientated mostly on a
> problem area I've been paying attention to recently.
>
> In some ways, DT has made things much harder.  I don't know whether
> you've taken a look at DRM and the various drivers we have under there,
> it's quite a mess of unreliable code which is trying to bend the DRM
> card based model to a DT based multi-device component based description
> with lots of sub-drivers.
>
> What DRM currently expects is a certain initialisation order: the main
> drm_device structure is created by the DRM code, and then supplied to
> the DRM driver to populate all the different parts of the "DRM card".
>
> Once all parts of the card have been setup (the CRTCs, encoders,
> connectors, etc) then some helpers can be initialised.  Once the
> helpers have been initialised, the "dimensions" of the "DRM card"
> become rather fixed until the helper is torn down.
>
> The problem is this: if you have a multi-driver based card, there is
> no way to prevent any of those sub-drivers from being unbound from
> their drivers at any time.  module refcounts don't save you from this.
> Meanwhile, (at the moment) you can't half-tear down a "DRM card" and
> have it still in a usable state.  The internals just don't allow for
> it at present.
>
> Yes, work can be put in to solve this problem, but it's being solved
> because of a desire to bend the subsystem to the DT way of doing things.
> That may or may not be the best idea.  However, what I do know is that
> there is now great pressure to "bend stuff so that it works with DT
> at all costs".  Evidence is the Exynos driver and the imx-drm driver.
>
> Now, the flip side to this is that some DRM solutions include an I2C
> device, which is itself a separate driver, and would appear to suffer
> from this same problem.  This is handled via the drm_encoder_slave
> infrastructure.  As it currently is written (ignoring DT) it get
> around the problem by not actually using the driver model "properly".
> If it were to, it would run into this same problem.
>
> How would we sort this out pre-DT?  We'd pass a chunk of platform data
> into a driver to describe the various options: eg, whether we wanted
> HDMI output, the I2C bus details of the DDC bus, etc., which results
> in a simpler solution - though traditionally a driver specific solution.
>
> However, "driver specific solution" is bad - always has been.  What was
> missed is that the platform datas should never have been specific to
> any particular device.  They should have been class specific.  I tried
> to do that with flash_platform_data for example - some people got the
> idea, but the vast majority didn't.
>
> What is clear to me is that there is no panacea "one size fits all"
> approach to the problem of device driver bindings and turning them into
> generic drivers.  Everyone has their own pet ideas and solutions to
> this.  Some favour DT.  Others favour other solutions.
>
> At the end of the day, the question should be - what is the easiest
> solution.  In the case of DRM, it may well be that the easiest solution
> is to have a translation layer which presents a DT multi-node
> description (note the change in terminology: multi-node not multi-device)
> to DRM as platform data so that DRM can preserve its "single card"
> solution.  Or whatever other translation layer is necessary for whatever
> solution is chosen in the future.
>
> There's much much more to the DRM vs DT problem than the above.  In
> short:
> - we have several driver specific solutions to this same problem
> - on the balance of probabilities, their solutions are buggy in some
>    way, some more buggy than others.
>
> I have one DRM driver which I've recently submitted to David Airlie
> which I have *not* implemented DT support for and that is because I
> don't want to solve this same problem in another driver specific way.
> I'd rather the driver wasn't directly supportable by DT until there's
> proper work in infrastructure than to create yet another driver
> specific solution - or the DT mess is dealt with outside the main
> driver.  (I believe that has already been done by Sebastian...)

IMHO, making a driver DT-aware should never really depend on re-writing
the core driver itself but help the subsystem to build up proper driver-
specific structs from it. When I started to make Armada DRM to work with
DT, I didn't look for places to modify the driver but what it expects
in terms of resources. So, for Armada DRM and most likely most SoC DRM
drivers DT should only be used to build up the platform_data required
for the driver.

IIRC, in the early DT days, everybody of_iomap'ed resources, with
device core translating those to resources you can limit some drivers
to the match table to make it DT aware. I guess this also has to be
done within other subsystems, drm and propably asoc too.

What DT really allows us to do, is describing dependencies between
nodes, i.e. RGB scan-out connected to HDMI transmitter on I2C bus
foo. That is what we really should exploit to build up a proper
representation of the devices used for e.g. a video card. Except some
very IP specific properties, there should be no need to parse the
DT yourself. Of course, there will be over-complicated boards or
designs that make it hard to deal with, but it would have been with or
without DT.

I definitely may have a limited view over the overall complexity
involved especially with non-SoC drivers. Nonetheless, I am looking
forward to meet some of you at ELCE and get more insight in this.

> Other thoughts on DT... it's a pain in the backside as it's far too
> easy to make a subtle mistake in a DT source file and have it "build"
> to a blob. You can then spend hours trying to debug why something isn't
> working, and it's very simply because you typo'd something.  A recent
> example:
>
> 	pintctrl-0 = <...>;

Aren't there proposals for DT schematas that could possibly solve this?

Sebastian

> and then you start wondering why aren't I getting signals out from the
> pins you want, and you start chasing around trying to find out if its
> something that you haven't thought of, whether some setting in the
> pin settings is wrong or whatever.  You completely fail to notice the
> additional 't' for hours and hours.  Eventually, you start pasting it
> onto IRC and at that point you spot the error.
>
> You may laugh at that, but that's exactly what has happened - all
> because the DT compiler is freeform - provided the strings look okay
> to it, that's all it cares about.  Whether the description is correct
> for the device or not is outside of its concern.
>
> I'm pretty certain that I won't be the only one who has gone through
> this - and I'm probably not going to be the last.
>
> We already know that "board firmware" has a tendency to be buggy.  Well,
> the DT compiler as it stands today does nothing what so ever to help
> people make sure that what they _think_ they're typing into the DT
> file is actually correct.  All the time that we're have a tool which
> allows typos through we're going to encounter bugs like this.  Not a
> problem when DT is shipped with the kernel, but when it isn't, what
> then...
