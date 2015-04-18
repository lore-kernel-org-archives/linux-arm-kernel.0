From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Apr 2015 10:01:47 +0100
Subject: [tpmdd-devel] [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <20150417163054.GA28241@obsidianresearch.com>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
 <20150417163054.GA28241@obsidianresearch.com>
Message-ID: <20150418090147.GF12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 17, 2015 at 10:30:54AM -0600, Jason Gunthorpe wrote:
> On Fri, Apr 17, 2015 at 09:50:56AM +0200, Jens Wiklander wrote:
> > +	teedev = devm_kzalloc(dev, sizeof(*teedev), GFP_KERNEL);
> [..]
> > +	rc = misc_register(&teedev->miscdev);
> [..]
> > +void tee_unregister(struct tee_device *teedev)
> > +{
> [..]
> > +	misc_deregister(&teedev->miscdev);
> > +}
> [..]
> >+static int optee_remove(struct platform_device *pdev)
> >+{
> >+       tee_unregister(optee->teedev);
> 
> Isn't that a potential use after free? AFAIK misc_deregister does not
> guarentee the miscdev will no longer be accessed after it returns, and
> the devm will free it after optee_remove returns.
> 
> Memory backing a stuct device needs to be freed via the release
> function.

Out of interest, which struct device are you talking about here?

struct tee_device contains two things - a struct device _pointer_ to the
device passed into the registration function, and a miscdev.

A miscdev contains two struct device _pointers_ - a pointer to the parent
device, and a pointer to the char class device.  As both of these are
pointers, freeing struct tee_device does not free the memory underlying
any device structure.

What does need to be taken care of is that unbinding the parent device
may cause an already-open user of the userspace interface to dereference
the memory which was freed.  Tying this to the lifetime of a struct
device doesn't seem right.

I would suggest adding a kref to struct tee_device and use that to manage
the lifetime of that structure - incrementing the refcount on fops->open
and dropping it at fops->release time, so that the struct is automatically
freed when the last user closes the miscdev after the device has been
unbound.  You should probably also have a flag to indicate that the device
is no longer present too to prevent further userspace IO.

It would be nice if miscdev provided help with this...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
