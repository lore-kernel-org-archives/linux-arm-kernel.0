From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 8 Mar 2013 10:29:50 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130308091052.18612729@skate>
References: <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
 <20130307222004.GA2450@localhost>
 <20130307230516.GA28975@obsidianresearch.com>
 <20130308091052.18612729@skate>
Message-ID: <20130308172950.GC4094@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 09:10:52AM +0100, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Thu, 7 Mar 2013 16:05:16 -0700, Jason Gunthorpe wrote:
> 
> > So what is the point of that? Get rid of your driver, have the mbus
> > driver set up its own windows and put cfi-flash directly under
> > mbus. Smaller, simpler, clearer, better.
> 
> No, we will still need the Device Bus driver to set up the timings.

I looked through Ezequiel's patch and saw a driver that provided those
properties and no user of them at all. Are the patches incomplete? Is
there some plan to use these values in the future?

> That's _your_ choice, and it's entirely inconsistent with most kernel
> practices. For example, we have the pinctrl subsystem, which
> precisely

Again, Ezequiel's patches do exactly the same thing.

pinctrl is a bit different, it depends on the PCB design which is
fixed. NAND/NOR timings depend on the flash chip in use, which can
vary from manufacturing run to manufacturing run.

> Sorry, but we _do_ want the kernel to be able to set those timings
> parameters, and therefore, a Device Bus driver will be needed,
> regardless of whether it creates the address window or not.

See the very good idea from Maxime Bizon about autoprobing the ONFI
timings directly from the NAND chip.

> > > In conclusion: there is absolutely no need to change the NOR driver,
> > > and there is no need to explictly add an explicit description of the
> > > NOR window in the device tree.
> > 
> > As I've said, a DT that has child nodes without an associated address
> > map is broken.
> 
> That's a statement without any arguments. How can we have a serious
> technical discussion if what you bring is just "this is broken", with no
> arguments?

I've brought many things up and you have ignored them all. Here is a
list of a few:
 - You can't actually do optmial dynamic allocation a device at a
   time, that will make holes in the address space due to the alignment
   constraints.
 - Having an invalid address map in DT breaks the naming of platform
   devices and breaks the collision avoidance mechanism in the OF core
 - Breaking the address map means any downstream driver that tries to
   use standard OF addressing functions on its of node gets broken.
 - Breaking the address map means the standard OF platform device
   creation functions don't work because they can't create the
   resource ranges from OF. This means things like standard Linux
   resource accounting is broken.
 - Adding bus specific boiler plate to drivers is not the Linux
   convention, the bus abstraction is ment to do that.
Arnd also mentioned:
 - Breaking the address map in DT breaks OS's without a mbus driver

What more do you want to hear?

Jason
