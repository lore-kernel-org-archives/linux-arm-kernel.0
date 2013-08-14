From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Aug 2013 21:05:09 +0200
Subject: [PATCH] pinctrl: improve warning messages
In-Reply-To: <520BB19E.8040901@wwwdotorg.org>
References: <1376497533-32303-1-git-send-email-linus.walleij@linaro.org>
 <520BB19E.8040901@wwwdotorg.org>
Message-ID: <CACRpkdbZZP3qowmR4djoPrNq0VnsR3ukoqLDyEC1oRFehfg74A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 6:34 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/14/2013 10:25 AM, Linus Walleij wrote:

>>                       dev_err(pctldev->dev,
>> -                             "could not request pin %d on device %s\n",
>> -                             pins[i], pinctrl_dev_get_name(pctldev));
>> +                             "could not request pin %d from group %s on "
>> +                             "device %s\n",
>> +                             pins[i], gname, pinctrl_dev_get_name(pctldev));
>
> I think it'd be useful to print the pin name rather than pin number here.

Fixed it.

>> @@ -486,6 +499,16 @@ void pinmux_disable_setting(struct pinctrl_setting const *setting)
>>                       desc->mux_setting = NULL;
>>                       /* And release the pin */
>>                       pin_free(pctldev, pins[i], NULL);
>> +             } else {
>> +                     const char *gname;
>> +
>> +                     gname = pctlops->get_group_name(pctldev,
>> +                                             setting->data.mux.group);
>> +                     dev_warn(pctldev->dev,
>> +                              "not freeing pin %d as part of deactivating "
>> +                              "group %s - it is already used for some other "
>> +                              "setting",
>> +                              pins[i], gname);
>>               }
>>       }
>
> I think that will only happen if one of the pinmux_enabling_setting
> prints already happened. Is it worth adding this one?

It happens at two very distinct places in the run path, disabling a setting
may appear at a totally different place in the dmesg so I think so.

It's just below the just added code that will avoid free:ing a pin if some
other setting is muxing it, so it's this print I was talking about
with Sonic.

Yours,
Linus Walleij
