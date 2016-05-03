From: nicoleotsuka@gmail.com (Nicolin Chen)
Date: Tue, 3 May 2016 12:52:31 -0700
Subject: mx6ul: Finding a good place to configure SAI2_MCLK
In-Reply-To: <20160503124203.GH5874@tiger>
References: <CAOMZO5CvT1rcHFPm6KoCBBgM1UACByLUQcJ_zDxY9ucbxCpgYA@mail.gmail.com>
 <20160503124203.GH5874@tiger>
Message-ID: <20160503195230.GA25881@Asurada-Nvidia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 08:42:03PM +0800, Shawn Guo wrote:
> On Mon, May 02, 2016 at 08:59:17PM -0300, Fabio Estevam wrote:
> > Hi,
> > 
> > In order to get audio working on imx6ul-evk board we need to enable
> > the SAI2 MCLK clock by setting bit 20 (SAI2_MCLK_DIR) of the
> > IOMUXC_GPR_GPR1 register.
> > 
> > I am not sure where is the appropriate place to set this bit.
> > 
> > Doing like this works fine:
> > 
> > --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > @@ -447,5 +447,6 @@
> >  #define IMX6UL_GPR1_ENET2_CLK_OUTPUT           (0x1 << 18)
> >  #define IMX6UL_GPR1_ENET_CLK_DIR               (0x3 << 17)
> >  #define IMX6UL_GPR1_ENET_CLK_OUTPUT            (0x3 << 17)
> > +#define IMX6UL_GPR1_SAI2_MCLK_DIR              (0x1 << 20)
> > 
> > index a38b16b..92cfb0f 100644
> > --- a/arch/arm/mach-imx/mach-imx6ul.c
> > +++ b/arch/arm/mach-imx/mach-imx6ul.c
> > @@ -56,6 +56,19 @@ static inline void imx6ul_enet_init(void)
> >         imx6ul_enet_phy_init();
> >  }
> > 
> > +static void __init imx6ul_mclk_init(void)
> > +{
> > +       struct regmap *gpr;
> > +
> > +       gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
> > +       if (!IS_ERR(gpr))
> > +               regmap_update_bits(gpr, IOMUXC_GPR1, IMX6UL_GPR1_SAI2_MCLK_DIR,
> > +                                  IMX6UL_GPR1_SAI2_MCLK_DIR);
> > +       else
> > +               pr_err("failed to find fsl,imx6ul-iomux-gpr regmap\n");
> > +
> > +}
> > +
> >  static void __init imx6ul_init_machine(void)
> >  {
> >         struct device *parent;
> > @@ -68,6 +81,7 @@ static void __init imx6ul_init_machine(void)
> >         imx6ul_enet_init();
> >         imx_anatop_init();
> >         imx6ul_pm_init();
> > +       imx6ul_mclk_init();
> >  }
> > 
> > but it does not seem correct as this should be board specific. Should
> > we call it only if the compatible string matches imx6sl-14x14-evk
> > string? Looks like that will not scale as well.
> > 
> > Currently in arch/arm/mach-imx/mach-imx6ul.c we also have
> > imx6ul_enet_clk_init() function which sets the ENET_CLK in the GPR1
> > register.
> > 
> > IMHO this is not correct because not all mx6ul boards need such clock
> > and then we need to change this too.
> > 
> > So where should we set the SAI2_MCLK_DIR bit of GPR1? Inside the SAI driver?
> 
> To me, it's the best if we can handle this in SAI driver.

Since the clock relationships are being handled by DT now, I feel
plausible to put this GPR hack in an audio driver, SAI or machine.

For SAI driver, it requires a DT property to indicate whether the
controller has the capability of getting/driving the MCLK from/to
the pad because it may not have this GPR hack, SAI1 for example.
Meanwhile, ASoC has a set_dai_sysclk() to configure the direction
of sysclk (MCLK).

> 
> Shawn
> 
> > 
> > Appreciate some feedback.
> > 
> > Thanks,
> > 
> > Fabio Estevam
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
