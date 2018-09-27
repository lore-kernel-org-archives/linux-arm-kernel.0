From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 27 Sep 2018 22:16:56 +0800
Subject: [linux-sunxi] Re: [PATCH 04/12] drm/sun4i: sun6i_mipi_dsi: Enable
 missing DSI bus clock
In-Reply-To: <CAMty3ZBUQKVLJsmkU=hjaO_O5bhetDfAh9-7iLkUqOznVc0KyA@mail.gmail.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-5-jagan@amarulasolutions.com>
 <CAGb2v66No3-AODYCCGifBrm9uvPjaNdR2W5MDQdazRAPomT9CQ@mail.gmail.com>
 <CAMty3ZBUQKVLJsmkU=hjaO_O5bhetDfAh9-7iLkUqOznVc0KyA@mail.gmail.com>
Message-ID: <CAGb2v67pKgORe7uo6r6F+xaVi=Q-p6_DKotZJD7P=46Z=4RhEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 9:44 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Sep 27, 2018 at 6:13 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > Hi,
> >
> > On Thu, Sep 27, 2018 at 7:49 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > DSI bus_clk is already available in sun6i_dsi but missed to
> > > get the clk and process for enable/disable.
> > >
> > > This patch add support for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > index 8e9c76febca2..156b371243c6 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -1004,6 +1004,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > >                 return PTR_ERR(dsi->reset);
> > >         }
> > >
> > > +       dsi->bus_clk = devm_clk_get(dev, "bus");
> > > +       if (IS_ERR(dsi->bus_clk)) {
> > > +               dev_err(dev, "Couldn't get the DSI bus clock\n");
> > > +               return PTR_ERR(dsi->bus_clk);
> > > +       }
> > > +
> >
> > The DSI driver uses devm_regmap_init_mmio_clk, which enables the
> > clock behind the scenes when regmap access needs it enabled.
> >
> > Did you have any issues without this patch?
>
> I'm unable to read register values via devmem, I see all 0's for all
> dsi reg space.

Well that is to be expected given how mmio with clk regmap works.
Did you encounter any other problems besides this?

FYI you can dump regmap contents using /sys/kernel/debug/regmap/*/registers

ChenYu
