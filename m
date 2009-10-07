From: greg@kroah.com (Greg KH)
Date: Wed, 7 Oct 2009 08:25:52 -0700
Subject: Kernel update to 2.6.31.1 on pxa270: udev and usb storage
	cause kernel Oops
In-Reply-To: <20091007145000.GC26894@kroah.com>
References: <1254213562.5586.13.camel@wks02-lin.nanotronic.local>
	<20091003124832.GA15525@n2100.arm.linux.org.uk>
	<20091005225222.GB792@kroah.com>
	<1254915955.26123.7.camel@wks02-lin.nanotronic.local>
	<20091007145000.GC26894@kroah.com>
Message-ID: <20091007152552.GB27394@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2009 at 07:50:00AM -0700, Greg KH wrote:
> On Wed, Oct 07, 2009 at 01:45:55PM +0200, hoefle marco wrote:
> > On Mon, 2009-10-05 at 15:52 -0700, Greg KH wrote:
> > > On Sat, Oct 03, 2009 at 01:48:32PM +0100, Russell King - ARM Linux wrote:
> > > > I think you need to report this to the USB/udev people.
> > > > 
> > > > On Tue, Sep 29, 2009 at 10:39:22AM +0200, hoefle marco wrote:
> > > > > Hello,
> > > > > we use Kernel 2.6.30.4 on a PXA270 platform (from Phytec). It works good
> > > > > with all peripherals on the Phytec board. 
> > > > > For an old Sandisk device (diskonchip) we have a driver ported to 2.6.3x
> > > > > as the block device driver API has changed. We thought it will be a wise
> > > > > decision to do the porting already to 2.6.3x. 
> > > > > However, when using the latest Kernel (and the previous one 2.6.30) with
> > > > > all the drivers we used in 2.6.30.4 udev and usb storage seem not to
> > > > > work any more.
> > > > > Does anybody have an idea why?
> > 
> > It looks that more things which worked with 2.6.30.4 do not work with
> > the latest stable 2.6.31.2 kernel. I get also a Kernel oops when
> > rebooting the system.
> > 
> > What I did to get there:
> > I disabled udevd and made the important device nodes static. This
> > allowed to boot into the system. I also disabled unnecessary things like
> > USB support and the tffs disk-on-chip driver.
> > Starting udevd manually does cause the same kernel oops as described at
> > the beginning of this thread.
> > 
> > In addition I get that oops when rebooting the system:
> > 
> > / # reboot
> > The system is going down NOW!
> > Sending SIGTERM to all processes
> > Sending SIGKILL to all processes
> > Requesting system reboot
> > Unable to handle kernel paging request at virtual address 20726590
> > pgd = c39a0000
> > [20726590] *pgd=00000000
> > Internal error: Oops: f5 [#2]
> > Modules linked in:
> > CPU: 0    Tainted: G      D     (2.6.31.2 #3)
> > PC is at device_shutdown+0x34/0xbc
> 
> I think something else is going on here that is a problem.
> 
> Can you turn on debugging for the driver core (CONFIG_DEBUG_DRIVER) and
> let us see the kernel log?  I'm guessing that you have a driver that
> doesn't like some of the driver core changes that went into 2.6.31.

See my response to you on the linux-hotplug list for a number of bugs I
just found in the driver code you posted.  In short, it's your code, not
the kernel :)

thanks,

greg k-h
