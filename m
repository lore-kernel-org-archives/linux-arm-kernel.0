From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 20 Jun 2016 18:41:39 +0530
Subject: [PATCH 2/4] phy: rockchip-emmc: configure frequency range and
 drive impedance
In-Reply-To: <1463092986-61777-2-git-send-email-briannorris@chromium.org>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
 <1463092986-61777-2-git-send-email-briannorris@chromium.org>
Message-ID: <5767EB8B.4010008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 13 May 2016 04:13 AM, Brian Norris wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Signal integrity analysis has suggested we set these values. Do this in
> power_on(), so that they get reconfigured after suspend/resume.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/phy-rockchip-emmc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
> index 48cbe691a889..5641dede32f6 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -56,6 +56,19 @@
>  #define PHYCTRL_DLLRDY_SHIFT	0x5
>  #define PHYCTRL_DLLRDY_DONE	0x1
>  #define PHYCTRL_DLLRDY_GOING	0x0
> +#define PHYCTRL_FREQSEL_200M	0x0
> +#define PHYCTRL_FREQSEL_50M	0x1
> +#define PHYCTRL_FREQSEL_100M	0x2
> +#define PHYCTRL_FREQSEL_150M	0x3
> +#define PHYCTRL_FREQSEL_MASK	0x3
> +#define PHYCTRL_FREQSEL_SHIFT	0xc
> +#define PHYCTRL_DR_MASK		0x7
> +#define PHYCTRL_DR_SHIFT	0x4
> +#define PHYCTRL_DR_50OHM	0x0
> +#define PHYCTRL_DR_33OHM	0x1
> +#define PHYCTRL_DR_66OHM	0x2
> +#define PHYCTRL_DR_100OHM	0x3
> +#define PHYCTRL_DR_40OHM	0x4
>  
>  struct rockchip_emmc_phy {
>  	unsigned int	reg_offset;
> @@ -154,6 +167,20 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
>  	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
>  	int ret = 0;
>  
> +	/* DLL operation: 170 to 200 MHz */
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->reg_offset + GRF_EMMCPHY_CON0,
> +		     HIWORD_UPDATE(PHYCTRL_FREQSEL_200M,
> +				   PHYCTRL_FREQSEL_MASK,
> +				   PHYCTRL_FREQSEL_SHIFT));
> +
> +	/* Drive impedance: 50 Ohm */
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
> +		     HIWORD_UPDATE(PHYCTRL_DR_50OHM,
> +				   PHYCTRL_DR_MASK,
> +				   PHYCTRL_DR_SHIFT));
> +
>  	/* Power up emmc phy analog blocks */
>  	ret = rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
>  	if (ret)
> 
