From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 03 Dec 2013 09:27:35 +0100
Subject: [PATCH v4 09/17] usb: phy-mxs: Enable IC fixes for related SoCs
In-Reply-To: <1386056231-17258-10-git-send-email-peter.chen@freescale.com>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
 <1386056231-17258-10-git-send-email-peter.chen@freescale.com>
Message-ID: <529D95F7.8060705@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 08:37 AM, Peter Chen wrote:
> Some PHY bugs are fixed by IC logic, but these bits are not
> enabled by default, so we enable them at driver.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index 8738890..0908d74 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -31,6 +31,10 @@
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
> @@ -42,6 +46,8 @@
>  #define BM_USBPHY_CTRL_ENUTMILEVEL2		BIT(14)
>  #define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	BIT(1)
>  
> +#define BM_USBPHY_IP_FIX                       (BIT(17) | BIT(18))
> +
>  #define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
>  
>  /* Do disconnection between PHY and controller without vbus */
> @@ -97,6 +103,16 @@ struct mxs_phy {
>  	struct regmap *regmap_anatop;
>  };
>  
> +static inline bool is_imx6q_phy(struct mxs_phy *mxs_phy)
> +{
> +	return mxs_phy->data == &imx6q_phy_data;
> +}
> +
> +static inline bool is_imx6sl_phy(struct mxs_phy *mxs_phy)
> +{
> +	return mxs_phy->data == &imx6sl_phy_data;
> +}

Why don't you use a a BIT() here as in Patch 2/17, too?

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131203/1f1a2b29/attachment.sig>
