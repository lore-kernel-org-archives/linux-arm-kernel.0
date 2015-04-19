From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 19 Apr 2015 09:00:49 +0200
Subject: [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <20150418205019.GL12732@n2100.arm.linux.org.uk>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
 <20150418085712.GB29858@kroah.com>
 <20150418090420.GG12732@n2100.arm.linux.org.uk>
 <20150418184713.GA30508@kroah.com>
 <20150418190224.GK12732@n2100.arm.linux.org.uk>
 <20150418203716.GC1347@kroah.com>
 <20150418205019.GL12732@n2100.arm.linux.org.uk>
Message-ID: <20150419070049.GA2391@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 18, 2015 at 09:50:19PM +0100, Russell King - ARM Linux wrote:
> On Sat, Apr 18, 2015 at 10:37:16PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Apr 18, 2015 at 08:02:24PM +0100, Russell King - ARM Linux wrote:
> > > On Sat, Apr 18, 2015 at 08:47:13PM +0200, Greg Kroah-Hartman wrote:
> > > > On Sat, Apr 18, 2015 at 10:04:20AM +0100, Russell King - ARM Linux wrote:
> > > > > On Sat, Apr 18, 2015 at 10:57:12AM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Fri, Apr 17, 2015 at 09:50:56AM +0200, Jens Wiklander wrote:
> > > > > > > +struct tee_device {
> > > > > > > +	char name[TEE_MAX_DEV_NAME_LEN];
> > > > > > > +	const struct tee_desc *desc;
> > > > > > > +	struct device *dev;
> > > > > > 
> > > > > > No, please embed the device in your structure, don't have a pointer to
> > > > > > it.
> > > > > 
> > > > > Greg, "dev" here is not a locally allocated device, but the parent device.
> > > > > It's actually the same as struct tee_device.miscdev.parent, which could be
> > > > > used instead and this member deleted.
> > > > 
> > > > A miscdev doesn't need to have a "parent", it's just there to provide a
> > > > character device node to userspace, not to represent a "device that you
> > > > can do things with in the heirachy".
> > > > 
> > > > If you really want that, then use a real 'struct device' as should be
> > > > done here.  Have just a pointer to a misc device, that is meant to be
> > > > dynamic.
> > > 
> > > Let's rewind.
> > > 
> > > You are saying that "struct device *dev;" should be "struct device dev;"
> > 
> > Yes.
> > 
> > > I'm saying that you are mis-interpreting in your review what _that_ is.
> > 
> > Probably, I really have no idea what it is anymore.  What it _should_ be
> > is the thing that controls the lifecycle of the structure.  Do not use a
> > miscdevice for that, it will not work, as the TPM developers found out
> > the hard way.
> 
> I _really_ don't understand what you're going on about.
> 
> The "struct device *dev" is a pointer to the struct device corresponding
> to the _device_ which is being probed and the tee device is being
> registered for - in the case of the submitted code, that is the
> struct device embedded in the platform device.
> 
> This is a /really/ standard thing to do in drivers - saving a pointer
> to the struct device which the driver is responsible for.

Yes, but this structure says it is a "tee_device", and as such, should
be a real device, not just an internal structure that is never exposed
to userspace, right?

> So why should this pointer become a struct device itself?

Because it is a device.  It should be a child of the platform device.

Unless it's just a "normal" device, then platform device shouldn't be
used here :)

> Greg, I think you have performed a disservice by poorly reviewing the
> driver, and giving _incorrect_ comments.  Please can you have another
> look at both patches together and provide a better review.  Thanks.

I think the comment about how the model is all messed up as it looks
like the TPM original code is correct.

> Second point _against_ embedding a struct device here - a struct device
> is exposed to userspace.  Why expose this to userspace - we have other
> ways to manage the lifetime of data structures, such as krefs, which
> are not exposed to userspace.  What's wrong with using a kref to
> control the lifetime of this structure?

It's a device, why wouldn't it be exposed to userspace.

If this isn't a device, then yes, it doesn't need to be.  But then don't
call it a "tee_device" :)

thanks,

greg k-h
