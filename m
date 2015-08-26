From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 26 Aug 2015 14:55:08 +0800
Subject: [PATCH v2] soc: mediatek: add scpsys support active_wakeup
In-Reply-To: <CAGS+omBqTbcJk-6QvupV4tkB5WQm97zpb5NzZ-S2ivR-UEWF4g@mail.gmail.com>
References: <1440482440-28700-1-git-send-email-eddie.huang@mediatek.com>
 <CAGS+omBqTbcJk-6QvupV4tkB5WQm97zpb5NzZ-S2ivR-UEWF4g@mail.gmail.com>
Message-ID: <1440572108.28149.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-08-26 at 05:11 +0800, Daniel Kurtz wrote:
> Hi Eddie,
> 
> On Tue, Aug 25, 2015 at 2:00 PM, Eddie Huang <eddie.huang@mediatek.com> wrote:
> > Register gpd_dev_ops.active_wakeup function to support keep power
> > during suspend state. And add flag to each power domain to
> > decide whether keep power during suspend or not.
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > ---
> > Change in v2:
> > Drop .active_wakeup = false lines in scp_domain_data[] array
> >
> > ---
> >  drivers/soc/mediatek/mtk-scpsys.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index 43a79ed..df2f288 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -67,6 +67,7 @@ struct scp_domain_data {
> >         u32 sram_pdn_ack_bits;
> >         u32 bus_prot_mask;
> >         enum clk_id clk_id;
> > +       bool active_wakeup;
> >  };
> >
> >  static const struct scp_domain_data scp_domain_data[] __initconst = {
> > @@ -127,6 +128,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
> >                 .sram_pdn_bits = GENMASK(11, 8),
> >                 .sram_pdn_ack_bits = GENMASK(15, 12),
> >                 .clk_id = MT8173_CLK_NONE,
> > +               .active_wakeup = true,
> >         },
> >         [MT8173_POWER_DOMAIN_MFG_ASYNC] = {
> >                 .name = "mfg_async",
> > @@ -171,6 +173,7 @@ struct scp_domain {
> >         u32 sram_pdn_bits;
> >         u32 sram_pdn_ack_bits;
> >         u32 bus_prot_mask;
> > +       bool active_wakeup;
> >  };
> >
> >  struct scp {
> > @@ -370,6 +373,20 @@ out:
> >         return ret;
> >  }
> >
> > +static bool scpsys_active_wakeup(struct device *dev)
> > +{
> > +       struct generic_pm_domain *genpd;
> > +       struct scp_domain *scpd;
> > +
> > +       if (IS_ERR_OR_NULL(dev->pm_domain))
> > +               return false;
> 
> Is it really possible to get here w/ pm_domain as an ERR or NULL?
> If the power core can ensure this cannot happen, then this function
> could be a bit simpler.
> 
> Other than that, this patch is:
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> 
> -Dan
> 

After checking drivers/base/power/domain.c, I believe check
dev->pm_domain here is redundant, I will remove it.

Eddie
Thanks
