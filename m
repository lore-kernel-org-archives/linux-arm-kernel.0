From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 May 2014 17:04:09 +0200
Subject: [linux-sunxi] [PATCH v2 3/7] phy: usb: sunxi: Introduce
 Allwinner A31 USB PHY support
In-Reply-To: <CAGb2v65Pstk6MqEeK838VUpNXw2cQH8K66Oo4oG3__zzWO3pig@mail.gmail.com>
References: <1399726619-30150-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399726619-30150-4-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65Pstk6MqEeK838VUpNXw2cQH8K66Oo4oG3__zzWO3pig@mail.gmail.com>
Message-ID: <20140512150409.GB17154@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 05:14:26PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Sat, May 10, 2014 at 8:56 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The USB phy controller in the A31 differs mostly from the older controllers
> > because it has a clock dedicated for each phy, while the older ones were having
> > a single clock for all the phys.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/phy/phy-sun4i-usb.c | 35 ++++++++++++++++++++++++++---------
> >  1 file changed, 26 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> > index e6e6c4ba7145..8bd89430d945 100644
> > --- a/drivers/phy/phy-sun4i-usb.c
> > +++ b/drivers/phy/phy-sun4i-usb.c
> > @@ -61,7 +61,6 @@
> >  #define MAX_PHYS                       3
> >
> >  struct sun4i_usb_phy_data {
> > -       struct clk *clk;
> >         void __iomem *base;
> >         struct mutex mutex;
> >         int num_phys;
> > @@ -71,6 +70,7 @@ struct sun4i_usb_phy_data {
> >                 void __iomem *pmu;
> >                 struct regulator *vbus;
> >                 struct reset_control *reset;
> > +               struct clk *clk;
> >                 int index;
> >         } phys[MAX_PHYS];
> >  };
> > @@ -146,13 +146,13 @@ static int sun4i_usb_phy_init(struct phy *_phy)
> >         struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
> >         int ret;
> >
> > -       ret = clk_prepare_enable(data->clk);
> > +       ret = clk_prepare_enable(phy->clk);
> >         if (ret)
> >                 return ret;
> >
> >         ret = reset_control_deassert(phy->reset);
> >         if (ret) {
> > -               clk_disable_unprepare(data->clk);
> > +               clk_disable_unprepare(phy->clk);
> >                 return ret;
> >         }
> >
> > @@ -170,11 +170,10 @@ static int sun4i_usb_phy_init(struct phy *_phy)
> >  static int sun4i_usb_phy_exit(struct phy *_phy)
> >  {
> >         struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> > -       struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
> >
> >         sun4i_usb_phy_passby(phy, 0);
> >         reset_control_assert(phy->reset);
> > -       clk_disable_unprepare(data->clk);
> > +       clk_disable_unprepare(phy->clk);
> >
> >         return 0;
> >  }
> > @@ -228,8 +227,10 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
> >         struct phy_provider *phy_provider;
> >         struct reset_control *reset;
> >         struct regulator *vbus;
> > +       bool dedicated_clocks;
> 
> No default?
> 
> >         struct resource *res;
> >         struct phy *phy;
> > +       struct clk *clk;
> >         char name[16];
> >         int i;
> >
> > @@ -249,15 +250,20 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
> >         else
> >                 data->disc_thresh = 2;
> >
> > +       if (of_device_is_compatible(np, "allwinner,sun6i-a31-usb-phy"))
> > +               dedicated_clocks = true;
> > +
> 
> dedicated_clocks is more than likely to be true from leftover data
> on the stack. This results in the usb phy driver probe failing, and
> the usb host drivers left in perpetual probe deferral on my Cubietruck.
> 
> Adding an else section fixes this.

Oh, yes. Stupid me. It used to be in a kzalloc'd section, so I didn't
have the error, and didn't properly test it because it was trivial.

Thanks for catching this, I'll submit a v3.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140512/731dfb57/attachment.sig>
