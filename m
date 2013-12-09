From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 09 Dec 2013 21:20:08 +0300
Subject: [PATCH v5 15/15] usb: phy-mxs: Add sync time after controller
 clear phcd
In-Reply-To: <1386570664-6713-16-git-send-email-peter.chen@freescale.com>
References: <1386570664-6713-1-git-send-email-peter.chen@freescale.com>
 <1386570664-6713-16-git-send-email-peter.chen@freescale.com>
Message-ID: <52A609D8.1050300@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/09/2013 09:31 AM, Peter Chen wrote:

> After clear portsc.phcd, PHY needs 200us stable time for switch
> 32K clock to AHB clock.

> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>   drivers/usb/phy/phy-mxs-usb.c |   11 +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)

> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index e18fdf3..7ae5225 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -151,6 +151,15 @@ static inline bool is_imx6sl_phy(struct mxs_phy *mxs_phy)
>   	return mxs_phy->data == &imx6sl_phy_data;
>   }
>
> +/*
> + * PHY needs some 32K cycles to switch from 32K clock to
> + * bus (such as AHB/AXI, etc) clock.
> + */
> +static void mxs_phy_clock_switch(void)
> +{
> +	usleep_range(300, 400);
> +}
> +

    Don't think this is a good name for this function since it doesn't really 
switch anything, just waits. I'd suggest something like 
mxs_phy_clock_switch_delay().

WBR, Sergei
