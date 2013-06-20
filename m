From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Jun 2013 15:07:46 +0300
Subject: [RFC PATCH 1/6] mfd: omap-usb-host: move initialization to
 module_init()
In-Reply-To: <1371650753-11452-2-git-send-email-rogerq@ti.com>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
 <1371650753-11452-2-git-send-email-rogerq@ti.com>
Message-ID: <20130620120746.GC9817@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 19, 2013 at 05:05:48PM +0300, Roger Quadros wrote:
> We no longer need to be initialized in any particular order
> so move driver initialization to the standard place i.e. module_init()
> 
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c |   10 +---------
>  drivers/mfd/omap-usb-tll.c  |    8 +-------
>  2 files changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 759fae3..6601a49 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -908,15 +908,7 @@ static int __init omap_usbhs_drvinit(void)
>  {
>  	return platform_driver_probe(&usbhs_omap_driver, usbhs_omap_probe);
>  }
> -
> -/*
> - * init before ehci and ohci drivers;
> - * The usbhs core driver should be initialized much before
> - * the omap ehci and ohci probe functions are called.
> - * This usbhs core driver should be initialized after
> - * usb tll driver
> - */
> -fs_initcall_sync(omap_usbhs_drvinit);
> +module_init(omap_usbhs_drvinit);
>  
>  static void __exit omap_usbhs_drvexit(void)
>  {
> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
> index e59ac4c..fb7c73e 100644
> --- a/drivers/mfd/omap-usb-tll.c
> +++ b/drivers/mfd/omap-usb-tll.c
> @@ -482,13 +482,7 @@ static int __init omap_usbtll_drvinit(void)
>  {
>  	return platform_driver_register(&usbtll_omap_driver);
>  }
> -
> -/*
> - * init before usbhs core driver;
> - * The usbtll driver should be initialized before
> - * the usbhs core driver probe function is called.
> - */
> -fs_initcall(omap_usbtll_drvinit);
> +module_init(omap_usbtll_drvinit);

since you're doing that, could just move to module_platform_driver.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/545be6e8/attachment.sig>
