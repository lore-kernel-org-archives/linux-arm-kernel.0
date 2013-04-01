From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 01 Apr 2013 13:02:52 -0600
Subject: [PATCHv3 3/6] pinctrl: gpio: vt8500: Add pincontrol driver for
 arch-vt8500
In-Reply-To: <5159D92B.9020401@prisktech.co.nz>
References: <1364451049-2981-1-git-send-email-linux@prisktech.co.nz>
 <1364451049-2981-4-git-send-email-linux@prisktech.co.nz>
 <5159BE78.5020905@wwwdotorg.org> <5159D92B.9020401@prisktech.co.nz>
Message-ID: <5159D9DC.9070201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2013 12:59 PM, Tony Prisk wrote:
> On 02/04/13 06:06, Stephen Warren wrote:
>> On 03/28/2013 12:10 AM, Tony Prisk wrote:
>>> This patch adds support for the GPIO/pinmux controller found on the VIA
>>> VT8500 and Wondermedia WM8xxx-series SoCs.
>>>
>>> Each pin within the controller is capable of operating as a GPIO or as
>>> an alternate function. The pins are numbered according to their control
>>> bank/bit so that if new pins are added, the existing numbering is
>>> maintained.
>>>
>>> All currently supported SoCs are included: VT8500, WM8505, WM8650,
>>> WM8750 and
>>> WM8850.

>>> diff --git a/drivers/pinctrl/vt8500/pinctrl-wmt.c

>>> +static int wmt_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>>> +                   struct device_node *np,
>>> +                   struct pinctrl_map **map,
>>> +                   unsigned *num_maps)
>>> +fail:
>>> +    kfree(maps);
>>> +    return err;
>>> +}
>
>> There, I think you also want to iterate over maps[] and free
>> map->data.configs.config for any PIN_MAP_TYPE_CONFIGS_PIN.
>>
>> Perhaps just call wmt_pctl_dt_free_map() here, with roughly nmaps =
>> cur_map - maps?
>
> I have dropped the kfree() and used devm_kzalloc instead. Makes the fail
> path tidier as well.

Does the pinctrl core guarantee that the map table entries get removed
when unregistering the pincontrol driver? If it does, I guess that
change is safe. If not, perhaps not. I guess it must though.
