From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 19 Jul 2012 08:37:36 +0200
Subject: [PATCH] ARM: Orion: fix driver probe error handling with respect
 to clk
In-Reply-To: <1342649049-3956-1-git-send-email-gmbnomis@gmail.com>
References: <1342649049-3956-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <20120719063736.GT4015@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 12:04:09AM +0200, Simon Baatz wrote:
> The clk patches added code to get and enable clocks in the
> respective driver probe functions.  If the probe function failed
> for some reason after enabling the clock, the clock was not
> disabled again in many cases.
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

Hi Simon

Looks mostly good. I can pull this into my collection of orion
patches.

> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index f0f06b2..c496720 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -2983,6 +2983,10 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
>  	return 0;
>  
>  out:
> +	if (!IS_ERR(mp->clk)) {
> +		clk_disable_unprepare(mp->clk);
> +		clk_put(mp->clk);
> +	}
>  	free_netdev(dev);
>  
>  	return err;

The ethernet driver is build on platforms which don't have clk
support. So this needs to be inside

#if defined(CONFIG_HAVE_CLK)
#endif

I will add this.

  Andrew
