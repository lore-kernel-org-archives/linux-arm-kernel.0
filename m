From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Sun, 19 Apr 2015 23:08:00 -0600
Subject: [tpmdd-devel] [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <20150418215755.GM12732@n2100.arm.linux.org.uk>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
 <20150417163054.GA28241@obsidianresearch.com>
 <20150418090147.GF12732@n2100.arm.linux.org.uk>
 <20150418172923.GA10605@obsidianresearch.com>
 <20150418215755.GM12732@n2100.arm.linux.org.uk>
Message-ID: <20150420050800.GA12928@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 18, 2015 at 10:57:55PM +0100, Russell King - ARM Linux wrote:

> > But then we trundle down to:
> > 
> > + ctx->teedev->desc->ops->get_version(ctx, &vers.spec_version,
> > +   vers.uuid);
> > 
> > If we kref teedev so it is valid then calling a driver call back after
> > (or during) it's remove function is very likely to blow up.
> 
> Why?
> 
> Normally, the file_operations will be associated with the module which,
> in this case, called misc_register() - the same module which contains
> the remove function.

As I read it, tee is similar to TPM and RTC, this code is the mid
layer code, and resides in it's own module while the function pointers
in 'ops' reside in the actual driver. So there are two modules.

There is some mucking in tee to keep the driver module around, it is
probably OK for the chardev, but again, sysfs, probably not. Absent
that code I think the module ops points to could be unloaded and the
.text backing the ops function can go away.

However, I was worrying about the driver itself - what is a driver to
do if a callback is called after tee_unregister is called? It must do
nothing and return error. Drawing from TPM, most drivers did not have
this check, so they blow up. Ie devm frees all their resources after
tee_unregister returns and they quickly deref null, or sleep on
disabled IRQ or timer, or something else fatal.

It seems like a good idea to have the midlayer guarentee the driver
ops cannot be called after the midlayer unregister function returns so
that drivers can operate in a simple environment. Nulling ops also
avoids caring about the driver's module ref count.

> > Also, in TPM we discovered that adding a sysfs file was very ugly
> > (impossible?) because without the misc_mtx protection that open has,
> > getting a locked tee_device in the sysfs callback is difficult.

> So, attaching attributes to the class device is _really_ a no-go.
> The attributes should be attached to the parent device - the device
> which is actually being driven.

But common midlayer convention is to put them in the same directory as
the 'dev', ie:

/sys/devices/pnp0/00:06/rtc/rtc0/dev
/sys/devices/pnp0/00:06/rtc/rtc0/max_user_freq

Which, I think, is misc->this_device

> attribute is removed from a struct device, its method won't be
> called any further (if it doesn't do this, I suspect we have a fair
> number of buggy drivers...)

Hmm, I went and looked again, and it seems kernfs_drain is part of a
mechanism that causes kernfs_remove to wait until all opens are
closed, so it sure looks like a sysfs callback cannot be called after
it is removed.

Years ago lwn documented that this wasn't true,
https://lwn.net/Articles/54651/, it is nice to see that has changed.

I still suspect the expected way to write a new mid layer is to create
your own struct device and not rely on misc_device, but use-after-free
races from sysfs doesn't seem to be a motivating reason...

Jason
