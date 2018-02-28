From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 28 Feb 2018 17:53:03 +0000
Subject: [PATCH 0/3] STM32 Extended TrustZone Protection driver
In-Reply-To: <CA+M3ks5qR++8Vwwk8=5Oh6DBdT9NF3ysqfjayq4Gze-oke8Ayg@mail.gmail.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
 <20180227171124.h2yjhicmlfrwr4nh@lakrids.cambridge.arm.com>
 <CA+M3ks6qV_pGdE6mr3n7TiY9VhbqEkrdH6tN=8e-A=oa4UbDHw@mail.gmail.com>
 <11c3ceb2-8b8d-de59-a0be-0777a42f63a7@arm.com>
 <CA+M3ks5qR++8Vwwk8=5Oh6DBdT9NF3ysqfjayq4Gze-oke8Ayg@mail.gmail.com>
Message-ID: <20180228175303.h7qm3zylmfsitmwn@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 08:53:28AM +0100, Benjamin Gaignard wrote:
> 2018-02-27 20:46 GMT+01:00 Robin Murphy <robin.murphy@arm.com>:
> > On 27/02/18 19:16, Benjamin Gaignard wrote:
> >> 2018-02-27 18:11 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> >>> On Tue, Feb 27, 2018 at 03:09:23PM +0100, Benjamin Gaignard wrote:
> >>>>
> >>>> On early boot stages STM32MP1 platform is able to dedicate some
> >>>> hardware blocks to a secure OS running in TrustZone.  We need to
> >>>> avoid using those hardware blocks on non-secure context (i.e.
> >>>> kernel) because read/write access will all be discarded.
> >>>>
> >>>> Extended TrustZone Protection driver register itself as listener
> >>>> of BUS_NOTIFY_BIND_DRIVER and check, given the device address, if
> >>>> the hardware block could be used in a Linux context. If not it
> >>>> returns NOTIFY_BAD to driver core to stop driver probing.

> >>> If these devices are not usable from the non-secure side, why are they
> >>> not removed form the DT (or marked disabled)?
> >>>
> >>> In other cases, where resources are carved out for the secure side (e.g.
> >>> DRAM carveouts), that's how we handle things.
> >>
> >> That true you can parse and disable a device a boot time but if DT
> >> doesn't exactly reflect etzpc status bits we will in trouble when
> >> try to get access to the device.
> >
> > Well, yes. If the DT doesn't correctly represent the hardware,
> > things will probably go wrong; that's hardly a novel concept, and
> > it's certainly not unique to this particular SoC.
> >
> >> Changing the DT is a software protection while etzpc is an hardware
> >> protection so we need to check it anyway.
> >
> > There are several in-tree DT and code examples where devices are marked as
> > disabled on certain boards/SoC variants/etc. because attempting to access
> > them can abort/lock up/trigger a secure watchdog reset/etc. The only
> > "special" thing in this particular situation is apparently that this device
> > even allows its secure configuration to be probed from the non-secure side
> > at all.
> >
> > Implementing a boardfile so that you can "check" the DT makes very little
> > sense to me; Linux is not a firmware validation suite.
> 
> It is not about to "check" the DT but if Linux could get access to the
> hardware.  Hardware block assignment to secure or non-secure world
> could change at runtime for example I2C block could be manage by
> secure OS for a trusted application and when it have finish "release"
> the it for Linux.

The driver does not do this today. It probe the HW once during early
boot, then aborts driver probes. It provides no provision for dynamic
assignment.

Is this something you plan to implement? How will the secure world
notify the non-secure world of its intent to manage a device, or
vice-versa?

> I don't think that could be done by changing DT.
> 
> I think that dhecking hardware blocks status bits before probe them is
> also more robust than let
> each driver discover at probe time that it hardware isn't responding.

I don't follow. Robin and I suggest that gets encoded in the DT, which
is *more* efficient than having each driver probe the DT, begin probing,
then abort via the notifier.

This really seems like something that should be done *prior* to entering
Linux.

Thanks,
Mark.
