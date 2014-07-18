From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jul 2014 08:54:20 -0500
Subject: [PATCH 7/9] usb: phy: am335x: setup the gen_phy function
 pointers _before_ adding the phy
In-Reply-To: <1405675890-8802-8-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-5-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-6-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-7-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-8-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140718135419.GG24914@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 11:31:28AM +0200, Lothar Wa?mann wrote:
> Make sure all parameters are correctly set up before registering the
> PHY with the USB framework.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  drivers/usb/phy/phy-am335x.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
> index 91c71ab..6522fa7 100644
> --- a/drivers/usb/phy/phy-am335x.c
> +++ b/drivers/usb/phy/phy-am335x.c
> @@ -56,11 +56,12 @@ static int am335x_phy_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	am_phy->usb_phy_gen.phy.init = am335x_init;
> +	am_phy->usb_phy_gen.phy.shutdown = am335x_shutdown;
> +
>  	ret = usb_add_phy_dev(&am_phy->usb_phy_gen.phy);
>  	if (ret)
>  		return ret;
> -	am_phy->usb_phy_gen.phy.init = am335x_init;
> -	am_phy->usb_phy_gen.phy.shutdown = am335x_shutdown;
>  
>  	platform_set_drvdata(pdev, am_phy);
>  	device_init_wakeup(dev, true);

both of these need to be done before registering the PHY too.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/82d3c19f/attachment.sig>
