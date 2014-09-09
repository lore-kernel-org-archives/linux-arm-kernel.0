From: pza@pengutronix.de (Philipp Zabel)
Date: Tue, 9 Sep 2014 22:49:38 +0200
Subject: [PATCH v7 2/5] ARM: imx6: gpc: Add PU power domain for GPU/VPU
In-Reply-To: <CAPDyKFozmLLEwK297K0mtvf-m_fUC79ZstbF6V-TAnNTh41VZw@mail.gmail.com>
References: <1409060791-23167-1-git-send-email-p.zabel@pengutronix.de>
 <1409060791-23167-3-git-send-email-p.zabel@pengutronix.de>
 <CAPDyKFovJOVyKRNSA+sEjd4mXA9QYYYDQEAvTzkptj8FDzgWTQ@mail.gmail.com>
 <1410177246.3981.34.camel@paszta.hi.pengutronix.de>
 <CAPDyKFozmLLEwK297K0mtvf-m_fUC79ZstbF6V-TAnNTh41VZw@mail.gmail.com>
Message-ID: <20140909204938.GA26440@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 09:01:08PM +0200, Ulf Hansson wrote:
> [...]
> 
> >> > +       is_off = IS_ENABLED(CONFIG_PM_RUNTIME);
> >> > +       if (is_off)
> >> > +               imx6q_pm_pu_power_off(&imx6q_pu_domain.base);
> >>
> >> Could you elaborate why is_off depends on CONFIG_PM_RUNTIME? That
> >> seems strange to me. :-)
> >>
> >> Additionally, I think it would be better to leave the domain "on"
> >> state. Wouldn't that even be required for some drivers to be able to
> >> succeed probing of these devices?
> >
> > The devices in the PU power domain are Vivante GPUs and the CODA Video
> > Processing Unit. These are platform devices that don't need to be active
> > to enumerate before being probed. The drivers support runtime PM, so if
> > CONFIG_PM_RUNTIME is enabled, it is safe to disable the PU power domain
> > on boot. The drivers will probe and request for the power domain to be
> > enabled via runtime PM before accessing the hardware.
> >
> > If CONFIG_PM_RUNTIME is disabled, the power domain needs to stay enabled
> > at all times.
> 
> Hi Philipp,
> 
> Thanks for your reply, that certainly made it clear on what you would
> like to accomplish.
> 
> Before discussing further consequences in genpd of this approach
> (using IS_ENABLED(CONFIG_PM_RUNTIME)), I would be interested to see
> how the runtime PM support is implemented for any of the drivers you
> refer to. Do you mind pointing me to any of them?

Of course, the CODA driver is at drivers/media/platform/coda.c in mainline
kernels (moved to drivers/media/platform/coda-common.c in linux-next).

regards
Philipp
