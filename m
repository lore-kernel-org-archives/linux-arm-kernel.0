From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 5 Feb 2013 21:51:48 +0800
Subject: [PATCH v8 12/12] document: devicetree: bind pinconf with pin
 single
In-Reply-To: <CAN1soZytx7w8a1C=-C7924_MW6FPH5b=gsvSH=BpDU4ZhJia4w@mail.gmail.com>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-13-git-send-email-haojian.zhuang@linaro.org>
 <20130205040721.GE25185@atomide.com>
 <CAN1soZytx7w8a1C=-C7924_MW6FPH5b=gsvSH=BpDU4ZhJia4w@mail.gmail.com>
Message-ID: <CAN1soZy0g3kWRm-d3gB4LmobrNTR6WVia38maS_fXbp4qmFayA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 5, 2013 at 4:06 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> On Tue, Feb 5, 2013 at 12:07 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Haojian Zhuang <haojian.zhuang@linaro.org> [130202 09:32]:
>>> +- pinctrl-single,drive-strength : array of value that are used to configure
>>> +  drive strength in the pinmux register. They're value of drive strength
>>> +  current and drive strength mask.
>>> +
>>> +             /* drive strength current, mask */
>>> +             pinctrl-single,power-source = <0x30 0xf0>;
>>> +
>>
>> Looks like a typo, this should probably say pinctrl-single,drive-strength
>> here instead of power-source?
>>
> Yes, I should update it to drive strength.
>
>> For the cases where there's a value to be set I'm still wondering how does
>> a client driver change the value if that needs to be changed dynamically?
>> Can the value be passed as value + PIN_CONFIG_END?
>>
> pinconf_to_config_packed() can help to bind param & argument into config
> variable.
>
>>> +- pinctrl-single,bias-disable : array of value that are used to configure the
>>> +  input bias disabled in the pinmux register. They're value of bias value,
>>> +  match bias disabled value and bias disabled mask.
>>> +
>>> +             /* bias value, match bias disabled value, mask */
>>> +             pinctrl-single,bias-disable = <2 0 3>;
>>> +
>>
>> I still suggest we use "enable" naming instead of "disable" naming.
>> So pinctrl-single,bias-enable instead of pinctrl-single,bias-disable.
>>
>> Then let's change the binding slightly to make it more readable:
>>
>>                 /* enable value, disable value, mask */
>>                 pinctrl-single,bias-enable = <2 0 3>;
>>
>> For example, I have bit 22 cleared to enable MMC PBIAS, or bit 22
>> set to disable PBIAS:
>>
>>                                              /* enable disable  mask */
>>                 pinctrl-single,bias-enable = <0x000000 0x400000 0x400000>;
>>
> In Hi3620 SoC, the bias could only be configured pull up or pull down. There's
> no any bit for controlling bias enable or bias disable. But user may need to
> remove both pullup and pulldown at runtime. In this case, I set bias disable
> if there's no pullup & pulldown.
>
> * Without bias enable/disable bit.
>             bias-disable = <user input value, expected disable value, mask>;
>             bias-pullup = <user input value, expected pullup value, mask>;
>       "expected disable value" is the set of not pullup bit and not
> pull down bit.
>       "expected pullup value" is the set of pullup bit.
>
> * With bias enable/disable bit.
>       "expected disable value" is the set of disable bit, NOT pullup
> bit and NOT pulldown bit.
>       "expected pullup value" is the set of NOT disable bit & pullup bit.
>
> PULLUP --> DISABLE: only need to set the expected disable value in
> bias-disable property.
> DISABLE --> PULLUP: only need to set the expected pullup value in
> bias-pullup property.
> PULLUP --> PULLDOWN: set the expected pulldown value. So both pullup
> and pulldown
> bits are enabled unless user call DISABLE first.. Maybe it's not
> right. I can fix it and keep
> either pullup or pulldown enabled. It's ok to add pinconf_clear() for
> bias as you mentioned.
>
> And I think that we need four parameters with your format.
>       <user setting on bias enable/disable, expected enable value,
> expected disable value, mask */
> Otherwise, how could we know user's setting? Especially, we need to
> configure pullup.
> In your case, expected pullup enable & expected pullup disable are set
> in bias-pullup property.
>>                 /* enable value, disable value, mask */
>>                 pinctrl-single,bias-pullup = <0 1 1>;
>
> Actually, I'm OK to use enable value. And it needs 4 parameters since
> disable value may not be zero.
>
> By the way, bias property would be the format in below with 4 parameters.
> * Without bias enable/disable bit.
>           bias-enable = <0, 0, 0, set of both pullup and pulldown mask>;
>
> * With bias enable/disable bit.
>           bias-enable = <user setting, expected enable, expected
> disable, mask of only enable/disable bit>;
>
> Behavior of pinconf_clear():
>      - call bias-disable
>      - call the expected bias setting.
>
> DISABLE --> PULLUP, user call config BIAS_PULLUP without additional argument.
> PULLUP --> PULLDOWN, user call with config BIAS_PULLDOWN without
> additional argument.
> PULLUP --> DISABLE, user call with config BIAS_ENABLE and 0 for argument.
>
> The switch from PULLUP to DISABLE is a little strange since we have to
> call BIAS_ENABLE.
> Is it good for you?
>

Maybe it didn't cover your case. It seems that there's only one bit
for bias in your case.
You can control MMC BIAS enable or disable. And there's neither pullup
nor pulldown.
Is it right?

If so, how about this?

* Without pullup & pulldown bias. With bias enable & disable bit.
(Your MMC bias)
     1) 3 params
           bias-disable = <user setting of bias value, expected bias
disable value, mask>;
           bias-enable = <user setting of bias value, expected bias
enable value, mask>;
     or 2) 4 params
           bias-enable = <user setting of bias value, expected bias
enable value, expected bias disable value, mask>;

     So I will need both config BIAS_ENABLE & config BIAS_DISABLE.
Driver switches between BIAS_ENABLE & BIAS_DISABLE.

* Without bias enable & disable bit. With bias pullup & pulldown bit.
(Hi3620 bias)
     1) 3 params
           bias-disable = <user setting of bias value, expected
disable value (w/o pullup & pulldown), mask (pullup & pulldown)>;
           bias-pullup = <user setting of bias value, expected bias
pullup value, mask of pullup>;
           bias-pulldown ...
     or 2) 4 params
           bias-enable = <user setting of bias value, expected enable
value (w pullup & pulldown), expected disable value (w/o pullup &
pulldown), mask (pullup & pulldown)>;
           bias-pullup = <user setting of bias value, expected bias
pullup value, expected bias pullup disable value, mask of pullup>;
           bias-pulldown ...
     Driver switches among BIAS_DISABLE, BIAS_PULLDOWN, BIAS_PULLUP.
It seems that BIAS_ENABLE is redundant operation at here.

* With bias enable & disable bit. With bias pullup & pulldown bit.
(MMP/PXA bias)
     1) 3 params
          bias-disable = <user setting of bias value, expected disable
value (single bit), mask (enable/disable)>;
          bias-pullup = <user setting of bias value, expected pullup
value, mask (pullup)>;
          bias-pulldown ...
     or 2) 4 params
          bias-enable = <user setting of bias value, expected enable
value, expected disable value, mask>;
          bias-pullup = <user setting of bias value, expected bias
pullup value, expected bias pullup disable value, mask of pullup>;
          bias-pulldown ...
     Driver switches among BIAS_DISABLE, BIAS_PULLDOWN, BIAS_PULLUP.
It seems that BIAS_ENABLE is redundant operation at here. Because user
won't only enable bias without pullup or pulldown.

There're two usage for all three cases. Which one do you like?

Best Regards
Haojian
