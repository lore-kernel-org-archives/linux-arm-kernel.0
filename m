From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 15 Apr 2015 10:36:46 -0400 (EDT)
Subject: [PATCHv2 2/3] usb: ehci-platform: Use devm_of_phy_get_by_index
In-Reply-To: <CAA7nrtipKF-WtGV-9b40DXYm=jBvM=Pg9PCH9U6yWhj37d41aw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1504151035150.1404-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Apr 2015, rajeev kumar wrote:

> > @@ -88,15 +88,13 @@ static int ehci_platform_power_on(struct platform_device *dev)
> >         }
> >
> >         for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
> > -               if (priv->phys[phy_num]) {
> > -                       ret = phy_init(priv->phys[phy_num]);
> > -                       if (ret)
> > -                               goto err_exit_phy;
> > -                       ret = phy_power_on(priv->phys[phy_num]);
> > -                       if (ret) {
> > -                               phy_exit(priv->phys[phy_num]);
> > -                               goto err_exit_phy;
> > -                       }
> > +               ret = phy_init(priv->phys[phy_num]);
> > +               if (ret)
> > +                       goto err_exit_phy;
> 
> Jumping to err_exit_phy will perform phy_power_off also which is not
> required as you are are powering on after phy_init. Wrong level
> jumping

Look again, and this time pay more attention to the value of phy_num.

Alan Stern

> ~Rajeev
> 
> > +               ret = phy_power_on(priv->phys[phy_num]);
> > +               if (ret) {
> > +                       phy_exit(priv->phys[phy_num]);
> > +                       goto err_exit_phy;
> >                 }
> >         }
> >
> > @@ -104,10 +102,8 @@ static int ehci_platform_power_on(struct platform_device *dev)
> >
> >  err_exit_phy:
> >         while (--phy_num >= 0) {
> > -               if (priv->phys[phy_num]) {
> > -                       phy_power_off(priv->phys[phy_num]);
> > -                       phy_exit(priv->phys[phy_num]);
> > -               }
> > +               phy_power_off(priv->phys[phy_num]);
> > +               phy_exit(priv->phys[phy_num]);
> >         }
