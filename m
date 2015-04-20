From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Mon, 20 Apr 2015 15:02:03 +0200
Subject: [tpmdd-devel] [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <20150418172923.GA10605@obsidianresearch.com>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
 <20150417163054.GA28241@obsidianresearch.com>
 <20150418090147.GF12732@n2100.arm.linux.org.uk>
 <20150418172923.GA10605@obsidianresearch.com>
Message-ID: <20150420130203.GB25054@ermac>
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
> 
> Also, in TPM we discovered that adding a sysfs file was very ugly
> (impossible?) because without the misc_mtx protection that open has,
> getting a locked tee_device in the sysfs callback is difficult.
> 
> With TPM, we ended up trying lots of options for fixing struct
> misc_device in the tpm core, which is handling multiple sub drivers,
> and basically gave up. Gave each struct tpm_device an embedded struct
> device like Greg suggested here. Then the tpm core is working with the
> APIs, not struggling against them.
> 
> But this is not a user-space invisible change, so better to do it right
> from day 1 ..
> 
> We followed rtc as an example of how to create a mid-layer that
> exports it's own register function, with char dev and sysfs
> components. It seems properly implemented, and has elegant solutions
> to these problems (like ops):
>  - Don't mess with modules, use 'ops' and set 'ops' to null when the
>    driver removes. The driver core will keep the driver module around
>    for you bettwen the probe/remove calls. Setting ops = NULL ensures driver
>    module code cannot be called after remove.
>  - Use locking for 'ops' to serialize driver callbacks with driver removal
>  - Embed a struct device/etc in the struct tee_device and use the release
>    function to deallocate struct tee_device. All callbacks from the
>    driver/char/sysfs core can now use container_of on something that
>    is already holds the right kref.
>  - Consider an alloc/register pattern as we use now in TPM. This has proven
>    smart for TPM as it allows:
>        alloc tee_device + init struct device, etc
>        driver setup
>        core library helper calls for setup/etc
>        driver register + char dev publish
> 
> It appeared to me this driver was copying TPM's old architecture,
> which is very much known to be broken.

The struct tee_device holds a shared memory pool from which shared
memory objects are allocated. These shared memory objects can be mapped
both by user space and secure world. When a shared memory object is
freed secure world may need to be notified, OP-TEE doesn't need that but
other TEEs may need it. To come around the problem with what should
happen when the driver is removed I'm increasing the refcount on the
driver for each allocated shared memory object and created file
pointers. As long as any resource is in use by either user space or
secure world the driver can't be unloaded.

What should happen when user space or secure world has some shared
memory which the driver owns (either allocated from CMA or from some
memory range received from the TEE)? Killing the user space process
would be a bit unfriendly. Secure world may not be prepared to release
that memory right now either.

What if I:
* Keep all the reference counting I have today on the module
  to make sure that the module can't be unloaded until all shared memory
  resources are release
* Change to use the pattern (with a struct device etc) as described above.
  I can't protect the ops with just a mutex since tee_ioctl_cmd() needs to
  be multithreaded. I need some reference counting too,
  try_module_get()/module_put() does exactly what I need here.

Is that pattern OK?

Regards,
Jens
