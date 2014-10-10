From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Oct 2014 09:36:27 +0100
Subject: [RFC] drop owner assignment from platform_drivers
In-Reply-To: <20141010072439.GA1741@katana>
References: <20141010072439.GA1741@katana>
Message-ID: <20141010083627.GL5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 09:24:39AM +0200, Wolfram Sang wrote:
> people found out that for platform_driver, we don't need to set the
> .owner field because this is done by the platform driver core. So far,
> so good. However, now I got patches removing the .owner field for this
> single i2c driver or for that one. To prevent getting thousands of
> patches fixing single drivers, I used coccinelle to remove all instances
> from the kernel. The SmPL looks like this, it doesn't blindly remove all
> THIS_MODULE, but checks if the platform_driver struct was really used by
> a call actually setting the .owner field:

Is this correct?

#define platform_driver_register(drv) \
        __platform_driver_register(drv, THIS_MODULE)
extern int __platform_driver_register(struct platform_driver *,
                                        struct module *);

Fine for those which use platform_driver_register(), but:

/* non-hotpluggable platform devices may use this so that probe() and
 * its support may live in __init sections, conserving runtime memory.
 */
extern int platform_driver_probe(struct platform_driver *driver,
                int (*probe)(struct platform_device *));

platform_driver_probe() doesn't seem to know which module called it.
This is also true of platform_create_bundle:

extern struct platform_device *platform_create_bundle(
        struct platform_driver *driver, int (*probe)(struct platform_device *),
        struct resource *res, unsigned int n_res,
        const void *data, size_t size);

So, it's not as trivial as just "all platform driver's should not have a
.owner field" - the real answer is far more complex than that.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
