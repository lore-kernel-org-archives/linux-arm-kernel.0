From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 09 Dec 2013 09:38:17 +0100
Subject: [PATCH v5 09/15] usb: phy-mxs: Enable IC fixes for related SoCs
In-Reply-To: <1386570664-6713-10-git-send-email-peter.chen@freescale.com>
References: <1386570664-6713-1-git-send-email-peter.chen@freescale.com>
 <1386570664-6713-10-git-send-email-peter.chen@freescale.com>
Message-ID: <52A58179.2050702@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 07:30 AM, Peter Chen wrote:
> Some PHY bugs are fixed by IC logic, but these bits are not
> enabled by default, so we enable them at driver.

Which bugs are fixed by enabling this bit? Is it only suspend related?
Can you document them or better add a pointer to the documentation.

Further I don't like the idea of adding code, or enabling a feature on
certain hardware, that is broken in the first place and fixing it in a
later patch. Think about squashing it into the correct patch.

> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |   28 ++++++++++++++++++++++++++--
>  1 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index e3df53f..d1c319b 100644
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
> @@ -63,6 +69,9 @@
>  /* The SoCs who have anatop module */
>  #define MXS_PHY_HAS_ANATOP			BIT(3)
>  
> +/* IC has bug fixes logic */
> +#define MXS_PHY_NEED_IP_FIX			BIT(4)
> +
>  struct mxs_phy_data {
>  	unsigned int flags;
>  };
> @@ -74,12 +83,14 @@ static const struct mxs_phy_data imx23_phy_data = {
>  static const struct mxs_phy_data imx6q_phy_data = {
>  	.flags = MXS_PHY_SENDING_SOF_TOO_FAST |
>  		MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS |
> -		MXS_PHY_HAS_ANATOP,
> +		MXS_PHY_HAS_ANATOP |
> +		MXS_PHY_NEED_IP_FIX,
>  };
>  
>  static const struct mxs_phy_data imx6sl_phy_data = {
>  	.flags = MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS |
> -		MXS_PHY_HAS_ANATOP,
> +		MXS_PHY_HAS_ANATOP |
> +		MXS_PHY_NEED_IP_FIX,
>  };
>  
>  static const struct of_device_id mxs_phy_dt_ids[] = {
> @@ -97,6 +108,16 @@ struct mxs_phy {
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

Are the two is_imx6* functions still needed?

> +
>  static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
>  {
>  	int ret;
> @@ -123,6 +144,9 @@ static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
>  		BM_USBPHY_CTRL_ENUTMILEVEL3,
>  	       base + HW_USBPHY_CTRL_SET);
>  
> +	if (mxs_phy->data->flags & MXS_PHY_NEED_IP_FIX)
> +		writel(BM_USBPHY_IP_FIX, base + HW_USBPHY_IP_SET);
> +
>  	return 0;
>  }

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/9242f466/attachment.sig>
