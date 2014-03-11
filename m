From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Mar 2014 14:20:49 -0700
Subject: [GIT PULL 00/21] Renesas ARM based SoC Board Updates for v3.15
In-Reply-To: <CANqRtoQyX6o=mO0wG8skqVVPPfFC6vZHGwdqoz6zjbODA9nwHA@mail.gmail.com>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
 <20140220082316.GE19089@quad.lixom.net>
 <CANqRtoQj8CNn=pNP5HkVbaSSc=PbZEoOD3wGa9sXF9nXraTVeQ@mail.gmail.com>
 <201402251704.54970.arnd@arndb.de>
 <CANqRtoQyX6o=mO0wG8skqVVPPfFC6vZHGwdqoz6zjbODA9nwHA@mail.gmail.com>
Message-ID: <20140311212049.GM31877@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 01:21:05PM +0900, Magnus Damm wrote:
> On Wed, Feb 26, 2014 at 1:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 25 February 2014, Magnus Damm wrote:
> >> On Thu, Feb 20, 2014 at 5:23 PM, Olof Johansson <olof@lixom.net> wrote:
> >> > On Thu, Feb 06, 2014 at 03:17:08PM +0900, Simon Horman wrote:
> >> Thanks for your email. I agree that the number of board file commits
> >> is definitely larger than zero so some clarification is in order.
> >>
> >> As you probably recall, we earlier agreed on not adding any new board
> >> files. That part is clear I believe so I will skip that.
> >>
> >> Regarding the legacy board code, we have quite ok hardware support
> >> coverage as it is now, but some devices drivers are of course still
> >> under development. This means that in some cases integration is on
> >> going or has not happened yet. You may see those kind of changes as
> >> significant commits in the pull requests for board support.
> >
> > [adding Ben Dooks, since he was complaining about this as well]
> >
> > My feeling is that we should adjust the strategy for shmobile. We've
> > had good success with the dual strategy of keeping board support
> > separate for DT-enabled and ATAGS-only boards in the sense that
> > we did not have to coordinate updates for bindings between subsystem
> > and architecture git trees, which has always been source for
> > problems on other platforms.
> 
> Hi Arnd,
> 
> You're right that many of our boot loaders only provide us with ATAG
> information. In the kernel we have long since made use of appended DTB
> to handle those cases. The last bit of code that depended on ATAGS and
> mach-type being passed from the boot loader was removed in the
> following patch:
> 
> [PATCH] ARM: shmobile: Update romImage to relocate appended DTB
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/boot/compressed/head-shmobile.S?id=2c408d149299e99c89fc4be80fb4fe00a7016f02
> 
> > However, the price for this seems to be that it's still not possible
> > to get a properly working system without a board file, and my feeling
> > is that it's taking too long to get there. In particular, we now see
> > new drivers getting added (I noticed VIN, which Ben mentioned before)
> > that start out with just platform_device support but no DT support.
> > This is bad, because it means DT users are always behind.
> 
> From my side it is possible to boot working systems with DT only
> (without a board file) for a wide range of SoCs and boards. Actually,
> for KZM9D we have no board code - instead there is only Multiplatform
> DT. Any left over C board code for KZM9D and the legacy EMEV2SoC code
> is removed in:
> 
> [PATCH 00/03] ARM: shmobile: Clean up the EMEV2 and KZM9D code base
> http://www.spinics.net/lists/arm-kernel/msg307379.html
> 
> To be clear, I believe all our boards can boot without a board file.
> The only exception is sh7372 and Mackerel which will be phased out.
> 
> Please note that device support may however be limited with DT. This
> since several device drivers are under constant development to be able
> to support the latest hardware features. And the hardware is being
> updated quite regularly, so it seems to me that our only choice is to
> keep on updating software support.
> 
> >> In the Legacy Lager/Koelsch board code the following devices are
> >> supported as platform devices:
> >>
> >> ETHER, SCIF, DU, I2C, SATA*, USB*, MSIOF*, SDHI*, QSPI*, MMCIF,
> >> Audio*, VIN*, Thermal, IRQC, PFC, CMT
> >>
> >> * Platform device support under development in v3.15-pre
> >>
> >> In the Multiplatform DT for Lager/Koelsch the following devices have DT support:
> >>
> >> ETHER, SCIF**, I2C, SATA, MSIOF, SDHI, QSPI, MMCIF, Thermal, IRQC, PFC, CMT**
> >>
> >> ** Driver DT binding development on-going but integration not finalized
> >>
> >> In Multiplatform DT for Lager/Koelsch the following devices lack DT bindings:
> >>
> >> DU (drm/kms)
> >> USB (host/function/phy)
> >> Audio (alsa-soc + dmac)
> >> VIN (v4l2 + camera sensor)
> >
> > Ok, thanks for the list.
> >
> >> Our plan is to migrate over to the DT Multiplatform code base as soon
> >> as ever possible, but at the same time we do not want to commit long
> >> term support of potentially premature DT bindings. Our short term
> >> solution to that is to use platform devices for a limited number of
> >> devices together with DT Multiplatform.
> >>
> >> If you would like use to adjust our way forwards please let me know!
> >
> > I think you should try to close the gap between ATAGS and DT now and
> > stop the dual strategy. You seem to have come far enough with the
> > basic infrastructure (clock, pinctrl, irq, timer, ...) that all the
> > devices missing DT support now are on-chip peripherals. If this is the
> > case, it should be possible to use auxdata registration in the
> > per-soc files to connect the platform data to the remaining devices
> > that are lacking DT bindings. This means we have to be more careful
> > with the dependencies when a driver gains a DT binding, but at least
> > we can enforce that any driver in the future only gets merged with
> > a proper DT binding as we do for other subarchitectures, and you don't
> > have to implement probing twice for each new driver.
> 
> I agree about closing the gap and using DT as much as ever possible.
> Perhaps we need to discuss a bit more about how to proceed.
> 
> In my mind this all boils down to two separate issues:
> 
> 1) How to close the gap:
> 
> Our current plan is to copy the left over non-DT devices from legacy
> board code to our DT board support. This can be done with or without
> AUXDATA, exactly how to do it is a separate (but perhaps important?)
> issue. When the DT board support is in OK state then we remove the
> legacy board code. How long time that takes depends on the level of
> board support. For the boards and devices I listed above I believe it
> can be done in less than a week. If you want us to do this differently
> then please advice us about your preference.
> 
> Regarding AUXDATA, it seems mainly useful for simple devices that have
> no dependencies on other parts of the system. Our remaining portion of
> non-DT device drivers are however all relatively complex devices with
> many dependencies and sometimes odd topology. On such device drivers
> our prototyping showed that AUXDATA mainly came with drawbacks of
> having to commit to bindings prematurely but we could not really see
> any upside. We would like to hear more from you how you think we
> should proceed.

I think you can do at least some of this without committing to bindings all
that early. Keep in mind that bindings can be amended over time, so if you
start a driver with a trivial binding you can add properties over time as
needed.

I think some of this could be easier to discuss if you include one or two
examples of the more complex drivers that you need to tackle.

Using AUXDATA to attach platform data is easy to do but messy to undo, since it
tends to require interlocked changes with the driver trees, which means shared
branches and merge conflicts across the wider tree. It has been done before
though so it's not impossible. :-)

> 2) How to handle continuous driver development and integration
> 
> As you have seen, most of our simple device drivers have already been
> successfully converted to DT. What remains are more complex devices.
> 
> Since we do upstream first we rely on being able to develop device
> driver code incrementally over several kernel releases. To allow early
> use, development and testing we also integrate the device drivers
> continuously. We have been doing this for many years now and it seems
> to work really well for us. That device drivers are reused and
> improved over several years is quite common.
> 
> So far we have been developing basic support via platform device
> interfaces and directly exposed that to our users via board code
> written in C. Over time we start feeling confident that we have good
> enough support level and understanding of the hardware for a
> particular driver. When that point has been reached then we define
> bindings to enable DT support. From there we probably keep on
> iterating even more. This is what we currently do.
> 
> In mach-shmobile you see a lot of board changes coming from us when we
> are performing continuous driver integration. I would like to ask you
> for advice if you can recommend us any other development model that
> may fit better with the ARM SoC way of doing things.

Again, I think it might be beneficial to talk about one or two specific
examples here instead of the generic situation, and figure it out from there.


-Olof
