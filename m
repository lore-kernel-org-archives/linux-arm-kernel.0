From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 26 Nov 2013 15:53:32 +0530
Subject: [PATCH v3 5/9] usb: gadget: s3c-hsotg: use generic
 phy_init()/phy_exit() support
In-Reply-To: <1385403367-18144-6-git-send-email-matt.porter@linaro.org>
References: <1385403367-18144-1-git-send-email-matt.porter@linaro.org>
 <1385403367-18144-6-git-send-email-matt.porter@linaro.org>
Message-ID: <529476A4.8080600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 25 November 2013 11:46 PM, Matt Porter wrote:
> If a generic phy is present, call phy_init()/phy_exit(). This supports
> generic phys that must be soft reset before power on.
> 
> Signed-off-by: Matt Porter <matt.porter@linaro.org>
> ---
>  drivers/usb/gadget/s3c-hsotg.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
> index da3879b..8dfe33f 100644
> --- a/drivers/usb/gadget/s3c-hsotg.c
> +++ b/drivers/usb/gadget/s3c-hsotg.c
> @@ -3622,6 +3622,9 @@ static int s3c_hsotg_probe(struct platform_device *pdev)
>  		goto err_supplies;
>  	}
>  
> +	if (hsotg->phy)

IS_ERR? If your phy_get fails *phy* will have a error value..

> +		phy_init(hsotg->phy);
> +
>  	/* usb phy enable */
>  	s3c_hsotg_phy_enable(hsotg);
>  
> @@ -3715,6 +3718,8 @@ static int s3c_hsotg_remove(struct platform_device *pdev)
>  	}
>  
>  	s3c_hsotg_phy_disable(hsotg);
> +	if (hsotg->phy)

same here.

Thanks
Kishon
