From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Nov 2018 14:18:16 +0100
Subject: [linux-sunxi] [PATCH v12 2/2] media: V3s: Add support for
 Allwinner CSI.
In-Reply-To: <CAMty3ZBa3XwQ-0CDYb69qny2MiaCfx1RiQZvQ+WhkoSonU5CbA@mail.gmail.com>
References: <1540887490-28316-1-git-send-email-yong.deng@magewell.com>
 <CAMty3ZAprBAxAm+=1kpFsbhV3XGvmQ8XEW+6mOcsV5iaR3xNyQ@mail.gmail.com>
 <CAMty3ZBa3XwQ-0CDYb69qny2MiaCfx1RiQZvQ+WhkoSonU5CbA@mail.gmail.com>
Message-ID: <20181120131816.sqwiiics7sannl7f@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 06:27:48PM +0530, Jagan Teki wrote:
> On Mon, Nov 19, 2018 at 5:38 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Tue, Oct 30, 2018 at 1:49 PM Yong Deng <yong.deng@magewell.com> wrote:
> > >
> > > Allwinner V3s SoC features a CSI module with parallel interface.
> > >
> > > This patch implement a v4l2 framework driver for it.
> > >
> > > Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>
> > > Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > Tested-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > Signed-off-by: Yong Deng <yong.deng@magewell.com>
> > > ---
> > >  MAINTAINERS                                        |   8 +
> > >  drivers/media/platform/Kconfig                     |   1 +
> > >  drivers/media/platform/Makefile                    |   2 +
> > >  drivers/media/platform/sunxi/sun6i-csi/Kconfig     |   9 +
> > >  drivers/media/platform/sunxi/sun6i-csi/Makefile    |   3 +
> > >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 915 +++++++++++++++++++++
> > >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h | 135 +++
> > >  .../media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h | 196 +++++
> > >  .../media/platform/sunxi/sun6i-csi/sun6i_video.c   | 678 +++++++++++++++
> > >  .../media/platform/sunxi/sun6i-csi/sun6i_video.h   |  38 +
> > >  10 files changed, 1985 insertions(+)
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/Kconfig
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/Makefile
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> > >  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 23021e0df5d7..42d73b35ed3e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3900,6 +3900,14 @@ M:       Jaya Kumar <jayakumar.alsa@gmail.com>
> > >  S:     Maintained
> > >  F:     sound/pci/cs5535audio/
> > >
> > > +CSI DRIVERS FOR ALLWINNER V3s
> > > +M:     Yong Deng <yong.deng@magewell.com>
> > > +L:     linux-media at vger.kernel.org
> > > +T:     git git://linuxtv.org/media_tree.git
> > > +S:     Maintained
> > > +F:     drivers/media/platform/sunxi/sun6i-csi/
> > > +F:     Documentation/devicetree/bindings/media/sun6i-csi.txt
> > > +
> > >  CW1200 WLAN driver
> > >  M:     Solomon Peachy <pizza@shaftnet.org>
> > >  S:     Maintained
> > > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> > > index 0edacfb01f3a..be6626ed0ec8 100644
> > > --- a/drivers/media/platform/Kconfig
> > > +++ b/drivers/media/platform/Kconfig
> > > @@ -138,6 +138,7 @@ source "drivers/media/platform/am437x/Kconfig"
> > >  source "drivers/media/platform/xilinx/Kconfig"
> > >  source "drivers/media/platform/rcar-vin/Kconfig"
> > >  source "drivers/media/platform/atmel/Kconfig"
> > > +source "drivers/media/platform/sunxi/sun6i-csi/Kconfig"
> >
> > [snip]
> >
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int sun6i_subdev_notify_complete(struct v4l2_async_notifier *notifier)
> > > +{
> > > +       struct sun6i_csi *csi = container_of(notifier, struct sun6i_csi,
> > > +                                            notifier);
> > > +       struct v4l2_device *v4l2_dev = &csi->v4l2_dev;
> > > +       struct v4l2_subdev *sd;
> > > +       int ret;
> > > +
> > > +       dev_dbg(csi->dev, "notify complete, all subdevs registered\n");
> > > +
> > > +       if (notifier->num_subdevs != 1)
> >
> > drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c: In function
> > ?sun6i_subdev_notify_complete?:
> > drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c:646:14: error:
> > ?struct v4l2_async_notifier? has no member named ?num_subdevs?
> 
> This build issues on linux-next, let me know you have next version
> changes for this, thanks.

This driver has been merged now, and you have a fix on the thread
starting from the cover letter of that very same version.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/ef1b53b3/attachment-0001.sig>
