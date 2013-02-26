From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 26 Feb 2013 18:00:09 +0000
Subject: [PATCH] gpio: gpiolib: Remove WARN reference
In-Reply-To: <CAOMZO5B+3p_pKab_Au_3_kgir55vVs+sUMq8iMoQgMdTw4Ghtw@mail.gmail.com>
References: <1361049848-14977-1-git-send-email-festevam@gmail.com>
 <CAOMZO5B+3p_pKab_Au_3_kgir55vVs+sUMq8iMoQgMdTw4Ghtw@mail.gmail.com>
Message-ID: <20130226180009.A2F613E40D0@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 16 Feb 2013 20:22:33 -0200, Fabio Estevam <festevam@gmail.com> wrote:
> On Sat, Feb 16, 2013 at 7:24 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > mx28evk has two ethernet controllers. The GPIO that performs the
> > ethernet reset on both ports is the same GPIO, so on the board dts file, only in
> > one ethernet instance is passed the GPIO reset property.
> >
> > Replace the WARN with a pr_warn message.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Please discard this patch, I think the proper fix would be in the fec driver:

I agree. You shouldn't need to change the .dts file to fix the problem.

g.

> 
>  drivers/net/ethernet/freescale/fec.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.c
> b/drivers/net/ethernet/freescale/fec.c
> index 0fe68c4..5864a67 100644
> --- a/drivers/net/ethernet/freescale/fec.c
> +++ b/drivers/net/ethernet/freescale/fec.c
> @@ -1689,6 +1689,9 @@ static void fec_reset_phy(struct platform_device *pdev)
>  		msec = 1;
> 
>  	phy_reset = of_get_named_gpio(np, "phy-reset-gpios", 0);
> +	if (!gpio_is_valid(phy_reset))
> +		return;
> +
>  	err = devm_gpio_request_one(&pdev->dev, phy_reset,
>  				    GPIOF_OUT_INIT_LOW, "phy-reset");
>  	if (err) {
> 
> Will submit it to net-dev.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
