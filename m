From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Jun 2015 09:45:29 +0200
Subject: [PATCH 3/5] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <CAPDyKFpY+agi_JyuP2iGB+7HPoTuwHi2iC1D2YCsGnNfZhevNw@mail.gmail.com>
References: <1433839623-10804-1-git-send-email-s.hauer@pengutronix.de>
 <1433839623-10804-4-git-send-email-s.hauer@pengutronix.de>
 <CAPDyKFpY+agi_JyuP2iGB+7HPoTuwHi2iC1D2YCsGnNfZhevNw@mail.gmail.com>
Message-ID: <20150615074529.GQ6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Wed, Jun 10, 2015 at 04:47:01PM +0200, Ulf Hansson wrote:
> On 9 June 2015 at 10:47, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > This adds a power domain driver for the Mediatek SCPSYS unit.
> >
> > The System Control Processor System (SCPSYS) has several power
> > management related tasks in the system. The tasks include thermal
> > measurement, dynamic voltage frequency scaling (DVFS), interrupt
> > filter and lowlevel sleep control. The System Power Manager (SPM)
> > inside the SCPSYS is for the MTCMOS power domain control.
> >
> > For now this driver only adds power domain support, the more
> > advanced features are not yet supported. The driver implements
> > the generic PM domain device tree bindings, the first user will
> > most likely be the Mediatek AFE audio driver.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/soc/mediatek/Kconfig             |   9 +
> >  drivers/soc/mediatek/Makefile            |   1 +
> >  drivers/soc/mediatek/mtk-scpsys.c        | 490 +++++++++++++++++++++++++++++++
> >  include/dt-bindings/power/mt8173-power.h |  15 +
> >  4 files changed, 515 insertions(+)
> >  create mode 100644 drivers/soc/mediatek/mtk-scpsys.c
> >  create mode 100644 include/dt-bindings/power/mt8173-power.h
> >
> > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > index e4f37a3..9a61b54 100644
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> > @@ -18,3 +18,12 @@ config MTK_PMIC_WRAP
> >           Say yes here to add support for MediaTek PMIC Wrapper found
> >           on different MediaTek SoCs. The PMIC wrapper is a proprietary
> >           hardware to connect the PMIC.
> > +
> > +config MTK_SCPSYS
> > +       bool "MediaTek SCPSYS Support"
> > +       depends on ARCH_MEDIATEK || COMPILE_TEST
> 
> How about also depending on "PM" and selecting PM_GENERIC_DOMAINS,
> would that work?

That's what patch 4/5 does. So far all drivers have this in
arch/arm/mach-*/Kconfig and so did I. However, they probably have it
under arch/ to have it next to the driver. I'll move it here and drop
4/5.

> > +static int scpsys_power_on(struct generic_pm_domain *genpd)
> > +{
> > +       struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
> > +       struct scp *scp = scpd->scp;
> > +       unsigned long timeout;
> > +       bool expired;
> > +       void __iomem *ctl_addr = scpd->ctl_addr;
> > +       u32 sram_pdn_ack = scpd->sram_pdn_ack_bits;
> > +       u32 val;
> > +       int ret;
> > +
> > +       if (scpd->clk) {
> 
> Shouldn't you check for !IS_ERR(scpd->clk) instead?

No. scpd->clk is initialized like this:

		if (data->clk_id != MT8173_CLK_NONE)
			scpd->clk = scp->clk[data->clk_id];

So scpd->clk will never be an ERR_PTR but always NULL if unset.

> 
> > +               ret = clk_prepare_enable(scpd->clk);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       val = readl(ctl_addr);
> > +       val |= PWR_ON_BIT;
> > +       writel(val, ctl_addr);
> > +       val |= PWR_ON_2ND_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       /* wait until PWR_ACK = 1 */
> > +       timeout = jiffies + HZ;
> > +       expired = false;
> > +       while (1) {
> > +               ret = scpsys_domain_is_on(scpd);
> > +               if (ret > 0)
> > +                       break;
> > +
> > +               if (expired) {
> > +                       ret = -ETIMEDOUT;
> > +                       goto out;
> > +               }
> > +
> > +               cpu_relax();
> > +
> > +               if (time_after(jiffies, timeout))
> > +                       expired = true;
> > +       }
> > +
> > +       val &= ~PWR_CLK_DIS_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       val &= ~PWR_ISO_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       val |= PWR_RST_B_BIT;
> > +       writel(val, ctl_addr);
> > +
> > +       val &= ~scpd->sram_pdn_bits;
> > +       writel(val, ctl_addr);
> > +
> > +       /* wait until SRAM_PDN_ACK all 0 */
> > +       timeout = jiffies + HZ;
> > +       expired = false;
> > +       while (sram_pdn_ack && (readl(ctl_addr) & sram_pdn_ack)) {
> > +
> > +               if (expired) {
> > +                       ret = -ETIMEDOUT;
> > +                       goto out;
> > +               }
> > +
> > +               cpu_relax();
> > +
> > +               if (time_after(jiffies, timeout))
> > +                       expired = true;
> > +       }
> > +
> > +       if (scpd->bus_prot_mask) {
> > +               ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> > +                               scpd->bus_prot_mask);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       return 0;
> > +out:
> 
> There are no error handling. Especially the clock should be gated.

I'll disable the clock in the error path for the next round. Apart from
that I think I cannot implement a proper error handling without knowing
what actually went wrong. I mean I ask the hardware to do something
and then poll for a bit to get the ack from the hardware. If that ack
doesn't come I don't know what to do to recover from this state. A I2C
controller or such could probably be resetted in this situation, but a
power domain controller?

> > +       writel(val, ctl_addr);
> > +
> > +       /* wait until PWR_ACK = 0 */
> > +       timeout = jiffies + HZ;
> > +       expired = false;
> > +       while (1) {
> > +               ret = scpsys_domain_is_on(scpd);
> > +               if (ret == 0)
> > +                       break;
> > +
> > +               if (expired) {
> > +                       ret = -ETIMEDOUT;
> > +                       goto out;
> > +               }
> > +
> > +               cpu_relax();
> > +
> > +               if (time_after(jiffies, timeout))
> > +                       expired = true;
> > +       }
> > +
> > +       if (scpd->clk)
> 
> Shouldn't you check for !IS_ERR(scpd->clk) instead?

No, as above.

> > +               return -ENOMEM;
> > +
> > +       scp->clk[MT8173_CLK_MM] = devm_clk_get(&pdev->dev, "mm");
> > +       if (IS_ERR(scp->clk[MT8173_CLK_MM])) {
> > +               dev_err(&pdev->dev, "Failed to get mm clk: %ld\n",
> > +                               PTR_ERR(scp->clk[MT8173_CLK_MM]));
> 
> I think a similar error message is already printed by the common clk framework!?
> 
> > +               return PTR_ERR(scp->clk[MT8173_CLK_MM]);
> > +       }
> > +
> > +       scp->clk[MT8173_CLK_MFG] = devm_clk_get(&pdev->dev, "mfg");
> > +       if (IS_ERR(scp->clk[MT8173_CLK_MFG])) {
> > +               dev_err(&pdev->dev, "Failed to get mfg clk: %ld\n",
> > +                               PTR_ERR(scp->clk[MT8173_CLK_MFG]));
> 
> I think a similar error message is already printed by the common clk framework!?

Yes, will drop these messages.

> 
> > +               return PTR_ERR(scp->clk[MT8173_CLK_MFG]);
> > +       }
> > +
> > +       scp->infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> > +                       "infracfg");
> > +       if (IS_ERR(scp->infracfg)) {
> > +               dev_err(&pdev->dev, "Cannot find infracfg controller: %ld\n",
> > +                               PTR_ERR(scp->infracfg));
> > +               return PTR_ERR(scp->infracfg);
> > +       }
> > +
> > +       pd_data->num_domains = NUM_DOMAINS;
> > +
> > +       for (i = 0; i < NUM_DOMAINS; i++) {
> > +               struct scp_domain *scpd = &scp->domains[i];
> > +               struct generic_pm_domain *genpd = &scpd->genpd;
> > +               const struct scp_domain_data *data = &scp_domain_data[i];
> > +
> > +               pd_data->domains[i] = genpd;
> > +               scpd->scp = scp;
> > +
> > +               scpd->sta_mask = data->sta_mask;
> > +               scpd->ctl_addr = scp->base + data->ctl_offs;
> > +               scpd->sram_pdn_bits = data->sram_pdn_bits;
> > +               scpd->sram_pdn_ack_bits = data->sram_pdn_ack_bits;
> > +               scpd->bus_prot_mask = data->bus_prot_mask;
> > +               if (data->clk_id != MT8173_CLK_NONE)
> > +                       scpd->clk = scp->clk[data->clk_id];
> 
> This seems odd. Why do you need to have an array of clocks to deal
> with this assignment?
> 
> I don't find that the struct scp->clk pointer is used but from this
> place. Couldn't you just fetch a reference to the clock to a local
> struct *clk, without caching it in the struct scp->clk?

Yes, will change.

Thanks for reviewing.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
