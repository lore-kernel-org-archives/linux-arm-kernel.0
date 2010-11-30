From: greg@kroah.com (Greg KH)
Date: Tue, 30 Nov 2010 15:05:33 -0800
Subject: [PATCH 09/10] MCDE: Add build files and bus
In-Reply-To: <20101130220550.GD8521@n2100.arm.linux.org.uk>
References: <F45880696056844FA6A73F415B568C6953604E802E@EXDCVYMBSTM006.EQ1STM.local>
	<201011261224.59490.arnd@arndb.de>
	<AANLkTinCYdb8p4-H+Aki-z+i7ZL2ETwGJdDxOQ4XpBJ+@mail.gmail.com>
	<201011301621.48140.arnd@arndb.de>
	<20101130184049.GC8521@n2100.arm.linux.org.uk>
	<20101130184834.GA16055@kroah.com>
	<20101130220550.GD8521@n2100.arm.linux.org.uk>
Message-ID: <20101130230533.GA11342@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 10:05:50PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 30, 2010 at 10:48:34AM -0800, Greg KH wrote:
> > On Tue, Nov 30, 2010 at 06:40:49PM +0000, Russell King - ARM Linux wrote:
> > > There's lots of static devices, not only platform devices, in the ARM
> > > tree.  It's going to be a hell of a lot of work to fix this all up
> > > properly.
> > 
> > I agree, it's been abused for many years this way :(
> 
> I don't agree that it is abuse - it was something explicitly allowed by
> the original device model design by Patrick, with the condition that
> such a device was never unregistered.  That's exactly the way we treat
> these devices.

I understand Pat allowed this, I just don't agree that it's the correct
thing to do :)

-mm had a patch for a long time that would throw up warnings if you ever
did this for x86 so that arch should be clean of this issue by now.

> What I'm slightly concerned about is that this is going to needlessly
> bloat the kernel - we're going to have to find some other way to store
> this information, and create devices from that - which means additional
> code to do the creation, and data structures for it to create these from.
> There will be additional wastage from kmalloc as kmalloc doesn't allocate
> just the size you ask for, but normally a power of two which will contain
> the size.
> 
> That could potentially mean that as the device structure is 216 bytes,
> kmalloc will use the 256 byte allocation size, which means a wastage of
> 40 bytes per device structure.  On top of that goes the size of
> resources with the allocation slop on top for that, and then there's
> another allocation for the platform data.
> 
> Has anyone considered these implications before making this choice?

Yes, I have, which is one reason I haven't done this type of change yet.
I need to figure out a way to not drasticly increase the size and still
make it easy and simple for the platform and driver write their code.

It's a work in progress, but wherever possible, I encourage people to
not make 'struct device' static.

thanks,

greg k-h
