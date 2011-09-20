From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 20 Sep 2011 09:50:17 +0200
Subject: [PATCH 3/4] net/fec: set phy_speed to the optimal frequency 2.5
	MHz
In-Reply-To: <1316346852-17090-4-git-send-email-shawn.guo@linaro.org>
References: <1316346852-17090-1-git-send-email-shawn.guo@linaro.org>
	<1316346852-17090-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20088.17849.987651.196256@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> With the unnecessary 1 bit left-shift on fep->phy_speed during the
> calculation, the phy_speed always runs at the half frequency of the
> optimal one 2.5 MHz.
> 
> The patch removes that 1 bit left-shift to get the optimal phy_speed.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/net/fec.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/fec.c b/drivers/net/fec.c
> index 5ef0e34..04206e4 100644
> --- a/drivers/net/fec.c
> +++ b/drivers/net/fec.c
> @@ -1007,7 +1007,7 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>  	/*
>  	 * Set MII speed to 2.5 MHz (= clk_get_rate() / 2 * phy_speed)
>  	 */
> -	fep->phy_speed = DIV_ROUND_UP(clk_get_rate(fep->clk), 5000000) << 1;
> +	fep->phy_speed = DIV_ROUND_UP(clk_get_rate(fep->clk), 5000000);
>  	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
>  
>  	fep->mii_bus = mdiobus_alloc();
>
The left shift accounts for the fact, that the MII_SPEED bitfield
starts at pos 1 in the register. Thus the divider value has to be
shifted left to occupy the correct bit positions in the register.

According to my measurements on the TX28 the original code works
correctly!
Did you measure the actual frequency on the MDC pin after you change?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
