From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jul 2014 09:04:03 -0500
Subject: [PATCH 9/9] usb: musb: musb_am335x: reinstate module
 loading/unloading support
In-Reply-To: <1405675890-8802-10-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-5-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-6-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-7-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-8-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-9-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-10-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140718140403.GI24914@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 11:31:30AM +0200, Lothar Wa?mann wrote:
> There is no need to throw the baby out with the bath due to a bad
> failure analysis. The commit:
> 7adb5c876e9c usb: musb: Fix panic upon musb_am335x module removal
> came to a wrong conclusion about the cause of the crash it was
> "fixing". The real culprit was the phy-am335x module that was removed
> from underneath its users that were still referencing data from it.
> After having fixed this in a previous patch, module unloading can be
> reinstated.
> 
> Another bug with module loading/unloading was the fact, that after
> removing the devices instantiated from DT their 'OF_POPULATED' flag
> was still set, so that re-loading the module after an unload had no
> effect. This is also fixed in this patch.

now this is a good commit log. I still can't see the need for the other
patch adding try_module_get(), though. Another thing, this needs to be
reviewed by DT folks too.

> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  drivers/usb/musb/musb_am335x.c |   23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_am335x.c b/drivers/usb/musb/musb_am335x.c
> index 164c868..152a6f5 100644
> --- a/drivers/usb/musb/musb_am335x.c
> +++ b/drivers/usb/musb/musb_am335x.c
> @@ -19,6 +19,22 @@ err:
>  	return ret;
>  }
>  
> +static int of_remove_populated_child(struct device *dev, void *d)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	of_device_unregister(pdev);
> +	of_node_clear_flag(pdev->dev.of_node, OF_POPULATED);

I don't think this should be called by drivers; rather by the bus.

> +	return 0;
> +}
> +
> +static int am335x_child_remove(struct platform_device *pdev)
> +{
> +	device_for_each_child(&pdev->dev, NULL, of_remove_populated_child);
> +	pm_runtime_disable(&pdev->dev);
> +	return 0;
> +}
> +
>  static const struct of_device_id am335x_child_of_match[] = {
>  	{ .compatible = "ti,am33xx-usb" },
>  	{  }
> @@ -27,17 +43,14 @@ MODULE_DEVICE_TABLE(of, am335x_child_of_match);
>  
>  static struct platform_driver am335x_child_driver = {
>  	.probe		= am335x_child_probe,
> +	.remove		= am335x_child_remove,
>  	.driver		= {
>  		.name	= "am335x-usb-childs",
>  		.of_match_table	= am335x_child_of_match,
>  	},
>  };
>  
> -static int __init am335x_child_init(void)
> -{
> -	return platform_driver_register(&am335x_child_driver);
> -}
> -module_init(am335x_child_init);
> +module_platform_driver(am335x_child_driver);
>  
>  MODULE_DESCRIPTION("AM33xx child devices");
>  MODULE_LICENSE("GPL v2");
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/824003e4/attachment.sig>
