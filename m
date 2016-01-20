From: henryc.chen@mediatek.com (Henry Chen)
Date: Wed, 20 Jan 2016 19:11:52 +0800
Subject: [PATCH] soc: mediatek: PMIC wrap: clear the STAUPD_TRIG bit of
 WDT_SRC_EN
In-Reply-To: <CAGS+omCFOUgTHxeUn0snrkBjvcR1bSOAAmkBHppF8nM37P1vrw@mail.gmail.com>
References: <1453265564-16379-1-git-send-email-henryc.chen@mediatek.com>
 <CAGS+omCFOUgTHxeUn0snrkBjvcR1bSOAAmkBHppF8nM37P1vrw@mail.gmail.com>
Message-ID: <1453288312.8457.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-01-20 at 02:32 -0800, Daniel Kurtz wrote:
> On Tue, Jan 19, 2016 at 8:52 PM, Henry Chen <henryc.chen@mediatek.com> wrote:
> > Since STAUPD interrupts aren't handled on mt8173, disable watchdog timeout
> > monitor of STAUPD to avoid WDT_INT triggered by STAUPD.
> >
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> 
> > ---
> >  drivers/soc/mediatek/mtk-pmic-wrap.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> > index af919b1..998f561 100644
> > --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> > +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> > @@ -60,6 +60,15 @@
> >  #define PWRAP_MAN_CMD_OP_OUTD          (0x9 << 8)
> >  #define PWRAP_MAN_CMD_OP_OUTQ          (0xa << 8)
> >
> > +/* macro for Watch Dog Timer Source */
> > +#define PWRAP_WDT_SRC_EN_STAUPD_TRIG           (1 << 25)
> > +#define PWRAP_WDT_SRC_EN_HARB_STAUPD_DLE       (1 << 20)
> > +#define PWRAP_WDT_SRC_EN_HARB_STAUPD_ALE       (1 << 6)
> > +#define PWRAP_WDT_SRC_MASK_ALL                 0xffffffff
> > +#define PWRAP_WDT_SRC_MASK_NO_STAUPD   ~(PWRAP_WDT_SRC_EN_STAUPD_TRIG | \
> > +                                         PWRAP_WDT_SRC_EN_HARB_STAUPD_DLE | \
> > +                                         PWRAP_WDT_SRC_EN_HARB_STAUPD_ALE)
> > +
> >  /* macro for slave device wrapper registers */
> >  #define PWRAP_DEW_BASE                 0xbc00
> >  #define PWRAP_DEW_EVENT_OUT_EN         (PWRAP_DEW_BASE + 0x0)
> > @@ -830,7 +839,7 @@ MODULE_DEVICE_TABLE(of, of_pwrap_match_tbl);
> >
> >  static int pwrap_probe(struct platform_device *pdev)
> >  {
> > -       int ret, irq;
> > +       int ret, irq, wdt_src;
> >         struct pmic_wrapper *wrp;
> >         struct device_node *np = pdev->dev.of_node;
> >         const struct of_device_id *of_id =
> > @@ -920,7 +929,13 @@ static int pwrap_probe(struct platform_device *pdev)
> >
> >         /* Initialize watchdog, may not be done by the bootloader */
> >         pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
> > -       pwrap_writel(wrp, 0xffffffff, PWRAP_WDT_SRC_EN);
> > +       /*
> > +        * Since STAUPD was not used on mt8173 platform,
> > +        * so STAUPD of WDT_SRC which should be turned off
> > +        */
> 
> It is a little awkward that "!pwrap_is_mt8135(wrp)" means mt8173.  Is
> this always true?
> Why aren't we clearing STAUPD for mt8135 too?
> I assume it is because mt8135 does not define this bit?
> What about other devices that are not mt8135 or mt8173?

MT8135 used STAUPD because it have pwrap event pin and it was different
with mt8173. pwrap event have been removed on mt8173, so it no need to
set STAUPD.

Henry

> Perhaps change the comment to:
> "This driver does not use STAUPD, so clear this WDT SRC for all
> devices for which it exists to avoid unhandled interrupts"
> 

> Other than that, this patch is:
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> 
> > +       wdt_src = pwrap_is_mt8135(wrp) ?
> > +                       PWRAP_WDT_SRC_MASK_ALL : PWRAP_WDT_SRC_MASK_NO_STAUPD;
> > +       pwrap_writel(wrp, wdt_src, PWRAP_WDT_SRC_EN);
> >         pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
> >         pwrap_writel(wrp, ~((1 << 31) | (1 << 1)), PWRAP_INT_EN);
> >
> > --
> > 1.8.1.1.dirty
> >
