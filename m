From: tony@atomide.com (Tony Lindgren)
Date: Sat, 22 Dec 2012 09:07:26 -0800
Subject: [PATCH v6 5/8] document: devicetree: bind pinconf with pin single
In-Reply-To: <CAD6h2NQNc0gke1FrEDn7h9ZwoEwBSxiqPAZFQw-By3GBW2xbZw@mail.gmail.com>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
 <1356083118-18857-6-git-send-email-haojian.zhuang@linaro.org>
 <20121222012201.GS21056@atomide.com>
 <CAD6h2NQNc0gke1FrEDn7h9ZwoEwBSxiqPAZFQw-By3GBW2xbZw@mail.gmail.com>
Message-ID: <20121222170725.GB12601@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@linaro.org> [121221 22:35]:
> On 22 December 2012 09:22, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > * Haojian Zhuang <haojian.zhuang@linaro.org> [121221 01:48]:
> >>
> >> +- pinctrl-single,power-source : array of value that are used to configure
> >> +  power source in the pinmux register. They're value of power source field
> >> +  and power source mask.
> >> +
> >> +             /* power source, mask */
> >> +             pinctrl-single,power-source = <0x1000 0x1800>;
> >> +
> >> +- pinctrl-single,bias : array of value that are used to configure the input
> >> +  bias in the pinmux register.  They're value of bias field, bias mask,
> >> +  bias disable value, bias pull down value & bias pull up value.
> >> +
> >> +             /* bias, mask, disable, pull down, pull up */
> >> +             pinctrl-single,bias = <0xc000 0xe000 0 0xa000 0xc000>;
> >> +
> >> +- pinctrl-single,input-schmitt : array of value that are used to configure
> >> +  input schmitt in the pinmux register. They're value of input schmitt field,
> >> +  mask, & disable value.
> >> +
> >> +             /* input schmitt value, mask, disable */
> >> +             pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
> >> +
> >
> > Hmm we might be able to standardize on just few bindings if we
> > break the bias into enable, pullup and pulldown. Then we should
> > have the defval, enable and disable for each of them to allow
> > setting the board specific config, and to enable and disable
> > things using the generic pinconf api.
> >
> > So how about something like this:
> >
> > pinctrl-single,power-source      = <defval regmask enableval disableval>;
> 
> It seems that there's no requirement on disable power source. Is there
> any silicon that need
> to disable power source? I think that power source means drive strength at here.

Yes at least I have cases where the bias disable needs to be set when
changing bias voltage between 1.8V and 3V.
 
> > pinctrl-single,bias-enable       = <defval regmask enableval disableval>;
> > pinctrl-single,bias-pullup       = <defval regmask enableval disableval>;
> > pinctrl-single,bias-pulldown     = <defval regmask enableval disableval>;
> 
> If bias-pullup or bias-pulldown, it means that bias-enable also.
> As my understanding, pin could be in any state of bias-disable,
> bias-pullup, bias-pulldown.
> In my v5 patches, pin couldn't switch state among these states. Now
> it's fixed in v6 patches.

Yes that's cool. I'm just worried that if we try to stuff all the bias
settings into one array, it won't work for additional bias states.
Looks like we have at least bias disable, bias voltage and bias high
impedance mode in addition to what you're describing.
 
> > pinctrl-single,input-schmitt     = <defval regmask enableval disableval>;
> In Marvell silicons, input-schmitt trigger could be configured as
> high-edge, low-edge or both
> detect. So enableval can't cover this usage.

Hmm there too trying to stuff them into one array may not be flexible
enough to cover all the cases. So that's why I'm suggesting we describe
them separately.

> > And then we can add support for other things like comparators too:
> >
> > pinctrl-single,comparator-enable = <defval regmask enableval disableval>;
> > pinctrl-single,comparator-status = <regmask>;   /* read only status bits */
> >
> I'm OK on appending these properties. I would also add slew rate property later.

OK thanks.

BTW, we may not need the board configured "defval" in the array examples
I posted above, we may have it already in the pinmux binding.

Regards,

Tony
