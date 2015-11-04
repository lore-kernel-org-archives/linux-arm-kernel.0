From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 05 Nov 2015 00:55:10 +0100
Subject: [PATCH 2/8] phy: rockchip-usb: introduce a common data-struct for
 the device
In-Reply-To: <CAD=FV=Uf0w0buknqwvW+ufao64m78i3B7Goza2pGCkjDSPU0tA@mail.gmail.com>
References: <1446673454-9529-1-git-send-email-heiko@sntech.de>
 <1446673454-9529-3-git-send-email-heiko@sntech.de>
 <CAD=FV=Uf0w0buknqwvW+ufao64m78i3B7Goza2pGCkjDSPU0tA@mail.gmail.com>
Message-ID: <6210861.uglufxBnXQ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 4. November 2015, 15:46:04 schrieb Doug Anderson:
> Hi,
> 
> On Wed, Nov 4, 2015 at 1:44 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> > This introduces a common struct that holds data belonging to
> > the umbrella device that contains all the phys and that we
> > want to use later.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  drivers/phy/phy-rockchip-usb.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
> > index dfc056b..dda1994 100644
> > --- a/drivers/phy/phy-rockchip-usb.c
> > +++ b/drivers/phy/phy-rockchip-usb.c
> > @@ -36,9 +36,14 @@
> >  #define SIDDQ_ON               BIT(13)
> >  #define SIDDQ_OFF              (0 << 13)
> >
> > +struct rockchip_usb_phy_base {
> > +       struct device *dev;
> > +       struct regmap *reg_base;
> > +};
> > +
> >  struct rockchip_usb_phy {
> > +       struct rockchip_usb_phy_base *base;
> >         unsigned int    reg_offset;
> > -       struct regmap   *reg_base;
> >         struct clk      *clk;
> >         struct phy      *phy;
> >  };
> > @@ -46,7 +51,7 @@ struct rockchip_usb_phy {
> >  static int rockchip_usb_phy_power(struct rockchip_usb_phy *phy,
> >                                            bool siddq)
> >  {
> > -       return regmap_write(phy->reg_base, phy->reg_offset,
> > +       return regmap_write(phy->base->reg_base, phy->reg_offset,
> >                             SIDDQ_WRITE_ENA | (siddq ? SIDDQ_ON : SIDDQ_OFF));
> >  }
> >
> > @@ -101,17 +106,23 @@ static void rockchip_usb_phy_action(void *data)
> >  static int rockchip_usb_phy_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> > +       struct rockchip_usb_phy_base *phy_base;
> >         struct rockchip_usb_phy *rk_phy;
> >         struct phy_provider *phy_provider;
> >         struct device_node *child;
> > -       struct regmap *grf;
> >         unsigned int reg_offset;
> >         int err;
> >
> > -       grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,grf");
> > -       if (IS_ERR(grf)) {
> > +       phy_base = devm_kzalloc(dev, sizeof(*phy_base), GFP_KERNEL);
> > +       if (!phy_base)
> > +               return -ENOMEM;
> > +
> > +       phy_base->dev = dev;
> > +       phy_base->reg_base = syscon_regmap_lookup_by_phandle(dev->of_node,
> > +                                                            "rockchip,grf");
> > +       if (IS_ERR(phy_base->reg_base)) {
> >                 dev_err(&pdev->dev, "Missing rockchip,grf property\n");
> > -               return PTR_ERR(grf);
> > +               return PTR_ERR(phy_base->reg_base);
> >         }
> >
> >         for_each_available_child_of_node(dev->of_node, child) {
> > @@ -126,7 +137,6 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
> >                 }
> >
> >                 rk_phy->reg_offset = reg_offset;
> > -               rk_phy->reg_base = grf;
> 
> I'm probably missing something, but I would have expected a line line:
> 
>   rk_phy->base = phy_base;
> 
> Otherwise how does "base" get assigned?  Ah, I see.  You forgot it in
> this patch and then cheated and slipped it in in patch #3.  ;)  For
> nice bisectability it probably belongs here, too...

Thanks for that catch and yep, it should definitly be here too. While
I did a compile-test for the individual steps, I guess I did not do
runtime tests for each.

I guess this is what happens when you try to separate a final work into
separate steps :-) . I'll send a revised version hopefully tomorrow.


Heiko
