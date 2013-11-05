From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 5 Nov 2013 12:12:30 -0700
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <201311051948.11992.arnd@arndb.de>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <201311050939.21071.arnd@arndb.de>
 <20131105180314.GB14706@obsidianresearch.com>
 <201311051948.11992.arnd@arndb.de>
Message-ID: <20131105191230.GA20600@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 07:48:11PM +0100, Arnd Bergmann wrote:
> On Tuesday 05 November 2013, Jason Gunthorpe wrote:
> > I've been brewing a patch set to fix TPM, but it is a large effort. I
> > would think other legacy subsystems that are not fully class device
> > enabled will have similar challenges?
> 
> I think a common pattern is to have the subsystem data be referenced from
> the driver data using a pointer, and contain a back reference to the struct
> device, which should not be a problem.

The issue is sysfs, the TPM core attaches attributes to the driver's
struct device, which means it has to convert from struct device * to
its own private data. It is totally wrong, but that is the way
it has been for ever. :(

> Yes, that would work, but it would prevent another idea I had that I
> haven't mentioned here: If we add a pointer to the 'struct
> devm_probe' array to

Seems quiet reasonable, but having two entry points just means drivers
that need to use the 2nd can't use the pointer in struct devm_probe.

The other thing that occured to me is your method could reduce the
devm overhead. If you keep a pointer to the probe list and to the
private data structure then you can unwide all the allocations just by
running backwards along the probe list. You don't need to do any
per-resource devm allocations..

> which would fit in nicely with the rest of the design, but now I'm no longer
> sure if that would actually work with the lifetime rules of the netdev, which
> would pin the refcount on the 'struct device', which in turn could prevent
> the devres cleanup to be executed.

I looked into this question recently, while trying to fixup TPM..

I concluded that devm doesn't actually really follow the refcount on
struct device. devm cleanup is called unconditionally after remove()
is called, and remove is called unconditionally when the device_driver
is deleted, which is called unconditionally on module unload.

So anything that used to be in the remove() function can be safely
moved into devm, including netdev deallocation. This makes sense,
considering what devm is for..

This process is separate from the refcount driven release, which
happens once all krefs to the struct device are dropped (eg, sysfs
open files, open char devices, etc)

Which creates the nasty bit, a sysfs callback/etc can be run even
after the device release function has finished and after the private
data has been deleted..

At least, that is where my search ended up, would appreciate it if
anyone knows different :)

Regards,
Jason
