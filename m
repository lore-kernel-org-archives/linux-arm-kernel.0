From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Aug 2013 01:49:12 -0700
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130731201457.GA24642@n2100.arm.linux.org.uk>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1999586.84BnWE5EUh@thinkpad> <20130731191209.GA8027@netboy>
 <1409617.9untvfnOTJ@flatron> <20130731200017.GC8027@netboy>
 <20130731201457.GA24642@n2100.arm.linux.org.uk>
Message-ID: <20130802084912.GE7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130731 13:22]:
> On Wed, Jul 31, 2013 at 10:00:17PM +0200, Richard Cochran wrote:
> > On Wed, Jul 31, 2013 at 09:29:35PM +0200, Tomasz Figa wrote:
> > > 
> > > I showed you two example solutions that could handle this use case without 
> > > stable binding ABI, just to prove that b) is not the only option (even if 
> > > it's the best one, which I continue to agree on, don't get me wrong).
> > 
> > You only showed *one* solution (b) that satisfies the use case. The
> > use case was:
> > 
> >    User acquires a machine running ARM Linux version 3.x, with u-boot
> >    and dtb in a read only flash partition. The board boots and works just
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^
> >    fine. However, for his application, the user requires a new kernel
> >    feature that appeared in version 3.y where y > x. He compiles the new
> >    kernel, and it also works.
> > 
> > But you suggested:
> > 
> >  a) using DT as direct replacement for board files - this means that you
> >     are free to say that DTSes are strictly coupled with kernel version
> >     and you are free to modify the bindings - see the analogy to board
> >     files, where you could modify the platform data structures and could
> >     not directly copy board file from one kernel version to another,
> > 
> > In the use case, the kernel is upgraded, but not the DTB. So this
> > solution makes no sense.
> 
> That's also crap for another reason.  DT on the whole is _supposed_ to
> describe what the hardware is, and how it is wired up in a WELL DEFINED
> and STABLE manner.  Unfortunately, there's a *BIG* mistake that was made
> - having this /chosen node in DT which gets used for "software"
> configuration - eg, the command line and so forth.
> 
> That was a mistake because it means that the DT isn't purely a
> description of the hardware.  Such stuff should have been left in ATAGs,
> and DT should have been placed into its own ATAG entry.  There would
> not have been any conflict between ATAGs and DT, because ATAGs generally
> don't deal with hardware configuration - the only real bit of hardware
> configuration conveyed via ATAGs is the location of memory and size of
> memory.

This I completely agree with. And I'd go a bit further requiring the DT
binding should describe the _types_ of registers the hardware has so the
device driver does not have to contain data for each similar supported
register instances for things like clocks and muxes and timers.

In the worst case, platform_data is just being replaced by device tree
and driver hacks in a confusing way that requires constant updating of
both the .dts files and the device driver.

Regards,

Tony
