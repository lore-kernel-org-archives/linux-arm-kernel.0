From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 17 Mar 2015 09:06:59 +0100
Subject: [STLinux Kernel] [PATCH] phy: stih41x-usb: Fixup
 stih41x_usb_phy_power_on failure path
In-Reply-To: <1426552741.6645.1.camel@phoenix>
References: <1426552741.6645.1.camel@phoenix>
Message-ID: <5507E0A3.2080500@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel

On 03/17/2015 01:39 AM, Axel Lin wrote:
> If stih41x_usb_phy_power_on() fails, we need to call clk_disable_unprepare()
> before return error. This is to ensure we have balanced clk_enable/disable
> calls.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/phy/phy-stih41x-usb.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/phy-stih41x-usb.c b/drivers/phy/phy-stih41x-usb.c
> index a603801..c093b47 100644
> --- a/drivers/phy/phy-stih41x-usb.c
> +++ b/drivers/phy/phy-stih41x-usb.c
> @@ -87,8 +87,12 @@ static int stih41x_usb_phy_power_on(struct phy *phy)
>   		return ret;
>   	}
>   
> -	return regmap_update_bits(phy_dev->regmap, phy_dev->cfg->syscfg,
> -			phy_dev->cfg->oscok, phy_dev->cfg->oscok);
> +	ret = regmap_update_bits(phy_dev->regmap, phy_dev->cfg->syscfg,
> +				 phy_dev->cfg->oscok, phy_dev->cfg->oscok);
> +	if (ret)
> +		clk_disable_unprepare(phy_dev->clk);
> +
> +	return ret;
>   }
>   
>   static int stih41x_usb_phy_power_off(struct phy *phy)

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
