From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Apr 2015 22:57:55 +0100
Subject: [tpmdd-devel] [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <20150418172923.GA10605@obsidianresearch.com>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
 <20150417163054.GA28241@obsidianresearch.com>
 <20150418090147.GF12732@n2100.arm.linux.org.uk>
 <20150418172923.GA10605@obsidianresearch.com>
Message-ID: <20150418215755.GM12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 18, 2015 at 11:29:23AM -0600, Jason Gunthorpe wrote:
> On Sat, Apr 18, 2015 at 10:01:47AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Apr 17, 2015 at 10:30:54AM -0600, Jason Gunthorpe wrote:
> > > On Fri, Apr 17, 2015 at 09:50:56AM +0200, Jens Wiklander wrote:
> > > > +	teedev = devm_kzalloc(dev, sizeof(*teedev), GFP_KERNEL);
> > > [..]
> > > > +	rc = misc_register(&teedev->miscdev);
> > > [..]
> > > > +void tee_unregister(struct tee_device *teedev)
> > > > +{
> > > [..]
> > > > +	misc_deregister(&teedev->miscdev);
> > > > +}
> > > [..]
> > > >+static int optee_remove(struct platform_device *pdev)
> > > >+{
> > > >+       tee_unregister(optee->teedev);
> > > 
> > > Isn't that a potential use after free? AFAIK misc_deregister does not
> > > guarentee the miscdev will no longer be accessed after it returns, and
> > > the devm will free it after optee_remove returns.
> > > 
> > > Memory backing a stuct device needs to be freed via the release
> > > function.
> > 
> > Out of interest, which struct device are you talking about here?
> 
> Sorry, I was imprecise. In the first paragraph I ment 'miscdev' to
> refer to the entire thing, struct tee_device, struct misc_device, the
> driver allocations, etc.
> 
> So, the first issue is the use-after-free via ioctl() touching struct
> tee_device that you described.
> 
> But then we trundle down to:
> 
> + ctx->teedev->desc->ops->get_version(ctx, &vers.spec_version,
> +   vers.uuid);
> 
> If we kref teedev so it is valid then calling a driver call back after
> (or during) it's remove function is very likely to blow up.

Why?

Normally, the file_operations will be associated with the module which,
in this case, called misc_register() - the same module which contains
the remove function.

So, the text for the remove function will still be available.  The data
for the remove function will also be available, because we haven't
kref_put()'d the last reference yet.

So, where's the problem?

> Also, in TPM we discovered that adding a sysfs file was very ugly
> (impossible?) because without the misc_mtx protection that open has,
> getting a locked tee_device in the sysfs callback is difficult.

Right - the problem here is that a sysfs file attached to the class
device inside miscdev could be open at the point we want to free the
tee structures - and the lifetime of the miscdev class device is
unrelated to the lifetime of the tee structure.

For a device attribute attached to that class device, the lifetime
of the class device will be controlled by the sysfs file being open.

The problem comes when you want to try to get at some private data
(in this case, the tee private data) from that class device.  The class
device has no driver data set.  So, people may be tempted to use
dev->parent to grab the parent device's private data - and that's
dangerous, because after device_destroy() in misc_deregister(),
nothing guarantees that the class device's parent pointer remains
valid.

So, attaching attributes to the class device is _really_ a no-go.
The attributes should be attached to the parent device - the device
which is actually being driven.

The second option is to attach them to the struct device for the
device being driven.  That has all the standard rules which come
from drivers attaching attributes to the struct device for which
they're driving, so that should be nothing new to anyone.

If that's hard to get right, then we have an error in the design of
the driver model - such stuff should be _easy_ to get right.  For
example, the driver model should guarantee that when a driver
attribute is removed from a struct device, its method won't be
called any further (if it doesn't do this, I suspect we have a fair
number of buggy drivers...)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
