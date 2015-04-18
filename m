From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 18 Apr 2015 22:37:16 +0200
Subject: [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <20150418190224.GK12732@n2100.arm.linux.org.uk>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
 <20150418085712.GB29858@kroah.com>
 <20150418090420.GG12732@n2100.arm.linux.org.uk>
 <20150418184713.GA30508@kroah.com>
 <20150418190224.GK12732@n2100.arm.linux.org.uk>
Message-ID: <20150418203716.GC1347@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 18, 2015 at 08:02:24PM +0100, Russell King - ARM Linux wrote:
> On Sat, Apr 18, 2015 at 08:47:13PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Apr 18, 2015 at 10:04:20AM +0100, Russell King - ARM Linux wrote:
> > > On Sat, Apr 18, 2015 at 10:57:12AM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, Apr 17, 2015 at 09:50:56AM +0200, Jens Wiklander wrote:
> > > > > +struct tee_device {
> > > > > +	char name[TEE_MAX_DEV_NAME_LEN];
> > > > > +	const struct tee_desc *desc;
> > > > > +	struct device *dev;
> > > > 
> > > > No, please embed the device in your structure, don't have a pointer to
> > > > it.
> > > 
> > > Greg, "dev" here is not a locally allocated device, but the parent device.
> > > It's actually the same as struct tee_device.miscdev.parent, which could be
> > > used instead and this member deleted.
> > 
> > A miscdev doesn't need to have a "parent", it's just there to provide a
> > character device node to userspace, not to represent a "device that you
> > can do things with in the heirachy".
> > 
> > If you really want that, then use a real 'struct device' as should be
> > done here.  Have just a pointer to a misc device, that is meant to be
> > dynamic.
> 
> Let's rewind.
> 
> You are saying that "struct device *dev;" should be "struct device dev;"

Yes.

> I'm saying that you are mis-interpreting in your review what _that_ is.

Probably, I really have no idea what it is anymore.  What it _should_ be
is the thing that controls the lifecycle of the structure.  Do not use a
miscdevice for that, it will not work, as the TPM developers found out
the hard way.

thanks,

greg k-h
