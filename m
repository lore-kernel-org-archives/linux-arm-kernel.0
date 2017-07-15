From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 16 Jul 2017 01:24:25 +0200
Subject: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
In-Reply-To: <1a5ef0ae-16f3-5a61-ae4e-083664cb30c0@gmail.com>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <20170715164626.GA1373@amd> <1a5ef0ae-16f3-5a61-ae4e-083664cb30c0@gmail.com>
Message-ID: <1578637.1XJQpJurXn@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, July 15, 2017 10:20:27 AM Florian Fainelli wrote:
> 
> On 07/15/2017 09:46 AM, Pavel Machek wrote:
> > Hi!
> > 
> >>>> I had an idea of using an enum type encompassing all of the power states
> >>>> defined for various platforms and serving both as a registry (to ensure the
> >>>> uniqueness of the values assigned to the states) and a common ground
> >>>> between platforms and drivers.
> >>>>
> >>>> Something like:
> >>>>
> >>>> enum platform_target_state {
> >>>> 	PLATFORM_STATE_UNKNOWN = -1,
> >>>> 	PLATFORM_STATE_WORKING = 0,
> >>>> 	PLATFORM_STATE_ACPI_S1,
> >>>> 	PLATFORM_STATE_ACPI_S2,
> >>>> 	PLATFORM_STATE_ACPI_S3,
> >>>> 	PLATFORM_STATE_MY_BOARD_1_GATE_CLOCKS,
> >>>> 	PLATFORM_STATE_MY_BOARD_1_GATE_POWER,
> >>>> 	PLATFORM_STATE_ANOTHER_BOARD_DO_CRAZY_STUFF,
> >>>> 	...
> >>>> };
> >>>>
> >>>> and define ->target_state to return a value of this type.
> >>>>
> >>>> Then, if a driver sees one of these and recognizes that value, it should
> >>>> know exactly what to do.
> >>>
> >>> Remind me why this is good idea?
> >>
> >> Because there are drivers that need to do specific things during
> >> suspend on a specific board when it goes into a specific state as a
> >> whole.
> > 
> > We have seen driver that cares about voltage to his device being
> > lost. That's reasonable.
> > 
> > Inquiring what the platform target state is... is not.
> > 
> >>> If board wants to know if certain regulator stays online during
> >>> suspend, it should invent an API for _that_.
> >>
> >> Ideally, yes.  However, that may be problematic for multiplatform kernels,
> >> because they would need to have all of those APIs built in and the driver
> >> code to figure out which API to use would be rather nasty.
> > 
> > Lets do it the right way. Big enum is wrong.
> 
> The enum offers the advantage of centralizing how many different states
> exist for all the platforms we know about in the kernel, it's easy to
> define common values for platforms that have the same semantics, just
> like it's simple to add new values for platform specific details.

Well, you seem to be liking this, so why don't you just implement it?

Thanks,
Rafael
