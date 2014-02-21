From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Feb 2014 09:21:27 +0000
Subject: [PATCH v10 10/15] usb: phy-mxs: Add implementation of set_wakeup
In-Reply-To: <1392873284-9386-11-git-send-email-peter.chen@freescale.com>
References: <1392873284-9386-1-git-send-email-peter.chen@freescale.com>
 <1392873284-9386-11-git-send-email-peter.chen@freescale.com>
Message-ID: <20140221092127.GC7541@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 05:14:39AM +0000, Peter Chen wrote:
> When we need the PHY can be waken up by external signals,
> we can call this API. Besides, we call mxs_phy_disconnect_line
> at this API to close the connection between USB PHY and
> controller, after that, the line state from controller is SE0.
> Once the PHY is out of power, without calling mxs_phy_disconnect_line,
> there are unknown wakeups due to dp/dm floating at device mode.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |  116 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 116 insertions(+), 0 deletions(-)

[...]

> +static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
> +{
> +	bool vbus_is_on = false;
> +
> +	/* If the SoCs don't need to disconnect line without vbus, quit */
> +	if (!(mxs_phy->data->flags & MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS))
> +		return;
> +
> +	/* If the SoCs don't have anatop, quit */
> +	if (!mxs_phy->regmap_anatop)
> +		return;

So it looks like fsl,anatop is truly optional.

Thanks,
Mark.
