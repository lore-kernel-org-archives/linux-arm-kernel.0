From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 18 Oct 2012 09:34:15 -0700
Subject: [RFC/NOT FOR MERGING 1/5] arm: omap: fix up _od_suspend_noirq and
 _od_resume_noirq
In-Reply-To: <1350488043-5053-2-git-send-email-balbi@ti.com> (Felipe Balbi's
 message of "Wed, 17 Oct 2012 18:33:59 +0300")
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-2-git-send-email-balbi@ti.com>
Message-ID: <871ugvivso.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> current implementation doesn't take care about
> drivers which don't provide *_noirq methods 

The generic ops handle this.  See below.

> and we could fall into a situation where we would suspend/resume
> devices even though they haven't asked for it.

The following explanation doesn't explain this, so I dont' follow
the "even though they haven't asked for it" part.

> One such case happened with the I2C driver which
> was getting suspended during suspend_noirq() just
> to be resume right after by any other device doing
> an I2C transfer on its suspend method.

In order to be I2C to be runtime resumed after its noirq method has been
called, that means the other device is doing an I2C xfer in its noirq
method.  That is a bug.

> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/plat-omap/omap_device.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 7a7d1f2..935f416 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -804,8 +804,12 @@ static int _od_suspend_noirq(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct omap_device *od = to_omap_device(pdev);
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  	int ret;
>  
> +	if (!pm || !pm->suspend_noirq)
> +		return 0;
> +

you just re implemented pm_generic_suspend_noirq() (c.f. drivers/base/power/generic_ops.c)

>  	/* Don't attempt late suspend on a driver that is not bound */
>  	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER)
>  		return 0;
> @@ -827,6 +831,10 @@ static int _od_resume_noirq(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct omap_device *od = to_omap_device(pdev);
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (!pm || !pm->resume_noirq)
> +		return 0;

and this is basically pm_generic_resume_noirq()

>  
>  	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
>  	    !pm_runtime_status_suspended(dev)) {

Kevin
