From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 21 Dec 2015 20:45:38 +0800
Subject: [PATCH] pinctrl: mediatek: convert to arch_initcall
In-Reply-To: <1450701598.6795.11.camel@mtksdaap41>
References: <1450412497-25872-1-git-send-email-djkurtz@chromium.org>
 <1450451196.19539.9.camel@mtksdaap41>
 <CAGS+omCDxj_wMDiAiywSv4hAtq6E9vm+CxgG8gs1TmrrS499mQ@mail.gmail.com>
 <1450701598.6795.11.camel@mtksdaap41>
Message-ID: <CAGS+omBX2hXXaLfnHQboMXEcQnzO8TV33DRqWq80DPaNHEW=Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 8:39 PM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
>
> On Mon, 2015-12-21 at 14:51 +0800, Daniel Kurtz wrote:
> > On Fri, Dec 18, 2015 at 11:06 PM, Yingjoe Chen
> > <yingjoe.chen@mediatek.com> wrote:
> > > On Fri, 2015-12-18 at 12:21 +0800, Daniel Kurtz wrote:
> > >> Move pinctrl initialization earlier in boot so that real devices can find
> > >> their pctldev without probe deferring.
> > >>
> > >> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > >> ---
> > >>  drivers/pinctrl/mediatek/pinctrl-mt6397.c | 2 +-
> > >>  drivers/pinctrl/mediatek/pinctrl-mt8127.c | 2 +-
> > >>  drivers/pinctrl/mediatek/pinctrl-mt8135.c | 2 +-
> > >>  drivers/pinctrl/mediatek/pinctrl-mt8173.c | 2 +-
> > >>  4 files changed, 4 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6397.c b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
> > >> index f9751ae..a3780d4 100644
> > >> --- a/drivers/pinctrl/mediatek/pinctrl-mt6397.c
> > >> +++ b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
> > >> @@ -70,7 +70,7 @@ static int __init mtk_pinctrl_init(void)
> > >>       return platform_driver_register(&mtk_pinctrl_driver);
> > >>  }
> > >>
> > >> -module_init(mtk_pinctrl_init);
> > >> +arch_initcall(mtk_pinctrl_init);
> > >
> > >
> > > MT6397 is PMIC, which depends on pwrap on main AP to work. Since
> > > pmic-wrap itself is module_platform_driver, I think it make sense to
> > > keep this one as module_init. Maybe adding a comment to explain why it
> > > is different from others will help.
> >
> > I interpret this the other way - I think that since the PMIC wrapper
> > provides a bus required for the system PMIC it should also be a
> > builtin and use arch_initcall.
>
> We'll have to change mt8173 PMIC wrapper and mt6397 MFD core to
> arch_initcall if we want to do it.
>
> I think regulators on PMIC is more important than pinctrl. For all
> mt8173 systems, few drivers depends on PMIC pinctrl to work but many
> depends on the regulators. So if we adjust pinctrl to arch_initcall, we
> should change mt6397 regulator as well.

ACK to changing all of mt6397 to arch_initcall, especially the regulators.
