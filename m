From: khilman@linaro.org (Kevin Hilman)
Date: Sat, 13 Jul 2013 23:21:29 +0100
Subject: [PATCH] arm: omap2plus: unidle devices which are about to probe
In-Reply-To: <1373537788-30413-1-git-send-email-balbi@ti.com> (Felipe Balbi's
 message of "Thu, 11 Jul 2013 13:16:28 +0300")
References: <20130711092612.GG23892@arwen.pp.htv.fi>
 <1373537788-30413-1-git-send-email-balbi@ti.com>
Message-ID: <8738rije3a.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> in order to make HWMOD and pm_runtime agree on the
> initial state of the device, we will unidle the device
> and call pm_runtime_set_active() to tell pm_runtime
> that the device is really active.
>
> By the time driver's probe() is reached, a call to
> pm_runtime_get_sync() will not cause driver's
> ->runtime_resume() method to be called at first, only
> after a successful ->runtime_suspend().
>
> Note that we must prevent pm_runtime transitions while
> driver is probing otherwise drivers would be suspended
> as soon as they call pm_runtime_use_autosuspend(). By
> calling pm_runtime_forbid() before probe() and
> pm_runtime_allow() after probe() we 'fix' that detail.

This part sounds a bit strange to me, and sounds more like a driver bug.
Looking at omap-serial, this probably happens because the driver calls
_use_autosuspend() after it has called _enable() but before has done its
_get_sync().

> Note that this patch was inspired by PCI's pci_pm_init().
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>
> boot tested on top of today's Linus master
> 6d128e1e72bf082542e85f72e6b7ddd704193588 with OMAP4
> panda. Reached console prompt and, after setting a
> proper autosuspend delay, consoles autosuspend just
> fine.
>
> It needs to be tested on other platforms.
>
> ps: note that we also call pm_runtime_set_suspended(dev)
> from our late_initcall() to disable devices so that pm_runtime
> and HWMOD continue to aggree on device's state.

Excellent.

I like this approach, but agree it needs more testing like you
mentioned.

>  arch/arm/mach-omap2/omap_device.c | 44 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 5cc9287..cb1fc1d 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -178,6 +178,26 @@ odbfd_exit:
>  	return ret;
>  }
>  
> +static void omap_device_pm_init(struct platform_device *pdev)
> +{
> +	omap_device_enable(pdev);
> +	pm_runtime_forbid(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	device_enable_async_suspend(&pdev->dev);

You don't comment in the changelog about what this is for.  I think we
probably want this, but I suspect it belongs in a follow-up patch with
its own changelog.

Also Like PCI, I think we also want the device_set_wakeup_capable() here
also, but that should have its own patch+changelog also.

Kevin
