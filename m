From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Dec 2013 10:06:11 -0600
Subject: [RFC 5/5] usb: dwc3: enable async suspend/resume
In-Reply-To: <1387363174-25942-5-git-send-email-yuvaraj.cd@samsung.com>
References: <1387363174-25942-1-git-send-email-yuvaraj.cd@samsung.com>
 <1387363174-25942-5-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <20131218160611.GC4970@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 04:09:34PM +0530, Yuvaraj Kumar C D wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
> 
> In addition to enabling async suspend/resume on the xhci-plat device,
> we must enable it for the dwc3 device (the parent of xhci-plat) in order
> to make the full USB stack resume asynchronously.  Like the xhci-plat,
> ehci-s5p, and ohci-exynos drivers, there are no outside dependencies
> which would make resuming the dwc3 driver asynchronously unsafe.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/usb/dwc3/core.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 59bb8d2..9c8a273 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -586,6 +586,8 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	pm_runtime_allow(dev);
>  
> +	device_enable_async_suspend(dev);

how has this series been tested ? Let me rephrase this: was this series
tested at all ? Note that if we are in gadget mode, we will disable
physical endpoints 0 and 1, which will break USB communication requiring
a new enumeration later. On top of that, for versions of the core which
are configured without hibernation support - in fact for all cores
currently, since we don't have hibernation support implemented in this
driver -, we will loose communication with the far end (be it a host or
a device).

You mention there are no external dependencies to make async suspend
work on this driver, but that's far from the truth. As it is today, this
driver needs a lot of work to learn about all the details about all
different versions of this IP when it comes to supporting async PM.

I suppose this was tested with 500 other out-of-tree patches and you
simply cherry-picked this patch to send upstream ? Am I right ? It
certainly looks like it.

Please let us know how has this been tested ? Did you run USB30CV ? Did
you make sure to run through USB Certification interoperability tests ?

Did you leave some stress test running for weeks before sending this
patch out ? Is Exynos 5 working fine out of mainline ?

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/5dd983bd/attachment-0001.sig>
