From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 2 Jul 2014 13:00:12 +0100
Subject: [PATCH 3/5] phy: miphy365x: Provide support for the MiPHY356x
 Generic PHY
In-Reply-To: <53B3DCBC.8000105@ti.com>
References: <1404133317-25953-1-git-send-email-lee.jones@linaro.org>
 <1404133317-25953-4-git-send-email-lee.jones@linaro.org>
 <53B3DCBC.8000105@ti.com>
Message-ID: <20140702120012.GB16724@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 02 Jul 2014, Kishon Vijay Abraham I wrote:
> On Monday 30 June 2014 06:31 PM, Lee Jones wrote:
> > The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
> > devices. It has 2 ports which it can use for either; both SATA, both
> > PCIe or one of each in any configuration.
> > 
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

I added this (a long time ago) becuase you already accepted this patch
into your tree at one point.  I guess things have changed since then,
I'll remove for the next submission.

> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/phy/Kconfig         |  10 +
> >  drivers/phy/Makefile        |   1 +
> >  drivers/phy/phy-miphy365x.c | 630 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 641 insertions(+)
> >  create mode 100644 drivers/phy/phy-miphy365x.c

[...]

> > +static void miphy365x_init_pcie_port(struct miphy365x *miphy_phy,
> > +				     struct miphy365x_dev *miphy_dev)
> 
> I would have this return int so that it's API is similar to that of sata.

Seems a little pointless, but okay.

[...]

> > +static inline int miphy365x_hfc_not_rdy(struct miphy365x *miphy_phy,
> > +					struct miphy365x_dev *miphy_dev)
> > +{
> > +	int timeout = HFC_TIMEOUT;
> > +	u8 mask = IDLL_RDY | PLL_RDY;
> > +	u8 regval;
> > +
> > +	do {
> > +		regval = readb_relaxed(miphy_phy->base + STATUS_REG);
> > +		usleep_range(2000, 2500);
> 
> msleep(2)?

usleep_range() is kinder to the scheduler than msleep().

[...]

> > +static inline void miphy365x_set_comp(struct miphy365x *miphy_phy,
> > +				      struct miphy365x_dev *miphy_dev)
> > +{
> > +	u8 val, mask;
> > +
> > +	if (miphy_dev->sata_gen == SATA_GEN1)
> > +		writeb_relaxed(COMP_2MHZ_RAT_GEN1,
> > +			       miphy_phy->base + COMP_CTRL2_REG);
> > +	else
> > +		writeb_relaxed(COMP_2MHZ_RAT,
> > +			       miphy_phy->base + COMP_CTRL2_REG);
> 
> Btw don't you think it will be safe to use readb/writeb instead of
> readb_relaxed/writeb_relaxed here and everywhere else?

{read,write}b_relaxed() calls are more efficient than {read,write}b().

The non-relaxed versions are only required on architectures which do
not guarantee access ordering.  This driver only supports ARM, which
does this by design.

[...]

> > +	if (WARN_ON(port >= ARRAY_SIZE(ports)))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (type == MIPHY_TYPE_SATA)
> > +		state->phys[port].base = state->phys[port].sata;
> > +	else if (type == MIPHY_TYPE_PCIE)
> > +		state->phys[port].base = state->phys[port].pcie;
> 
> Sergei made an important point about overriding the PHY mode (like here) that
> might create problem for the first driver that got the PHY. This might need
> both the phy-core and the phy driver to maintain state to handle this properly.

Would you be kind enough to explain a little more about the problem
and what you think a valid solution might look like?

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
