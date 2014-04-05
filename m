From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Apr 2014 19:24:23 +0100
Subject: [PATCH v2 1/7] drm/exynos: add super device support
In-Reply-To: <53403E42.1010403@gmail.com>
References: <1396355882-17010-1-git-send-email-inki.dae@samsung.com>
 <1396355882-17010-2-git-send-email-inki.dae@samsung.com>
 <533EB9C6.80302@samsung.com>
 <CAAQKjZPbzb+qvJA5y+Kco9BRv4j3iVatM_0bd+ugyuVZUbfFFg@mail.gmail.com>
 <53403E42.1010403@gmail.com>
Message-ID: <20140405182423.GL7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 05, 2014 at 07:32:50PM +0200, Tomasz Figa wrote:
> Not exactly. The approach we found does mostly the same as componentized  
> subsystem framework but without _any_ extra data in Device Tree. Just  
> based on the list of subsystem sub-drivers that is already available to  
> the master driver.

The existing approach is fundamentally broken.  Yes, your solution may
work for the probing case, but have you tried unbinding any of your
sub-drivers?

>From what I can see, that causes a kernel oops for one very simple reason -
you destroy stuff while it's still in use.  Let's look at an example:

struct platform_driver ipp_driver = {
        .probe          = ipp_probe,
        .remove         = ipp_remove,
        .driver         = {
                .name   = "exynos-drm-ipp",
                .owner  = THIS_MODULE,
                .pm     = &ipp_pm_ops,
        },
};

static int ipp_remove(struct platform_device *pdev)
{
        struct ipp_context *ctx = platform_get_drvdata(pdev);

        /* unregister sub driver */
        exynos_drm_subdrv_unregister(&ctx->subdrv);

        /* remove,destroy ipp idr */
        idr_destroy(&ctx->ipp_idr);
        idr_destroy(&ctx->prop_idr);

        mutex_destroy(&ctx->ipp_lock);
        mutex_destroy(&ctx->prop_lock);

        /* destroy command, event work queue */
        destroy_workqueue(ctx->cmd_workq);
        destroy_workqueue(ctx->event_workq);

        return 0;
}

int exynos_drm_subdrv_unregister(struct exynos_drm_subdrv *subdrv)
{
        if (!subdrv)
                return -EINVAL;

        list_del(&subdrv->list);

        return 0;
}

Oh dear, that destroys a whole pile of resources which could already
be in use without telling anything that it's about to do that.

I'm sure if I continue looking at the exynos stuff, it'll show similar
crap all over the place.

What you have now in mainline is not a solution.  It's a crappy bodge.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
