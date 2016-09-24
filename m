From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 24 Sep 2016 10:59:27 +0200
Subject: [PATCH 3/3] regulator: axp20x: simplify device access
In-Reply-To: <CAGb2v64ZpQ=9KUH39cFoRxU6n03cgDoUbHegjFfDWaTLQAZ2wg@mail.gmail.com>
References: <cover.1474616699.git.moinejf@free.fr>
 <d3078ed4eefd4de48e4b5666a64f6123f8d72483.1474616699.git.moinejf@free.fr>
 <CAGb2v64ZpQ=9KUH39cFoRxU6n03cgDoUbHegjFfDWaTLQAZ2wg@mail.gmail.com>
Message-ID: <20160924105927.794f768afbe30e53616cf95f@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 24 Sep 2016 16:29:11 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

	[snip]
> >  static int axp20x_regulator_probe(struct platform_device *pdev)
> >  {
> > +       struct device *dev = pdev->dev.parent;
> 
> There are 2 struct device's in play in this function, 1 from the parent,
> and 1 for the platform device for this regulator sub-device.
> 
> >         struct regulator_dev *rdev;
> > -       struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> > +       struct axp20x_dev *axp20x = dev_get_drvdata(dev);
> >         const struct regulator_desc *regulators;
> >         struct regulator_config config = {
> > -               .dev = pdev->dev.parent,
> > +               .dev = dev,
> >                 .regmap = axp20x->regmap,
> >                 .driver_data = axp20x,
> >         };
> > @@ -532,7 +533,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
> >                 dcdc5_ix = AXP22X_DCDC5;
> >                 dc1sw_ix = AXP22X_DC1SW;
> >                 dc5ldo_ix = AXP22X_DC5LDO;
> > -               drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
> > +               drivevbus = of_property_read_bool(dev->of_node,
> >                                                   "x-powers,drive-vbus-en");
> >                 break;
> >         case AXP806_ID:
> > @@ -555,13 +556,13 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
> >                 dc5ldo_ix = AXP809_DC5LDO;
> >                 break;
> >         default:
> > -               dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
> > +               dev_err(dev, "Unsupported AXP variant: %ld\n",
> 
> So this one is incorrect. You should use this device's struct,
> not the parent. It's possible the mfd driver supports a PMIC,
> but the regulator driver is still missing.

Why do you need a regulator driver? The 'regulator' node in the DT is
not a real device. It is just a container and it could be removed
without any problem.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
