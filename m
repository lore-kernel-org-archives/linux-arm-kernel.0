From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Aug 2014 19:43:43 +0100
Subject: Generic communication of boot loader state to the OS
In-Reply-To: <CAKON4OyENsHnPc528zLnimVY-B2x6-gdBQ6iyYHO60PgHdnvWg@mail.gmail.com>
References: <CAKON4Oz-PRgXyNKj=T9ymzOOhCMPjBMdYdE1Mr1CHWv3boskiw@mail.gmail.com>
 <20140826171658.GJ4078@leverpostej>
 <CAKON4OyENsHnPc528zLnimVY-B2x6-gdBQ6iyYHO60PgHdnvWg@mail.gmail.com>
Message-ID: <20140826184343.GM4078@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 07:31:09PM +0100, jonsmirl at gmail.com wrote:
> On Tue, Aug 26, 2014 at 1:16 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi Jon,
> >
> > On Tue, Aug 26, 2014 at 05:10:00PM +0100, jonsmirl at gmail.com wrote:
> >> New thread split off from the simple-framebuffer discussion....
> >>
> >> Is there a generic, underlying problem here that needs to be solved?
> >> AFAIK no one has designed a general purpose mechanism for
> >> communicating boot loader state to the OS. There is the existing
> >> device tree <chosen> node but it is limited compared to what is
> >> needed. Maybe we should step back and first design a good solution to
> >> this basic problem. Then specific solutions for things like
> >> framebuffers would fall out of the basic design.
> >
> > I think the fundamental problem here is unfortunately far too abstract
> > for the general solution to be any more concrete. The solution to "we
> > don't communicate boot state" is "we should communicate boot state".
> >
> > We can perhaps come up with general guidelines (for instance, the clock
> > subsystem has assigned-* properties), but I don't think there's a
> > one-size-fits-all solution.
> 
> I think it worth taking some time to consider if a one-size-fits-all
> solution exists for the general issues of communicating between the
> boot loader and the OS. Things are a lot better now, but I can
> remember have 20K byte long kernel command lines in the past.  Some
> random thoughts...

As I mentioned, I think we can set general guidelines. Some information
is just going to be device-specific, so enforcing a particular format
for everything is going to get in the way. There's no reason there can't
be common conventions, however.

> Do we even need a kernel command line any more?

I quite like being able to override options for test purposes, but we
don't necessarily have to require a non-empty command line.

> Could EARLY_PRINTK be made automatic with cooperation from the bootloader?

I believe Rob Herring's earlycon patches can set up an earlycon based on
stdout-path.

> Can we make it all the way from the boot loader to the GUI without
> having the display flash from mode setting?

If we communicate the display mode and the configuration of the clocks,
regulators, and memory allocations, probably. We already have the basic
bindings for all of these, so I think the bulk of the work would be
convincing the subsystems to do interact in the right way.

> Can I not auto-negotiate network links speed twice (a slow process)?

Perhaps. It depends on what information your particular network
controller setup needs to pass along (perhaps nothing whatsoever).

> Can 23 years of different solutions be collapsed into a general framework?

I think the only common thing here is that something in a subsystem
needs to parse the DT early and act on it. We already have initcalls.

Thanks,
Mark.
