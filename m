From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 6 Aug 2015 19:21:41 -0700
Subject: [PATCH 0/2] drivers: PL061: Add platform driver probing support
In-Reply-To: <20150803190935.GL7557@n2100.arm.linux.org.uk>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
 <20150803075848.GH7557@n2100.arm.linux.org.uk>
 <55BF33AD.5040502@huawei.com>
 <20150803094923.GI7557@n2100.arm.linux.org.uk>
 <20150803162623.GB30867@kroah.com>
 <20150803190935.GL7557@n2100.arm.linux.org.uk>
Message-ID: <20150807022141.GD25067@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 08:09:35PM +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 03, 2015 at 09:26:23AM -0700, Greg Kroah-Hartman wrote:
> > On Mon, Aug 03, 2015 at 10:49:23AM +0100, Russell King - ARM Linux wrote:
> > > On Mon, Aug 03, 2015 at 05:26:05PM +0800, Shannon Zhao wrote:
> > > > Hi Russell,
> > > > 
> > > > On 2015/8/3 15:58, Russell King - ARM Linux wrote:
> > > > > On Mon, Aug 03, 2015 at 02:59:56PM +0800, Shannon Zhao wrote:
> > > > >> From: Shannon Zhao <shannon.zhao@linaro.org>
> > > > >>
> > > > >> According to ACPI SPEC, it supports ARM boards to use "GPIO-signaled
> > > > >> ACPI Events". These events can be used for input events. And to QEMU, it
> > > > >> uses GPIO PL061 controller for input events.
> > > > >>
> > > > >> These two patches add platform driver support for PL061 probed by DT or
> > > > >> ACPI.
> > > > > 
> > > > > This certainly is incorrect for DT, and is probably wrong for ACPI too.
> > > > > DT creates amba devices, so binds via the amba device driver.
> > > > > 
> > > > 
> > > > Oh, sorry. The changes for DT are not necessary. But for ACPI I think it
> > > > needs to convert pl061 to platform device since ACPI doesn't support
> > > > AMBA devices. The Pl011 also does the same thing to support ACPI
> > > > probing. See drivers/tty/serial/amba-pl011.c
> > > 
> > > Maybe rather than having every AMBA driver also converted to a platform
> > > driver (which GregKH hates) maybe ACPI should support the AMBA bus
> > > instead?
> > > 
> > > Greg?
> > 
> > The ACPI developers have been doing work to allow a driver to handle
> > getting the resources from either DT or ACPI no matter what bus it is
> > on, so converting anything to a platform driver shouldn't be needed.
> > 
> > but I don't really know the details here, and this isn't being sent to
> > the ACPI mailing list, so I don't know what to suggest...
> 
> Greg,
> 
> You're the one who's said many times that you'd like to see platform
> devices and platform device drivers to go away.

Yes, of course, I hate the things :)

> So, when I give you
> the opportunity to comment on platform devices being used to augment
> existing device drivers such as the AMBA bus drivers (which you've
> also previously said is a more preferable way to use the driver model)
> why not support that view?

Because I don't know the whole story here, sorry.

> Right now, there seems to be a move to convert _all_ AMBA device drivers
> to become dual-drivers: an amba bus driver and a platform driver.  Is
> that something you really want to see, irrespective of ACPI issues?

Ick, no, I don't think that's wise at all.  Why not just make the needed
resources availble to _all_ bus drivers, then it doesn't matter if it's
AMBA, or ACPI, or USB, or anything else?

I thought that is what some recent patches did to the acpi/of core, but
maybe I was mistaken.

thanks,

greg k-h
