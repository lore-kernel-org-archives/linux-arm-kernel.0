From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Jan 2013 10:55:44 -0800
Subject: [PATCH v7 14/15] pinctrl: single: support generic pinconf
In-Reply-To: <CAD6h2NTgw4xvaDJfZrw4U3Q=37W5EgqcXaYKTHbzKb-HqbQvgA@mail.gmail.com>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-15-git-send-email-haojian.zhuang@linaro.org>
 <20130121171436.GI15361@atomide.com>
 <CAD6h2NTgw4xvaDJfZrw4U3Q=37W5EgqcXaYKTHbzKb-HqbQvgA@mail.gmail.com>
Message-ID: <20130122185543.GP22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@linaro.org> [130121 22:01]:
> On 22 January 2013 01:14, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > * Haojian Zhuang <haojian.zhuang@linaro.org> [130117 23:35]:
> >> +static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
> >> +                          struct pcs_function *func,
> >> +                          struct pinctrl_map **map)
> >> +
> >> +{
> >> +     struct pinctrl_map *m = *map;
> >> +     int i = 0, nconfs = 0;
> >> +     unsigned long *settings = NULL, *s = NULL;
> >> +     struct pcs_conf_vals *conf = NULL;
> >> +     struct pcs_conf_type prop2[] = {
> >> +             { "pinctrl-single,power-source", PIN_CONFIG_POWER_SOURCE, },
> >> +             { "pinctrl-single,slew-rate", PIN_CONFIG_SLEW_RATE, },
> >> +             { "pinctrl-single,input-schmitt", PIN_CONFIG_INPUT_SCHMITT, },
> >> +     };
> >
> > The PIN_CONFIG_POWER_SOURCE should be split to PIN_CONFIG_POWER_ENABLE
> > and PIN_CONFIG_POWER_SOURCE. If you only have one bit for it, I guess then
> > you can just use PIN_CONFIG_POWER_ENABLE and make PIN_CONFIG_POWER_SOURCE
> > a NOP.
> >
> 
> In Hisilicon Hi3620 SoC, 4bits are used for power source. b0000 is
> 2mA, b0001 is 4mA, .... b1111 is 8mA.
> There's no power enable bit. In Marvell silicon, it's also same.

Yeah I figured from your earlier mails. Anyways, from client driver point of
view, PIN_CONFIG_POWER_ENABLE should be just a NOP in your case?

This way the same client device driver can work on other platforms that might
also use ENABLE. It's probably unsafe to attempt to handle any ENABLE bits
automatically as the sequence to change POWER_SOURCE and then ENABLE might be
hardware specific.

Then regarding the various values: We probably need a new pinconf generic
function to set the POWER_SOURCE as it need to be passed a value too?

Regards,

Tony 
