From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 3 Dec 2014 15:04:27 -0800
Subject: [PATCH v2 1/7] pinctrl: pinconf-generic: Infer map type from DT
 property
In-Reply-To: <CACRpkdbd2cAD5osYnwKTg4d1MwSjNF9i3Y+6ryjc_qLsg46Wtg@mail.gmail.com>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
 <1417137993-8337-2-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdbd2cAD5osYnwKTg4d1MwSjNF9i3Y+6ryjc_qLsg46Wtg@mail.gmail.com>
Message-ID: <942cd3fb168944d5a3379b8312bc6894@BY2FFO11FD047.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, 2014-12-02 at 04:01PM +0100, Linus Walleij wrote:
> On Fri, Nov 28, 2014 at 2:26 AM, Soren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
> > With the new 'groups' property, the DT parser can infer the map type
> > from the fact whether 'pins' or 'groups' is used to specify the pin
> > group to work on.
> > To maintain backwards compatibitliy with current usage of the DT
> > binding, this is only done when an invalid map type is passed to the
> > parsing function.
> >
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > Tested-by: Andreas F?rber <afaerber@suse.de>
> > ---
> > Changes since RFC v2:
> >  - none
> 
> OK there are problems with this.
> 
> > @@ -264,6 +264,7 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
> >         unsigned reserve;
> >         struct property *prop;
> >         const char *group;
> > +       const char *dt_pin_specifier = "pins";
> 
> Something called "dt_pin_specifier" contains the string "pins"...
> 
> >
> >         ret = of_property_read_string(np, "function", &function);
> >         if (ret < 0) {
> > @@ -284,10 +285,20 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
> >                 reserve++;
> >         if (num_configs)
> >                 reserve++;
> > +
> >         ret = of_property_count_strings(np, "pins");
> >         if (ret < 0) {
> > -               dev_err(dev, "could not parse property pins\n");
> > -               goto exit;
> > +               ret = of_property_count_strings(np, "groups");
> > +               if (ret < 0) {
> > +                       dev_err(dev, "could not parse property pins/groups\n");
> > +                       goto exit;
> > +               }
> > +               if (type == PIN_MAP_TYPE_INVALID)
> > +                       type = PIN_MAP_TYPE_CONFIGS_GROUP;
> > +               dt_pin_specifier = "groups";
> 
> Then suddenly "groups".
> 
> The pointer variable should be named something like "subnode_target_type"
> or so.

I will rename it accordingly in the next version.

> 
> > +++ b/include/linux/pinctrl/pinconf-generic.h
> > @@ -174,6 +174,13 @@ static inline int pinconf_generic_dt_node_to_map_pin(
> >                         PIN_MAP_TYPE_CONFIGS_PIN);
> >  }
> >
> > +static inline int pinconf_generic_dt_node_to_map_all(
> > +               struct pinctrl_dev *pctldev, struct device_node *np_config,
> > +               struct pinctrl_map **map, unsigned *num_maps)
> > +{
> > +       return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
> > +                       PIN_MAP_TYPE_INVALID);
> > +}
> 
> First add some comment describing what happens here and why
> INVALID is specified.
> 
> Then what does this have to do with the $subject?
> 
> Atleast mention in the commit text that a new helper is added, though unused.

Ok. I'll put a comment in the header and one or two sentences regarding
this helper in the commit message.

	Thanks,
	S?ren
