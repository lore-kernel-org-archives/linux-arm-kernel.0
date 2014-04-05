From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 05 Apr 2014 20:31:15 +0200
Subject: [PATCH v2 1/7] drm/exynos: add super device support
In-Reply-To: <20140405182423.GL7528@n2100.arm.linux.org.uk>
References: <1396355882-17010-1-git-send-email-inki.dae@samsung.com>
 <1396355882-17010-2-git-send-email-inki.dae@samsung.com>
 <533EB9C6.80302@samsung.com>
 <CAAQKjZPbzb+qvJA5y+Kco9BRv4j3iVatM_0bd+ugyuVZUbfFFg@mail.gmail.com>
 <53403E42.1010403@gmail.com> <20140405182423.GL7528@n2100.arm.linux.org.uk>
Message-ID: <53404BF3.2010409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05.04.2014 20:24, Russell King - ARM Linux wrote:
> On Sat, Apr 05, 2014 at 07:32:50PM +0200, Tomasz Figa wrote:
>> Not exactly. The approach we found does mostly the same as componentized
>> subsystem framework but without _any_ extra data in Device Tree. Just
>> based on the list of subsystem sub-drivers that is already available to
>> the master driver.
>
> The existing approach is fundamentally broken.  Yes, your solution may
> work for the probing case, but have you tried unbinding any of your
> sub-drivers?
>
>  From what I can see, that causes a kernel oops for one very simple reason -
> you destroy stuff while it's still in use.  Let's look at an example:
>
> struct platform_driver ipp_driver = {
>          .probe          = ipp_probe,
>          .remove         = ipp_remove,
>          .driver         = {
>                  .name   = "exynos-drm-ipp",
>                  .owner  = THIS_MODULE,
>                  .pm     = &ipp_pm_ops,
>          },
> };
>
> static int ipp_remove(struct platform_device *pdev)
> {
>          struct ipp_context *ctx = platform_get_drvdata(pdev);
>
>          /* unregister sub driver */
>          exynos_drm_subdrv_unregister(&ctx->subdrv);
>
>          /* remove,destroy ipp idr */
>          idr_destroy(&ctx->ipp_idr);
>          idr_destroy(&ctx->prop_idr);
>
>          mutex_destroy(&ctx->ipp_lock);
>          mutex_destroy(&ctx->prop_lock);
>
>          /* destroy command, event work queue */
>          destroy_workqueue(ctx->cmd_workq);
>          destroy_workqueue(ctx->event_workq);
>
>          return 0;
> }
>
> int exynos_drm_subdrv_unregister(struct exynos_drm_subdrv *subdrv)
> {
>          if (!subdrv)
>                  return -EINVAL;
>
>          list_del(&subdrv->list);
>
>          return 0;
> }
>
> Oh dear, that destroys a whole pile of resources which could already
> be in use without telling anything that it's about to do that.
>
> I'm sure if I continue looking at the exynos stuff, it'll show similar
> crap all over the place.
>
> What you have now in mainline is not a solution.  It's a crappy bodge.
>

Undoubtedly. Nobody here is trying to state the opposite.

Maybe my words have been misinterpreted, but all I'm suggesting here is 
that there is no need to add any new data to DT to solve the same issue 
to the same extent as componentized subsystem framework, at least in 
Exynos case.

Best regards,
Tomasz
