From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 25 Jan 2016 09:30:15 -0300
Subject: [PATCH V2 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <56A612E2.1010509@openwrt.org>
References: <1453718405-40815-1-git-send-email-blogic@openwrt.org>
 <1453718405-40815-2-git-send-email-blogic@openwrt.org>
 <CABxcv=kWnUwpCo=JJbnPAARRM226YfBJw_6yF7MiE8-7iqBD+Q@mail.gmail.com>
 <56A612E2.1010509@openwrt.org>
Message-ID: <CABxcv=kC3tOrfJvCCaXcMSO4ufBXc_GoWeGBcX56k1RV-BX=ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello John,

On Mon, Jan 25, 2016 at 9:19 AM, John Crispin <blogic@openwrt.org> wrote:
> Hi,
>
> On 25/01/2016 13:11, Javier Martinez Canillas wrote:
>> Hello,
>>
>> On Mon, Jan 25, 2016 at 7:40 AM, John Crispin <blogic@openwrt.org> wrote:
>>> From: Chen Zhong <chen.zhong@mediatek.com>
>>
>> [snip]
>>
>>> +}
>>> +
>>> +static struct platform_driver mt6323_regulator_driver = {
>>> +       .driver = {
>>> +               .name = "mt6323-regulator",
>>> +       },
>>> +       .probe = mt6323_regulator_probe,
>>> +};
>>> +
>>
>> You don't have a .of_match table but according the DT bindings, the
>> compatible string "mediatek,mt6323-regulator" should be used so there
>> should be a OF match table or the vendor prefix of the compatible
>> string won't be used for matching (i.e: fallbacks to the driver .name
>> for match).
>
> the driver is probed via drivers/mfd/mt6397-core.c and does not require
> the OF match table. It loads fine just like the mt6397 driver.
>

The MFD driver sets .of_compatible = "mediatek,mt6397-regulator" for
the MFD cell so I'm pretty sure that the platform bus .uevent callback
will report a MODALIAS=of:NfooT<NULL>C"mediatek,mt6397-regulator" so
that's what udev is going to pass to kmod but:

kmod load of:NfooT<NULL>C"mediatek,mt6397-regulator"

is not going to succeed since there won't be a kernel module with that alias.

Did you really try building it as a module and checked that it auto loads?

>>
>>> +module_platform_driver(mt6323_regulator_driver);
>>> +
>>> +MODULE_AUTHOR("Chen Zhong <chen.zhong@mediatek.com>");
>>> +MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6397 PMIC");
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_ALIAS("platform:mt6323-regulator");
>>
>> This alias should not be needed if you provide a OF match table and a
>> MODULE_DEVICE_TABLE(of, foo);
>
> see above.
>

In any case, I think the correct thing to do is to provide a .match
and .of_match tables for the platform driver. Since in the future if
you need to support another device with the same driver, you will need
to add another MODULE_ALIAS(). And also is better to be consistent on
what is matched and what is reported to user-space as a module alias.

>         John

Bets regards,
Javier
