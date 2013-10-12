From: marex@denx.de (Marek Vasut)
Date: Sat, 12 Oct 2013 11:38:16 +0200
Subject: [PATCH 02/12] usb: phy-mxs: Enable IC fixes for mx6 SoC serial
In-Reply-To: <1381568986-19802-3-git-send-email-peter.chen@freescale.com>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
 <1381568986-19802-3-git-send-email-peter.chen@freescale.com>
Message-ID: <201310121138.16584.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> After adding IC fixes bits, some PHY bugs are fixed by
> IC logic.

Can you please elaborate what those bits do exactly ? They seem like a magic 
stuff to me thus far, which is not exactly helpful . I can't find them in the 
datasheet either.

> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index 87ba429..831b13e 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -29,6 +29,10 @@
>  #define HW_USBPHY_CTRL_SET			0x34
>  #define HW_USBPHY_CTRL_CLR			0x38
> 
> +#define HW_USBPHY_IP				0x90
> +#define HW_USBPHY_IP_SET			0x94
> +#define HW_USBPHY_IP_CLR			0x98
> +
>  #define BM_USBPHY_CTRL_SFTRST			BIT(31)
>  #define BM_USBPHY_CTRL_CLKGATE			BIT(30)
>  #define BM_USBPHY_CTRL_ENAUTOSET_USBCLKS	BIT(26)
> @@ -40,6 +44,8 @@
>  #define BM_USBPHY_CTRL_ENUTMILEVEL2		BIT(14)
>  #define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	BIT(1)
> 
> +#define BM_USBPHY_IP_FIX                       (BIT(17) | BIT(18))
> +
>  #define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
> 
>  enum imx_phy_type {
> @@ -118,6 +124,10 @@ static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
>  		BM_USBPHY_CTRL_ENUTMILEVEL3,
>  	       base + HW_USBPHY_CTRL_SET);
> 
> +	/* Enable IC solution */
> +	if (is_mx6q_phy(mxs_phy) || is_mx6sl_phy(mxs_phy))
> +		writel(BM_USBPHY_IP_FIX, base + HW_USBPHY_IP_SET);
> +
>  	return 0;
>  }

Best regards,
Marek Vasut
