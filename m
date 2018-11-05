From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Nov 2018 09:34:05 +0100
Subject: [PATCH v3 16/25] drm/sun4i: sun6i_mipi_dsi: Add support for
 VCC-DSI voltage regulator
In-Reply-To: <CAMty3ZBky1kP-1Q+ja2BpcbTxdHgQOFn=T4bcnZwMz6zP+AcOQ@mail.gmail.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-17-jagan@amarulasolutions.com>
 <20181029093142.hgn4q6o7q32voutf@flea>
 <CAMty3ZBky1kP-1Q+ja2BpcbTxdHgQOFn=T4bcnZwMz6zP+AcOQ@mail.gmail.com>
Message-ID: <20181105083405.zhhnulfsyyvlzusf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 08:18:05PM +0530, Jagan Teki wrote:
> On Mon, Oct 29, 2018 at 3:01 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Oct 26, 2018 at 08:13:35PM +0530, Jagan Teki wrote:
> > > Some boards have VCC-DSI pin connected to voltage regulator which may
> > > not be turned on by default.
> > >
> > > Add support for such boards by adding voltage regulator handling code to
> > > MIPI DSI driver.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > Tested-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v3:
> > > - new patch
> > > Changes for v2:
> > > - none
> > >
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
> > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  3 +++
> > >  2 files changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > index 42bd7506abaf..bc57343592e0 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -949,6 +949,12 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
> > >
> > >       dsi->drv = drv;
> > >
> > > +     ret = regulator_enable(dsi->regulator);
> > > +     if (ret) {
> > > +             dev_err(dev, "Failed to enable regulator\n");
> > > +             return ret;
> > > +     }
> > > +
> >
> > The regulator should be enabled only when the device is in use.
> 
> True, but there is no device specific quirk needed because who ever
> not needed simply use dummy regulator
> [    0.245821] sun6i-mipi-dsi 1ca0000.dsi: 1ca0000.dsi supply vcc-dsi
> not found, using dummy regulato
> r
> 
> even like HVCC in hdmi driver [1]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c?id=633ba1e086e1abbeef1ffd899911de8cf3987d9f

That's not my point. You should enable the regulator only when the DSI
bridge is being enabled, not when the driver has probed.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/f4803c60/attachment.sig>
