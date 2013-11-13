From: balbi@ti.com (Felipe Balbi)
Date: Wed, 13 Nov 2013 06:51:49 -0600
Subject: [PATCH V2] ARM: OMAP2+: omap_device: maintain sane runtime pm
 status around suspend/resume
In-Reply-To: <1384297710-29694-1-git-send-email-nm@ti.com>
References: <1384297710-29694-1-git-send-email-nm@ti.com>
Message-ID: <20131113125149.GB28192@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 12, 2013 at 05:08:30PM -0600, Nishanth Menon wrote:
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index b69dd9a..f97b34b 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -621,6 +621,7 @@ static int _od_suspend_noirq(struct device *dev)
>  
>  	if (!ret && !pm_runtime_status_suspended(dev)) {
>  		if (pm_generic_runtime_suspend(dev) == 0) {
> +			pm_runtime_set_suspended(dev);

don't you have to disable pm_runtime around status changes ? Or is
pm_runtime already disabled by the time we get here ?

> @@ -634,10 +635,10 @@ static int _od_resume_noirq(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct omap_device *od = to_omap_device(pdev);
>  
> -	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
> -	    !pm_runtime_status_suspended(dev)) {
> +	if (od->flags & OMAP_DEVICE_SUSPENDED) {
>  		od->flags &= ~OMAP_DEVICE_SUSPENDED;
>  		omap_device_enable(pdev);
> +		pm_runtime_set_active(dev);

ditto, also pm_runtime_set_active() may fail.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131113/04bc436c/attachment.sig>
