From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sat, 22 Dec 2012 14:33:18 +0800
Subject: [PATCH v6 5/8] document: devicetree: bind pinconf with pin single
In-Reply-To: <20121222012201.GS21056@atomide.com>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
 <1356083118-18857-6-git-send-email-haojian.zhuang@linaro.org>
 <20121222012201.GS21056@atomide.com>
Message-ID: <CAD6h2NQNc0gke1FrEDn7h9ZwoEwBSxiqPAZFQw-By3GBW2xbZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 December 2012 09:22, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Haojian Zhuang <haojian.zhuang@linaro.org> [121221 01:48]:
>>
>> +- pinctrl-single,power-source : array of value that are used to configure
>> +  power source in the pinmux register. They're value of power source field
>> +  and power source mask.
>> +
>> +             /* power source, mask */
>> +             pinctrl-single,power-source = <0x1000 0x1800>;
>> +
>> +- pinctrl-single,bias : array of value that are used to configure the input
>> +  bias in the pinmux register.  They're value of bias field, bias mask,
>> +  bias disable value, bias pull down value & bias pull up value.
>> +
>> +             /* bias, mask, disable, pull down, pull up */
>> +             pinctrl-single,bias = <0xc000 0xe000 0 0xa000 0xc000>;
>> +
>> +- pinctrl-single,input-schmitt : array of value that are used to configure
>> +  input schmitt in the pinmux register. They're value of input schmitt field,
>> +  mask, & disable value.
>> +
>> +             /* input schmitt value, mask, disable */
>> +             pinctrl-single,input-schmitt = <0x40 0x70 0x40>;
>> +
>
> Hmm we might be able to standardize on just few bindings if we
> break the bias into enable, pullup and pulldown. Then we should
> have the defval, enable and disable for each of them to allow
> setting the board specific config, and to enable and disable
> things using the generic pinconf api.
>
> So how about something like this:
>
> pinctrl-single,power-source      = <defval regmask enableval disableval>;

It seems that there's no requirement on disable power source. Is there
any silicon that need
to disable power source? I think that power source means drive strength at here.

> pinctrl-single,bias-enable       = <defval regmask enableval disableval>;
> pinctrl-single,bias-pullup       = <defval regmask enableval disableval>;
> pinctrl-single,bias-pulldown     = <defval regmask enableval disableval>;

If bias-pullup or bias-pulldown, it means that bias-enable also.
As my understanding, pin could be in any state of bias-disable,
bias-pullup, bias-pulldown.
In my v5 patches, pin couldn't switch state among these states. Now
it's fixed in v6 patches.

> pinctrl-single,input-schmitt     = <defval regmask enableval disableval>;
In Marvell silicons, input-schmitt trigger could be configured as
high-edge, low-edge or both
detect. So enableval can't cover this usage.

>
> And then we can add support for other things like comparators too:
>
> pinctrl-single,comparator-enable = <defval regmask enableval disableval>;
> pinctrl-single,comparator-status = <regmask>;   /* read only status bits */
>
I'm OK on appending these properties. I would also add slew rate property later.

Regards
Haojian
