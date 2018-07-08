From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 8 Jul 2018 22:47:07 +0200
Subject: [PATCH net-next 2/5 v2] net: gemini: Improve connection prints
In-Reply-To: <20180704204047.GD23469@lunn.ch>
References: <20180704183324.10605-1-linus.walleij@linaro.org>
 <20180704183324.10605-2-linus.walleij@linaro.org>
 <20180704204047.GD23469@lunn.ch>
Message-ID: <CACRpkdaZ_SgiiHj24EfB55pHNW+siU_n-wofckj-GUHkY_NMqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2018 at 10:40 PM Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Jul 04, 2018 at 08:33:21PM +0200, Linus Walleij wrote:
> > @@ -300,23 +305,26 @@ static void gmac_speed_set(struct net_device *netdev)
> >               status.bits.speed = GMAC_SPEED_1000;
> >               if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
> >                       status.bits.mii_rmii = GMAC_PHY_RGMII_1000;
> > -             netdev_info(netdev, "connect to RGMII @ 1Gbit\n");
> > +             netdev_dbg(netdev, "connect %s to RGMII @ 1Gbit\n",
> > +                        phydev_name(phydev));
>
> Hi Linus
>
> Since these are netdev_dbg, they will generally never be seen. So
> could you add a call to phy_print_status() at the end of this
> function. That is what most MAC drivers do.

It does:

       if (netif_msg_link(port)) {
                phy_print_status(phydev);
                netdev_info(netdev, "link flow control: %s\n",
                            phydev->pause
                            ? (phydev->asym_pause ? "tx" : "both")
                            : (phydev->asym_pause ? "rx" : "none")
                );
        }

Just not visible in the patch since it was there all the time :D

My new module parameter however, makes that
phy_print_status() actually show up-

I can mention it in the commit message so it's clear.

> > -     netdev_info(netdev, "connected to PHY \"%s\"\n",
> > -                 phydev_name(phy));
> > -     phy_attached_print(phy, "phy_id=0x%.8lx, phy_mode=%s\n",
> > -                        (unsigned long)phy->phy_id,
> > -                        phy_modes(phy->interface));
> > +     netdev_dbg(netdev, "connected to PHY \"%s\"\n",
> > +                phydev_name(phy));
> >
>
> It would be nice to call phy_attached_info(), as most other MAC
> drivers do.

OK adding it!

Yours,
Linus Walleij
