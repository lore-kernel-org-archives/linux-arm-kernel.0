From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 27 Nov 2014 09:53:14 -0800
Subject: [PATCH 3/7] pinctrl: pinconf-generic: Allow driver to specify DT
 params
In-Reply-To: <CACRpkdYfj2ydLQ4q_FKwXo73jzNsvj9u2Aem9EiuEw-OCvurrg@mail.gmail.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-4-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdYfj2ydLQ4q_FKwXo73jzNsvj9u2Aem9EiuEw-OCvurrg@mail.gmail.com>
Message-ID: <3656bd45ce11485ebe7dfa6b64ca87fe@BN1BFFO11FD023.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, 2014-11-11 at 03:53PM +0100, Linus Walleij wrote:
> On Mon, Nov 3, 2014 at 8:05 PM, Soren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
> > Additionally to the generic DT parameters, allow drivers to provide
> > driver-specific DT parameters to be used with the generic parser
> > infrastructure.
> >
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> 
> I like the looks of this, but the patch description is a bit terse.
> I'd like it to describe some of the refactorings being done
> to the intrinsics, because I have a hard time following the patch.

I'll be a little more verbose :)

> 
> First please rebase onto the "devel" branch in the pin control
> tree, and notice that drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> which is merged there is actually doing this already:
> 
> 
>         for_each_child_of_node(np_config, np) {
>                 ret = pinconf_generic_dt_subnode_to_map(pctldev, np, map,
>                                                         &reserv, nmaps, type);
>                 if (ret)
>                         break;
> 
>                 ret = pmic_gpio_dt_subnode_to_map(pctldev, np, map, &reserv,
>                                                   nmaps, type);
>                 if (ret)
>                         break;
>         }
> 
> So it should be patched to illustrate the point of this code.

I'll look into this.

> 
> I'd like feedback from Ivan+Bj?rn on the code too if possible.
> 
> > -       ret = pinconf_generic_parse_dt_config(np, &configs, &nconfigs);
> > +       ret = pinconf_generic_parse_dt_config(np, pctldev, &configs, &nconfigs);
> >         if (nconfigs)
> >                 has_config = 1;
> >         np_config = of_parse_phandle(np, "ste,config", 0);
> >         if (np_config) {
> > -               ret = pinconf_generic_parse_dt_config(np_config, &configs,
> > -                               &nconfigs);
> > +               ret = pinconf_generic_parse_dt_config(np_config, pctldev,
> > +                               &configs, &nconfigs);
> 
> This code is patched upstream so that ABx500 only uses generic config.
> Again rebase on "devel"

Yeah, causes a conflict, but seems to be pretty much the same.

> 
> > -void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
> > -                             struct seq_file *s, unsigned pin)
> > +static void _pinconf_generic_dump(struct pinctrl_dev *pctldev,
> > +                                 struct seq_file *s, const char *gname,
> > +                                 unsigned pin,
> > +                                 const struct pin_config_item *items,
> > +                                 int nitems)
> 
> Don't use functions named _foo, actually the underscore is for
> preprocessor and compiler things in my book, just give it an intuitive
> name instead. Like pinconf_generic_dump_one() if that is suitable
> or whatever.
> 
> This changes the function signature from something quite intuitively
> understood to something pretty hard to understand, so you need to
> add kerneldoc to it. (That also enhance my understanding of the
> patch.)

I'll rename it and add some documentation.

> 
> > -void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
> > -                             struct seq_file *s, const char *gname)
> > +static void pinconf_generic_dump(struct pinctrl_dev *pctldev,
> > +                                struct seq_file *s, const char *gname,
> > +                                unsigned pin)
> 
> This looks intuitive and nice.
> 
> > +       _pinconf_generic_dump(pctldev, s, gname, pin,
> > +                             conf_items, ARRAY_SIZE(conf_items));
> > +       if (pctldev->desc->num_dt_params) {
> > +               BUG_ON(!pctldev->desc->conf_items);
> 
> Don't use BUG_ON() like that, it's nasty. Always try to
> recover and bail out instead.

I merge the condition into the if.

> 
> > +void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
> > +                             struct seq_file *s, unsigned pin)
> > +{
> > +       pinconf_generic_dump(pctldev, s, NULL, pin);
> > +}
> > +
> > +void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
> > +                             struct seq_file *s, const char *gname)
> > +{
> > +       pinconf_generic_dump(pctldev, s, gname, 0);
> > +}
> 
> Do you really need these helpers? Isn't it simpler just
> to call the generic function with the different arguments?

I'll remove the helpers and patch the users of these functions.

> 
> > @@ -148,17 +132,22 @@ void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
> >                 seq_printf(s, "%s: 0x%x", conf_items[i].display,
> >                            pinconf_to_config_argument(config));
> >         }
> > +
> > +       if (!pctldev->desc->num_dt_params)
> > +               return;
> > +
> > +       BUG_ON(!pctldev->desc->conf_items);
> 
> No BUG_ON() dev_err() and exit.

As above.

> 
> > +static void _parse_dt_cfg(struct device_node *np,
> > +                         const struct pinconf_generic_dt_params *params,
> > +                         unsigned int count,
> > +                         unsigned long *cfg,
> > +                         unsigned int *ncfg)
> 
> Should return an error code right? Kerneldoc doesn't hurt either.

I don't see a need for an error return. It's currently not needed and
this refactoring doesn't change that, IMHO. I'll add kerneldoc.

> 
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < count; i++) {
> > +               u32 val;
> > +               int ret;
> > +               const struct pinconf_generic_dt_params *par = &params[i];
> > +
> > +               ret = of_property_read_u32(np, par->property, &val);
> 
> Not checking this return value. Alter the function to return an
> int value on success.

It's checked in the very next statement?! And it's all handled in this
function. No need to report anything to the caller.

> 
> > +
> > +               /* property not found */
> > +               if (ret == -EINVAL)
> > +                       continue;
> > +
> > +               /* use default value, when no value is specified */
> > +               if (ret)
> > +                       val = par->default_value;
> > +
> > +               pr_debug("found %s with value %u\n", par->property, val);
> > +               cfg[*ncfg] = pinconf_to_config_packed(par->param, val);
> > +               (*ncfg)++;
> > +       }
> > +}
> 
> There is something very unintuitive about this loop. You pass two
> counter indexes (count, ncfg) in basically, that is looking weird,
> does it have to look like that? Especially since there is no
> bounds check on ncfg!
> 
> Just use one index in the loop please. Assign  *ncfg = ... after
> the loop has *successfully* iterated.

I think this needs to be as is. There are two arrays @cfg and @params.
@params holding the DT params parsed with @count indicating the
boundary. And @cfg, where the parsed options are put with @ncfg being
a write pointer. @nfcg can be passed non-zero into this function. The
caller is responsible to allocate enough memory to hold all possible entries.

> 
> >  int pinconf_generic_parse_dt_config(struct device_node *np,
> > +                                   struct pinctrl_dev *pctldev,
> >                                     unsigned long **configs,
> >                                     unsigned int *nconfigs)
> 
> This is a good refactoring, but no _foo naming!

Will be renamed.

> 
> >  {
> >         unsigned long *cfg;
> > -       unsigned int ncfg = 0;
> > +       unsigned int max_cfg, ncfg = 0;
> >         int ret;
> > -       int i;
> > -       u32 val;
> >
> >         if (!np)
> >                 return -EINVAL;
> >
> >         /* allocate a temporary array big enough to hold one of each option */
> > -       cfg = kzalloc(sizeof(*cfg) * ARRAY_SIZE(dt_params), GFP_KERNEL);
> > +       max_cfg = ARRAY_SIZE(dt_params);
> > +       if (pctldev)
> > +               max_cfg += pctldev->desc->num_dt_params;
> > +       cfg = kcalloc(max_cfg, sizeof(*cfg), GFP_KERNEL);
> 
> Aha this looks good...
> 
> > +       _parse_dt_cfg(np, dt_params, ARRAY_SIZE(dt_params), cfg, &ncfg);
> > +       if (pctldev && pctldev->desc->num_dt_params) {
> > +               BUG_ON(!pctldev->desc->params);
> 
> No BUG_ON()

as above.

	S?ren
