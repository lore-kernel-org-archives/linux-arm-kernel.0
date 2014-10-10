From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 10 Oct 2014 20:26:05 +0200
Subject: [RFC] drop owner assignment from platform_drivers
In-Reply-To: <20141010083627.GL5182@n2100.arm.linux.org.uk>
References: <20141010072439.GA1741@katana>
 <20141010083627.GL5182@n2100.arm.linux.org.uk>
Message-ID: <20141010182604.GC6075@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 09:36:27AM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 10, 2014 at 09:24:39AM +0200, Wolfram Sang wrote:
> > people found out that for platform_driver, we don't need to set the
> > .owner field because this is done by the platform driver core. So far,
> > so good. However, now I got patches removing the .owner field for this
> > single i2c driver or for that one. To prevent getting thousands of
> > patches fixing single drivers, I used coccinelle to remove all instances
> > from the kernel. The SmPL looks like this, it doesn't blindly remove all
> > THIS_MODULE, but checks if the platform_driver struct was really used by
> > a call actually setting the .owner field:
> 
> Is this correct?
> 
> #define platform_driver_register(drv) \
>         __platform_driver_register(drv, THIS_MODULE)
> extern int __platform_driver_register(struct platform_driver *,
>                                         struct module *);
> 
> Fine for those which use platform_driver_register(), but:
> 
> /* non-hotpluggable platform devices may use this so that probe() and
>  * its support may live in __init sections, conserving runtime memory.
>  */
> extern int platform_driver_probe(struct platform_driver *driver,
>                 int (*probe)(struct platform_device *));
> 
> platform_driver_probe() doesn't seem to know which module called it.
> This is also true of platform_create_bundle:
> 
> extern struct platform_device *platform_create_bundle(
>         struct platform_driver *driver, int (*probe)(struct platform_device *),
>         struct resource *res, unsigned int n_res,
>         const void *data, size_t size);
> 
> So, it's not as trivial as just "all platform driver's should not have a
> .owner field" - the real answer is far more complex than that.

platform_create_bundle() calls platform_driver_probe().
platform_driver_probe() calls platform_driver_register().
platform_driver_register() modifies driver.owner.

So, it is correct from the point of view that it doesn't make sense to
set the .owner field if it gets overwritten anyhow.

You got me wondering, though, that it could not be correct to call
platform_driver_register() from the platform core instead of module
init. I will check tomorrow. Still, this would be a bug independent of
my series. Although I'd need to respin it if platform_driver_probe()
needed a fix.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/e24feddd/attachment-0001.sig>
