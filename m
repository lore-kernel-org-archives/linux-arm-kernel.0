From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 25 Jan 2013 14:15:29 +0000
Subject: [PATCH 1/4] drm/tilcdc: add TI LCD Controller DRM driver (v3)
In-Reply-To: <CAF6AEGsqkUr0R3eYa4P371tUPq_NLSJLhH=N_MkyJF31s068+g@mail.gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-2-git-send-email-robdclark@gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA939BB@DBDE01.ent.ti.com>
 <CAF6AEGsqkUr0R3eYa4P371tUPq_NLSJLhH=N_MkyJF31s068+g@mail.gmail.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA93A7D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Jan 25, 2013 at 19:29:40, Rob Clark wrote:
> On Fri, Jan 25, 2013 at 7:19 AM, Mohammed, Afzal <afzal@ti.com> wrote:
> > On Wed, Jan 23, 2013 at 04:06:22, Rob Clark wrote:

> >> A simple DRM/KMS driver for the TI LCD Controller found in various
> >> smaller TI parts (AM33xx, OMAPL138, etc).  This driver uses the

> >> +void tilcdc_crtc_update_clk(struct drm_crtc *crtc)
> >
> >> +     /* in raster mode, minimum divisor is 2: */
> >> +     ret = clk_set_rate(priv->disp_clk, crtc->mode.clock * 1000 * 2);

> > These things can better be handled with divider clock having a
> > minimum value (being discussed with Mike on how exactly it should
> > be) and instead of setting rate over a platform specific clock,
> > you can set rate over lcd clock using SET_RATE_PARENT at platform
> > level, more below,

> I looked at that patch you were proposing for da8xx-fb..  to be
> honest, it did not seem simpler to me, so I was sort of failing to see
> the benefit..

It's not about being simple, but not doing the wrong way, here you are
relying on a platform specific clock in a driver, think about the case
where same IP is used on another platform. Either way it is not a good
thing to handle platform specific details (about disp_clk) in driver.

And Mike mentioned that one of design goals of CCF is to model these
kinds of clocks in IP's.

> >> +     /* Configure the LCD clock divisor. */
> >> +     tilcdc_write(dev, LCDC_CTRL_REG, LCDC_CLK_DIVISOR(div) |
> >> +                     LCDC_RASTER_MODE);
> >> +
> >> +     if (priv->rev == 2)
> >> +             tilcdc_set(dev, LCDC_CLK_ENABLE_REG,
> >> +                             LCDC_V2_DMA_CLK_EN | LCDC_V2_LIDD_CLK_EN |
> >> +                             LCDC_V2_CORE_CLK_EN);
> >
> > Mike was suggesting to model the above using gate/divider/composite
> > clocks of CCF in the FB driver.

> >> +     priv->clk = clk_get(dev->dev, "fck");
> >> +     if (IS_ERR(priv->clk)) {
> >> +             dev_err(dev->dev, "failed to get functional clock\n");
> >> +             ret = -ENODEV;
> >> +             goto fail;
> >> +     }
> >> +
> >> +     priv->disp_clk = clk_get(dev->dev, "dpll_disp_ck");
> >> +     if (IS_ERR(priv->clk)) {
> >> +             dev_err(dev->dev, "failed to get display clock\n");
> >> +             ret = -ENODEV;
> >> +             goto fail;
> >> +     }
> >
> > "dpll_disp_ck" is a platform specific matter, driver should not
> > be handling platform specifics. And this won't work on DaVinci,
> > you can probably make use of
> 
> meaning the clock has a different name on davinci, or?  Presumably
> there must be some clock generating the pixel clock for the display,
> but I confess to not being too familiar with the details on davinci..

The only option for the driver in DaVinci is to configure clock rate
using the divider of LCDC IP, it has "fck", which gives a rate
decided by its ancestors.

Regards
Afzal
