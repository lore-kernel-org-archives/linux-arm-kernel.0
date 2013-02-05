From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 5 Feb 2013 16:06:01 +0800
Subject: [PATCH v8 12/12] document: devicetree: bind pinconf with pin
 single
In-Reply-To: <20130205040721.GE25185@atomide.com>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-13-git-send-email-haojian.zhuang@linaro.org>
 <20130205040721.GE25185@atomide.com>
Message-ID: <CAN1soZytx7w8a1C=-C7924_MW6FPH5b=gsvSH=BpDU4ZhJia4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 5, 2013 at 12:07 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Haojian Zhuang <haojian.zhuang@linaro.org> [130202 09:32]:
>> +- pinctrl-single,drive-strength : array of value that are used to configure
>> +  drive strength in the pinmux register. They're value of drive strength
>> +  current and drive strength mask.
>> +
>> +             /* drive strength current, mask */
>> +             pinctrl-single,power-source = <0x30 0xf0>;
>> +
>
> Looks like a typo, this should probably say pinctrl-single,drive-strength
> here instead of power-source?
>
Yes, I should update it to drive strength.

> For the cases where there's a value to be set I'm still wondering how does
> a client driver change the value if that needs to be changed dynamically?
> Can the value be passed as value + PIN_CONFIG_END?
>
pinconf_to_config_packed() can help to bind param & argument into config
variable.

>> +- pinctrl-single,bias-disable : array of value that are used to configure the
>> +  input bias disabled in the pinmux register. They're value of bias value,
>> +  match bias disabled value and bias disabled mask.
>> +
>> +             /* bias value, match bias disabled value, mask */
>> +             pinctrl-single,bias-disable = <2 0 3>;
>> +
>
> I still suggest we use "enable" naming instead of "disable" naming.
> So pinctrl-single,bias-enable instead of pinctrl-single,bias-disable.
>
> Then let's change the binding slightly to make it more readable:
>
>                 /* enable value, disable value, mask */
>                 pinctrl-single,bias-enable = <2 0 3>;
>
> For example, I have bit 22 cleared to enable MMC PBIAS, or bit 22
> set to disable PBIAS:
>
>                                              /* enable disable  mask */
>                 pinctrl-single,bias-enable = <0x000000 0x400000 0x400000>;
>
In Hi3620 SoC, the bias could only be configured pull up or pull down. There's
no any bit for controlling bias enable or bias disable. But user may need to
remove both pullup and pulldown at runtime. In this case, I set bias disable
if there's no pullup & pulldown.

* Without bias enable/disable bit.
            bias-disable = <user input value, expected disable value, mask>;
            bias-pullup = <user input value, expected pullup value, mask>;
      "expected disable value" is the set of not pullup bit and not
pull down bit.
      "expected pullup value" is the set of pullup bit.

* With bias enable/disable bit.
      "expected disable value" is the set of disable bit, NOT pullup
bit and NOT pulldown bit.
      "expected pullup value" is the set of NOT disable bit & pullup bit.

PULLUP --> DISABLE: only need to set the expected disable value in
bias-disable property.
DISABLE --> PULLUP: only need to set the expected pullup value in
bias-pullup property.
PULLUP --> PULLDOWN: set the expected pulldown value. So both pullup
and pulldown
bits are enabled unless user call DISABLE first.. Maybe it's not
right. I can fix it and keep
either pullup or pulldown enabled. It's ok to add pinconf_clear() for
bias as you mentioned.

And I think that we need four parameters with your format.
      <user setting on bias enable/disable, expected enable value,
expected disable value, mask */
Otherwise, how could we know user's setting? Especially, we need to
configure pullup.
In your case, expected pullup enable & expected pullup disable are set
in bias-pullup property.
>                 /* enable value, disable value, mask */
>                 pinctrl-single,bias-pullup = <0 1 1>;

Actually, I'm OK to use enable value. And it needs 4 parameters since
disable value may not be zero.

By the way, bias property would be the format in below with 4 parameters.
* Without bias enable/disable bit.
          bias-enable = <0, 0, 0, set of both pullup and pulldown mask>;

* With bias enable/disable bit.
          bias-enable = <user setting, expected enable, expected
disable, mask of only enable/disable bit>;

Behavior of pinconf_clear():
     - call bias-disable
     - call the expected bias setting.

DISABLE --> PULLUP, user call config BIAS_PULLUP without additional argument.
PULLUP --> PULLDOWN, user call with config BIAS_PULLDOWN without
additional argument.
PULLUP --> DISABLE, user call with config BIAS_ENABLE and 0 for argument.

The switch from PULLUP to DISABLE is a little strange since we have to
call BIAS_ENABLE.
Is it good for you?

> Then I think pretty much the only change to pinconf_get() would be:
>
>         data = pcs->read(pcs->base + offset) & func->conf[i].mask;
>
>         switch (func->conf[i].param) {
>         /* 3 parameters */
>         case PIN_CONFIG_BIAS_ENABLE:
>         case PIN_CONFIG_BIAS_PULL_DOWN:
>         case PIN_CONFIG_BIAS_PULL_UP:
>         case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
>         *config = data;
>         if (data == func->conf[i].enable)
>                 res = 0;
>         else
>                 res = -ENOTSUPP;
>         break;
>         ...
>
> And then the client driver can always assume that if the return value
> is 0, the ENABLE value in question is set. And if -ENOTSUPP (or how about
> -ENOTSET :) is returned, the ENABLE value is not set?
>
Return constant value 0 is better. I'll update.

> Then regarding pinconf_set(), don't we also need pinconf_clear() in
> addition to pinconf_set()?
>
> Otherwise we need both ENABLE and DISABLE enumeration, which seems
> unnecessary to me. So rather than have both PIN_CONFIG_BIAS_ENABLE and
> PIN_CONFIG_BIAS_DISABLE, we just need PIN_CONFIG_BIAS_ENABLE.
I can append pinconf_clear() to handle it.

>
>> +- pinctrl-single,bias-pullup : array of value that are used to configure the
>> +  input bias pullup in the pinmux register. They're value of bias value,
>> +  match bias pullup value and bias pullup mask.
>> +
>> +             /* bias value, match bias pullup value, mask */
>> +             pinctrl-single,bias-pullup = <0 1 1>;
>
> It seems that you could then use same generic comment in all places
> then to make it a bit easier to read:
>
>                 /* enable value, disable value, mask */
>                 pinctrl-single,bias-pullup = <0 1 1>;
Discussed above.
