From: greg@kroah.com (Greg KH)
Date: Fri, 2 Aug 2013 05:04:19 +0800
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130801204506.GH23006@n2100.arm.linux.org.uk>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130801193936.GD23006@n2100.arm.linux.org.uk>
 <20130801201539.GA12291@kroah.com>
 <20130801201823.GF23006@n2100.arm.linux.org.uk>
 <20130801203631.GA12802@kroah.com>
 <20130801204506.GH23006@n2100.arm.linux.org.uk>
Message-ID: <20130801210419.GA13871@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 09:45:06PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 02, 2013 at 04:36:31AM +0800, Greg KH wrote:
> > On Thu, Aug 01, 2013 at 09:18:23PM +0100, Russell King - ARM Linux wrote:
> > > On Fri, Aug 02, 2013 at 04:15:39AM +0800, Greg KH wrote:
> > > > I'm not saying move away from DT at all, if it can be used to describe
> > > > stuff like this, wonderful.  Just please don't use platform_bus anymore
> > > > than you have to.
> > > 
> > > As far as that sentiment goes, it would have been nice if that was made
> > > more vocally ten years ago, because at that time I was the one trying to
> > > encourage people to think about creating appropriate bus types, and what
> > > I was being told was that no, bus types are something which are deprecated
> > > and platform bus is what should be used.
> > 
> > Was that me that said that?
> 
> I don't remember...
> 
> > I don't recall it at all, and if I did, I
> > was flat out wrong.  I've always said that platform_bus is a hack, and
> > should only be used as a "last resort".  Others have grabbed onto it as
> > the "only" way to do devices for embedded things because that is what
> > they were used to.
> 
> Well, I have three bus types to my name: the amba bus type, the ecard
> bus type, and the sa1111 companion chip bus type.
> 
> I've been under pressure a number of times to convert the amba_bus
> implementation to be a platform_bus, and of course I've refused to do
> that because I don't see that platform buses provide what's required
> there.  Not only that, but people keep using platform devices/driver
> when they create a new driver which should be using the amba bus stuff.

You are correct, you shouldn't be converting amba_bus, it is fine as-is.

> Unfortunately, the message that platform devices should be used is soo
> ingrained today that it's going to be really difficult to fight it
> without basically refusing everything that comes along.

So, what can I do to combat this?  I have no objection to refusing any
new stuff at all, we do it all the time quite successfully :)

> We also have the new problem (as of the adoption of DT on ARM) that it's
> also embedded into the DT representation now, because the platform bus
> is the "simple-bus" type in DT, and that's where everyone in ARM land
> is placing their on-SoC devices.  That happened because DT already had
> a way to create platform devices, and as they were already being used
> on ARM, it gave a way to have DT create the platform devices without
> any additional effort.
> 
> Yes, we can change the kernel code, but that now means that rather than
> just changing the entirety of ARM, there's also the impact on PowerPC
> to think about too with such a change.

Creating a "DT" bus would place us back at the same spot that the
platform_bus code has today.

And the thing is, DT, just like ACPI, doesn't want to be a bus either.
ACPI is having a bunch of rework done in its driver/bus representation
because of mistakes like this that were done in the past.

There is no reason that any devices represented by DT needs to be on the
platform_bus, just like ACPI, so the two should be totally separate.
It's just that new drivers/subsystems that are added, should NOT
abuse the platform_bus code, when they should be creating their own
busses.

> Or we have to rip up our existing DT files and start with a different
> approach...

No, not at all, this shouldn't be needed.

thanks,

greg k-h
