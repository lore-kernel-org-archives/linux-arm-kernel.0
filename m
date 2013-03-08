From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Mar 2013 18:33:00 +0200
Subject: [PATCH 3/5] USB chipidea: introduce dual role mode pdata flags
In-Reply-To: <1362049024-11383-4-git-send-email-mkl@pengutronix.de>
References: <1362049024-11383-1-git-send-email-mkl@pengutronix.de>
 <1362049024-11383-4-git-send-email-mkl@pengutronix.de>
Message-ID: <20130308163300.GF32368@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 28, 2013 at 11:57:02AM +0100, Marc Kleine-Budde wrote:
> @@ -487,14 +488,23 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	/* For now we treat dual-role as otg */
> +	dr_mode = ci->platdata->dr_mode;
> +	if (dr_mode == USB_DR_MODE_UNKNOWN || dr_mode == USB_DR_MODE_DUAL_ROLE)
> +		dr_mode = USB_DR_MODE_OTG;
> +
>  	/* initialize role(s) before the interrupt is requested */
> -	ret = ci_hdrc_host_init(ci);
> -	if (ret)
> -		dev_info(dev, "doesn't support host\n");
> +	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {

this is not something you should be passing via pdata; chipidea core
should know how to read this data by itself. Meaning that chipidea core
should be taught about devicetree. But make it optional since now all
users use DT.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130308/5eda4a64/attachment.sig>
