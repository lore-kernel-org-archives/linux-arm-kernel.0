From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 22:39:23 -0600
Subject: [PATCH v6 15/15] usb: phy-mxs: Add sync time after controller
 clear phcd
In-Reply-To: <1386897825-6130-16-git-send-email-peter.chen@freescale.com>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-16-git-send-email-peter.chen@freescale.com>
Message-ID: <20131213043923.GJ867@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 09:23:45AM +0800, Peter Chen wrote:
> After clear portsc.phcd, PHY needs 200us stable time for switch
> 32K clock to AHB clock.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index 885f8d9..68bd981 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -156,6 +156,15 @@ static inline bool is_imx6sl_phy(struct mxs_phy *mxs_phy)
>  	return mxs_phy->data == &imx6sl_phy_data;
>  }
>  
> +/*
> + * PHY needs some 32K cycles to switch from 32K clock to
> + * bus (such as AHB/AXI, etc) clock.
> + */
> +static void mxs_phy_clock_switch_delay(void)
> +{
> +	usleep_range(300, 400);
> +}

shouldn't this be handled by clk_set_parent() itself ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/f899c155/attachment.sig>
