From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 May 2016 16:54:17 +0200
Subject: [PATCH 1/2] drm: hdlcd: Skip PM callbacks if unbound
In-Reply-To: <eeb2a5540f50f5a3dd7f87861be1e9117bc4ed65.1462464611.git.robin.murphy@arm.com>
References: <eeb2a5540f50f5a3dd7f87861be1e9117bc4ed65.1462464611.git.robin.murphy@arm.com>
Message-ID: <20160506145417.GB15076@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2016 at 05:13:37PM +0100, Robin Murphy wrote:
> Until an encoder component is available to trigger the HDLCD's component
> master bind callback, the drm_device we keep in drvdata isn't allocated.
> Since it is quite possible to, say, hibernate the system without having
> loaded the encoder driver, the PM callbacks need to check for a valid
> drm_device before trying to take the lock and suspend/resume the crtcs,
> otherwise this happens:
> 
> [   51.779092] Unable to handle kernel NULL pointer dereference at virtual address 00000200
> [   51.787143] pgd = ffff800974462000
> [   51.790514] [00000200] *pgd=0000000000000000
> [   51.794768] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [   51.800291] Modules linked in:
> [   51.803325] CPU: 4 PID: 2098 Comm: systemd-sleep Not tainted 4.6.0-rc6+ #4
> [   51.810140] Hardware name: ARM Juno development board (r1) (DT)
> [   51.816008] task: ffff800974430000 ti: ffff80097380c000 task.ti: ffff80097380c000
> [   51.823433] PC is at mutex_lock+0x14/0x60
> [   51.827411] LR is at drm_modeset_lock_all+0x3c/0xe0
> [   51.832246] pc : [<ffff0000087d55c4>] lr : [<ffff0000084839fc>] pstate: 40000145
> [   51.839577] sp : ffff80097380faf0
> [   51.842859] x29: ffff80097380faf0 x28: 0000000000000000
> [   51.848132] x27: 0000000000000002 x26: ffff000008e01000
> [   51.853405] x25: ffff0000084cc000 x24: ffff000008dcb408
> [   51.858678] x23: ffff000008e7c000 x22: ffff8009760e8870
> [   51.863962] x21: 0000000000000200 x20: 0000000000000000
> [   51.869244] x19: 0000000000000200 x18: ffff800079357dd0
> [   51.874527] x17: 0000ffff8a00ab88 x16: 0000000000000018
> [   51.879809] x15: 0000000000000018 x14: 0000000000000000
> [   51.885091] x13: 0000000000000002 x12: 0000000000000000
> [   51.890374] x11: ffff0000087ff904 x10: 0000000000000840
> [   51.895656] x9 : 0000000000000000 x8 : ffff800973821680
> [   51.900938] x7 : 0000000000000000 x6 : 000000000000003f
> [   51.906220] x5 : 0000000000000040 x4 : 0000000000000000
> [   51.911502] x3 : 0000000000000004 x2 : 0000000000000000
> [   51.916784] x1 : 0000000000000001 x0 : 0000000000000200
> ...
> [   52.339406] [<ffff0000087d55c4>] mutex_lock+0x14/0x60
> [   52.344425] [<ffff0000084839fc>] drm_modeset_lock_all+0x3c/0xe0
> [   52.350305] [<ffff00000848a034>] hdlcd_pm_suspend+0x2c/0x90
> [   52.355842] [<ffff0000084c0d14>] platform_pm_suspend+0x24/0x58
> [   52.361638] [<ffff0000084cc190>] dpm_run_callback.isra.4+0x20/0x68
> [   52.367778] [<ffff0000084ccad4>] __device_suspend+0xe4/0x238
> [   52.373400] [<ffff0000084cdcac>] dpm_suspend+0x10c/0x240
> [   52.378679] [<ffff0000084ce0b8>] dpm_suspend_start+0x70/0x80
> [   52.384302] [<ffff0000080f80e4>] suspend_devices_and_enter+0x9c/0x480
> [   52.390699] [<ffff0000080f8698>] pm_suspend+0x1d0/0x240
> [   52.395890] [<ffff0000080f7280>] state_store+0x80/0x100
> [   52.401084] [<ffff0000083503f4>] kobj_attr_store+0x14/0x28
> [   52.406535] [<ffff000008238580>] sysfs_kf_write+0x48/0x58
> [   52.411899] [<ffff00000823798c>] kernfs_fop_write+0xbc/0x188
> [   52.417521] [<ffff0000081c71f4>] __vfs_write+0x1c/0xe0
> [   52.422626] [<ffff0000081c8144>] vfs_write+0x8c/0x1a8
> [   52.427644] [<ffff0000081c953c>] SyS_write+0x44/0xa0
> [   52.432578] [<ffff000008084ecc>] __sys_trace_return+0x0/0x4
> [   52.438114] Code: 910003fd f9000bf3 aa0003f3 f9800011 (885ffc01)
> [   52.444229] ---[ end trace 34b87a5fb9453f65 ]---
> 
> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/gpu/drm/arm/hdlcd_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> index 734899c4e4bb..86a5eea4cf53 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -498,7 +498,7 @@ static int __maybe_unused hdlcd_pm_suspend(struct device *dev)
>  	struct drm_device *drm = dev_get_drvdata(dev);
>  	struct drm_crtc *crtc;
>  
> -	if (pm_runtime_suspended(dev))
> +	if (pm_runtime_suspended(dev) || !drm)
>  		return 0;
>  
>  	drm_modeset_lock_all(drm);
> @@ -513,7 +513,7 @@ static int __maybe_unused hdlcd_pm_resume(struct device *dev)
>  	struct drm_device *drm = dev_get_drvdata(dev);
>  	struct drm_crtc *crtc;
>  
> -	if (!pm_runtime_suspended(dev))
> +	if (!pm_runtime_suspended(dev) || !drm)
>  		return 0;

Perhaps rather than this workaround you should only enable runtime PM on
this after the master has been bound?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160506/f3fa93c9/attachment-0001.sig>
