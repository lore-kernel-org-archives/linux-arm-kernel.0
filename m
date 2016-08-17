From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Wed, 17 Aug 2016 20:03:01 +0200
Subject: [PATCH] ARM: dts: imx6sx: document SION necessity of
 ENET1_REF_CLK1
In-Reply-To: <CAOMZO5CCwreYYgNd6uGnf9A0=KcMefYqHLFNWdMnweSTezxnWQ@mail.gmail.com>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
 <20160805065845.GI17874@pengutronix.de>
 <1470398615.1936.22.camel@googlemail.com>
 <CAOMZO5BQQemrKFjejUxQpW+d=BGn_b+d_sbr9Untu8iO3dOVvw@mail.gmail.com>
 <1471120532.1923.4.camel@googlemail.com>
 <20160815052244.mwygjlo72e46w353@pengutronix.de>
 <1471425931.1934.18.camel@googlemail.com>
 <CAOMZO5CCwreYYgNd6uGnf9A0=KcMefYqHLFNWdMnweSTezxnWQ@mail.gmail.com>
Message-ID: <1471456981.1934.63.camel@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-17 at 11:26 -0300, Fabio Estevam wrote:
> Hi Christoph,
> 
> On Wed, Aug 17, 2016 at 6:25 AM, Christoph Fritz
> <chf.fritz@googlemail.com> wrote:
> 
> > +/*
> > + * SION bit is necessary for ENET1_REF_CLK1 (ENET2_REF_CLK2 untested) if it is
> > + * used as clock output of IMX6SX_CLK_ENET_REF (ENET1_TX_CLK) to e.g. supply a
> > + * PHY in RMII mode. This configuration is valid if:
> > + *  - bit 1 in field IMX6SX_GPR1_FEC_CLOCK_PAD_DIR_MASK is set
> > + *  - bit 1 in field IMX6SX_GPR1_FEC_CLOCK_MUX_SEL_MASK unset
> 
> So in your case the imx6sx_enet_clk_sel() does not do what you need:
> 
> static void __init imx6sx_enet_clk_sel(void)
> {
>     struct regmap *gpr;
> 
>     gpr = syscon_regmap_lookup_by_compatible("fsl,imx6sx-iomuxc-gpr");
>     if (!IS_ERR(gpr)) {
>         regmap_update_bits(gpr, IOMUXC_GPR1,
>                    IMX6SX_GPR1_FEC_CLOCK_MUX_SEL_MASK, 0);
>         regmap_update_bits(gpr, IOMUXC_GPR1,
>                    IMX6SX_GPR1_FEC_CLOCK_PAD_DIR_MASK, 0);
>     } else {
>         pr_err("failed to find fsl,imx6sx-iomux-gpr regmap\n");
>     }
> }
> 
> It seems that it is not a good idea to have imx6sx_enet_clk_sel() in
> common code as the GPR1 setting can change from board to board.

Yes, currently I'm adapting/quirking the fec config there and in
imx6sx_clocks_init() to set the Phy-Clock-Frequency to 50Mhz.

> I think we need the fec driver to be in charge of configuring the GPR1 register.

What about making the Phy-Clock-Frequency IMX6SX_CLK_ENET_REF
adjustable?

> This is unrelated to your patch though :-)

Thanks
 -- Christoph
