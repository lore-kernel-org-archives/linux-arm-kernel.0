From: zonque@gmail.com (Daniel Mack)
Date: Thu, 09 Aug 2012 16:28:51 +0200
Subject: [PATCH 6/6] ARM: dts: add pinctrl in PXA DT files
In-Reply-To: <CACRpkdayqp0ptdURHtYWC6G5pk1rNaAiWZkc7bdhv2osY1MaHA@mail.gmail.com>
References: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
 <1343458722-17127-7-git-send-email-haojian.zhuang@gmail.com>
 <201208060844.29333.arnd@arndb.de>
 <CACRpkdayqp0ptdURHtYWC6G5pk1rNaAiWZkc7bdhv2osY1MaHA@mail.gmail.com>
Message-ID: <5023C923.3080808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.08.2012 08:49, Linus Walleij wrote:
> On Mon, Aug 6, 2012 at 10:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Saturday 28 July 2012, Haojian Zhuang wrote:
>>> +Required subnode-properties:
>>> +- marvell,pins : An array of strings. Each string contains the name of a pin
>>> +                 or group.
>>> +- marvell,function     : A string containing the name of the function to mux to the
>>> +                 pin or group.
>>> +- marvell,drive-strength : An integer value that means the drive strength of a
>>> +                        pin.
>>> +- marvell,pull-up      : The property means a pin is pull up for input.
>>> +- marvell,pull-down : The property means a pin is pull down for input.
>>> +- marvell,lowpower-pull-up : The property means a pin is pull up for input in
>>> +                         sleep state.
>>> +- marvell,lowpower-pull-down : The property means a pin is pull down for input
>>> +                           in sleep state.
>>> +- marvell,lowpower-drive-high : The property means a pin is driving high for
>>> +                            output in sleep state.
>>> +- marvell,lowpower-drive-low : The property means a pin is driving low for
>>> +                           output in sleep state.
>>> +- marvell,lowpower-float : The property means a pin is float in sleep state.
>>> +- marvell,lowpower-zero : The property means a pin is not configured in sleep
>>> +                       state.
>>
>> These (or most of them) look like they are not very Marvell specific. Should
>> we try to standardize the way they are set across different bindings?
> 
> If the device tree properties are to be standardized, the driver should be
> moved over to using generic pin config (drivers/pinctrl/pinconf-generic.c,
> include/linux/pinctrl/pinconf-generic.h) too, or it makes no sense.
> 
> So please augment the PXA driver to use these, then move the generic
> bindings to pinconf-generic.txt or something.
> 
> If pinconf-generic needs extending/augmenting in the process, just do it,
> it's supposed to be generic...

I am looking at the generic pinctrl code right now and I wonder if the
following approach would be ok:

- each driver that calls pinctrl_register() has its own dt_match_table
entry, so the 'compatible' part of the bindings is specific to a pin
controller chip.
- introduce a pinctrl_parse_of(struct of_node *) and call that after the
driver has added all its pins. That function walks all the children of
the given node and uses the callbacks provided by the driver to do the
actual work.
- Unfortunately, we can't parse the node from pinctrl_register() as the
gpio ranges are only added after that by the drivers.

If that sounds good, I can come up with a patch.


Thanks,
Daniel
