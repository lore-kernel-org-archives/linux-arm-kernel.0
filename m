From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 15 Jul 2014 15:54:26 +0200
Subject: [PATCH v3 3/4] can: flexcan: switch on clocks before accessing
 ecr register
In-Reply-To: <c80f9d2ec80d01088e51be61a4e7845cbfe58f6a.1405428166.git.stefan@agner.ch>
References: <cover.1405428166.git.stefan@agner.ch>
 <c80f9d2ec80d01088e51be61a4e7845cbfe58f6a.1405428166.git.stefan@agner.ch>
Message-ID: <20140715155426.3c03f0d8@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Stefan Agner wrote:
> Reported-by: Ashutosh Singh <ashuleapyear@gmail.com>
> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> [stefan at agner.ch: added return check for clk_enable_prepare]
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/net/can/flexcan.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index f425ec2..89745aa 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -383,12 +383,26 @@ static int flexcan_get_berr_counter(const struct net_device *dev,
>  {
>  	const struct flexcan_priv *priv = netdev_priv(dev);
>  	struct flexcan_regs __iomem *regs = priv->base;
> -	u32 reg = flexcan_read(&regs->ecr);
> +	u32 reg, err;
> +
> +	err = clk_prepare_enable(priv->clk_ipg);
> +	if (err)
> +		return err;
> +
> +	err = clk_prepare_enable(priv->clk_per);
> +	if (err)
> +		goto out_disable_ipg;
> +
> +	reg = flexcan_read(&regs->ecr);
>  
flexcan_get_berr_counter() may be called from interrupt context and
thus must not call any functions that can sleep.
Compiling the driver with CONFIG_DEBUG_ATOMIC_SLEEP would catch this!


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
