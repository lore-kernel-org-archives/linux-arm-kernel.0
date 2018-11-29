From: hongxing.zhu@nxp.com (Richard Zhu)
Date: Thu, 29 Nov 2018 10:52:12 +0000
Subject: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
In-Reply-To: <CAHQ1cqER2jjZCfFeaMi0T3-N-yNhiLiX5WYztpzuseXhA96JFw@mail.gmail.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-4-andrew.smirnov@gmail.com>
 <AM0PR0402MB35706B20F01340140367FECD8CD80@AM0PR0402MB3570.eurprd04.prod.outlook.com>
 <CAHQ1cqER2jjZCfFeaMi0T3-N-yNhiLiX5WYztpzuseXhA96JFw@mail.gmail.com>
Message-ID: <AM0PR0402MB35708A4A24F6497D648DD8718CD20@AM0PR0402MB3570.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Andrey Smirnov [mailto:andrew.smirnov at gmail.com]
> Sent: 2018?11?27? 2:10
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>; Bjorn Helgaas
> <bhelgaas@google.com>; Fabio Estevam <fabio.estevam@nxp.com>; Chris
> Healy <cphealy@gmail.com>; Lucas Stach <l.stach@pengutronix.de>;
> Leonard Crestez <leonard.crestez@nxp.com>; Aisheng DONG
> <aisheng.dong@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel <linux-arm-kernel@lists.infradead.org>;
> linux-pci at vger.kernel.org
> Subject: Re: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
> 
> On Sun, Nov 18, 2018 at 11:07 PM Richard Zhu <hongxing.zhu@nxp.com>
> wrote:
> >
> > Hi Andrey:
> > Thanks for your patch-set.
> > I have comment about the L1SS implementation below.
> > It's better to figure out one method to fix it.
> >
> > BR
> > Richard
> >
> > > -----Original Message-----
> > > From: Andrey Smirnov [mailto:andrew.smirnov at gmail.com]
> > > Sent: 2018?11?18? 2:12
> > > To: linux-kernel at vger.kernel.org
> > > Cc: Andrey Smirnov <andrew.smirnov@gmail.com>;
> bhelgaas at google.com;
> > > Fabio Estevam <fabio.estevam@nxp.com>; cphealy at gmail.com;
> > > l.stach at pengutronix.de; Leonard Crestez <leonard.crestez@nxp.com>;
> > > Aisheng DONG <aisheng.dong@nxp.com>; Richard Zhu
> > > <hongxing.zhu@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> > > linux-arm-kernel at lists.infradead.org; linux-pci at vger.kernel.org
> > > Subject: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
> > >
> > > Cc: bhelgaas at google.com
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: cphealy at gmail.com
> > > Cc: l.stach at pengutronix.de
> > > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > > Cc: linux-imx at nxp.com
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Cc: linux-kernel at vger.kernel.org
> > > Cc: linux-pci at vger.kernel.org
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > ---
> > >  drivers/pci/controller/dwc/Kconfig    |   2 +-
> > >  drivers/pci/controller/dwc/pci-imx6.c | 117
> > > ++++++++++++++++++++++++--
> > >  2 files changed, 113 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/Kconfig
> > > b/drivers/pci/controller/dwc/Kconfig
> > > index 91b0194240a5..2b139acccf32 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -90,7 +90,7 @@ config PCI_EXYNOS
> > >
> > >  config PCI_IMX6
> > >       bool "Freescale i.MX6 PCIe controller"
> > > -     depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
> > > +     depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM &&
> COMPILE_TEST)
> > >       depends on PCI_MSI_IRQ_DOMAIN
> > >       select PCIE_DW_HOST
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 3c3002861d25..8d1f310e41a6 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -8,6 +8,7 @@
> > >   * Author: Sean Cross <xobs@kosagi.com>
> > >   */
> > >
> > > +#include <linux/bitfield.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/gpio.h>
> > > @@ -30,6 +31,14 @@
> > >
> > >  #include "pcie-designware.h"
> > >
> > > +#define IMX8MQ_PCIE_LINK_CAP_REG_OFFSET              0x7C
> > > +#define IMX8MQ_PCIE_LINK_CAP_L1EL_64US               (0x6 <<
> 15)
> > > +
> > > +#define IMX8MQ_GPR_PCIE_REF_USE_PAD          BIT(9)
> > > +#define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN  BIT(10)
> > > +#define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE     BIT(11)
> > > +
> > > +
> > >  #define to_imx6_pcie(x)      dev_get_drvdata((x)->dev)
> > >
> > >  enum imx6_pcie_variants {
> > > @@ -37,6 +46,7 @@ enum imx6_pcie_variants {
> > >       IMX6SX,
> > >       IMX6QP,
> > >       IMX7D,
> > > +     IMX8MQ,
> > >  };
> > >
> > >  struct imx6_pcie {
> > > @@ -48,8 +58,10 @@ struct imx6_pcie {
> > >       struct clk              *pcie_inbound_axi;
> > >       struct clk              *pcie;
> > >       struct regmap           *iomuxc_gpr;
> > > +     u32                     gpr1x;
> > >       struct reset_control    *pciephy_reset;
> > >       struct reset_control    *apps_reset;
> > > +     struct reset_control    *apps_clk_req;
> > >       struct reset_control    *turnoff_reset;
> > >       enum imx6_pcie_variants variant;
> > >       u32                     tx_deemph_gen1;
> > > @@ -59,6 +71,7 @@ struct imx6_pcie {
> > >       u32                     tx_swing_low;
> > >       int                     link_gen;
> > >       struct regulator        *vpcie;
> > > +     u32                     device_type[2];
> > >  };
> > >
> > >  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> > > @@
> > > -245,7 +258,8 @@ static void imx6_pcie_reset_phy(struct imx6_pcie
> > > *imx6_pcie)  {
> > >       u32 tmp;
> > >
> > > -     if (imx6_pcie->variant == IMX7D)
> > > +     if (imx6_pcie->variant == IMX7D ||
> > > +         imx6_pcie->variant == IMX8MQ)
> > >               return;
> > >
> > >       pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp); @@
> -261,6
> > > +275,7 @@ static void imx6_pcie_reset_phy(struct imx6_pcie
> > > +*imx6_pcie)
> > >       pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);  }
> > >
> > > +#ifdef CONFIG_ARM
> > >  /*  Added for PCI abort handling */  static int
> > > imx6q_pcie_abort_handler(unsigned long addr,
> > >               unsigned int fsr, struct pt_regs *regs) @@ -294,6
> > > +309,7 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
> > >
> > >       return 1;
> > >  }
> > > +#endif
> > >
> > >  static void imx6_pcie_assert_core_reset(struct imx6_pcie
> > > *imx6_pcie) { @@ -301,6 +317,7 @@ static void
> > > imx6_pcie_assert_core_reset(struct
> > > imx6_pcie *imx6_pcie)
> > >
> > >       switch (imx6_pcie->variant) {
> > >       case IMX7D:
> > > +     case IMX8MQ: /* FALLTHROUGH */
> > >               reset_control_assert(imx6_pcie->pciephy_reset);
> > >               reset_control_assert(imx6_pcie->apps_reset);
> > >               break;
> > > @@ -369,6 +386,18 @@ static int imx6_pcie_enable_ref_clk(struct
> > > imx6_pcie *imx6_pcie)
> > >               break;
> > >       case IMX7D:
> > >               break;
> > > +     case IMX8MQ:
> > > +             /*
> > > +              * Set the over ride low and enabled
> > > +              * make sure that REF_CLK is turned on.
> > > +              */
> > > +             regmap_update_bits(imx6_pcie->iomuxc_gpr,
> imx6_pcie->gpr1x,
> > > +
> IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> > > +                                0);
> > > +             regmap_update_bits(imx6_pcie->iomuxc_gpr,
> imx6_pcie->gpr1x,
> > > +
> IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> > > +
> IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> > > +             break;
> > >       }
> > >
> > >       return ret;
> > > @@ -397,6 +426,7 @@ static void imx6_pcie_deassert_core_reset(struct
> > > imx6_pcie *imx6_pcie)  {
> > >       struct dw_pcie *pci = imx6_pcie->pci;
> > >       struct device *dev = pci->dev;
> > > +     unsigned int val;
> > >       int ret;
> > >
> > >       if (imx6_pcie->vpcie &&
> > > !regulator_is_enabled(imx6_pcie->vpcie)) { @@
> > > -445,6 +475,29 @@ static void imx6_pcie_deassert_core_reset(struct
> > > imx6_pcie *imx6_pcie)
> > >       }
> > >
> > >       switch (imx6_pcie->variant) {
> > > +     case IMX8MQ:
> > > +             reset_control_deassert(imx6_pcie->pciephy_reset);
> > > +             udelay(100);
> > > +             /*
> > > +              * Configure the CLK_REQ# high, let the L1SS
> > > +              * automatically controlled by HW.
> > > +              */
> > > +             reset_control_assert(imx6_pcie->apps_clk_req);
> > > +
> > > +             /*
> > > +              * Configure the L1 latency of rc to less than 64us
> > > +              * Otherwise, the L1/L1SUB wouldn't be enable by
> ASPM.
> > > +              */
> > > +             val = dw_pcie_readl_dbi(imx6_pcie->pci,
> > > +                                     SZ_1M +
> > > +
> IMX8MQ_PCIE_LINK_CAP_REG_OFFSET);
> > > +             val &= ~PCI_EXP_LNKCAP_L1EL;
> > > +             val |= IMX8MQ_PCIE_LINK_CAP_L1EL_64US;
> > > +             dw_pcie_writel_dbi(imx6_pcie->pci,
> > > +                                SZ_1M +
> > > +
> IMX8MQ_PCIE_LINK_CAP_REG_OFFSET,
> > > +                                val);
> > > +             break;
> > >       case IMX7D:
> > >               reset_control_deassert(imx6_pcie->pciephy_reset);
> > >               imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
> > > @@ -483,6 +536,15 @@ static void
> > > imx6_pcie_deassert_core_reset(struct
> > > imx6_pcie *imx6_pcie)  static void imx6_pcie_init_phy(struct
> > > imx6_pcie
> > > *imx6_pcie)  {
> > >       switch (imx6_pcie->variant) {
> > > +     case IMX8MQ:
> > > +             /*
> > > +              * TODO: Currently this code assumes external
> > > +              * oscillator is being used
> > > +              */
> > > +             regmap_update_bits(imx6_pcie->iomuxc_gpr,
> imx6_pcie->gpr1x,
> > > +
> IMX8MQ_GPR_PCIE_REF_USE_PAD,
> > > +
> IMX8MQ_GPR_PCIE_REF_USE_PAD);
> > > +             break;
> > >       case IMX7D:
> > >               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> IOMUXC_GPR12,
> > >
> IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > > 0); @@
> > > -519,7 +581,8 @@ static void imx6_pcie_init_phy(struct imx6_pcie
> > > *imx6_pcie)
> > >       }
> > >
> > >       regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > -                     IMX6Q_GPR12_DEVICE_TYPE,
> PCI_EXP_TYPE_ROOT_PORT <<
> > > 12);
> > > +                        imx6_pcie->device_type[0],
> > > +                        imx6_pcie->device_type[1]);
> > >  }
> > >
> > >  static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie) @@
> > > -528,7
> > > +591,8 @@ static int imx6_setup_phy_mpll(struct imx6_pcie
> > > +*imx6_pcie)
> > >       int mult, div;
> > >       u32 val;
> > >
> > > -     if (imx6_pcie->variant == IMX7D)
> > > +     if (imx6_pcie->variant == IMX7D ||
> > > +         imx6_pcie->variant == IMX8MQ)
> > >               return 0;
> > >
> > >       switch (phy_rate) {
> > > @@ -616,6 +680,7 @@ static void imx6_pcie_ltssm_enable(struct device
> > > *dev)
> > >                                  IMX6Q_GPR12_PCIE_CTL_2);
> > >               break;
> > >       case IMX7D:
> > > +     case IMX8MQ:            /* FALLTHROUGH */
> > >               reset_control_deassert(imx6_pcie->apps_reset);
> > >               break;
> > >       }
> > > @@ -798,10 +863,24 @@ static void imx6_pcie_clk_disable(struct
> > > imx6_pcie
> > > *imx6_pcie)
> > >       clk_disable_unprepare(imx6_pcie->pcie_phy);
> > >       clk_disable_unprepare(imx6_pcie->pcie_bus);
> > >
> > > -     if (imx6_pcie->variant == IMX7D) {
> > > +     switch (imx6_pcie->variant) {
> > > +     case IMX7D:
> > >               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> IOMUXC_GPR12,
> > >
> IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > >
> IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > > +             break;
> > > +     /*
> > > +      * Disable the override. Configure the CLK_REQ# high, let the
> > > +      * L1SS automatically controlled by HW when link is up.
> > > +      * Otherwise, turn off the REF_CLK to save power consumption.
> > > +      */
> > [Richard Zhu] About the L1SS support, there is a back-compatible issue.
> > When one none-L1SS capability EP device is used in one HW design solution.
> > In this case, EP device wouldn't manipulated its own CLK_REQ#.
> > The CLK_REQ# would be high when the override_en is disabled here.
> > That means the REFCLK would be turned off abnormally.
> > System would have problem when the REFCLK of PCIe is turned off
> abnormally after link is up.
> >
> 
> I don't have a lot of expertise in this area, so please take my comment with a
> grain of salt. The way I understand it, is in legacy systems that do not support
> L1SS with CLKREQ that feature shouldn't be enabled/used. Unless I've missed
> something, I think it should be possible to do so and disable the feature by
> configuring corresponding CLKREQ_B pad as GPIO and adding a GPIO hog
> node to pull CLKREQ low. Do you see any problems with this approach?
[Richard Zhu]Sorry to reply late. You're right. The L1SS shouldn't be enabled when
 L1SS none-supported EP device is inserted.
The CLKREQ# can be configured as INPUT and OD, I think.
But the L1SS capability should be figured out by SW in a proper mechanism.
And SW should enable the L1SS automatically refer to the capability.
I found the below notice in the L1SS ECN.
" 5. Analysis of the Software Implications
Capability discovery and enabling are required. 
"

> 
> Regardless though, I wasn't really planning on including PM support in this
> series. The code in question shouldn't even be in the patch since it'll never be
> executed because imx6_pcie_clk_disable() is only called by
> imx6_pcie_suspend_noirq() which is a no-op on all variants except i.MX7D.
> 
> I'll drop all of the unused PM-related bits I missed from the series and we can
> add them later in a separate submission.
> 
[Richard Zhu] Agree with that.
The PM feature can be added later in a standalone patch-set.
Thanks
Richard

> Thanks,
> Andrey Smirnov
