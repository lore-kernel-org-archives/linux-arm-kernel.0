From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 9 Mar 2015 11:38:35 +0100
Subject: [PATCH 1/2] soc: mediatek: Add PMIC wrapper for MT8135 and
 MT8173 SoCs
In-Reply-To: <CABuKBe+goUnNUtK1+-VGNq9w-NUgQOA5d5h_0Yx9VwuXr6-A6g@mail.gmail.com>
References: <1424606567-29708-1-git-send-email-s.hauer@pengutronix.de>
 <1424606567-29708-2-git-send-email-s.hauer@pengutronix.de>
 <CABuKBe+goUnNUtK1+-VGNq9w-NUgQOA5d5h_0Yx9VwuXr6-A6g@mail.gmail.com>
Message-ID: <20150309103835.GB31289@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 09:53:31AM +0100, Matthias Brugger wrote:
> 2015-02-22 13:02 GMT+01:00 Sascha Hauer <s.hauer@pengutronix.de>:
> > From: Flora Fu <flora.fu@mediatek.com>
> >
> > new file mode 100644
> > index 0000000..b91665a
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/Kconfig
> > @@ -0,0 +1,11 @@
> > +#
> > +# MediaTek SoC drivers
> > +#
> > +config MTK_PMIC_WRAP
> > +       tristate "MediaTek PMIC Wrapper Support"
> > +       depends on ARCH_MEDIATEK
> > +       select REGMAP
> > +       help
> > +         Say yes here to add support for MediaTek PMIC Wrapper found
> > +         on the MT8135 and MT8173 SoCs. The PMIC wrapper is a proprietary
> > +         hardware to connect the PMIC.
> 
> I have found pmic-wrapper on mt6589, mt6582 and mt6592. Most probably
> more SoCs, if not all will have a pmic-wrapper, so we should take this
> into account. This message should reflect that.

Changed to:

	  Say yes here to add support for MediaTek PMIC Wrapper found
	  on different MediaTek SoCs. The PMIC wrapper is a proprietary
	  hardware to connect the PMIC.

> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +#define DEBUG

Dropped this.

> > +/*
> > + * FIXME: These shouldn't be here. These registers are on the PMIC,
> > + *        so they should be touched in the PMIC driver, not the driver
> > + *        granting access to it.
> > + */
> > +#define MT6397_WRP_CKPDN               0x011a
> > +#define MT6397_WRP_RST_CON             0x0120
> > +#define MT6397_TOP_CKCON2              0x012a
> > +#define MT6397_TOP_CKCON3              0x01d4
> 
> We should not mix up between pmic-wrapper and pmic.

I removed these. It still seems to work. Whoever wants to add that back
can probably give a good reason why this must be done and how it can be
abstracted properly.

> > +       PWRAP_RRARB_EN,
> > +       PWRAP_RRARB_STA0,
> > +       PWRAP_RRARB_STA1,
> > +       PWRAP_EVENT_STA,
> > +       PWRAP_EVENT_STACLR,
> > +       PWRAP_CIPHER_LOAD,
> > +       PWRAP_CIPHER_START,
> 
> This registers exist on mt6589 as well, which makes me think that the
> wrapper might have the same internal version.

Once we know this we can replace mt8173 with v1 or whatever the version
is. Should be easy enough for a cleanup patch.

> > +       [PWRAP_WDT_UNIT] =              0xe4,
> > +       [PWRAP_WDT_SRC_EN] =            0xe8,
> > +       [PWRAP_WDT_FLG] =               0xec,
> > +       [PWRAP_DEBUG_INT_SEL] =         0xf0,
> > +       [PWRAP_CIPHER_KEY_SEL] =        0x134,
> > +       [PWRAP_CIPHER_IV_SEL] =         0x138,
> > +       [PWRAP_CIPHER_LOAD] =           0x13c,
> > +       [PWRAP_CIPHER_START] =          0x140,
> > +       [PWRAP_CIPHER_RDY] =            0x144,
> > +       [PWRAP_CIPHER_MODE] =           0x148,
> > +       [PWRAP_CIPHER_SWRST] =          0x14c,
> > +       [PWRAP_DCM_EN] =                0x15c,
> > +       [PWRAP_DCM_DBC_PRD] =           0x160,
> > +};
> 
> I'm not really happy with putting this arrays in here. When adding
> more SoCs this will bloat up the file. Better if we put this
> definitions in a header file.

It's usually recommended that for #defines for only a single user no
additional header file is created. Should this file really bloat up this
file so much before the engineers have learned that registers should not
be shifted like this, then we can still move to a separate header file.

> > +static int pwrap_init_reg_clock(struct pmic_wrapper *wrp)
> > +{
> > +       u32 wdata;
> > +       u32 rdata;
> > +       unsigned long rate_spi;
> > +       int ck_mhz;
> > +
> > +       rate_spi = clk_get_rate(wrp->clk_spi);
> > +
> > +       if (rate_spi > 26000000)
> > +               ck_mhz = 26;
> > +       else if (rate_spi > 18)
> 
> Hu, 18 Hz? Looks like a typo.

Fixed, thanks

> > +
> > +       switch (ck_mhz) {
> > +       case 18:
> > +               if (pwrap_is_mt8135(wrp))
> > +                       pwrap_writel(wrp, 0xc, PWRAP_CSHEXT);
> 
> If the pmic-wrapper is unique to every SoC, we should think of
> providing a different way to distinguish between the implementations.
> Otherwise we will bloat up the code with SoC specific conditionals.

I am happy to replace this with pwrap_is_v2() or even with additional
function hooks in struct pmic_wrapper_type once it's clear how other
pmic wrapper are different. Without this knowledge it's hard to predict
what the right weapon is to abstract between SoC differences.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
