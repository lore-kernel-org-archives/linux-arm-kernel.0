From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Oct 2016 11:02:53 +0200
Subject: [PATCH 4/9] pinctrl: sunxi: Deal with configless pins
In-Reply-To: <CAGb2v654vv3B-OhHPgdLjsEOf0zPP=Ky1_+o=8mf9dZHMFjR-w@mail.gmail.com>
References: <cover.26c6f76b361d146fb079d744251f020ef6d2db7d.1475489558.git-series.maxime.ripard@free-electrons.com>
 <8b72a134d957afdee6de48ec2c1891d8bba1b9e3.1475489558.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v654vv3B-OhHPgdLjsEOf0zPP=Ky1_+o=8mf9dZHMFjR-w@mail.gmail.com>
Message-ID: <20161007090253.GL4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 04, 2016 at 10:28:18AM +0800, Chen-Yu Tsai wrote:
> >         if (sunxi_pctrl_has_drive_prop(node)) {
> >                 int drive = sunxi_pctrl_parse_drive_prop(node);
> > -               if (drive < 0)
> > +               if (drive < 0) {
> > +                       ret = -EINVAL;
> 
> Why not just pass the error code returned from the parse function?

Yep, I'll change that.

> > -               (*map)[i].type = PIN_MAP_TYPE_CONFIGS_GROUP;
> > -               (*map)[i].data.configs.group_or_pin = group;
> > -               (*map)[i].data.configs.configs = pinconfig;
> > -               (*map)[i].data.configs.num_configs = configlen;
> > -
> > -               i++;
> > +               if (pinconfig) {
> > +                       (*map)[i].type = PIN_MAP_TYPE_CONFIGS_GROUP;
> > +                       (*map)[i].data.configs.group_or_pin = group;
> > +                       (*map)[i].data.configs.configs = pinconfig;
> > +                       (*map)[i].data.configs.num_configs = configlen;
> > +                       i++;
> > +               }
> >         }
> >
> > -       *num_maps = nmaps;
> > +       *num_maps = i;
> 
> Thought: should we do a krealloc to shrink the array?

Yep, I'll make an additional patch to fix that.

> 
> >
> >         return 0;
> >
> > @@ -342,8 +357,13 @@ static void sunxi_pctrl_dt_free_map(struct pinctrl_dev *pctldev,
> >                                     struct pinctrl_map *map,
> >                                     unsigned num_maps)
> >  {
> > +       unsigned long *pinconfig;
> > +
> >         /* All the maps have the same pin config, free only the first one */
> > -       kfree(map[0].data.configs.configs);
> > +       pinconfig = map[0].data.configs.configs;
> > +       if (pinconfig)
> > +               kfree(pinconfig);
> 
> Passing NULL to kfree is allowed. (It becomes a no-op.)
> So you could leave this function alone.

And I'll change that as well.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161007/081df1b2/attachment.sig>
